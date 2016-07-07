import Chisel._

class SPIFlashModule extends Module {
  val io = new Bundle {
    val flash_en = Bool(INPUT)
    val flash_write = Bool(INPUT)
    val quad_io = UInt(INPUT, 4)
    val flash_addr = UInt(INPUT, 24)
    val flash_data_in = UInt(INPUT, 32)
    val flash_data_out = UInt(INPUT, 32)
    val state_to_cpu = UInt(OUTPUT)
    val SI = UInt(OUTPUT, 1)
    val tri_si = UInt(OUTPUT, 1)
    val cs = UInt(OUTPUT, 1)
  }

  // cmd definition
  val RDSR1 = UInt(0x05, 8)
  val WRR = UInt(0x01, 8)
  val WREN = UInt(0x06, 8)
  val WRDI = UInt(0x04, 8)
  val READ = UInt(0x03, 8)
  val QREAD = UInt(0x6B, 8)
  val PP = UInt(0x02, 8)
  val QPP = UInt(0x32, 8)

  val inst = UInt(0, 6)

  // state definition
  val st_idle = UInt(0, 6)
  val st_read = UInt(1, 6)
  val st_write = UInt(2, 6)
  val st_finish = UInt(3, 6)

  val subst_idle = UInt(0, 6)
  val subst_set_wren = UInt(1, 6)
  val subst_check_wren = UInt(2, 6)
  val subst_req_sr1 = UInt(3, 6)
  val subst_issue_instr = UInt(4, 6)
  val subst_send_addr = UInt(5, 6)
  val subst_read_data_byte = UInt(6, 6)
  val subst_wait_cs_1 = UInt(7, 6)
  val subst_send_data = UInt(8, 6)
  val subst_check_r1 = UInt(9, 6)
  val subst_recv_sr1 = UInt(10,6)

  val state = Reg(init = st_idle)
  val sub_state = Reg(init = st_idle)
  val counter = Reg(init = UInt(0, 6))
  val cs = Reg(init = UInt(1, 1))

  val write_old = Reg(init = UInt(0, 1))
  val addr_old = Reg(init = UInt(0, 24))
  val buffer = Reg(init = UInt(0, 32))
  val reg_buffer = Reg(init = UInt(0, 8))

  val not_move = ((state === st_idle & io.flash_en === UInt(0))
    | ((state === st_idle) & (addr_old === io.flash_addr) &
      (write_old === io.flash_write)))

  //default
  io.SI := UInt(0)
  io.tri_si := UInt(0)
  io.state_to_cpu := Cat(state, sub_state)

  inst := UInt(0, 6)

  when (state === st_idle) {
    when(~not_move) {
      cs := UInt(0)
      counter := UInt(7)
      when(io.flash_en & ~io.flash_write) {
        state := st_read
        sub_state := subst_issue_instr
      }
      when(io.flash_en & io.flash_write) {
        state := st_write
        sub_state := subst_set_wren
      }
    }
  }

  when (state === st_read) {
    when (sub_state === subst_issue_instr) {
      io.SI := QREAD(counter(2, 0))
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_send_addr
        counter := UInt(23)
      }
    }
    when (sub_state === subst_send_addr) {
      io.SI := io.flash_addr(counter(4, 0))
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_read_data_byte
        counter := UInt(0)
      }
    }

    when (sub_state === subst_read_data_byte) {
      io.tri_si := UInt(1)
      counter := counter + UInt(1)
      when (counter === UInt(0 + 2*0)) {
        buffer(7 + 8*0, 4 + 8*0) := io.quad_io
      }
      .elsewhen (counter === UInt(1 + 2*0)) {
        buffer(3 + 8*0, 0 + 8*0) := io.quad_io
      }
      .elsewhen (counter === UInt(0 + 2*1)) {
        buffer(7 + 8*1, 4 + 8*1) := io.quad_io
      }
      .elsewhen (counter === UInt(1 + 2*1)) {
        buffer(3 + 8*1, 0 + 8*1) := io.quad_io
      }
      .elsewhen (counter === UInt(0 + 2*2)) {
        buffer(7 + 8*2, 4 + 8*2) := io.quad_io
      }
      .elsewhen (counter === UInt(1 + 2*2)) {
        buffer(3 + 8*2, 0 + 8*2) := io.quad_io
      }
      .elsewhen (counter === UInt(0 + 2*3)) {
        buffer(7 + 8*3, 4 + 8*3) := io.quad_io
      }
      .otherwise {  //(counter === UInt(1 + 2*3))
        buffer(3 + 8*3, 0 + 8*3) := io.quad_io
        cs := UInt(1)
        state := st_finish
        sub_state := st_idle
      }
    }
  }

  when (state === st_write) {
    when (sub_state === subst_set_wren) {
      io.SI := WREN(counter(2,0))
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_wait_cs_1
        counter := UInt(7)
        cs := UInt(1)
      }
    }
    when (sub_state === subst_wait_cs_1) {
      sub_state := subst_issue_instr
      cs := UInt(0)
    }
    when (sub_state === subst_issue_instr) {
      io.SI := PP(counter(2,0))
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_send_addr
        counter := UInt(23)
      }
    }
    when (sub_state === subst_send_addr) {
      io.SI := io.flash_addr(counter(4, 0))
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_send_data
        counter(2, 0) := UInt(7, 3)
        counter(4, 3) := UInt(0, 2)
      }
    }
    when (sub_state === subst_send_data) {
      io.SI := io.flash_data_in(counter(4,0))
      counter := counter - UInt(1)
      when (counter(2,0) === UInt(0, 3)) {
        counter(4, 3) := counter(4, 3) + UInt(1)
        when (counter(4, 3) === UInt(3, 2)) {
          sub_state := subst_req_sr1
          counter := UInt(7)
        }
      }
    }

    when (sub_state === subst_req_sr1) {
      io.SI := RDSR1(counter(2,0))
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_recv_sr1
        counter := UInt(7)
      }
    }
    when (sub_state === subst_recv_sr1) {
      reg_buffer(counter(2,0)) := io.quad_io(1)
      when (counter === UInt(0)) {
        sub_state := subst_check_r1
      }
    }
  }

  when (state === st_finish) {
    state := st_idle
    addr_old := io.flash_addr
    write_old := io.flash_write
  }


  io.cs := cs
}

class FlashModuleTests(c: SPIFlashModule) extends Tester(c) {
  for (i <- 0 until 120) {
    poke(c.io.flash_en, 1)
    poke(c.io.flash_write, 0)
    poke(c.io.flash_addr, 0xff00ff)
    poke(c.io.flash_data_in, 0xffffffff)
    step(1)
  }
  for (i <- 0 until 200) {
    poke(c.io.flash_en, 1)
    poke(c.io.flash_write, 1)
    poke(c.io.flash_addr, 0x731731)
    poke(c.io.flash_data_in, 0x8cef8cef)
    step(1)
  }
}

object hello {
  def main(args: Array[String]): Unit = {
    chiselMainTest(args,
      () => Module(new SPIFlashModule())){c => new FlashModuleTests(c)}
  }
}

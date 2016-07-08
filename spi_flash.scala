import Chisel._

class SPIFlashModule extends Module {
  val io = new Bundle {
    val flash_en = Bool(INPUT)
    val flash_write = Bool(INPUT)
    val quad_io = UInt(INPUT, 4)
    val flash_addr = UInt(INPUT, 24)
    val flash_data_in = UInt(INPUT, 32)
    val read_id = Bool(INPUT)

    val flash_data_out = UInt(OUTPUT, 32)
    val state_to_cpu = UInt(OUTPUT)
    val SI = UInt(OUTPUT, 1)
    val WP = UInt(OUTPUT, 1)
    val tri_si = UInt(OUTPUT, 1)
    val tri_wp = UInt(OUTPUT, 1)
    val cs = UInt(OUTPUT, 1)
    val ready = UInt(OUTPUT, 1)
    val sr1 = UInt(OUTPUT, 8)
    val cr = UInt(OUTPUT, 8)
    val sck_gate = UInt(OUTPUT, 1)
  }

  // cmd definition
  val RDSR1 = Reg(init = UInt(0x05, 8))
  val RDCR = Reg(init = UInt(0x35, 8))
  val WRR = Reg(init = UInt(0x01, 8))
  val WREN = Reg(init = UInt(0x06, 8))
  val WRDI = Reg(init = UInt(0x04, 8))
  val READ = Reg(init = UInt(0x03, 8))
  val QREAD = Reg(init = UInt(0x6B, 8))
  val PP = Reg(init = UInt(0x02, 8))
  val QPP = Reg(init = UInt(0x32, 8))
  val RDID = Reg(init = UInt(0x9f, 8))
  val READ_ID = Reg(init = UInt(0x90, 8))


  // state definition
  val st_idle = UInt(0, 6)
  val st_read = UInt(1, 6)
  val st_write = UInt(2, 6)
  val st_finish = UInt(3, 6)
  val st_set_quad = UInt(4, 6)
  val st_read_id = UInt(5, 6)

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
  val subst_req_cr = UInt(11,6)
  val subst_recv_cr = UInt(12,6)
  val subst_issue_wrr = UInt(13,6)
  val subst_send_sr1 = UInt(14,6)
  val subst_send_cr = UInt(15,6)
  val subst_check_wip_1 = UInt(16,6)
  val subst_check_wip_2 = UInt(17,6)
  val subst_wait_cs_2 = UInt(18, 6)
  val subst_wait_cs_3 = UInt(19, 6)
  val subst_wait_cs_4 = UInt(20, 6)
  val subst_wait_cs_5 = UInt(21, 6)
  val subst_req_cr_2 = UInt(22, 6)
  val subst_recv_cr_2 = UInt(23, 6)
  val subst_recv_id = UInt(24, 6)
  val subst_dead = UInt(25, 6)
  val subst_wait_cs_init = UInt(26, 6)

  val state = Reg(init = st_idle)
  val sub_state = Reg(init = st_idle)
  val counter = Reg(init = UInt(0, 6))
  val cs = Reg(init = UInt(1, 1))

  val write_old = Reg(init = UInt(0, 1))
  val addr_old = Reg(init = UInt(0, 24))
  val buffer = Reg(init = UInt(0, 32))
  val reg_buffer_sr1 = Reg(init = UInt(0, 8))
  val reg_buffer_cr = Reg(init = UInt(0, 8))
  val reg_buffer_id = Reg(init = UInt(0, 24))
  val err_counter = Reg(init = UInt(0, 15))
  val sck_gate = Reg(init = UInt(1, 1))
  val read_id_addr = Reg(init = UInt(0x000001, 24))
  val cs_counter = Reg(init = UInt(0, 3))

  val not_move = ((state === st_idle & io.flash_en === UInt(0))
    | ((state === st_idle) & (addr_old === io.flash_addr) &
      (write_old === io.flash_write)))

  //default
  io.SI := UInt(0)
  io.tri_si := UInt(0)
  io.state_to_cpu := Cat(state, sub_state)
  io.WP := UInt(0)
  io.tri_wp := UInt(1)

  when (state === st_idle) {
    cs := UInt(1)
    when(~not_move) {
      cs := UInt(0)
      counter := UInt(7)
      when (io.flash_en) {
        when (io.read_id) {
          state := st_read_id
          sub_state := subst_wait_cs_init
        }
        .elsewhen (~io.flash_write) {
          state := st_read
          sub_state := subst_wait_cs_init
          cs_counter := UInt(0)
        }
        .elsewhen (io.flash_write) {
          state := st_write
          sub_state := subst_wait_cs_init
          cs_counter := UInt(0)
        }
      }
    }
  }

  when (state === st_read_id) {
    when (sub_state === subst_wait_cs_init) {
      sub_state := subst_issue_instr
      sck_gate := UInt(0)
    }
    when (sub_state === subst_issue_instr) {
      io.SI := READ_ID(counter(2, 0))
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_send_addr
        counter := UInt(23)
      }
    }
    when (sub_state === subst_send_addr) {
      io.SI := read_id_addr(counter(4, 0))
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_recv_id
        counter := UInt(15)
      }
    }
    when (sub_state === subst_recv_id) {
      reg_buffer_id(counter(4, 0)) := io.quad_io(1) // S := io.quad_io(1) // SOO
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        cs := UInt(1)
        sub_state := subst_dead
        sck_gate := UInt(1)
      }
    }
  }

  when (state === st_read) {
    when (sub_state === subst_wait_cs_init) {
      cs_counter := cs_counter - UInt(1)
      when (cs_counter === UInt(0)) {
        sub_state := subst_issue_instr
        cs := UInt(0)
        counter := UInt(7)
      }
    }
    when (sub_state === subst_issue_instr) {
      io.SI := READ(counter(2, 0))
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
        counter := UInt(7)
      }
    }

    when (sub_state === subst_read_data_byte) {
      io.tri_si := UInt(1)
      buffer(counter(4, 0)) := io.quad_io(1)
      counter(2, 0) := counter(2, 0) - UInt(1, 3)
      when(counter(2, 0) === UInt(0, 3)) {
        counter(4, 3) := counter(4, 3) + UInt(1, 2)
        when (counter(4, 3) === UInt(3, 2)) {
          cs := UInt(1)
          state := st_finish
          sub_state := subst_idle
        }
      }
    }
  }

  when (state === st_write) {
    when (sub_state === subst_wait_cs_init) {
      cs_counter := cs_counter - UInt(1)
      when (cs_counter === UInt(0)) {
        sub_state := subst_set_wren
        cs := UInt(0)
        counter := UInt(7)
      }
    }
    when (sub_state === subst_set_wren) {
      io.SI := WREN(counter(2,0))
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_wait_cs_1
        cs_counter := UInt(3)
        cs := UInt(1)
      }
    }
    when (sub_state === subst_wait_cs_1) {
      cs_counter := cs_counter - UInt(1)
      when (cs_counter === UInt(1)) {
        cs := UInt(0)
      }
      when (cs_counter === UInt(0)) {
        counter := UInt(7)
        sub_state := subst_issue_instr
      }
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
        counter(5) := UInt(0, 1)
      }
    }
    when (sub_state === subst_send_data) {
      io.SI := io.flash_data_in(counter(4,0))
      counter(2, 0) := counter(2, 0) - UInt(1)
      when (counter(2, 0) === UInt(0, 3)) {
        counter(4, 3) := counter(4, 3) + UInt(1, 2)
        when (counter(4, 3) === UInt(3, 2)) {
          sub_state := subst_wait_cs_3
          cs_counter := UInt(3)
          cs := UInt(1)
        }
      }
    }
    /*
    when (sub_state === subst_req_sr1) {
      io.SI := RDSR1(counter(2,0))
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_recv_sr1
        counter := UInt(7)
      }
    }
    when (sub_state === subst_recv_sr1) {
      reg_buffer_sr1(counter(2,0)) := io.quad_io(1)
      when (counter === UInt(0)) {
        sub_state := subst_check_r1
      }
    }
    */

		when (sub_state === subst_wait_cs_3) {
      cs_counter := cs_counter - UInt(1)
      when (cs_counter === UInt(1)) {
        cs := UInt(0)
      }
      when (cs_counter === UInt(0)) {
        sub_state := subst_check_wip_1
        counter := UInt(7)
      }
    }
    when (sub_state === subst_check_wip_1) {
      io.SI := RDSR1(counter(2,0))
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_check_wip_2
        counter := UInt(7)
      }
    }
    when (sub_state === subst_check_wip_2) {
      reg_buffer_sr1(counter(2,0)) := io.quad_io(1)
      counter := counter - UInt(1)
      when (counter === UInt(0)) {
        sub_state := subst_wait_cs_4
        cs := UInt(1)
      }
    }
    when (sub_state === subst_wait_cs_4) {
      counter := UInt(7)
      when (reg_buffer_sr1(0) === UInt(1)) { // wait writing process
        sub_state := subst_check_wip_1
        err_counter := err_counter + UInt(1)
        when (err_counter > UInt(1024)) {
          state := state
          sub_state := sub_state
        }
      }
      .otherwise {
        state := st_finish
        sub_state := subst_idle
      }
    }
  }

  when (state === st_finish) {
    state := st_idle
    addr_old := io.flash_addr
    write_old := io.flash_write
  }

  io.flash_data_out := Cat(reg_buffer_id, UInt(0, 8))
  io.cs := cs
  io.ready := not_move | (state === st_finish)
  io.sr1 := reg_buffer_sr1
  io.cr := reg_buffer_cr
  io.sck_gate := sck_gate
}

class FlashModuleTests(c: SPIFlashModule) extends Tester(c) {
  for (i <- 0 until 200) {
    poke(c.io.flash_en, 1)
    poke(c.io.flash_write, 0)
    poke(c.io.read_id, 0)
    poke(c.io.flash_addr, 0xff00ff)
    poke(c.io.quad_io, 0x0)
    poke(c.io.flash_data_in, 0x8cef8cef)
    step(1)
  }

  for (i <- 0 until 200) {
    poke(c.io.flash_en, 1)
    poke(c.io.flash_write, 1)
    poke(c.io.flash_addr, 0xff00ff)
    poke(c.io.quad_io, 0x0)
    poke(c.io.flash_data_in, 0xffffffff)
    step(1)
  }
  for (i <- 0 until 90) {
    poke(c.io.flash_en, 1)
    poke(c.io.flash_write, 0)
    poke(c.io.flash_addr, 0xff00ff)
    poke(c.io.quad_io, 0xf)
    poke(c.io.flash_data_in, 0xffffffff)
    step(1)
  }

}

object hello {
  def main(args: Array[String]): Unit = {
    chiselMainTest(args,
      () => Module(new SPIFlashModule())){c => new FlashModuleTests(c)}
  }
}

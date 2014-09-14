From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: AMIGA_BUILTIN_SERIAL should depend on TTY
Date: Sun, 14 Sep 2014 11:42:11 +0200
Message-ID: <1410687731-10697-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-m68k@lists.linux-m68k.org
Cc: linux-serial@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

If CONFIG_TTY=n:

drivers/built-in.o: In function `rs_flush_buffer':
amiserial.c:(.text+0x1f626): undefined reference to `tty_wakeup'
drivers/built-in.o: In function `transmit_chars':
amiserial.c:(.text+0x1f6c8): undefined reference to `tty_wakeup'
drivers/built-in.o: In function `change_speed':
amiserial.c:(.text+0x1f80a): undefined reference to `tty_termios_baud_rate'
amiserial.c:(.text+0x1f88c): undefined reference to `tty_termios_baud_rate'
drivers/built-in.o: In function `check_modem_status':
amiserial.c:(.text+0x1faa6): undefined reference to `tty_hangup'
amiserial.c:(.text+0x1faec): undefined reference to `tty_wakeup'
drivers/built-in.o: In function `get_serial_info':
amiserial.c:(.text+0x1fb88): undefined reference to `tty_lock'
amiserial.c:(.text+0x1fbc0): undefined reference to `tty_unlock'
drivers/built-in.o: In function `rs_open':
amiserial.c:(.text+0x1fdc6): undefined reference to `tty_port_block_til_ready'
drivers/built-in.o: In function `set_serial_info':
amiserial.c:(.text+0x1fe0c): undefined reference to `tty_lock'
amiserial.c:(.text+0x1fea0): undefined reference to `tty_unlock'
amiserial.c:(.text+0x1fed0): undefined reference to `tty_unlock'
amiserial.c:(.text+0x1ffaa): undefined reference to `tty_unlock'
drivers/built-in.o: In function `receive_chars':
amiserial.c:(.text+0x2005c): undefined reference to `do_SAK'
amiserial.c:(.text+0x200e0): undefined reference to `tty_insert_flip_string_flags'
amiserial.c:(.text+0x2013c): undefined reference to `tty_insert_flip_string_flags'
amiserial.c:(.text+0x20148): undefined reference to `tty_flip_buffer_push'
drivers/built-in.o: In function `rs_close':
amiserial.c:(.text+0x20744): undefined reference to `tty_port_close_start'
amiserial.c:(.text+0x2078a): undefined reference to `tty_ldisc_flush'
amiserial.c:(.text+0x20798): undefined reference to `tty_port_close_end'
drivers/built-in.o: In function `amiga_serial_probe':
amiserial.c:(.init.text+0x96a): undefined reference to `__tty_alloc_driver'
amiserial.c:(.init.text+0x9c0): undefined reference to `tty_std_termios'
amiserial.c:(.init.text+0x9e6): undefined reference to `tty_set_operations'
amiserial.c:(.init.text+0xa3e): undefined reference to `tty_port_init'
amiserial.c:(.init.text+0xa5c): undefined reference to `tty_port_link_device'
amiserial.c:(.init.text+0xa6c): undefined reference to `tty_register_driver'
amiserial.c:(.init.text+0xb4a): undefined reference to `tty_unregister_driver'
amiserial.c:(.init.text+0xb58): undefined reference to `tty_port_destroy'
amiserial.c:(.init.text+0xb64): undefined reference to `put_tty_driver'

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/Kconfig.devices | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/Kconfig.devices b/arch/m68k/Kconfig.devices
index 5e38bc25fc09..1154bb24ca84 100644
--- a/arch/m68k/Kconfig.devices
+++ b/arch/m68k/Kconfig.devices
@@ -95,7 +95,7 @@ config ATARI_DSP56K
 
 config AMIGA_BUILTIN_SERIAL
 	tristate "Amiga builtin serial support"
-	depends on AMIGA
+	depends on AMIGA && TTY
 	help
 	  If you want to use your Amiga's built-in serial port in Linux,
 	  answer Y.
-- 
1.9.1

From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 5/9] serial: hp300: Remove obsolete comments
Date: Wed,  5 Nov 2014 12:26:28 -0500
Message-ID: <1415208392-16189-6-git-send-email-peter@hurleysoftware.com>
References: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

setup_serial_console() is obsolete and has been superseded by
early_serial_setup() which is called at the end of the function.

The IA64 arch does not call this function; only the m68k arch setup
calls this function.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_hp300.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index afffe4d..b488208 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -88,10 +88,6 @@ extern int hp300_uart_scode;
 /*
  * Parse the bootinfo to find descriptions for headless console and
  * debug serial ports and register them with the 8250 driver.
- * This function should be called before serial_console_init() is called
- * to make sure the serial console will be available for use. IA-64 kernel
- * calls this function from setup_arch() after the EFI and ACPI tables have
- * been parsed.
  */
 int __init hp300_setup_serial_console(void)
 {
-- 
2.1.3

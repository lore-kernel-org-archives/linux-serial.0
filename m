From: Sudhir Sreedharan <ssreedharan@mvista.com>
Subject: [PATCH v1] tty: serial: 8250_core: restore the LCR register in set_sleep
Date: Fri, 17 Oct 2014 18:09:18 +0530
Message-ID: <1413549558-24227-1-git-send-email-ssreedharan@mvista.com>
References: <CAJJ77WsAi5jmnDxY45ipu3a94D6+yoHJNHgExhFsVoirV3NoyQ@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJJ77WsAi5jmnDxY45ipu3a94D6+yoHJNHgExhFsVoirV3NoyQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter@hurleysoftware.com, gregkh@linuxfoundation.org, khilman@kernel.org
Cc: linux-serial@vger.kernel.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, olof@lixom.net, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, Sudhir Sreedharan <ssreedharan@mvista.com>
List-Id: linux-serial@vger.kernel.org

In ST16650V2 based serial uarts, while initalizing the PM state,
LCR registers are being initialized to 0 in serial8250_set_sleep().
If console port is already initialized and being used, this will
throws garbage in the console.

Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
---
Changes in v1:
	Removed the condition of sleep flag for restoring the LCR and EFR.
	Initialized the lcr and efr variables.

 drivers/tty/serial/8250/8250_core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ca5cfdc..b170487 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -595,6 +595,7 @@ static void serial8250_rpm_put_tx(struct uart_8250_port *p)
  */
 static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 {
+	unsigned char lcr = 0, efr = 0;
 	/*
 	 * Exar UARTs have a SLEEP register that enables or disables
 	 * each UART to enter sleep mode separately.  On the XR17V35x the
@@ -611,6 +612,8 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 
 	if (p->capabilities & UART_CAP_SLEEP) {
 		if (p->capabilities & UART_CAP_EFR) {
+			lcr = serial_in(p, UART_LCR);
+			efr = serial_in(p, UART_EFR);
 			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
 			serial_out(p, UART_EFR, UART_EFR_ECB);
 			serial_out(p, UART_LCR, 0);
@@ -618,8 +621,8 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 		serial_out(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);
 		if (p->capabilities & UART_CAP_EFR) {
 			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
-			serial_out(p, UART_EFR, 0);
-			serial_out(p, UART_LCR, 0);
+			serial_out(p, UART_EFR, efr);
+			serial_out(p, UART_LCR, lcr);
 		}
 	}
 out:
-- 
1.7.0.1

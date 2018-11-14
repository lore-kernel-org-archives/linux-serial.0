From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/3] serial: imx: avoid crash when un/re-binding serial console device
Date: Wed, 14 Nov 2018 18:49:40 +0100
Message-ID: <20181114174940.7865-3-stefan@agner.ch>
References: <20181114174940.7865-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114174940.7865-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: fabio.estevam@nxp.com, u.kleine-koenig@pengutronix.de, s.hauer@pengutronix.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-serial@vger.kernel.org

If the device used as a serial console gets un/re-binded, then
register_console() will call imx_uart_setup_console() again.
Drop __init so that imx_uart_setup_console() can be safely called
at runtime.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This addresses a kernel panic seen when unbinding/rebinding the i.MX
UART which is serial console on i.MX 6/7 via SSH:
# cd /sys/bus/platform/drivers/imx-uart/
# echo 30860000.serial > unbind && echo 30860000.serial > bind

console [ttymxc0] disabled
30860000.serial: ttymxc0 at MMIO 0x30860000 (irq = 52, base_baud = 1500000) is a IMX
Unable to handle kernel paging request at virtual address c0c4b830
pgd = 5e12e3d4
[c0c4b830] *pgd=80c1141e(bad)
Internal error: Oops: 8000000d [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 866 Comm: sh Not tainted 4.18.15-00048-gb3b505988801-dirty #403
Hardware name: Freescale i.MX7 Dual (Device Tree)
PC is at imx_uart_console_setup+0x0/0x274
LR is at register_console+0x184/0x3c4
pc : [<c0c4b830>]    lr : [<c0171314>]    psr: a0070013
sp : e8015db8  ip : c0d06548  fp : c0b4a158
r10: ec1d9380  r9 : 00000001  r8 : 00000000
r7 : 00000000  r6 : c0d819e0  r5 : c0d81e48  r4 : c0d47d68
r3 : c0c4b830  r2 : 00000000  r1 : efffca03  r0 : c0d47d68
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: a803806a  DAC: 00000051
Process sh (pid: 866, stack limit = 0x9c2f1d49)

It seems that also other drivers are affected. An alternative might be
to disallow unbinding/rebinding instead.

 drivers/tty/serial/imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 757c91e5105a..674bd0ea2491 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1966,7 +1966,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
  * If the port was already initialised (eg, by a boot loader),
  * try to determine the current setup.
  */
-static void __init
+static void
 imx_uart_console_get_options(struct imx_port *sport, int *baud,
 			     int *parity, int *bits)
 {
@@ -2025,7 +2025,7 @@ imx_uart_console_get_options(struct imx_port *sport, int *baud,
 	}
 }
 
-static int __init
+static int
 imx_uart_console_setup(struct console *co, char *options)
 {
 	struct imx_port *sport;
-- 
2.19.1

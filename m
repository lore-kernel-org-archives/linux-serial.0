From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] tty: serial: remove set but not used variable 'error'
Date: Thu, 20 Sep 2018 01:59:16 +0000
Message-ID: <1537408756-196431-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: YueHaibing <yuehaibing@huawei.com>, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/tty/serial/pmac_zilog.c: In function 'pmz_receive_chars':
drivers/tty/serial/pmac_zilog.c:222:30: warning:
 variable 'error' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/tty/serial/pmac_zilog.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index a4ec22d..a9d4098 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -219,7 +219,7 @@ static void pmz_interrupt_control(struct uart_pmac_port *uap, int enable)
 static bool pmz_receive_chars(struct uart_pmac_port *uap)
 {
 	struct tty_port *port;
-	unsigned char ch, r1, drop, error, flag;
+	unsigned char ch, r1, drop, flag;
 	int loops = 0;
 
 	/* Sanity check, make sure the old bug is no longer happening */
@@ -231,7 +231,6 @@ static bool pmz_receive_chars(struct uart_pmac_port *uap)
 	port = &uap->port.state->port;
 
 	while (1) {
-		error = 0;
 		drop = 0;
 
 		r1 = read_zsreg(uap, R1);
@@ -273,7 +272,6 @@ static bool pmz_receive_chars(struct uart_pmac_port *uap)
 		uap->port.icount.rx++;
 
 		if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR | BRK_ABRT)) {
-			error = 1;
 			if (r1 & BRK_ABRT) {
 				pmz_debug("pmz: got break !\n");
 				r1 &= ~(PAR_ERR | CRC_ERR);

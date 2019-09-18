From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH] tty: serial: linflexuart: Fix magic SysRq handling
Date: Wed, 18 Sep 2019 18:45:49 +0000
Message-ID: <20190918184439.7465-1-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kbuild test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-serial@vger.kernel.org

Following an incorrect indentation reported to me by Dan Carpenter, I
noticed that the SysRq lines were inherited from the lpuart driver[1] (note
how the 'continue' is aligned to 'sport->port.sysrq =3D 0') and we have nev=
er
actually tested the SysRq support.

'sport->sysrq =3D 0' is not necessary neither before nor after 'continue',
because sysrq will already be 0 after uart_handle_sysrq_char() will finish.
Also, since the LINFlexD driver never called uart_handle_break(), sysrq
would have never been set to a nonzero value, so uart_handle_sysrq_char()
was not going to do anything.

Break conditions are detected based on a null data byte along with a
framing error (stop bit sampled to 0).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/tty/serial/fsl_lpuart.c?h=3Db3e3bf2ef2c74f5ce5c19510edbbb9bfc1d249=
c2#n659

Fixes: 09864c1cdf5c ("tty: serial: Add linflexuart driver for S32V234")
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_=
linflexuart.c
index 68d74f2b5106..a32f0d2afd59 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -3,7 +3,7 @@
  * Freescale linflexuart serial port driver
  *
  * Copyright 2012-2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2018 NXP
+ * Copyright 2017-2019 NXP
  */
=20
 #if defined(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE) && \
@@ -246,12 +246,14 @@ static irqreturn_t linflex_rxint(int irq, void *dev_i=
d)
 	struct tty_port *port =3D &sport->state->port;
 	unsigned long flags, status;
 	unsigned char rx;
+	bool brk;
=20
 	spin_lock_irqsave(&sport->lock, flags);
=20
 	status =3D readl(sport->membase + UARTSR);
 	while (status & LINFLEXD_UARTSR_RMB) {
 		rx =3D readb(sport->membase + BDRM);
+		brk =3D false;
 		flg =3D TTY_NORMAL;
 		sport->icount.rx++;
=20
@@ -261,8 +263,11 @@ static irqreturn_t linflex_rxint(int irq, void *dev_id=
)
 				status |=3D LINFLEXD_UARTSR_SZF;
 			if (status & LINFLEXD_UARTSR_BOF)
 				status |=3D LINFLEXD_UARTSR_BOF;
-			if (status & LINFLEXD_UARTSR_FEF)
+			if (status & LINFLEXD_UARTSR_FEF) {
+				if (!rx)
+					brk =3D true;
 				status |=3D LINFLEXD_UARTSR_FEF;
+			}
 			if (status & LINFLEXD_UARTSR_PE)
 				status |=3D  LINFLEXD_UARTSR_PE;
 		}
@@ -271,13 +276,15 @@ static irqreturn_t linflex_rxint(int irq, void *dev_i=
d)
 		       sport->membase + UARTSR);
 		status =3D readl(sport->membase + UARTSR);
=20
-		if (uart_handle_sysrq_char(sport, (unsigned char)rx))
-			continue;
-
+		if (brk) {
+			uart_handle_break(sport);
+		} else {
 #ifdef SUPPORT_SYSRQ
-			sport->sysrq =3D 0;
+			if (uart_handle_sysrq_char(sport, (unsigned char)rx))
+				continue;
 #endif
-		tty_insert_flip_char(port, rx, flg);
+			tty_insert_flip_char(port, rx, flg);
+		}
 	}
=20
 	spin_unlock_irqrestore(&sport->lock, flags);
--=20
2.22.0

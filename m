From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: mxs-auart: Fix mxs_auart_set_ldisc()
Date: Wed, 12 Nov 2014 15:35:12 -0200
Message-ID: <1415813712-5872-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:49490 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbaKLRgH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 12:36:07 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so10782066qcw.37
        for <linux-serial@vger.kernel.org>; Wed, 12 Nov 2014 09:36:05 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: j.uzycki@elproma.com.pl, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 36a262782b04 ("serial: mxs-auart: enable PPS support")
the following build warning is seen:

drivers/tty/serial/mxs-auart.c:962:2: warning: initialization from
incompatible pointer type
  .set_ldisc      = mxs_auart_set_ldisc,
  ^
drivers/tty/serial/mxs-auart.c:962:2: warning: (near initialization
for 'mxs_auart_ops.set_ldisc')

The second argument of set_ldisc should be 'struct ktermios *termios', so
fix it accordingly. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Janusz,

This is build-tested only. Please test it on real hardware, if possible.

 drivers/tty/serial/mxs-auart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 3784920..a6d2bb9f4 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -784,9 +784,10 @@ static void mxs_auart_settermios(struct uart_port *u,
 		mxs_auart_disable_ms(u);
 }
 
-static void mxs_auart_set_ldisc(struct uart_port *port, int new)
+static void mxs_auart_set_ldisc(struct uart_port *port,
+				struct ktermios *termios)
 {
-	if (new == N_PPS) {
+	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
 		mxs_auart_enable_ms(port);
 	} else {
-- 
1.9.1


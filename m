From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v1] tty: serial: 8250: Fix possible race in serial8250_em485_destroy()
Date: Thu, 11 Feb 2016 22:32:32 +0300
Message-ID: <1455219152-10254-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, andy.shevchenko@gmail.com, gnomes@lxorguk.ukuu.org.uk
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fix possbile race in serial8250_em485_destroy() when timer handlers can
dereference p->em485 which is alread destroyed but not yet NULLed.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
I've found that Greg applied initial patchset, so this erratum goes as separate patch.

 drivers/tty/serial/8250/8250_port.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c908b77..d962de2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -617,14 +617,16 @@ EXPORT_SYMBOL_GPL(serial8250_em485_init);
  */
 void serial8250_em485_destroy(struct uart_8250_port *p)
 {
-	if (p->em485 == NULL)
+	struct uart_8250_em485 *em485 = p->em485;
+
+	if (!em485)
 		return;
 
-	del_timer(&p->em485->start_tx_timer);
-	del_timer(&p->em485->stop_tx_timer);
+	del_timer(&em485->start_tx_timer);
+	del_timer(&em485->stop_tx_timer);
 
-	kfree(p->em485);
 	p->em485 = NULL;
+	kfree(em485);
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_destroy);
 
-- 
2.7.0

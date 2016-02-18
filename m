From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v1] tty: serial: Use GFP_ATOMIC instead of GFP_KERNEL in serial8250_em485_init()
Date: Thu, 18 Feb 2016 21:47:20 +0300
Message-ID: <1455821240-5842-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, andy.shevchenko@gmail.com, gnomes@lxorguk.ukuu.org.uk
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

serial8250_em485_init() is supposed to be protected with
p->port.lock spinlock.
This may lead to issues when kmalloc sleeps, so it is better to use
GFP_ATOMIC in this spinlocked context.

Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
Reported-by: <torso.nafi@gmail.com>
Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c908b77..4d6deef 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -586,7 +586,7 @@ int serial8250_em485_init(struct uart_8250_port *p)
 	if (p->em485 != NULL)
 		return 0;
 
-	p->em485 = kmalloc(sizeof(struct uart_8250_em485), GFP_KERNEL);
+	p->em485 = kmalloc(sizeof(struct uart_8250_em485), GFP_ATOMIC);
 	if (p->em485 == NULL)
 		return -ENOMEM;
 
-- 
2.7.0

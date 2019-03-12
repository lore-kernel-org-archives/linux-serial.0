From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 2/8] drivers: tty: serial: 8250_dw: use devm_ioremap_resource()
Date: Tue, 12 Mar 2019 15:57:34 +0100
Message-ID: <1552402660-31730-3-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use helper devm_ioremap_resource() to make the code a little bit
shorter and easier to read.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index d31b975..f0a294d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -526,7 +526,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
 
-	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
+	p->membase = devm_ioremap_resource(dev, regs);
 	if (!p->membase)
 		return -ENOMEM;
 
-- 
1.9.1

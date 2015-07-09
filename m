From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [RFT PATCH] serial: amba-pl011: Fix devm_ioremap_resource return value check
Date: Thu,  9 Jul 2015 22:21:41 +0900
Message-ID: <1436448101-24819-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Value returned by devm_ioremap_resource() was checked for non-NULL but
devm_ioremap_resource() returns IOMEM_ERR_PTR, not NULL. In case of
error this could lead to dereference of ERR_PTR.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: <stable@vger.kernel.org>
Fixes: 3873e2d7f63a ("drivers: PL011: refactor pl011_probe()")

---

Patch only compile tested.
---
 drivers/tty/serial/amba-pl011.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 50cf5b10ceed..fd27e986b1dd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2310,8 +2310,8 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 	void __iomem *base;
 
 	base = devm_ioremap_resource(dev, mmiobase);
-	if (!base)
-		return -ENOMEM;
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	index = pl011_probe_dt_alias(index, dev);
 
-- 
2.1.4

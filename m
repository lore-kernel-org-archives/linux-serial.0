From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: [PATCH 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Wed, 30 Sep 2015 11:38:50 +0100
Message-ID: <1443609530-21524-4-git-send-email-graeme.gregory@linaro.org>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, shannon.zhao@linaro.org, Graeme Gregory <graeme.gregory@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

In ACPI this device is only defined in SBSA mode so
if we are probing from ACPI use this mode.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index fd27e98..55209aa 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2368,18 +2368,28 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	if (!uap)
 		return -ENOMEM;
 
-	uap->clk = devm_clk_get(&dev->dev, NULL);
-	if (IS_ERR(uap->clk))
-		return PTR_ERR(uap->clk);
-
-	uap->vendor = vendor;
-	uap->lcrh_rx = vendor->lcrh_rx;
-	uap->lcrh_tx = vendor->lcrh_tx;
-	uap->fifosize = vendor->get_fifosize(dev);
+	/* ACPI only defines SBSA variant */
+	if (!ACPI_COMPANION(&dev->dev)) {
+		uap->clk = devm_clk_get(&dev->dev, NULL);
+		if (IS_ERR(uap->clk))
+			return PTR_ERR(uap->clk);
+
+		uap->vendor = vendor;
+		uap->lcrh_rx = vendor->lcrh_rx;
+		uap->lcrh_tx = vendor->lcrh_tx;
+		uap->fifosize = vendor->get_fifosize(dev);
+		uap->port.ops = &amba_pl011_pops;
+		snprintf(uap->type, sizeof(uap->type), "PL011 rev%u",
+				amba_rev(dev));
+	 } else {
+		uap->vendor	= &vendor_sbsa;
+		uap->fifosize	= 32;
+		uap->port.ops	= &sbsa_uart_pops;
+		uap->fixed_baud = 115200;
+
+		snprintf(uap->type, sizeof(uap->type), "SBSA");
+	}
 	uap->port.irq = dev->irq[0];
-	uap->port.ops = &amba_pl011_pops;
-
-	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
 
 	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
 	if (ret)
-- 
2.4.3

From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/4] serial: sccnxp: Disable regulator on error
Date: Wed, 31 Jul 2013 14:56:29 +0400
Message-ID: <1375268191-13428-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp33.i.mail.ru ([94.100.177.93]:40844 "EHLO smtp33.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755530Ab3GaK4j (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Jul 2013 06:56:39 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

The patch disables the regulator in case of errors, if we have it.
In addition, the patch adds support for deferred regulator probe and
makes error path are a bit clean.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 9855517..12a5c26 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -787,10 +787,9 @@ static int sccnxp_probe(struct platform_device *pdev)
 	struct sccnxp_port *s;
 	void __iomem *membase;
 
-	if (!res) {
-		dev_err(&pdev->dev, "Missing memory resource data\n");
-		return -EADDRNOTAVAIL;
-	}
+	membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(membase))
+		return PTR_ERR(membase);
 
 	s = devm_kzalloc(&pdev->dev, sizeof(struct sccnxp_port), GFP_KERNEL);
 	if (!s) {
@@ -885,10 +884,20 @@ static int sccnxp_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported chip type %i\n", chiptype);
-		ret = -ENOTSUPP;
-		goto err_out;
+		return -ENOTSUPP;
 	}
 
+	s->regulator = devm_regulator_get(&pdev->dev, "vcc");
+	if (!IS_ERR(s->regulator)) {
+		ret = regulator_enable(s->regulator);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to enable regulator: %i\n", ret);
+			return ret;
+		}
+	} else if (PTR_ERR(s->regulator) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	if (!pdata) {
 		dev_warn(&pdev->dev,
 			 "No platform data supplied, using defaults\n");
@@ -919,22 +928,6 @@ static int sccnxp_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	s->regulator = devm_regulator_get(&pdev->dev, "VCC");
-	if (!IS_ERR(s->regulator)) {
-		ret = regulator_enable(s->regulator);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable regulator: %i\n", ret);
-			return ret;
-		}
-	}
-
-	membase = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(membase)) {
-		ret = PTR_ERR(membase);
-		goto err_out;
-	}
-
 	s->uart.owner		= THIS_MODULE;
 	s->uart.dev_name	= "ttySC";
 	s->uart.major		= SCCNXP_MAJOR;
@@ -997,6 +990,9 @@ static int sccnxp_probe(struct platform_device *pdev)
 	}
 
 err_out:
+	if (!IS_ERR(s->regulator))
+		return regulator_disable(s->regulator);
+
 	return ret;
 }
 
-- 
1.8.1.5


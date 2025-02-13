Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD300281377
	for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2025 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457277; cv=none; b=Jsr2b5Tjl3sX1LBDINIFXJN+3fxUP+/HNMT0DnVefRwR8+SVKM1iMRRvCLkDDxN2Hr3tkbtMQCwp9fk3s5HusWCkzP6AE+Zy1B3tOxoP+ls6I5CNiJZNiAWJx00iPM6+JOtz0MYDZ+ewT+p2590tyXhVlHOm5SFJin3BMH+QlrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457277; c=relaxed/simple;
	bh=8NtIDNPn56BNuzzRwqwLoydtZQD11+nWsJYo43DoMK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c4HK9uUMYlJ6Ty2DJ8ec37PTzFs96UMRbYqiANAFypZh5tW5h3wxq//Nc/jICNrWZAlZCZHsvzaZJlWPPHMh9nYfAL45kxbS91NLV4wTg0+SYtFlws5umN4w2dru7GWrqFMIXk84/1+JlPEog4SU1le3NckbmbQijPnSPVt4BYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kuu2aIsb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kuu2aIsb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso452641f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2025 06:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739457274; x=1740062074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ot60i2jO+mKT6jwVNWuztFNXp0wxNOhC7ns8J4uo4NI=;
        b=kuu2aIsbur4Kgfmw7PbnDYA2NK0yirxifVeyC8h24+va6ppaPeepidyNLFPZgBOkAr
         +LVVmm3ErJ4KSWNlAE7XPbSX9HU7XgXJDGvY+fr0NKjopGy2F/+njMmFgsQBkLFOjoOq
         bc78kRbksCG7xhULVCq+fOc655OhmteRIkvyKPO2A7+AWojjX7iClWRWwNgjqrBRFdUW
         T5wd7P0apUpZFsijBZuVNUo7cEUkS9Cl8x3NfKOUYxKUX/ZT9b59mLf031o1FgN602vx
         3rzTGxfQoCwcUsy4mbKfr+VpGcOhp6OWOdYY/M7+6tDm7syydEuEnz5Q3x7WdzXbuxZp
         5BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457274; x=1740062074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ot60i2jO+mKT6jwVNWuztFNXp0wxNOhC7ns8J4uo4NI=;
        b=czvslTkZU2fA7685izAUY+5D836J7e5safnJc/V7Birk2zT+aX9FUxquFvYitxYeGQ
         NmTehJtU4wyKVUaHkencwJTfszGWZ6B5mvsu3t0DU5tVwNxID6nsZCmQy8zkWhUGuar4
         80ZO0yymTdi7rQ/eX2IKUdvdL3S1rUwAzYa18BEiJlwVfGfbDPstiTe6ot/QATyfmHXJ
         CwN2vgNR71xRtQx//H9E9u/A0q34Ah1xjcyWakiCrvWz9OiRwsHzTVjQgabJ3dAJD2tS
         z8nYH3ppsvJ6rrE2pUxbZAOfbUwdNNU70/hpxIhNFCky76CxwwTHESn/jkFC7KCk1Pq7
         wokQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7+rcr+ZfPOm8WTZheMYsqCckD/lpl0VMOIMQiVd0nSyiLMUp4TPHf7XnjuPvEz/dywA8UBh3PUuW8ql0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+a5pu6OVxywEF8YuYBks0ZSSFMLz4b9aNA9fvx+WZQdMndoaK
	Bz3pEMGG6atwn2mNTOLeZXUZ5F46zz+Uv+G9UHWrGrFvwOoXrrN93/w9qfJYtrA=
X-Gm-Gg: ASbGncs2TNz4XyyehjfWsdjOTnOlQ5Wo8bZRH+JITvTbrQWe/8RbB03oNkqpto4xv/b
	5LXgxIdk5D7eaE4itJS7GwUQF3YzgNv9j6NwbPX3MzUuc3t2pJ1qu6dC5vxFs2Pm0UH7fmNe1Kk
	UzZlZkscA4G+xoWNAfhYWIrS76bLx54GFzKfgd7br7ulHlmO8kKRN9Srr5c41s6utiUoe5AL6ds
	i1ywIUgSAyD/q5bEvf9o7owWn6tBw+Lglou8FneZ6zyzN2Q0i5h8J+/ezXzvLICaAq1aoRm8NiO
	nZeJXZswQetC4/mY/YCFOc8Nra1VpzjeVg==
X-Google-Smtp-Source: AGHT+IFfH3dQ1I2aKMsBDwKG/V6c8D9eVp/YUjk4AMWbV3lmLOxfPn41XxwWY5sdhHBTS6QB8K3UFA==
X-Received: by 2002:a05:6000:1849:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-38f2451a394mr4509032f8f.49.1739457273955;
        Thu, 13 Feb 2025 06:34:33 -0800 (PST)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:ad62:b2f0:914c:91ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8868sm50350815e9.39.2025.02.13.06.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:34:33 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: robh@kernel.org
Cc: jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] serdev: Add support for wakeup-source
Date: Thu, 13 Feb 2025 15:34:30 +0100
Message-Id: <20250213143430.3893651-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This brings support for dedicated interrupt as wakeup source into the
serdev core, similarly to the I2C bus, and aligned with the documentation:
Documentation/devicetree/bindings/power/wakeup-source.txt

As an example, this can be used for bluetooth serial devices with dedicated
controller-to-host wakeup pin.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/tty/serdev/core.c | 48 +++++++++++++++++++++++++++++++++++++--
 include/linux/serdev.h    |  1 +
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index ebf0bbc2cff2..2d016fa546ca 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -13,8 +13,10 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/property.h>
 #include <linux/sched.h>
 #include <linux/serdev.h>
@@ -164,6 +166,9 @@ int serdev_device_open(struct serdev_device *serdev)
 		goto err_close;
 	}
 
+	if (serdev->wakeup_source)
+		device_wakeup_enable(&serdev->dev);
+
 	return 0;
 
 err_close:
@@ -181,6 +186,9 @@ void serdev_device_close(struct serdev_device *serdev)
 	if (!ctrl || !ctrl->ops->close)
 		return;
 
+	if (serdev->wakeup_source)
+		device_wakeup_disable(&serdev->dev);
+
 	pm_runtime_put(&ctrl->dev);
 
 	ctrl->ops->close(ctrl);
@@ -406,18 +414,52 @@ int serdev_device_break_ctl(struct serdev_device *serdev, int break_state)
 }
 EXPORT_SYMBOL_GPL(serdev_device_break_ctl);
 
+static int serdev_wakeup_attach(struct device *dev)
+{
+	int wakeirq;
+
+	if (!of_property_read_bool(dev->of_node, "wakeup-source"))
+		return 0;
+
+	to_serdev_device(dev)->wakeup_source = true;
+
+	device_set_wakeup_capable(dev, true);
+
+	wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
+	if (wakeirq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else if (wakeirq > 0)
+		return dev_pm_set_dedicated_wake_irq(dev, wakeirq);
+
+	return 0;
+}
+
+static void serdev_wakeup_detach(struct device *dev)
+{
+	device_init_wakeup(dev, false);
+	dev_pm_clear_wake_irq(dev);
+}
+
 static int serdev_drv_probe(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, true);
+	ret = serdev_wakeup_attach(dev);
 	if (ret)
 		return ret;
 
+	ret = dev_pm_domain_attach(dev, true);
+	if (ret) {
+		serdev_wakeup_detach(dev);
+		return ret;
+	}
+
 	ret = sdrv->probe(to_serdev_device(dev));
-	if (ret)
+	if (ret) {
 		dev_pm_domain_detach(dev, true);
+		serdev_wakeup_detach(dev);
+	}
 
 	return ret;
 }
@@ -429,6 +471,8 @@ static void serdev_drv_remove(struct device *dev)
 		sdrv->remove(to_serdev_device(dev));
 
 	dev_pm_domain_detach(dev, true);
+
+	serdev_wakeup_detach(dev);
 }
 
 static const struct bus_type serdev_bus_type = {
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index ff78efc1f60d..2b3ee7b2c141 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -47,6 +47,7 @@ struct serdev_device {
 	const struct serdev_device_ops *ops;
 	struct completion write_comp;
 	struct mutex write_lock;
+	bool wakeup_source;
 };
 
 static inline struct serdev_device *to_serdev_device(struct device *d)
-- 
2.34.1


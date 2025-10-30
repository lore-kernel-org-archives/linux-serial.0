Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA21315D4E
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846109; cv=none; b=qF04YQ2+P1YsW7hO7EmVE8rOg/OnS3XmIwdnKRuIvBvXznjeVp24M6iRySqhS3VKhzedbIEiWe2Q0PPazP6x5kXcWJ9wMUafJJXwJPPb1H0aBuNoJBUYAwJJD0O/MvHpFuC/RinW2Slsu0s5HSvzYeXC4tclRxDQdmN4CCH5RXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846109; c=relaxed/simple;
	bh=PPpcJ+LeQYqPWNStI16pHKVV4v0AwdL8+TrLmQI+rT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kr+hRRe+9jHRE2E/n3awS4j2aQzRPvXz4ZwZz6qbNWjbw9W4g7K6mMxaFL7W1RK7nbU30j+5rErr/MWaQKlxgTLHdNRERVA+rQtCgFWv8O0q9VwYLcVz3Gu3/9wBhUHNd4CJp5rOHHp0iDaJYitpbGvdujYbrOVg0C1dfqrTOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdxVrIps; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdxVrIps"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-378f010bf18so24267971fa.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846106; x=1762450906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tMZVGlgJ/tzJ2avrVXvI1uqWovw6kCly6XeUNYPNL8=;
        b=YdxVrIpsJ4mo3HLfVZubJ6QOHHve2693DQtkqm+ElY0SajtuQASRDMKP7EfhCz51QO
         GMN2ErnsgM7b9c0q9Pg2twXfLKgcsKMynaLa8164+9LCQznrl09m4gaK2tfxELBDeQaX
         T3qZw3BnExhUMK3FDHeKFr/4nsQ1z/FpYBGE4tX7wkMm8vaVmv+jbpJmQhzbqGiEie5l
         qHMoHW14tXysiJ0i+RuNDhh46jTsw4jUreLArinPHTix4f6rpz5LL0dzFp6iE4vIClY7
         77YuuPmhJLrDWDBM3Wv4f4Tf+6zYeUrnWbG0OtD92jnKEaf1vIWhd+rY0qw9Gp4FUwOF
         2Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846106; x=1762450906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tMZVGlgJ/tzJ2avrVXvI1uqWovw6kCly6XeUNYPNL8=;
        b=fvySpH23E3ckrHOcKD3rW0HeK8tBrKQjIoVdzTc1bbNgm2QE6bBYidXJoz4WPnPJcN
         9GHqfnJoj7lEboYl50+BwyiK2KVWy9DpGyQgPGy8ttInBrx5/U+pzgqm2gtteTGRSiag
         JSy1ypGUQdN48F1Q2P76z6s4nJWyrMqMhclui1oI2R1Ohv0TwHisIYYat5ejcYC957KT
         iRlTTGjYG6fCctRmfkJFvGRLVZYFnjIoccLiNlxkBl0BTfmnNHdb/37MRaQGwiKnlw7G
         EIfo2xBBlyXN2C8ol3v+XE0ohFvKiSocZ82Y/7W/kyVk1rWPDKc5b8XGkw2WlvqClzDZ
         qfdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2XNCJ8IBKTFo1QwGwFTLi6NZRbpBK98DWu0uz4Q6y4ELxMqIvta63Gcgk9J8L6Nis3y0sDgEby9hwoRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7dzAUCgBXltTi16xEiRDkpjiEtGrAgtqZMmVr4wxZw8VWo8m
	+uMaHVWb8k0YSz96pZ0P4fIcuDLU+v847EKGL3aRcSfHAx+OHr6pwuF4
X-Gm-Gg: ASbGncsaJTveuzhC8u6w5nv9jXkh9RwqtX2necpnm/La0MWIgz4R/OzRT/Z5o2MujbG
	CPCrHAQ0ax9gtRBdKOg7EpbeQs4JaOuyu8+6OC5sDR7ExDFzBzkWjvGKAaOvXLVVhZx+vdURrpD
	CNuRuZ/bR9YKktnRVuFufdu97Q8MiCkO5zHLvlREs3a+stF9wZhn2u/khIe4REwlSSKDzboMSfz
	T0VlANEc6CAwEFs14zOQhZHzFmfdNdkylSyo1JU/otP/ZTz7v+4VSozbGsSP2nmyuPCz7LEBy9N
	IBuBICxJvbjpPaZv7LlkR8HOZiApDCpwJffP5szpP4VVBHYOHQoZvewnOT3nvoAvVuVG0++YtUd
	/q8v9ru1LyhXPy8RXcttxZtfbjlByLZSQNdEyVzS13Aytchyk50tWlYzV097tViRiWxeYbK4OAS
	MasF9Bn64z6vxoZAkKJkTLr8EI2Zo=
X-Google-Smtp-Source: AGHT+IE59wDXoDY9Ty/nX580ekGeU+nSofSVIV4X1mRII6fAyM9CpBxt6kxcxiREme7sLfFLOLbT5Q==
X-Received: by 2002:ac2:4e11:0:b0:594:1a8a:3858 with SMTP id 2adb3069b0e04-5941a8a3a2dmr907581e87.4.1761846105581;
        Thu, 30 Oct 2025 10:41:45 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f6e644sm4793397e87.79.2025.10.30.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:41:45 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: a.shimko.dev@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_dw: Fix runtime PM and use _DEFINE_DEV_PM_OPS
Date: Thu, 30 Oct 2025 20:41:41 +0300
Message-ID: <20251030174142.2039122-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pm_runtime_set_active() before UART port setup and registration to
prevent runtime PM from suspending the device during probe. This ensures
the device remains active throughout critical initialization phases like
dw8250_setup_port() and serial8250_register_8250_port().

Add proper error handling in dw8250_runtime_resume() to maintain clock
state consistency. If clk enable fails, roll back previously enabled pclk.

Replace deprecated RUNTIME_PM_OPS macro with _DEFINE_DEV_PM_OPS for
modern kernel compliance.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---

Dear Maintainers,

This patch series enhances runtime power management in the 8250_dw
driver and updates the PM ops to modern kernel standards.

Thank you for your consideration.
--
Best regards,
Artem

 drivers/tty/serial/8250/8250_dw.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 710ae4d40aec..0c0a9fc97fe3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -643,6 +643,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = pm_runtime_set_active(dev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to set the runtime suspend as active\n");
+
 	data->uart_16550_compatible = device_property_read_bool(dev, "snps,uart-16550-compatible");
 
 	data->pdata = device_get_match_data(p->dev);
@@ -685,7 +689,6 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
 	return 0;
@@ -741,19 +744,25 @@ static int dw8250_runtime_suspend(struct device *dev)
 
 static int dw8250_runtime_resume(struct device *dev)
 {
+	int ret;
 	struct dw8250_data *data = dev_get_drvdata(dev);
 
-	clk_prepare_enable(data->pclk);
+	ret = clk_prepare_enable(data->pclk);
+	if (ret)
+		return ret;
 
-	clk_prepare_enable(data->clk);
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		clk_disable_unprepare(data->pclk);
+		return ret;
+	}
 
 	return 0;
 }
 
-static const struct dev_pm_ops dw8250_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
-	RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume, NULL)
-};
+static _DEFINE_DEV_PM_OPS(dw8250_pm_ops, dw8250_suspend, dw8250_resume,
+			  dw8250_runtime_suspend, dw8250_runtime_resume,
+			  NULL);
 
 static const struct dw8250_platform_data dw8250_dw_apb = {
 	.usr_reg = DW_UART_USR,
-- 
2.43.0


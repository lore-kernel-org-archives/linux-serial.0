Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CDC10F31
	for <linux-serial@archiver.kernel.org>; Fri,  9 Dec 2022 14:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLIOMV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiLIOLg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Dec 2022 09:11:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A872425C4E
        for <linux-serial@vger.kernel.org>; Fri,  9 Dec 2022 06:07:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso5832298wme.5
        for <linux-serial@vger.kernel.org>; Fri, 09 Dec 2022 06:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nofF3uq4mMCbmKOkK6zREu9Cnd568OqVIOgqPBzLczQ=;
        b=7vgfFbEF2nf6NQkTEVbI4W1ni7qg48IYIHg46dDKOOO/5HNcsRjlzq3pRL8ZYe0X+Q
         VonuKatsOY/CzkY4JOdxL4a8uzG94YJWp6vxqjuJIuSYDcwZPxPKQncRe8NDHknoMuyZ
         IvYnnM68rI+nNRHSLqs6cJrlbqMzziLrSFTaoboDp3S21VpQvFSZw2OOT/bmaa3suZUj
         Yzpnq/DDL6D/wSD3axjP4V50VmonoeN5+2sYGg09WRA1I/uqmUYH/djtSQPq9MmeS6t+
         DghXv51PMutOGkAnEwtT4USksj8Cly2/oArCcG/a4yG4OmZVYjKqtn2zCVLOhsBevlfl
         pBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nofF3uq4mMCbmKOkK6zREu9Cnd568OqVIOgqPBzLczQ=;
        b=sPtf7a/G8eBJhhoDUHUFSV9Y9BkSGKmVn/geeLHWYGU2uNasvQ4QWpXz699DQMUwXc
         iSZxpdaqzSTwLN2qTU1enk4iqnl2K40iAf2SEE4J65ZJXf1gdPyAB1f2VaSS5BlkiEMN
         PpMDNtPF2gQLLAvOxiH9u6hWoSt3WXHb6fITQxeiaV+4OCdQ9yInMw5UWm7pEhVINm9W
         fB0XKIYcA9ZVF0+cR4RfUXrzVpliLtoBv5cempFBMF1Kellp5epQbtEO6qvkmtatT/AT
         +88yT1yqru0ikdXpqTV7RM6eHEEo4L5pRc9gWBl5aixr04pIOK1RlRwWWpTt03xCEJxL
         ZJew==
X-Gm-Message-State: ANoB5pm584M6h5RegINGwMzZZ8Mfz1w4LGrcqOhSrAMbxn95ySuMO7v/
        QTAPYVPQTaSTkWHirshOvvAQCQ==
X-Google-Smtp-Source: AA0mqf6v7YakytNoN0NrAI81R1P8GQ1jxvefsU4UuQfsuRoqiC+9Hy8r1tsShgHTdWQ+OC29fqGWgQ==
X-Received: by 2002:a05:600c:34cd:b0:3cf:c2a5:5abc with SMTP id d13-20020a05600c34cd00b003cfc2a55abcmr5244101wmq.17.1670594857347;
        Fri, 09 Dec 2022 06:07:37 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:51db:8fd7:45e0:fe69])
        by smtp.gmail.com with ESMTPSA id q3-20020a1c4303000000b003cfa81e2eb4sm1869848wma.38.2022.12.09.06.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:07:36 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] tty: serial: qcom-geni-serial: use devres for uart port management
Date:   Fri,  9 Dec 2022 15:07:31 +0100
Message-Id: <20221209140731.573503-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221209140731.573503-1-brgl@bgdev.pl>
References: <20221209140731.573503-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Shrink and simplify the probe() and remove() code by using the managed
variant of uart_add_one_port().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 83b66b73303a..16532cb64465 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1469,7 +1469,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, port);
 	port->handle_rx = console ? handle_rx_console : handle_rx_uart;
 
-	ret = uart_add_one_port(drv, uport);
+	ret = devm_uart_add_one_port(&pdev->dev, drv, uport);
 	if (ret)
 		return ret;
 
@@ -1478,7 +1478,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			IRQF_TRIGGER_HIGH, port->name, uport);
 	if (ret) {
 		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
-		uart_remove_one_port(drv, uport);
 		return ret;
 	}
 
@@ -1495,7 +1494,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 						port->wakeup_irq);
 		if (ret) {
 			device_init_wakeup(&pdev->dev, false);
-			uart_remove_one_port(drv, uport);
 			return ret;
 		}
 	}
@@ -1505,12 +1503,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 static int qcom_geni_serial_remove(struct platform_device *pdev)
 {
-	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
-	struct uart_driver *drv = port->private_data.drv;
-
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
-	uart_remove_one_port(drv, &port->uport);
 
 	return 0;
 }
-- 
2.37.2


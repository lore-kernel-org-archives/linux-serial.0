Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBAAC3DA79
	for <linux-serial@archiver.kernel.org>; Thu, 29 Dec 2022 16:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiL2QT7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Dec 2022 11:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiL2QT6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Dec 2022 11:19:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2213DF67
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 08:19:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n3so17062234wrc.5
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDpCQXfYYeEajOv2TSbXiA18Zt/t8Tes9TDsjO3NMJY=;
        b=yNLYjLmFkWgpBuxsj3eCtD/tewyWrBUjf/VDqz9k2I8wFreh2JLvBmkwy76s9K2bR0
         NjIjDB5jdTOVn5I7OCol+10dKoOpfQDSmQsREjobtiiX+no1N6HDVDac63lGKrKVJHI7
         a/dNQgrAgkkbX6eo8gyHKBWD9yzCRpHHF0r9Wv+4q7mBUQyxIEGYIw8d/V2Ev/Sv6P6o
         70VS6oZnZq4wNuZ+4RA3ID0TQtRQLJnvpOtvu07/0mE5+IGovwljbG+qshXgqn8So+IN
         W8/Ex4HcTs7FfWUC1aXRWR1q4M9guN1IOsi0ZCSeoyBKrtN90J6A1o80zu4/EZ9dtDYs
         Fubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDpCQXfYYeEajOv2TSbXiA18Zt/t8Tes9TDsjO3NMJY=;
        b=ws++ZCdCUUpRugtezmfii/pk0GWMDTTFQy+rFe3KSXJse+Xd6MX7aHj/7EA9xgAVDV
         Mc7GxhdvRKd+7zbQf3mRVnipDHpy40/6VQUzLQq94ilx4e3fPPVwDcr+9CvquxNGknVo
         N1KgS87C/J3vx14b5vw4qFVhm1QNCDEj3UUZ2DmR0QG6jBtXJIGsZlGCGdIzjWFyxQyn
         a7wZzWzq1PvNKYexL4Jqb2ZkU0ch0tUSxm5/UphZACKNETZCTf2ZnhSX6BbRfE7QE7Cf
         ljmLgILbXRBuuHNCHssvMCKkqw25pezMYtCfSrBWOYPpi44tr1O6Vxqh0iQWdBVGn/3j
         BzFg==
X-Gm-Message-State: AFqh2kptmo74vuOtgbs3DnjHlsMf+ClbucLK0Ef8VgRBkT7IeAVN0+YB
        fvX8OrBmu40Ba8QAs8vCSIwzFw==
X-Google-Smtp-Source: AMrXdXvJkZIZ8ZCse4FEIYklGaB6f5dxdugGRdR7nEI4aKVZOu1OLJno2BcF9sbWPcmY//eCfxVizg==
X-Received: by 2002:adf:e383:0:b0:267:b8df:932b with SMTP id e3-20020adfe383000000b00267b8df932bmr23522542wrm.23.1672330795175;
        Thu, 29 Dec 2022 08:19:55 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d49c5000000b0028cf987d944sm1333199wrs.33.2022.12.29.08.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:19:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH 2/2] tty: serial: qcom-geni-serial: use devres for uart port management
Date:   Thu, 29 Dec 2022 17:19:48 +0100
Message-Id: <20221229161948.594102-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229161948.594102-1-brgl@bgdev.pl>
References: <20221229161948.594102-1-brgl@bgdev.pl>
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
index b487823f0e61..7d5b51d7fb9e 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1470,7 +1470,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, port);
 	port->handle_rx = console ? handle_rx_console : handle_rx_uart;
 
-	ret = uart_add_one_port(drv, uport);
+	ret = devm_uart_add_one_port(&pdev->dev, drv, uport);
 	if (ret)
 		return ret;
 
@@ -1479,7 +1479,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			IRQF_TRIGGER_HIGH, port->name, uport);
 	if (ret) {
 		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
-		uart_remove_one_port(drv, uport);
 		return ret;
 	}
 
@@ -1496,7 +1495,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 						port->wakeup_irq);
 		if (ret) {
 			device_init_wakeup(&pdev->dev, false);
-			uart_remove_one_port(drv, uport);
 			return ret;
 		}
 	}
@@ -1506,12 +1504,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
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


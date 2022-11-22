Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884E4C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 22 Nov 2022 10:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiKVKXu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiKVKWL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Nov 2022 05:22:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDE14FFA9
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:53 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id t1so10358472wmi.4
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBSJ9X9pr9Z0i2+NFcnle+eN9VzlxNW46WoYTtGtQAo=;
        b=cNOOrBVDDBxp8Mc+etJ2bnstzSg1Lzp5SAUFfR5Ck/B28wVrN1R9+kJTGe4UPeXN20
         Zu1NxMwctssO70t4AhcPojH9Lpd/OtIVYxCP/o9t4g/osQ4RmxjOUk8kIaLIBQF2LTGI
         DzyLxy/b76Ry0jdaUUPWKo3Nfe1MipiYEfkSOr7cffF2StDF4vuszG4StaL+rdKN7ywA
         ltZaddUhWCDNpCdOEbMKnGmEWn6OQRtY2/yxSTsppKMnfHg3nLC+8DDm6ndI2qqMhwwL
         xEmt7dQflPtTlvn2Rhwr3DlFu+HeFd9HeWUU16GLiORzmPYaUnclQePBH3oRJ6LrsvBj
         OVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBSJ9X9pr9Z0i2+NFcnle+eN9VzlxNW46WoYTtGtQAo=;
        b=kPOWdWGU1M/w6a203q035Oq039m/PhhJaQUJwtFQJPGEuBjOvYoIqkeTFR3j59Rblp
         1cSlmUhJqzS73AMt9WeuSU7gypYUz1li0HzyzRtcaIiGsBUohGma6tGfCfGj6DuO7QY9
         OMsTvVT3zk2pwjWYqMBYTnDR1pHr1+pejaXY38MtSYECx98BLhDzYBmWx+1KYU/y5wUe
         DqBzworD+LCY8vnbqdOxdR5svNF1jhzXPUFofutqyNdiThunAEygeGdUGZXTo4hYM++b
         Vuvoc+TaMxeMMUDo4cGRz+kzLoPdXMfogdGwsAYI5okHpfPHS5g4SdyG9OybK/fK75uO
         ClYQ==
X-Gm-Message-State: ANoB5pnPQtOogbi90U8idF86DXrvp4npdnOthuu1ezKDzMpYnm5pW4Km
        l2DG0S6bGA28sLJlzCV6alHgiw==
X-Google-Smtp-Source: AA0mqf6hZkdlXyqPZJiyPnxJlhWvw7hy1el3QF7vnCcy3ErQ04FPrEZZTgfw8fLc6lEPvbo9gfIwxg==
X-Received: by 2002:a05:600c:384f:b0:3cf:9377:c76f with SMTP id s15-20020a05600c384f00b003cf9377c76fmr3817135wmr.189.1669112511702;
        Tue, 22 Nov 2022 02:21:51 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:51 -0800 (PST)
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 11/15] tty: serial: qcom-geni-serial: stop operations in progress at shutdown
Date:   Tue, 22 Nov 2022 11:21:21 +0100
Message-Id: <20221122102125.142075-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122102125.142075-1-brgl@bgdev.pl>
References: <20221122102125.142075-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We don't stop transmissions in progress at shutdown. This is fine with
FIFO SE mode but with DMA it causes trouble so fix it now.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 036231106321..82242a40a95a 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -865,6 +865,9 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
 
 static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
+	qcom_geni_serial_stop_tx(uport);
+	qcom_geni_serial_stop_rx(uport);
+
 	disable_irq(uport->irq);
 }
 
-- 
2.37.2


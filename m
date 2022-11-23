Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4EDC3A59F
	for <linux-serial@archiver.kernel.org>; Wed, 23 Nov 2022 11:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiKWLJs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiKWLIe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Nov 2022 06:08:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDBCB483A
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 03:08:16 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1041170wmg.2
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 03:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBSJ9X9pr9Z0i2+NFcnle+eN9VzlxNW46WoYTtGtQAo=;
        b=ja4+W1jEpsH8IErFm7dMfOR6osTp3PvRK/79rIXT0E+hHFA5TgZynARrHm1/8P3WnR
         EJt1uCTQKkJxt2DdA4lpEzHSNSq/FUNk/JGIwbSIl7yzE1uR5W+Z9l+a69RC63LmUHl1
         n5ZmZ/4m51Z7+ZZPJTkVwcooV7FndRr4kiiCUZ7OD+bxCO7pgWDapJgVH7fkdi8A3RFd
         510VYT98Hik+yO6mhv5z3eP7DEAjnKnJKmlDIW/gnF6lIlC/5FYtzZJX8fDE0/+rhRky
         w7dhyStbmJyQ7C8Ah+mhPXG8g/8h3GQ37ubmGb8n+w1ZJH0IFf9B+sJa6DHBWZN3vr8a
         s66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBSJ9X9pr9Z0i2+NFcnle+eN9VzlxNW46WoYTtGtQAo=;
        b=DO+FBZt0DEZrDuBHwcqu7aP0AeSKoAOZBOJKhOWzcjwkAuLmt/aMIVsIfZ24lCR7Fu
         RMIO21tLewjBDwQ4SZt3QE0c+4TpzAjAlN8jVaXJQ22kocUfC5n1gGNy5Y1Ham7hymc6
         9/YP11lfvR/QATuEbZbO/r6R547/wxma0tP14qZL69HwVljWhVTTAIlIMZwV68JtU0T1
         INgIcqKytkRKNWVfsrggeEoBLOKSMdylzXeEazjcxN1FNPkAfyOpEJJURbjqUhTAbxCR
         nt+CwsenlEXQqg81dcoOeHOD+IogVQbrjJ7BNfSLEMY2QYdHFi1UH9IHWWZ98NsYopwH
         +T9A==
X-Gm-Message-State: ANoB5pnGmnwzoBsFfMaQ+eg8uiZAdRzYlpPMKhlThTrBpgugsI4lUfRQ
        rn07r+JainuE51ecapgyIvrUFg==
X-Google-Smtp-Source: AA0mqf6vsa+V+vsSi3bWTVFs3TJdUlWUuW5z8+WoTDBQzJSHc/V3on/vqmuOTF0NzH09nBzYfRK6Gw==
X-Received: by 2002:a05:600c:654c:b0:3d0:110c:d25f with SMTP id dn12-20020a05600c654c00b003d0110cd25fmr13782378wmb.125.1669201695202;
        Wed, 23 Nov 2022 03:08:15 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae74:d94f:4677:3378])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm2560406wmq.36.2022.11.23.03.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:08:14 -0800 (PST)
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
Subject: [PATCH v3 11/13] tty: serial: qcom-geni-serial: stop operations in progress at shutdown
Date:   Wed, 23 Nov 2022 12:07:57 +0100
Message-Id: <20221123110759.1836666-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221123110759.1836666-1-brgl@bgdev.pl>
References: <20221123110759.1836666-1-brgl@bgdev.pl>
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


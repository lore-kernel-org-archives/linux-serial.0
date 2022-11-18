Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE01C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 12:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbiKRM0b (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbiKRM02 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F45976E5
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v1so8963295wrt.11
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJiQI08Pb3pmpY28T3+Fd6ggBQFLoumFh4Lv/NyHmzg=;
        b=NTwSgH/pPCy0rx9k8+4HSIGh4YIOeNP51I2+IQZNCer+bRZZJMrHL4W8MOAZaSlcHa
         CQ3/fD/YOF7RVGFCC9csekJzz7aov9U4qd78L338s5sACCKRMpjk7BFjGdD7JViUsqKE
         Nc4YU02rLOIRMxsypwq3fAN7CJWgOTIE/AZHR110qhWm5SWYkZgOL2ghf/y9GdG5oQ6Z
         e7OYrK88Uok9baa7uaJTzMVwDpfgce8jdDZi8QKiBjpOCuNJ7x1L+2Si/dUbc1pHN2ol
         erzGM6k83Pov8QlyGvBpFXV3Xm6xzcPIICPjbeblWIjZRX7mbUVasH1o5J3PV/xC9OlN
         CS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJiQI08Pb3pmpY28T3+Fd6ggBQFLoumFh4Lv/NyHmzg=;
        b=OBRYZETo3T+IID++ZYBkHdtI1Jls4eQisYyAzVOK45iqP2qpTejVAc9ktHvOZz6HhB
         JmpmatHCoY7RIsKY7T3Ik5phFZBGovFi+kywIbXkS5GRgL2ZH30ZTcvcnilaLZT/FHHU
         e9XaOS7DEdNcicW6R5jD+RAUxeWULKskc9LaofQerSEIkKyAmwsZ6gCJnrasIUDpSobC
         J9VWeq3bIL9vycjpf/7zqRP/tNTY0+sXmo5loHiPQUJK1Av9P4sUvFsLntEVQimftqvY
         cbvxO8RMCNf3B32fgJOcVnMsge3ipbsLDjk1qvmYJpheHnyBW/n4wtKvtVu5iuUr9sR4
         ckZA==
X-Gm-Message-State: ANoB5pkecqNkHOjBuZpxjOjz6o3RN/rgFrkSV9URE/tZsir40K0d/WdZ
        u5+dJ7rwTKztnVl1jmkbZX9Fzg==
X-Google-Smtp-Source: AA0mqf59q2fvpqJa3HC7aoMwXyiWX2TtLzh14/FzlTwnW6Ry65yk2a7Yc0oPWE4Kjt69fFUtNKh4dA==
X-Received: by 2002:a5d:678c:0:b0:235:14dc:5e14 with SMTP id v12-20020a5d678c000000b0023514dc5e14mr4302820wru.252.1668774368100;
        Fri, 18 Nov 2022 04:26:08 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:07 -0800 (PST)
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
Subject: [PATCH 06/15] tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
Date:   Fri, 18 Nov 2022 13:25:30 +0100
Message-Id: <20221118122539.384993-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Simplify the conditions in qcom_geni_serial_isr() and fix indentation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index dd1491a72deb..22c1869c60f4 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -824,20 +824,18 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 
 	if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
 		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
-					geni_status & M_GENI_CMD_ACTIVE);
+					   geni_status & M_GENI_CMD_ACTIVE);
 
-	if (s_irq_status & S_GP_IRQ_0_EN || s_irq_status & S_GP_IRQ_1_EN) {
+	if (s_irq_status & (S_GP_IRQ_0_EN | S_GP_IRQ_1_EN)) {
 		if (s_irq_status & S_GP_IRQ_0_EN)
 			uport->icount.parity++;
 		drop_rx = true;
-	} else if (s_irq_status & S_GP_IRQ_2_EN ||
-					s_irq_status & S_GP_IRQ_3_EN) {
+	} else if (s_irq_status & (S_GP_IRQ_2_EN | S_GP_IRQ_3_EN)) {
 		uport->icount.brk++;
 		port->brk = true;
 	}
 
-	if (s_irq_status & S_RX_FIFO_WATERMARK_EN ||
-					s_irq_status & S_RX_FIFO_LAST_EN)
+	if (s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))
 		qcom_geni_serial_handle_rx(uport, drop_rx);
 
 out_unlock:
-- 
2.37.2


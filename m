Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF41C4332F
	for <linux-serial@archiver.kernel.org>; Fri,  2 Dec 2022 08:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiLBI4x (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Dec 2022 03:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiLBI4I (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Dec 2022 03:56:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFD8BF90B
        for <linux-serial@vger.kernel.org>; Fri,  2 Dec 2022 00:56:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso3706773wms.4
        for <linux-serial@vger.kernel.org>; Fri, 02 Dec 2022 00:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrodxjE3++JzSf9Q5uxlAVuutjj+cagca/Bct4wXLdY=;
        b=tIuPN7gVpzhf5tzAOu1OwiGIo8Y2MQmTpARnakTsWoSGJ5neM8dBZrSunMVPCJ7q4C
         IIHyD0b4thOp5VkFipRYdtXOUrCbI8TYsFNYGL4XhEIBxHTaNwwHkRb94WFirpaLkMwu
         qHKmGg7Tft980XwnRXwD4wE+IJUHxEqVNRGDemAZRniDFh+j5FNwrLZ39s8vUjNgv/HD
         84tTBYV8nhrii+zA7SdX4Crpr5yJMNqLwajxOfVj73JmeEty1JP9ptohSQUleAUU4pM7
         m5t/qIA78T3UqJNUSbzIhmu+v0IDgJ45d22b/44mx8Sw6B9xc0zrjMopg1kA6v8VDI1X
         3+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrodxjE3++JzSf9Q5uxlAVuutjj+cagca/Bct4wXLdY=;
        b=BLmZHygZbZ8gTX8ZFp+/8AyFPnbuT6QgiyipmOILUQDaubj3c5yPL7ySXWFksT3b4V
         nC3Iv66TZ5N+c/5meHhHtzZSC2iLiOkPwAGzDVN2TtoFYiGHUIHVXndqc9ErgOMCtGsW
         t2x8t+8RQNvRZ+hOMV2eeufJI3bclshsxcweZxJmowNQnUlJf/VuDEB06a5W5pUMTtKg
         d5EBr/9Hp/0Pgn5qui3CDDR1TaYN5zjJIq1GjhKcowfJoTEmCLWOzKiF7ZNRriAJabif
         X+CZE7Lee7lv6cEPRysc1IgSzoelnSXoIqSNLTNcK0Y9gFcIqReH4OoMFy4p/MD/ivnp
         sVOw==
X-Gm-Message-State: ANoB5pnqtD8HzYQPtiOfaY/uSPEbN1Jwaov7j6mnlQTU2xSt1vGX2GCO
        mbEKMzuPsiTz5aMBp+DlOwyGGw==
X-Google-Smtp-Source: AA0mqf61ZY7CS7HBSf5vp8aAXkwToX/vU8MNJwLF/dElJBE+4oQl0yyFZBodseqLwlp/q6Qd2NdIUQ==
X-Received: by 2002:a05:600c:1907:b0:3cf:7981:9a7 with SMTP id j7-20020a05600c190700b003cf798109a7mr51178838wmq.87.1669971363351;
        Fri, 02 Dec 2022 00:56:03 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:29a4:6f04:ddb1:1ed7])
        by smtp.gmail.com with ESMTPSA id a13-20020adfed0d000000b0024219b1cb1bsm6527517wro.60.2022.12.02.00.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:56:02 -0800 (PST)
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
Subject: [PATCH v5 06/14] tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
Date:   Fri,  2 Dec 2022 09:55:46 +0100
Message-Id: <20221202085554.59637-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221202085554.59637-1-brgl@bgdev.pl>
References: <20221202085554.59637-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Simplify the conditions in qcom_geni_serial_isr() and fix indentation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index ec2523736e99..fba02f71a874 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -827,20 +827,18 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 
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


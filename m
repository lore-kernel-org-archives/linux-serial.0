Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A39C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 22 Nov 2022 10:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiKVKWx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiKVKWA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Nov 2022 05:22:00 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7180531F90
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s5so6771918wru.1
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrodxjE3++JzSf9Q5uxlAVuutjj+cagca/Bct4wXLdY=;
        b=ndwSmtL+kAnfwuKf91FC6UZir/RZb1ZDDCnNFXt0T4Lq8cS85ReAD+6SX5v0lqE++L
         0445vCIfJJSnQYou686J4MPxo4mqcXUpWrqHwqPlb2QfhZ5KVxoWZujCf1AUG9lJo2EW
         Tc+j/Vk3YdG2GdTGHKQM/rEFn3XFE1fFnYs4fUwBQC8Rkf5RbUA5xNDQzaTFDKFboDNR
         jo7kngEVk8S3VnBahuzZPCvBhBY2mHiuJkOpv2PYV/ykJjhq/sPhw7jR4gQUYudXVJ8H
         odrTvG+8/1snCWxy6gR9x9FEMaFWyt/53O0Vm2lZkBqm5SaP4G2D4pnG0xnaWab09IMi
         CSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrodxjE3++JzSf9Q5uxlAVuutjj+cagca/Bct4wXLdY=;
        b=fa1VaAeR+hR+oVhkASVWzUo35afYXm4k7cTpGUW8HzHLlhYMgJDVxJeiSCkXanRrvL
         /4GnHk6tx0izONSR2wBxnyBH8lsYF2s7w9IbIWfjPiFyGf0aEDCUc9aVVtZ+PFm4Z2As
         XkJHxaQ/27Nk8is5W9XEQ8PO3E3kNkXchKHdFYqWEqK8Bly9oWaMOjfLIuNpISMrNMsI
         gGoG1h9W0RBHxhIFbSM+xe9CgAuUQawIL2TqShMI98JTg2nuefmNqMbdKBz2eWXP8+S2
         y+xSD35eU56pu0LtqdrZR5bQRI4LT7A4XNqK7r+c//c8U6nMkahFNkoEEWTFUCz/m6Gv
         u0Fw==
X-Gm-Message-State: ANoB5pmgXURdU0DpjoXyG1Q1jNFJqrxSrstq42kiOQ2FjaFeESN8lvBh
        x4NXqsaODbX2hrX+ckY6eVwR2A==
X-Google-Smtp-Source: AA0mqf5xuv1AmUgpzLsqRaOMYIcXA6pTY60wDLqH7jl0HFNAeGjtRx0Gzxn3UOiKZEKaAZwH4k713g==
X-Received: by 2002:a05:6000:16c2:b0:241:c56c:b485 with SMTP id h2-20020a05600016c200b00241c56cb485mr10018000wrf.566.1669112507036;
        Tue, 22 Nov 2022 02:21:47 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:46 -0800 (PST)
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
Subject: [PATCH v2 06/15] tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
Date:   Tue, 22 Nov 2022 11:21:16 +0100
Message-Id: <20221122102125.142075-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122102125.142075-1-brgl@bgdev.pl>
References: <20221122102125.142075-1-brgl@bgdev.pl>
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


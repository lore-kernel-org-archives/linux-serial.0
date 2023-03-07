Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F812C678D5
	for <linux-serial@archiver.kernel.org>; Tue,  7 Mar 2023 15:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjCGP46 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Mar 2023 10:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjCGP4Q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Mar 2023 10:56:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136FD898C3
        for <linux-serial@vger.kernel.org>; Tue,  7 Mar 2023 07:55:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t15so12605233wrz.7
        for <linux-serial@vger.kernel.org>; Tue, 07 Mar 2023 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678204545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRjk8VOppnGqzOz7XErLSEL3dWYMpgLTb6kuNQ17jK8=;
        b=eZrAbeN4kKHrj/W0DHIGzXlvGANWW+5yMvHLqz3FFmu6qH7AU6P+SItcRoa7rfBPDm
         xdLgqEe/47cGXLKlgqRqoxlD0V4sjR8fHv5jDSJo/cS4f5W50o33s8Ykpc5VoyWcEEMH
         AqG5Rl1u4TeRXnnxCGZ5q33dhoMQANbSoDjzTZIHtSy+r53aEZIVo+wpqtHAq8iDF74L
         0vx8wQdFLpqCmqHGJRESnN4NxQ7j82BItCzmjQunVI6umHiIqTtG/loLmjvPUsmD0CzL
         1zkLZ2LroIsxvaydN65lm0WfPcedfi6BeVpUSWbn3SegwmpCkbdsEZV+gNoO2ibQjCmQ
         u+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678204545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRjk8VOppnGqzOz7XErLSEL3dWYMpgLTb6kuNQ17jK8=;
        b=JHL/Y5JxScz/10r+f/wON/ClyGmHcyAvM23IS4CNKJyXJIayhkslvJk8/FvHiouJvM
         LaRRJijZrP4SO9q03kU8N97YAoYj0xBVZz0Q3FxPjtuAJUVfxKZusA+s04OXN1YFBenE
         RkQe1ZckM6vrOjesTUTOzcMhCyhYp1s5IDS1BzVPTZ1TuVL0UEy4yMxbq0LVP/3OIcXt
         kw3v/scvgJWmXgWjuRRRLR9QdLVOCRl/9RPmeLJR6qzLNMxRuhomQ2T2uU3QFTyPBvpv
         1pWEAUDkjNUrl/o4yIwIzhtKGtYx8Z4nLBtz+Kkk3BPDnmwXYKdAW4LbcdWIa1ETRyCb
         bhOg==
X-Gm-Message-State: AO0yUKUKfhoVhFtiGrHqareGq6axB0LksHvG00slU7wS/M+sH74PkwCj
        NE1v0Gzwsbq9iyOd8rX63lqzmA==
X-Google-Smtp-Source: AK7set/N/5BkOLByxbmUAWxPDJR0jyVXI564X6f26/BBqGzsj0yvuKvIsK2Ppkj/Voswj+bqthK4HQ==
X-Received: by 2002:a5d:6148:0:b0:2c5:5335:73f3 with SMTP id y8-20020a5d6148000000b002c5533573f3mr14139460wrt.34.1678204545343;
        Tue, 07 Mar 2023 07:55:45 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b003e1fee8baacsm18115389wmo.25.2023.03.07.07.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:55:44 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, gregkh@linuxfoundation.org
Cc:     konrad.dybcio@linaro.org, jirislaby@kernel.org,
        bartosz.golaszewski@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] tty: serial: qcom-geni-serial: check correct dma address before unprep
Date:   Tue,  7 Mar 2023 15:55:41 +0000
Message-Id: <20230307155543.31021-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

looks like there was a typo while checking validatity of tx_dma_addr, the
code was checking rx instead of tx.
This can potentially lead to memory leak, this patch fixes the typo.

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d69592e5e2ec..5972b5c317d3 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -596,7 +596,7 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
 	if (!qcom_geni_serial_main_active(uport))
 		return;
 
-	if (port->rx_dma_addr) {
+	if (port->tx_dma_addr) {
 		geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr,
 				      port->tx_remaining);
 		port->tx_dma_addr = 0;
-- 
2.21.0


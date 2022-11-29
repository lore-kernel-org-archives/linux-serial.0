Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D339FC4321E
	for <linux-serial@archiver.kernel.org>; Tue, 29 Nov 2022 11:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiK2LBw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Nov 2022 06:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiK2LAt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E258660E91
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d1so21468928wrs.12
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuwEN90AtgG+bvIlYhOJ4Y3TdxahsORXGOntfwKDvGM=;
        b=pRIFqC4dlxFU+bQiqjtLoDfrz5xyHyCSsTH7JTWf1/eAN0WYhoIrFGKArOa736Dw2/
         1DDbDoebKoUvem0JG5Y73B/uSePxmqfLMPpbuMpe8ZD0hf/72GKUJQEEkGW7s8bN4eKU
         0xXfm5XP8rMPtSJFP5f85Wb2hFb3LjNQbxtjt0LH5MuMrMeEmjfVmhmQwjvLEd8jIJbw
         dbo3X0/B7t2xGxo2UbOJvycXZSZ5zjNbR39Pbzcbf95F98UMJ0en/4vtvSgU8F9yamvM
         K5XcTDI62wt7MzSjMccNVRW3H4KpfCSuSduHdQR3DJ/8lFsYoAyPi1sOnamCOFxMiQCr
         nZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuwEN90AtgG+bvIlYhOJ4Y3TdxahsORXGOntfwKDvGM=;
        b=kF3tVXJu4nlG/3ngE7mPROHvBVaV+wuG5qnl8SSBQVgbugcB4EUCO5Ho5esGyR9JaS
         lgWYAW4d/ORbPEXF4JobBdWm8wG3KB5JHa8bQvQmphmNGOFFcgYPHf0o9bCL+3mxPvVp
         +KEAB+w5BWm2HR66BXWhvk6+HHMK0a6oZy73YV2SJnipy8vu+TbLGElzLctzTpBVqK48
         wqjMFRwuEFd0JqrG2556Tk6sJI6RspcIPeWJRKMKX8WOiLwVoKFofL8W3Om4IYTsHQiJ
         M4qZzsKBDIHxHipIONZmVlvPLAm2JNki3+gUw5YVEvQ8aO+JxNTlS4ejbD5IDNXYdA9J
         /Vjg==
X-Gm-Message-State: ANoB5pmBjnKEzGfc95ZisTnzI0RfG+JI2e2MlDgOB9+K4UjI5HJBPRS9
        upNNzq+Yl9MkANHWLgti/rSUkw==
X-Google-Smtp-Source: AA0mqf4RsabVzQK84xDYO1JzgdzlW+eTBl++QKyCuHvr5r+AzIVdwkefDmkyWfFl73DM6qN6EoFLKA==
X-Received: by 2002:a05:6000:783:b0:241:bc34:3149 with SMTP id bu3-20020a056000078300b00241bc343149mr28789891wrb.351.1669719629472;
        Tue, 29 Nov 2022 03:00:29 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:29 -0800 (PST)
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
Subject: [PATCH v4 12/13] soc: qcom-geni-se: add more symbol definitions
Date:   Tue, 29 Nov 2022 12:00:11 +0100
Message-Id: <20221129110012.224685-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129110012.224685-1-brgl@bgdev.pl>
References: <20221129110012.224685-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The following symbols will be used when adding support for SE DMA in
the qcom geni serial driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/linux/qcom-geni-se.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index f5672785c0c4..400213daa461 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -103,6 +103,7 @@ struct geni_se {
 #define SE_DMA_TX_FSM_RST		0xc58
 #define SE_DMA_RX_IRQ_STAT		0xd40
 #define SE_DMA_RX_IRQ_CLR		0xd44
+#define SE_DMA_RX_LEN_IN		0xd54
 #define SE_DMA_RX_FSM_RST		0xd58
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
@@ -235,6 +236,8 @@ struct geni_se {
 #define RX_SBE				BIT(2)
 #define RX_RESET_DONE			BIT(3)
 #define RX_FLUSH_DONE			BIT(4)
+#define RX_DMA_PARITY_ERR		BIT(5)
+#define RX_DMA_BREAK			GENMASK(8, 7)
 #define RX_GENI_GP_IRQ			GENMASK(10, 5)
 #define RX_GENI_CANCEL_IRQ		BIT(11)
 #define RX_GENI_GP_IRQ_EXT		GENMASK(13, 12)
-- 
2.37.2


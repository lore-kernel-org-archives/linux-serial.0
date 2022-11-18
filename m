Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCCCC47088
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 12:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiKRM1T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbiKRM0c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0504C9AC8D
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:16 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j15so8355046wrq.3
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WB27jhF4DCx/Ah98HAn4Zt+8vZMKTVFmQpCWXcHg7GM=;
        b=Hv4j2/dPaM9EBDU7n724L6eQsr4DNXdBQjGvzrtzZDn429adWSeIfWvr+e7+Mjbgfp
         3NqMO0rr+HQIQsWTe0RTQiVILKK9vcb549WGRP+cGKonal19zGGv1Alpm8bIh/5R+0Qx
         cmEgAbVp47aUAPBQ9KyV+jYDb8GBGDTlHuhjGoG2bCMdjDAQPThWMPAsyiNiQKPsXH1e
         ViA7Y5Os/+LZ5VG6GxXLwsooznyMtBZ6aUVhvCJkYCiN+ehm1J0ehhTMxdBOyeIUV+yE
         uTUeMjURKolrFZr6a24URF5pNbnymttJUzfMWu0gmdhKQndYGm2GqegJmBr9Nb+ks9/J
         +cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WB27jhF4DCx/Ah98HAn4Zt+8vZMKTVFmQpCWXcHg7GM=;
        b=4zi+JTSQUisNOwl1p+4EXHY33JtvGMsgxc9KYgMP0I4Lzh856/iBbBjQFFf178MFsr
         6OWXE7mmN2sUrPLqHj+wYZ9kzCfkFFCjblRZdszdsNe9BHugip3CHpM0nuBl0HL6+Jag
         w1p/6MRDJT7LLoRrLyJtvRk5fLEL+QyK5Tqw+UcqTGhY/oMduzWWUCBApub0rqPWJDlG
         27t1s8Zl749LNoNEwUvUjw5nEP1NP8qU6Rx2Mg3koYNi/PqUm9VGsFb8835EOwkQEL/a
         le2tGNDnFCATTcuRSCVT3XZ6XNgOEl1UNL/x8AufK+O+7xvBq1sbStZFbTxholqXvbbk
         bvsQ==
X-Gm-Message-State: ANoB5pkx/flOrXX+5wGfsqbIOWjOvgE8Y77FiaZL13BY3/ArSxG8kkpV
        +uLBU3QQR9Qbun8/0Mv0EqQOnQ==
X-Google-Smtp-Source: AA0mqf5RPSNmKNYUH2/qrCXqX9bGdjEIkUCG//ScGngr0QgwxAVFX2JzCF6xdpSKvgMJWLHkf5jG+A==
X-Received: by 2002:a5d:6a46:0:b0:241:c2d5:7407 with SMTP id t6-20020a5d6a46000000b00241c2d57407mr1285401wrw.623.1668774375543;
        Fri, 18 Nov 2022 04:26:15 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:15 -0800 (PST)
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
Subject: [PATCH 14/15] soc: qcom-geni-se: add more symbol definitions
Date:   Fri, 18 Nov 2022 13:25:38 +0100
Message-Id: <20221118122539.384993-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The following symbols will be used when adding support for SE DMA in
the qcom geni serial driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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


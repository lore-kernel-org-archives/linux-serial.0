Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49F6C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 22 Nov 2022 10:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiKVKYH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiKVKWM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Nov 2022 05:22:12 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088CF45ED8
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i64-20020a1c3b43000000b003d016c21100so5261441wma.3
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuwEN90AtgG+bvIlYhOJ4Y3TdxahsORXGOntfwKDvGM=;
        b=pm9vorLOyiaAwAF9/TjFi6cTTneYhVQ8PReaGylh7jses9Q/PQ5Qikf4ZNkOz9hlA5
         a975HkDG5AptKCKGw9b8S3098WCFv2s8Fpq4jCQYoLjeUYWnHlPaqUWV2FBkTMKu2Wkz
         6P4TN0lJRCmeV5evy/dYN6Xh1aV4AEQwWCTNeUHFrfpFdI3RTPA1a8aEDToX7j1oGoAM
         Z/i68/Fw8qdfDRAeBXQSTgh7THtF4pP/NFvVWGicV0NmFanAmsyvfDT8a5Nojowbx9LG
         AB65Agk/Osr8EM7o5Lc2fgBjTVCwiHOhw81p/sNSRowWrXmJ/V1Dx6TM0z0boDe7+sZs
         VOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuwEN90AtgG+bvIlYhOJ4Y3TdxahsORXGOntfwKDvGM=;
        b=ttat4Ggel2On56QAELXWheHPPp+VK8kXGsWne63D7OZudAyuLfC+lRZ357E28tDX00
         blxXaPR6RfodxY/bzN/fJQTAy0HW0CMrEcjxfXxgpOm6PsU2V/2olJqDLiL2tVU/ndoN
         7WlByXwsjWIWFPypJ8NscpEekEkLoEhSOqGPMz5bWuKf/HppRv3mX9QURD9m6N+iftoF
         UNJdQBT6koFVdldieXnrX7IF13NP9scYmkmt1xzsMJcqBf6SrHwC3ehVjEiV0NzMyBcr
         zIR3ECRZcgBz2QGaionI5u6hiBXTp2tcTMA/PvLpEsRwuAlj+DeejxX1jXOQIB0NWqX0
         RL/g==
X-Gm-Message-State: ANoB5pkjIeG4mymdsKRIcuPpz5ar0nQMy49Yp35CAWEk0Cthb0a/1hW7
        X3EXQMfDaLoFAg7Yc+nsIdMgww==
X-Google-Smtp-Source: AA0mqf4fbw+zj5HmCYuWJqReW81MxMlkjzTRgI8oCuDDWAaFqqnSPYk0ZMW4h5zIQrbfLRA5jXD15w==
X-Received: by 2002:a05:600c:42d2:b0:3cf:c907:a05a with SMTP id j18-20020a05600c42d200b003cfc907a05amr18855098wme.177.1669112514599;
        Tue, 22 Nov 2022 02:21:54 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:54 -0800 (PST)
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
Subject: [PATCH v2 14/15] soc: qcom-geni-se: add more symbol definitions
Date:   Tue, 22 Nov 2022 11:21:24 +0100
Message-Id: <20221122102125.142075-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122102125.142075-1-brgl@bgdev.pl>
References: <20221122102125.142075-1-brgl@bgdev.pl>
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


Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A32C43217
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 12:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbiKRM0a (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiKRM01 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF4976D1
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:09 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so8983241wrt.12
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMYlxBECUyROeU2qoZzKEqhzlBfoiS2AeDouftWiN14=;
        b=h3ylSwylTpt/gTd5gxjRVlnohrLzxyaHkKxHSNdsMOgFdjULJkYTK9ag3H5B7bZGNF
         xpg0lzKa/Kdgi+wwNxNugBCVUxhRzAeEO0K9bZo5r+rixRV2dZT8E1XYBNEu5gFMBPMk
         u3QrTixzNo2+yRMl1tCa5RS9oH4RsO/lSqL1j8ZDZ+J1rahMob66xdS+/rt/GuPB8Fa0
         /MnLjQYgrfLogwNpXSQwcE4A3zNxtyujkrgVt9k5TS5qYNyuHkGAJQeOPW+XFCv5Erio
         Cw+8ATnanhtooLYJuYJCabSEaLbnbmt3/ey5xxHhjF+06VG3BizN8UcivtyLeLRJEKaH
         BL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMYlxBECUyROeU2qoZzKEqhzlBfoiS2AeDouftWiN14=;
        b=gOfBXYfncRZbbBYE2bgnoFYGdH4e8dDK9Ier3aF9fO1G2Y0Dj2qN/laVufATLraFGW
         QZW1oni2eYCKYgM8lF8IlZXcTmD70edOqYhozPOeYYcoNFIcD8nYSkwSCXrzeWCiukqt
         ly+W4SgTtSo/FbLuHvT4WgJBxdT2nX02+iKUSwC1+xAuFG7662dK64du+zfvqDaKFUU2
         dfPT4eaPbu5ZB2+VjNmGmN4Ey0w/3gED5bBCLn1VUOFg+0oBQTE98JDi/5trbrJ1x1Vr
         7lwOY127U5Caba6cxbUYHIh0/7PR2hbuMtQT6KNXxMums5xaJtrwG5WJ6I5RiOIfD+JI
         DP2g==
X-Gm-Message-State: ANoB5pk2hreh2g40YAZl7KqldjXOqJ4TU8KvuAX62dCIRcN/ybI2/Yyp
        X9iVKBKTtj4OrIxb2wyZarHA+g==
X-Google-Smtp-Source: AA0mqf6XQpZNIv4JSPh2Iy9S4x4cMT6r1bE9lJXiqxSKL5yWDvqbOxuNaKATf/tjq89JAK0wQcExfA==
X-Received: by 2002:a5d:408b:0:b0:236:53d2:1668 with SMTP id o11-20020a5d408b000000b0023653d21668mr4185721wrp.694.1668774369037;
        Fri, 18 Nov 2022 04:26:09 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:08 -0800 (PST)
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
Subject: [PATCH 07/15] tty: serial: qcom-geni-serial: remove unneeded tabs
Date:   Fri, 18 Nov 2022 13:25:31 +0100
Message-Id: <20221118122539.384993-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Remove redundant indentation in struct member assignment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 22c1869c60f4..39041538e5d2 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -138,26 +138,26 @@ static struct uart_driver qcom_geni_uart_driver;
 static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
 	[0] = {
 		.uport = {
-				.iotype = UPIO_MEM,
-				.ops = &qcom_geni_uart_pops,
-				.flags = UPF_BOOT_AUTOCONF,
-				.line = 0,
+			.iotype = UPIO_MEM,
+			.ops = &qcom_geni_uart_pops,
+			.flags = UPF_BOOT_AUTOCONF,
+			.line = 0,
 		},
 	},
 	[1] = {
 		.uport = {
-				.iotype = UPIO_MEM,
-				.ops = &qcom_geni_uart_pops,
-				.flags = UPF_BOOT_AUTOCONF,
-				.line = 1,
+			.iotype = UPIO_MEM,
+			.ops = &qcom_geni_uart_pops,
+			.flags = UPF_BOOT_AUTOCONF,
+			.line = 1,
 		},
 	},
 	[2] = {
 		.uport = {
-				.iotype = UPIO_MEM,
-				.ops = &qcom_geni_uart_pops,
-				.flags = UPF_BOOT_AUTOCONF,
-				.line = 2,
+			.iotype = UPIO_MEM,
+			.ops = &qcom_geni_uart_pops,
+			.flags = UPF_BOOT_AUTOCONF,
+			.line = 2,
 		},
 	},
 };
-- 
2.37.2


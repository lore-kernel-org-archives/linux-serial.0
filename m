Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0026C43219
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 12:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbiKRM0I (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKRM0G (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:06 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEE6976C7
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:05 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a14so9048861wru.5
        for <linux-serial@vger.kernel.org>; Fri, 18 Nov 2022 04:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOBbY723QPvtzFt4pwa0mpU0HWVBeuJRMHbL1UtjHyM=;
        b=gQHNmX9HawS79JfeWPLjvmVeWSkxrESjRcvkQVaP6nQPzkyEUQq67QRguT7YByBaU+
         lxZNjUJpiSCTS7S4bLBL+EGQjhi4wHgGb3lGzwgEUp/Hzq1IkfdyXa+7uedgIHDJXnZi
         tDnkzhAm1GxRuVWQFq4Jyh1cvbyTKIi2hLF5vN5qxNLtzJgTw1vp7cKiBUDNy82S6Wsi
         2uHaNc6aOL4Qzf2m+UPQjXjoF6LYd5Bh4vxMrNYMjARRHiGb3F2RXxtXmSVkwsEO2sQc
         SeNSRSck4Sn3FGXPNw5SSSYCSPKnD2AVBGHd8N6saFOkvwDTz4ig9kVUzBEhWMDIfF6t
         5wHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOBbY723QPvtzFt4pwa0mpU0HWVBeuJRMHbL1UtjHyM=;
        b=q8LvwL3NCpyP8V9qX7b1gb/FIMM1NLYfYRHb0RUU2oLve+rvK0I5+j6OUL5a//F9/L
         IS2cZhXQwwBi+UdSUhML4JRyaV4nVx4j8hcRlInPG0AIshEyrBC5FdqCf7czC26gZHLq
         9bZu5KNSMUKBfFXIpuF1TVAe+P3RtdtEyeW/jnmmMRw5wAN0GJCiROFYZ/4pUaNvbSFs
         OojUUo/yxncvv+1Y5VOjRzSAR9Xy7lDINSNO4OTTuxIAcTSnmyVvTxrmBIvtEIWKvXZT
         P6MdBlwVO8lS7rtx23A2tlZaF8OnFa/hNonJUSy8ftuqLcRRtKvbAmE/m3Amcc/BRqGS
         U90g==
X-Gm-Message-State: ANoB5plxe4McvvscHpHw/ylRGstMIsispt5IluwDOfi5J+n0nHR+AxOD
        8u3JjL926JU0Y/lowUQ5+WYsNQ==
X-Google-Smtp-Source: AA0mqf5CXPmfXFowF4YDMQ48wXu2gpCMtYE8nN1WpQzQaxvXUuZHyjNSLGYTeHaT50harnsxkQymRg==
X-Received: by 2002:a5d:4b82:0:b0:236:84b5:2d30 with SMTP id b2-20020a5d4b82000000b0023684b52d30mr4316250wrt.591.1668774364247;
        Fri, 18 Nov 2022 04:26:04 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:03 -0800 (PST)
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
Subject: [PATCH 02/15] tty: serial: qcom-geni-serial: remove unused symbols
Date:   Fri, 18 Nov 2022 13:25:26 +0100
Message-Id: <20221118122539.384993-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Drop all unused symbols from the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9f2212e7b5ec..7af5df6833c7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -42,20 +42,11 @@
 #define UART_TX_PAR_EN		BIT(0)
 #define UART_CTS_MASK		BIT(1)
 
-/* SE_UART_TX_WORD_LEN */
-#define TX_WORD_LEN_MSK		GENMASK(9, 0)
-
 /* SE_UART_TX_STOP_BIT_LEN */
-#define TX_STOP_BIT_LEN_MSK	GENMASK(23, 0)
 #define TX_STOP_BIT_LEN_1	0
-#define TX_STOP_BIT_LEN_1_5	1
 #define TX_STOP_BIT_LEN_2	2
 
-/* SE_UART_TX_TRANS_LEN */
-#define TX_TRANS_LEN_MSK	GENMASK(23, 0)
-
 /* SE_UART_RX_TRANS_CFG */
-#define UART_RX_INS_STATUS_BIT	BIT(2)
 #define UART_RX_PAR_EN		BIT(3)
 
 /* SE_UART_RX_WORD_LEN */
@@ -66,12 +57,9 @@
 
 /* SE_UART_TX_PARITY_CFG/RX_PARITY_CFG */
 #define PAR_CALC_EN		BIT(0)
-#define PAR_MODE_MSK		GENMASK(2, 1)
-#define PAR_MODE_SHFT		1
 #define PAR_EVEN		0x00
 #define PAR_ODD			0x01
 #define PAR_SPACE		0x10
-#define PAR_MARK		0x11
 
 /* SE_UART_MANUAL_RFR register fields */
 #define UART_MANUAL_RFR_EN	BIT(31)
@@ -80,11 +68,8 @@
 
 /* UART M_CMD OP codes */
 #define UART_START_TX		0x1
-#define UART_START_BREAK	0x4
-#define UART_STOP_BREAK		0x5
 /* UART S_CMD OP codes */
 #define UART_START_READ		0x1
-#define UART_PARAM		0x1
 
 #define UART_OVERSAMPLING	32
 #define STALE_TIMEOUT		16
-- 
2.37.2


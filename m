Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5A7C3DA79
	for <linux-serial@archiver.kernel.org>; Thu, 29 Dec 2022 15:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiL2Pup (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Dec 2022 10:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiL2Puj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5C813F9A
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so7943144wmk.4
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVGwSRNkV++8e1tKlPyV6LZX61uuumwYr0Qkw5f5jMg=;
        b=qdeIeDaYP+b+841I6BjiqZzY5PImnho+txhmq4D6ic7R9So491Uvy8ikcrCzHFbjGS
         w6t/yirz4+Bj2W3LRI+3g6ctsmi46P1nr4My7ZGj9gfSWHUQeZNMN+D6GWzVW0/LVWc6
         uPhhVR+rzaCv6cc/+1l4nDsPAN4akFMsPwpHU//iejl9jKhWn5P94WffCcp3Xypar0hH
         0fYoKqiPzmvQqaoVJOPjUZas2PCpaX5xFyBzlHLDlqVnDwV89jwmwyCgogm0qLQ6CE+Y
         uKGQcs/oBk21gA2jStWMbMY+0b8+0Fc6tpp6iSj8+FFtFLUXrjX/FRLL08ZE0BKyWPbP
         2Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVGwSRNkV++8e1tKlPyV6LZX61uuumwYr0Qkw5f5jMg=;
        b=mnc7UHbW6TUKkeIGmVZM93BGqArCDrNzZLwfaD2Cr8PZu8gbo9RISTWjPHlz9BJTRK
         ZAJrnd3hsgVpx6EnasIRv6xdELNqwGa4l4Ei+OA+99MA3sXkjE2GYNL/ffb9si6nGOAS
         JCwVlUgkKtQa0Oq+OWVUVluC+ZFYkejgCkGMiIEr27lspvX1ayKqPIA43OEx1kUj2Pr1
         Tu8fcrpBYh0urqGI+MTDC2Vz7sDmzp2o7BEPycJ4EM9tz5KexYjObx95T8+gaH02c46E
         wVLKtovLQslyqkgPTmGhKHRB8y81yRXxORGIk/LmwlaVUHNCC0kLpeYsVwF2jnDVrwoV
         271w==
X-Gm-Message-State: AFqh2koPRNwL0qd4NTY5it6Cfmyb6WWCycCbsKZaqqHLWtBvYnlP7lNt
        DqtuYOhMXOahyo/fWpxB/C1Tug==
X-Google-Smtp-Source: AMrXdXs8bMflY8UieNb+w9TOC6QrlrG5buh/R+qN1lJfk3+bpQVgte3LGsFnxtTjKbnbKtlyScEzJQ==
X-Received: by 2002:a05:600c:2183:b0:3d2:17db:d6e7 with SMTP id e3-20020a05600c218300b003d217dbd6e7mr23575377wme.20.1672329036989;
        Thu, 29 Dec 2022 07:50:36 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:36 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v6 03/14] tty: serial: qcom-geni-serial: remove unused symbols
Date:   Thu, 29 Dec 2022 16:50:19 +0100
Message-Id: <20221229155030.418800-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229155030.418800-1-brgl@bgdev.pl>
References: <20221229155030.418800-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Drop all unused symbols from the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 31e0faf702a3..359d9f0ba6ee 100644
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


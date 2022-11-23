Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D7AC47088
	for <linux-serial@archiver.kernel.org>; Wed, 23 Nov 2022 11:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiKWLIr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbiKWLI2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Nov 2022 06:08:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2134A15A00
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 03:08:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n7so1234274wrr.13
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 03:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S89n9QHiQI/y9x3/RBBeD2hc63bXZL5TZ/yxbLwZvtk=;
        b=YLqfKb2uPUZ5u8IKKS8v9dFwT1LJ3cQXBokiRhpYXLPsy0W4TeKCSP0n4hLrJWbmgQ
         /WyJVHReGFQoibIMoOazDY19AavkjJyJzzYTuW/q+6S3Zl2CwkSRpO0+o/yB11f+Lvlj
         rxPq23bonpm/1SWbJMHaqMPuecnx/k9wRrjdphPsBoJo+3k2QIVJd/g/mQB4rNWLkWJm
         pg2DzOdMBSgO08ySMjaT73dhp90A1xPbnCzm5gNwM7kNXW8pE2Pf0APhe8GpIrBYet1o
         frNq4IxSVxq7jrgFkHkt5DUItvwNqNhXd9gjyv7/yvBDF3mp9XTjCIKfeFGOh/BQxHj0
         Co3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S89n9QHiQI/y9x3/RBBeD2hc63bXZL5TZ/yxbLwZvtk=;
        b=XtvVjQmiwqWvM8CD8nv8UWfg0OGX+v73vb7qm2c6OwPLPbEMvzHWWZmZoZuSzc4JAP
         aZPx0wertBtnmPm0va1EZAC9cT6ipKWN5eMhubEmUBiort6muP2XGZNL0V0Vi/6edWcw
         3tBMJa7jvBSFB3+SrU6D3IA/OvRUmuVl4cKnel8RGSVpFTRrGIzHMYzPgaXDWqNzH83F
         6kLFdHvt4hcHbIODaaXpu3F0itA+anKqRZRKFEFYu8n9YLnHA6SWz9i3NFsiHIrF53py
         5c7MEkbyOJCqVWbkQatVjx4ewOCqZwmYJzrCgBxOu+uQeieU4ZnqJLIe9YiiW7ld4fuO
         Xr9g==
X-Gm-Message-State: ANoB5pnBpjaNECo2kEH6K5S+v4GhOQCiqCAUtAgbfgmkxSRorrw6QCVz
        ZEGVDlCbqjDP0SL02K2R03VqFg==
X-Google-Smtp-Source: AA0mqf7XcXHsZrQ0kn+i9/4Tav71MGu3rtYjFsUzq5XSxZTFgjB20GPpjRhgmHjxcvjkPYiEGRCBUA==
X-Received: by 2002:adf:e7ce:0:b0:22e:4864:ee11 with SMTP id e14-20020adfe7ce000000b0022e4864ee11mr5599177wrn.488.1669201686677;
        Wed, 23 Nov 2022 03:08:06 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae74:d94f:4677:3378])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm2560406wmq.36.2022.11.23.03.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:08:06 -0800 (PST)
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
Subject: [PATCH v3 02/13] tty: serial: qcom-geni-serial: remove unused symbols
Date:   Wed, 23 Nov 2022 12:07:48 +0100
Message-Id: <20221123110759.1836666-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221123110759.1836666-1-brgl@bgdev.pl>
References: <20221123110759.1836666-1-brgl@bgdev.pl>
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


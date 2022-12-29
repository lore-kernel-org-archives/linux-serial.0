Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA9CC4167B
	for <linux-serial@archiver.kernel.org>; Thu, 29 Dec 2022 15:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiL2Pv1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Dec 2022 10:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiL2Puo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:44 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D64319B
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso13451490wmp.3
        for <linux-serial@vger.kernel.org>; Thu, 29 Dec 2022 07:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2MzVRg5qsZeZ18MD/OVh4kRzP+Ug6N74PqvU/3Swas=;
        b=Y5922RWr1l5HBO0JbK7W3Yjs7ASUaSdffFGQQEtjLvvPIEIvPMl8831AoB0e4ATkTn
         6srnJDvyVx2vCYObMMJwu7Ok/5lBuhdxdlf2ucF18O2Xzt/jkCBiSyg/sMDbRM3ZBfIb
         PyTGmtPihb1Xvd8QhM2KhNK1UmojfHGha+kcLYu7xer8H0Y/PbrMCcLSXTiShyhl7zbs
         J+rOnMyw/ITsQE0l3Zg/HcmhcGwznCvl8bKx4UGEGl09jt46KxwrX59JRW5XM6a7FhIc
         arF5yHwcWHqKDF4d1ZCrAd+ZRF8i5Z55YG+IsQh3My0iQJ+JfXM/pzhPCCA+VN3psBr5
         IMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2MzVRg5qsZeZ18MD/OVh4kRzP+Ug6N74PqvU/3Swas=;
        b=EplRjTiOPR2KmWZK88eIVCkSuBST70tjSUlbOSKq77sKhYFkJw4Cm09t2+ygWBt5LG
         FYxeIcdpkLAE2oZm77YAu1MPxax/xyy+SNeMLGoSuABOVXL+XzPMQjWMhnCNJ6Pbm+vZ
         dyrTrbxVfnr0euphb+06jbPIDrR9nIQHfJPV4nx8rZDVWE5NllhmooW2DyqgDm8o4alY
         YOgqbxdVGD7SC/OsG3hUIo1MhnuHvmYGW18Q3V0j+9VH7syo0IRJ9ExbOZdhQiZGm+tU
         Rko21RdChMNbQPW3ObRluFlHvDsios/JnfVZ9qeWVCea37rSe/Ns3cWhgvaq8y47BtT7
         Mq8A==
X-Gm-Message-State: AFqh2koCugqlIVToVPdRX4ircizc2Zn48B3fDGLVD9nZNBTdXHnCM3LH
        Q7LtT/Vhwm5IT3G5BsKsl49dGA==
X-Google-Smtp-Source: AMrXdXtAkLnVo2ai/aPmHEOE8d9cd2QOOnUgDCzL++zMq+TxIIn/2285ryyO5APeXNQ7SkrNT1EWjg==
X-Received: by 2002:a7b:c4c8:0:b0:3d3:5a4a:9101 with SMTP id g8-20020a7bc4c8000000b003d35a4a9101mr23683301wmk.23.1672329041742;
        Thu, 29 Dec 2022 07:50:41 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:41 -0800 (PST)
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
Subject: [PATCH v6 08/14] tty: serial: qcom-geni-serial: remove unneeded tabs
Date:   Thu, 29 Dec 2022 16:50:24 +0100
Message-Id: <20221229155030.418800-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229155030.418800-1-brgl@bgdev.pl>
References: <20221229155030.418800-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Remove redundant indentation in struct member assignment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 92aefd4f8527..e34fe56247d9 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -141,26 +141,26 @@ static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
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


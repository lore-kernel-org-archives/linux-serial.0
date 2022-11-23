Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CE4C43219
	for <linux-serial@archiver.kernel.org>; Wed, 23 Nov 2022 11:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbiKWLJW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbiKWLIc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Nov 2022 06:08:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A31970B6
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 03:08:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v1so28800060wrt.11
        for <linux-serial@vger.kernel.org>; Wed, 23 Nov 2022 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbfRkHz4/aW9Ej0X8Fhaj4Le2T1GhSly/B7XfhIOtq0=;
        b=AGy0MYOOnKebCT2KvF1CA0lwhTW5qhu60TOQyMYjiIwYYdPvzBjMuqCy34ZDxnOxAa
         /noqVpIyDg6WR3oa8Q7ty/FSxYJjUcMqDLC0h71qbKFJaMTS9lNxf1s+SG+Pv3iK8o9P
         KaFXodivUlB865KxyrafFF6OAobC87eZ5mpN1Zd7iX70ciN0aZJsGdpAyr7br6/WhF6u
         +787dPruWXzqtJx7coNQAyKBlgKm+Xn9MxwYt3IjRLM9OJdOEsyUBNYnFYHn35ZRTAux
         HAFIgGzIEDnPEMIUK2RbRrdAmKc+6wcIV675j+zrsYJg4qi7kkvp/UshHndKfMe5E8x4
         6pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbfRkHz4/aW9Ej0X8Fhaj4Le2T1GhSly/B7XfhIOtq0=;
        b=sflEMKPjasx+s6pgPL+uTfkCaMr0BqrUUuFwRmJDcY5xE6pUbz9Qf4LTWvJ9KyxOQN
         bDvICB68MhV1zJPCUgSY2/5K0JpeKfbkcs867hrR4+wZMagdgSw9qNueyGWoxIL85WTZ
         6XbECdIR1iVhNq3qk5QqVyo2880vulTfOknVohOokmz7JrJDwDP+I1d31GBdvk6YUHE8
         19KRdVKp3xeXQmE41M2EwNAbjRSzev6GsoUyoYRY5J75/r3LT11JehkjafNEApAsM3Kx
         m6Oi+9WnYBF15/TRnxZeELFFEzKu+aNwqnNf3Hd6pkKuEHTu4SSYoa7CWkKWlRTZupIa
         UFzw==
X-Gm-Message-State: ANoB5plaN/n9WUtEYfiLnLoEulQJb4ZL4tyIvcZg97AYs7zIB3JE0+74
        NXsrbf0Yp7Ug9NFpsboGSBgGuA==
X-Google-Smtp-Source: AA0mqf5a6EWO6iA5XpckEqZAv+qcaVpLZ0FVszb3Hr1WY/QMYQASstS57/Zoy0LEyudGTj73jAsb+w==
X-Received: by 2002:a5d:4e43:0:b0:241:d029:e98b with SMTP id r3-20020a5d4e43000000b00241d029e98bmr9305875wrt.551.1669201691326;
        Wed, 23 Nov 2022 03:08:11 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae74:d94f:4677:3378])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm2560406wmq.36.2022.11.23.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:08:11 -0800 (PST)
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
Subject: [PATCH v3 07/13] tty: serial: qcom-geni-serial: remove unneeded tabs
Date:   Wed, 23 Nov 2022 12:07:53 +0100
Message-Id: <20221123110759.1836666-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221123110759.1836666-1-brgl@bgdev.pl>
References: <20221123110759.1836666-1-brgl@bgdev.pl>
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
index fba02f71a874..68a1402fbe58 100644
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


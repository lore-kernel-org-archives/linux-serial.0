Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDB3C4321E
	for <linux-serial@archiver.kernel.org>; Tue, 29 Nov 2022 11:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiK2LAa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Nov 2022 06:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiK2LAZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19B260E98
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id h131-20020a1c2189000000b003d02dd48c45so8160436wmh.0
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EonL2PwB0Makj2JepNmLczYfWSZatIPogqShuTJezMI=;
        b=oC3RvrZh+uD/rIN/OhFpct3sfNNCaF6rodg7ivYc3KKlgkwKPvt1s3rlHtq05ZuK83
         ByMi14bSTIY6u1CzO3uSSE2/0xiVhGKcK6YfPCo7wrZCk3dxci49pvh3E0WUKOlssDQB
         hdDj+gtyTMlQtchdsdLyRFI08Fh2q+VSksE35RSjGojbbww20MP/87IQUOXYsKZVuULU
         BiAAyvI5y43cfac0R8NKk9BWUeGfjNVpIkmxeNTYU1qkIxUUtD/I0oyAcSF9QYDd630h
         YKSrvI30htxcWGuxwvd3/RVnSHvGOp8THzBZcMX3Y5hszJ+8XhAZhWhhlNZDkpejFM3J
         wCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EonL2PwB0Makj2JepNmLczYfWSZatIPogqShuTJezMI=;
        b=efMlp7pvgayX5ossFxdX5y09GzNplxmHlqMat1YM4nU7z49W2VJETa8cZ2GzFaPXPQ
         ymGgWbZDVPmRJ84fkAwynrhm095Q1hTKlC4chNh8ldFrjtLkHlwTXyhg7fZD3S7GRX16
         fKxw9oKdBfuNy4Je1DcGNDBl2OiTHr/bPJ18Fo58T9J+nod+6Il3HLXCXHNV1mKOSfHf
         sSQLjqHTMokiTDK9OdjVEyRp0t8O4XqXyZZyjj8yecVHkKMnFPLEd9fgX1OjdB2Ca1k2
         9xXjBtwMDVc7JKXqA67OOrw5BWJslKTiEsj+aqbaOaLcz5FOviujO1f8c/00KpuLPx01
         kX2g==
X-Gm-Message-State: ANoB5pkZCNopQXJd9TePjOG3QMmNPLOFtN+GEfRfBlGzJw/D7pYe6uzK
        zyxK/oda619UmDgfV2SdfAssHw==
X-Google-Smtp-Source: AA0mqf5j5YyHdMnLTqWYWWktLVBD+0Xy9WBNz2pgYLzaZzBHz4S0NpFwwlF5MmZrsdP9vWOUwOJhCw==
X-Received: by 2002:a05:600c:1d9c:b0:3c6:e369:e856 with SMTP id p28-20020a05600c1d9c00b003c6e369e856mr40758892wms.35.1669719622444;
        Tue, 29 Nov 2022 03:00:22 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:22 -0800 (PST)
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
Subject: [PATCH v4 05/13] tty: serial: qcom-geni-serial: remove stray newlines
Date:   Tue, 29 Nov 2022 12:00:04 +0100
Message-Id: <20221129110012.224685-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129110012.224685-1-brgl@bgdev.pl>
References: <20221129110012.224685-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Remove stray newlines around #ifdefs for consistency with the rest
of the driver code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e4139718e084..ec2523736e99 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -320,7 +320,6 @@ static void qcom_geni_serial_abort_rx(struct uart_port *uport)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
-
 static int qcom_geni_serial_get_char(struct uart_port *uport)
 {
 	struct qcom_geni_private_data *private_data = uport->private_data;
@@ -545,7 +544,6 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 {
 	return -EPERM;
 }
-
 #endif /* CONFIG_SERIAL_QCOM_GENI_CONSOLE */
 
 static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
-- 
2.37.2


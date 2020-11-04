Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013CDC4741F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948E020679
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOvIce5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgKDThd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731495AbgKDTgi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:38 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3546AC0613D4
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:36:38 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id n15so23374199wrq.2
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxIwRMD6TNBg9udmxGZqLaXn9yYcY9lwNa4w1OOgomY=;
        b=jOvIce5Y8cX6tbhY9L9KsU+MZChw1k/jcW944Xh2LDWfP2jwxOiW4gq2+Bawg47x9z
         bNE4CHODRlR5URrZecp9S23e5lzUQfpT3inK47e3MR7A9u2JyHP1M5Nu+flMLBMovr4X
         4XuSxNmW2Ig982I82J5WyB5huHaeXoOCGUxU/+C0hOeCouFqYCUOSu7VHvBDKs4Hyycg
         ydDhqoQ9Bav7qws0Xzs9/iSiy3k+R6NSlYZ2rseiR47s64hWEF0pq5Zjd7FLYVnRCdDR
         NHSrZIOa5qvgwc3XTM+5JX8tmYoA3cGjK5D4IcJjYCNa5MRZmHCdUnAD/e4dR4spsuN2
         e3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxIwRMD6TNBg9udmxGZqLaXn9yYcY9lwNa4w1OOgomY=;
        b=n4MkyCj4U4y1p9M+hEmUsZ2jlWtikXV0tMMPkAF2tL065FLPJQVJ6DgIVt4uiymD0K
         9c1Bg0mxVOVRPChW5AoeHkuTcYwjYiiyRwSKCc7HHkTq60jFn0Mvzhv5CetDLueGGX8R
         dGveSgSpE+7l9p/AztxrxZj4kFeYlf3DhZFZgtNZcJKI/oGdTLu3Iej2PdfLsYDIW4J2
         palztE5uaf/7/Xk6U4XWx9uaRjCqGLXHpVS0JDiKl8SszEw/L0jOmdXRuoHlwRUQv0KQ
         mALhWup5w+dSVRyrmrJaRhuOHzuA7tr+873UtSIHWcXyp7LbSTMlbi+eYgg5opFEZnub
         z8vA==
X-Gm-Message-State: AOAM530kABzZzjj1vZSoHD8nLM4XCht4NDKT5Fbtc55Q1mzWMAq7sDd1
        v5OFZQH/UgFhTdrTo3oFlf5LBQ==
X-Google-Smtp-Source: ABdhPJxku7Y3Kg5JTrtXlnam3qROwaJDh/c2CuIvjzLZI/zWTYPrraJ+G80GnqYixVTfkfiagatmeA==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr33601906wrq.193.1604518596915;
        Wed, 04 Nov 2020 11:36:36 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 25/36] tty: serial: sifive: Struct headers should start with 'struct <name>'
Date:   Wed,  4 Nov 2020 19:35:38 +0000
Message-Id: <20201104193549.4026187-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Also supply a missing member description.

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/sifive.c:157: warning: cannot understand function prototype: 'struct sifive_serial_port '

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/sifive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 13eadcb8aec4e..1066eebe3b28b 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -144,12 +144,13 @@
  */
 
 /**
- * sifive_serial_port - driver-specific data extension to struct uart_port
+ * struct sifive_serial_port - driver-specific data extension to struct uart_port
  * @port: struct uart_port embedded in this struct
  * @dev: struct device *
  * @ier: shadowed copy of the interrupt enable register
  * @clkin_rate: input clock to the UART IP block.
  * @baud_rate: UART serial line rate (e.g., 115200 baud)
+ * @clk: reference to this device's clock
  * @clk_notifier: clock rate change notifier for upstream clock changes
  *
  * Configuration data specific to this SiFive UART.
-- 
2.25.1


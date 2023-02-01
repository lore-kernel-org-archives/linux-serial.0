Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2CDC636D7
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 14:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjBAO14 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjBAO1t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 09:27:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89B46811E
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 06:27:47 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z11so17876994ede.1
        for <linux-serial@vger.kernel.org>; Wed, 01 Feb 2023 06:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxyxFeq00JGhfZF3lbLUVUOmxZ61KQdQmUjeiwFbgw8=;
        b=TqxSdo+txye/hH+JqDPj5+BHdWVeRBNc0K8jgGttCeHsb3yXb7k+vU36AzeDltqy3v
         9tebe7abB0jDHhCl/7e23/HfrTJI4COPeIxtOr5YPWXChODWdRRPYf0PYmNpipTyH7fL
         CgQSOYJTfF9CPoRmwvjw9GJqQQXYOcPZA6v+4Z0lsfQmeJV52awQRXWerMbk4kjxrEf2
         y2GCmwKDqMkTBpD6ik89DmR0SiIBG1cOdivGzo3YmgAGmExSu1BJsNXONBUgdZQPj1W6
         EWiSXk4x18qkxpUHuHC1dZGe2bqT+kvHIPi2SWRSVWh2dS2mkDonCAPpdKGLx0UXaAWY
         7New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxyxFeq00JGhfZF3lbLUVUOmxZ61KQdQmUjeiwFbgw8=;
        b=ECAHeCgglNzc79lXO9ocaLFMXUiBkBZIU6YZkAJLTZFh+eCmkpgXsUAHU1C1g7M8NK
         a7oHySA/Di4F+vFRm6/8N9JJiSUhDCsqLy9llHKjCrCJ5s+FMbAHE6KNElJZ6iY2RG59
         FUXXge6XC1gN6NHWE4rpHRM29+jqfKyEDfcyeMSHJKSHQwMjjpgsUR3fuDfibsNqaQWg
         ajvfwuVMWWCRnqrfV7PkTBeRLoNZVBX/kdx78WfCW/AsXqOwjLbgE72x1foakbejXXT1
         JaoMWEhez9xEkXosoSHt/Umv7L1z+IA298P7W3EmxrDNdt9jvK4XBIAl5Zw8MbT2j75I
         27kw==
X-Gm-Message-State: AO0yUKWpcJFOzjsFlfrLfIt9XdhQBAWqYAzkuFlcfTXZmn/yORbvJd4N
        DfzosjideMfcl4G+iYz0VvA=
X-Google-Smtp-Source: AK7set/U/qA9uhgkckwtVXIcYK+eNjL8h6axhavdaN9OZUBKFGGYjKnPrkEhQ7UYDUf9udq8Ns6cYA==
X-Received: by 2002:aa7:d0c6:0:b0:49b:4711:f4b4 with SMTP id u6-20020aa7d0c6000000b0049b4711f4b4mr2459599edo.0.1675261666145;
        Wed, 01 Feb 2023 06:27:46 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b004a18f2ffb86sm8975564edb.79.2023.02.01.06.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:27:45 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 5/7] serial: imx: remove redundant USR2 read from FIFO reading loop
Date:   Wed,  1 Feb 2023 17:26:58 +0300
Message-Id: <20230201142700.4346-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201142700.4346-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230201142700.4346-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no need to read USR2 twice at every loop iteration: get rid of the
second read.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/tty/serial/imx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 797c441088a9..af4349fe6970 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -904,7 +904,6 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 
 		rx = imx_uart_readl(sport, URXD0);
 
-		usr2 = imx_uart_readl(sport, USR2);
 		if (usr2 & USR2_BRCD) {
 			imx_uart_writel(sport, USR2_BRCD, USR2);
 			if (uart_handle_break(&sport->port))
-- 
2.30.1


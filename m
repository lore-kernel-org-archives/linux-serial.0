Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37353C54EBD
	for <linux-serial@archiver.kernel.org>; Fri, 13 Jan 2023 18:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjAMSoK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjAMSnv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Jan 2023 13:43:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3DE1C412
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:49 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so34328190lfv.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbM/0E+S8Ggk1+wMb510R+JTgrBTxf1YBPHLYLwKArg=;
        b=nLU3w/vxV1hxV25+86rkxBbQZK+BmAIZLXx6T+ellWNO3FpbmA8o5fuxCUB5Jm2Q8i
         Al6w8SjBakZcN4kSBLbvfyqqcOAaovr7977oM2iJf/w70U6/0ouACx7oyK3lCO7PRxf8
         gbAHAhB9ArTotSJvbqp0c8cWqmQmrIkLIPMRC537cwMjD5fDc9NjIBa7AIsphaeFE93j
         XtPXFBAyySR9uCN3OK0Q8dPDY0q1UFH+YihyJpdE8YTUQYRZYUX/s4ZzA+3+bodw5XGB
         tMV9rXRYtuMflakV1THt7ZX9gW+YyBVbH4kekmi2U1ub9iWEEnPSoEssXhxS+QSm/1hk
         PXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbM/0E+S8Ggk1+wMb510R+JTgrBTxf1YBPHLYLwKArg=;
        b=nKaxtdImQvEHA/aFGxAzWiy6OFb00DLkQLkwFjRxF8RBN5ovwVe1KWb103JbiSPIkQ
         cLyR3BG/KU+eK6Pz6z/Ak1Jp7b4emnZqGWqKnySoIkw9D7D1LjpjBQpAuGzvw7iG6NAu
         yTozXgZllfAqtXhIG3DQheUeo52SVl4zRdv/aonOSE/AZXisFfIbokOeV5m0IPeIkyHU
         I+USwmyVqkhxnG5c98SYLYptusP1WUA81xhbsV3XjaKdu/sfxjZ0cFfUPn10ov2zRF6J
         v6c9SplWuhGeU37Yxmofpof8PSJE4AveJTZz2+6umR4PBAB5J4H6iwbKYLigRxZRuqR/
         1paw==
X-Gm-Message-State: AFqh2krJ4Bi/GYal5epiz9s1foKeuBvud/6NYiJ3qJsgZqdryYB/eq6h
        UVA/6tiFPxoB6wa9DShcgKYNzFneP9U=
X-Google-Smtp-Source: AMrXdXsXqRwIW3RF1gdJ2+dC0m7vCsdhy4s6Ys42aIGjx4EcO93YP8XInQWa95Xzt9my4fC1xjEuRg==
X-Received: by 2002:ac2:429a:0:b0:4b5:7aad:2690 with SMTP id m26-20020ac2429a000000b004b57aad2690mr19833381lfh.12.1673635427842;
        Fri, 13 Jan 2023 10:43:47 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2434b000000b004cc9ddce3adsm1261439lfl.82.2023.01.13.10.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:43:47 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 5/8] serial: imx: remove redundant USR2 read from FIFO reading loop
Date:   Fri, 13 Jan 2023 21:43:31 +0300
Message-Id: <20230113184334.287130-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230113184334.287130-1-sorganov@gmail.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
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
index b96b0edc7854..c44a7293c013 100644
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


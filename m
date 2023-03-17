Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3624C6FD1D
	for <linux-serial@archiver.kernel.org>; Fri, 17 Mar 2023 20:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCQU6T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjCQU6O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Mar 2023 16:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B2062B45
        for <linux-serial@vger.kernel.org>; Fri, 17 Mar 2023 13:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679086641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3ueSLYTbczhpfG9NghbRnTQhmVk9+C96iBsuLv5iJJc=;
        b=UZ0NzoRyC9cFuIjibwQ7DAscLfmQ3KoLUPlxde60tzF7x+XYw9Y3ZW76cug3JmmSWaOkD1
        dzDhCzS7pokOI9sXXbIGcKoIj2ka2Vt2iD9hcNOFkH7+5dTHTjEXXPwGBbGYXRucpHXRP1
        bLK3cbMMZ7RUWht0S9ZwXh6U2GNJd7M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-2uUOtXLgNcyi18l-wPCHLA-1; Fri, 17 Mar 2023 16:57:20 -0400
X-MC-Unique: 2uUOtXLgNcyi18l-wPCHLA-1
Received: by mail-qk1-f197.google.com with SMTP id z11-20020ae9e60b000000b00745cb04c72eso3257285qkf.13
        for <linux-serial@vger.kernel.org>; Fri, 17 Mar 2023 13:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ueSLYTbczhpfG9NghbRnTQhmVk9+C96iBsuLv5iJJc=;
        b=B9P3o0q+55gDGv1fr+p0B3/VuRwxu8zF4JTqlG940axdr/5U0H7MtEsgeXDbBMhzGy
         FVPjyXRFO7tYW7iNqMQrQNy0/mozeUQfmLGUz2Iaq/hgtZbzPRMO+/wvLyAzNoyxMuyY
         DO33VmZbDpB+mZzmUciBJERWLr0BnIpUUOh95UCcqpb3nCkh7xsEGjZ5TDKlW1VnEzYL
         yA6cVy9N5FePR+D2njvmc4Q2YbRuX8SiZPNytHFeObEdXS2in7rE8+shuw//hSM7LHEx
         Jdjtp5OUCKtaLDHWsucwaQJ7IDZavHhS3VVkMyZ2Il912hZk9z9NIH/wVjRUaDYx6TQM
         rJ6A==
X-Gm-Message-State: AO0yUKVaViXA8+ydY7GGComvkzlrWjza6HdDa6txH9W3ZfaBEM7UwUbA
        0nUzjMEy4wXAPI2+8g38aHGekayWKg47Gc0Pa3bq2wPw2tFuC6gYyoN2PxM2rVnAzoY/nrBhpfa
        Tx+ioMhvEa4Ei8wpH5ZDaVxwP
X-Received: by 2002:a05:6214:e88:b0:5b4:2271:b42f with SMTP id hf8-20020a0562140e8800b005b42271b42fmr15359009qvb.47.1679086639846;
        Fri, 17 Mar 2023 13:57:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set+i8S89kFUh6Def3I4RhtkIaIaYkO0oKXURsOnZTacJ2FYR4+jckCSLZDHDDsPzEFtMvK2Vgw==
X-Received: by 2002:a05:6214:e88:b0:5b4:2271:b42f with SMTP id hf8-20020a0562140e8800b005b42271b42fmr15358978qvb.47.1679086639567;
        Fri, 17 Mar 2023 13:57:19 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s20-20020a374514000000b00742bc037f29sm2295574qka.120.2023.03.17.13.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 13:57:19 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] serial: imx: remove unused imx_uart_is_imx* functions
Date:   Fri, 17 Mar 2023 16:57:10 -0400
Message-Id: <20230317205710.1672232-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

clang with W=1 reports
drivers/tty/serial/imx.c:292:19: error:
  unused function 'imx_uart_is_imx21' [-Werror,-Wunused-function]
static inline int imx_uart_is_imx21(struct imx_port *sport)
                  ^
drivers/tty/serial/imx.c:297:19: error:
  unused function 'imx_uart_is_imx53' [-Werror,-Wunused-function]
static inline int imx_uart_is_imx53(struct imx_port *sport)
                  ^
drivers/tty/serial/imx.c:302:19: error:
  unused function 'imx_uart_is_imx6q' [-Werror,-Wunused-function]
static inline int imx_uart_is_imx6q(struct imx_port *sport)
                  ^
These static functions are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/imx.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 84bc0e768726..dbb3af4c1a34 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -289,20 +289,6 @@ static inline int imx_uart_is_imx1(struct imx_port *sport)
 	return sport->devdata->devtype == IMX1_UART;
 }
 
-static inline int imx_uart_is_imx21(struct imx_port *sport)
-{
-	return sport->devdata->devtype == IMX21_UART;
-}
-
-static inline int imx_uart_is_imx53(struct imx_port *sport)
-{
-	return sport->devdata->devtype == IMX53_UART;
-}
-
-static inline int imx_uart_is_imx6q(struct imx_port *sport)
-{
-	return sport->devdata->devtype == IMX6Q_UART;
-}
 /*
  * Save and restore functions for UCR1, UCR2 and UCR3 registers
  */
-- 
2.27.0


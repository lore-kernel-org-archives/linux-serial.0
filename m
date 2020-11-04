Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6665C4741F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FC220679
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ms2JX/ol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgKDThr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbgKDTg1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:27 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DC0C061A4C
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:36:27 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g12so23287943wrp.10
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjXTZO3THTknUKc+FF8iaHBvsw+0f6VMadCbFHOAPuM=;
        b=ms2JX/olfhvXUd5gZU8GpM2AlBUdhsOVTqftJLAZsSd3S6CA4St9e8Z3GVUJOPmBH3
         Wv+e5VL/yIgilU8EvaWEC11WiXxDDYSZTosDlw9sO3Gem/ACN7zcS+464DoBy798QAcH
         OPG1s6i1ZL6NhVvbs5YXlsbdqZEHIzc0+LOC4YSprETgdP0IUwxP1HatTFbZr3Q1gVcv
         i854ry1t+jafdMYbiPc8nv8BT3ro4yc3QyZESN0BlPVfflbvzS0u+2sy5v8ZA98Wm1GT
         r3s419fmQ+DJ0EwoWS+et3BfGfkP9LbKal++RpqWiA5dqdiTmztKyhwwOy9HGefmTbgE
         YXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjXTZO3THTknUKc+FF8iaHBvsw+0f6VMadCbFHOAPuM=;
        b=EKBWYpW1YVBCECYhotD7tPNivucPD61tRHu5lLHyK2xDzJaLT6YIuBJEGbb7KPqTcd
         T5r6rnW0GZtMJWovZQ4V5hRT6cdtLS+lxTv+NPXPguUc1zUJUCiXTPOUTJEI2pHS0mM2
         gL74jPETV1zkkg3/VbyOfXsfEDyiCZn6y5t3RBWzaVvhNaFJ6dP/OyGpXaBdlESg4QLQ
         riJCMgWuV973W4U67fyN4GYlese5CkQoCp4uyvllPEX3N2Dzs6JU9i/1H9Ujh5ucPwZz
         /K4amw1p9do9L65R7Sefzaurdk8PzOUAQNcx4q3lGxT+lcktQPEhuxJogUEWlTlCddgu
         Au1A==
X-Gm-Message-State: AOAM532lR7TetBo9Af9gS0FiYcnwgl7Wqe/dIvbKbeqcuqSOvnxFJb0+
        L0zhfxMr55oPoI0fsdfT2uxu0w==
X-Google-Smtp-Source: ABdhPJwbXgRf846UE4ULzw1UaKkRcnno8eWKOJyQ2YXTMjG5JuMVVZBJynEIcVUKav7QeoqCCWIriw==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr32969818wrt.137.1604518585814;
        Wed, 04 Nov 2020 11:36:25 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kevin Wells <kevin.wells@nxp.com>,
        Roland Stigge <stigge@antcom.de>, linux-serial@vger.kernel.org
Subject: [PATCH 19/36] tty: serial: lpc32xx_hs: Remove unused variable 'tmp'
Date:   Wed,  4 Nov 2020 19:35:32 +0000
Message-Id: <20201104193549.4026187-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/lpc32xx_hs.c: In function ‘__serial_uart_flush’:
 drivers/tty/serial/lpc32xx_hs.c:244:6: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Kevin Wells <kevin.wells@nxp.com>
Cc: Roland Stigge <stigge@antcom.de>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/lpc32xx_hs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index b5898c9320361..1fa098d7aec4b 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -241,12 +241,11 @@ static unsigned int __serial_get_clock_div(unsigned long uartclk,
 
 static void __serial_uart_flush(struct uart_port *port)
 {
-	u32 tmp;
 	int cnt = 0;
 
 	while ((readl(LPC32XX_HSUART_LEVEL(port->membase)) > 0) &&
 	       (cnt++ < FIFO_READ_LIMIT))
-		tmp = readl(LPC32XX_HSUART_FIFO(port->membase));
+		readl(LPC32XX_HSUART_FIFO(port->membase));
 }
 
 static void __serial_lpc32xx_rx(struct uart_port *port)
-- 
2.25.1


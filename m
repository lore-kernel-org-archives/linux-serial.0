Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D621C4332F
	for <linux-serial@archiver.kernel.org>; Wed, 23 Nov 2022 13:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiKWNZ0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Nov 2022 08:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiKWNY3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:29 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19B9A5DE;
        Wed, 23 Nov 2022 05:05:15 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id k2so12295163qkk.7;
        Wed, 23 Nov 2022 05:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHMcgVVLHSCbEuvVFdiKP9FgRZ42FtfzD1n98ex5KfA=;
        b=B99Re7VWdUz5fCMscSfwQQBcIa5cZrCVF3WBup0O/mFR8plWAjAfUloXizc4Io/mek
         1Uden+X0L+Rc2geTjabuyPjQ3QhRLVgVnjLNUt4Cu3zNuaott3LuLuOtualZ23t7ttdB
         ITNQmr70YnRmnbBAXjx43lkgCLPTEiVM2aND0HvGHYUJXGFzK0jzUYZIT1IOCZ02b4Lm
         w03Ahs9W+9mmDh7/cb4v5RPALhRDzJw9lgEuc3sPTiWg8qJfIHqVyQXHSKRVTbz/DwCW
         1VD1KWHrTxHH7IHaqkmJH6XD2t0yoU9yZy2OquJtk/c7fwlnROb8Xxa55+ZS21gwWqNA
         KP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHMcgVVLHSCbEuvVFdiKP9FgRZ42FtfzD1n98ex5KfA=;
        b=wooVCAk7uiHhC0EzrqkVcUnYYE4RHt5Gm/zT2zbDboPYow/OZLHBx2TzBXHiBNbBCV
         P4v2dS9T6AHuGzFK7C1rSj4m1Hu6XFgN95vcnLXtz45nTD1OC/yDuMJhNskYdbPIr7gf
         wILZ7uyI76LfSGwCMzfuohhN0h4D8Js44N58oV4e1DGM7GFKjhieRoxM38A1t0orBx4G
         bS7izi42v8Fuz8QSwRp7MvUZzCLnSxear51oo97IT6KvbJu+hhnipZcZsSUCe8mYa6JU
         E4CT3+kIXi4w2qKl79FaaYyhSbOkbJwR4xwbdKjRD3JqoYOg8IrEme0x2ump+CcurlwL
         JauQ==
X-Gm-Message-State: ANoB5pliLENm0bp/yFbGpL0Mibu83s9sFgoWK9SIBI8V2wU+1Foq38gK
        xWtN9wa8aYPaUx6M9ifmTpDGGgBDpsxkUA==
X-Google-Smtp-Source: AA0mqf6yb+wfYnjySuQKRM4lx5rs/UhaMTpb+Kj4jhVHVoo/vfWA3jPPFATlksk5k1RWmU3akOHTeA==
X-Received: by 2002:a37:5ec7:0:b0:6fa:27fa:45d6 with SMTP id s190-20020a375ec7000000b006fa27fa45d6mr25124923qkb.177.1669208714465;
        Wed, 23 Nov 2022 05:05:14 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:14 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 06/14] serial: liteuart: move tty_flip_buffer_push() out of rx loop
Date:   Wed, 23 Nov 2022 08:04:52 -0500
Message-Id: <20221123130500.1030189-7-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123130500.1030189-1-gsomlo@gmail.com>
References: <20221123130500.1030189-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Calling tty_flip_buffer_push() for each individual received character
is overkill. Move it out of the rx loop, and only call it once per
set of characters received together.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/liteuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 1e3429bcc2ad..81a86c5eb393 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -87,10 +87,10 @@ static void liteuart_timer(struct timer_list *t)
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
 			uart_insert_char(port, status, 0, ch, flg);
-
-		tty_flip_buffer_push(&port->state->port);
 	}
 
+	tty_flip_buffer_push(&port->state->port);
+
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
 
-- 
2.38.1


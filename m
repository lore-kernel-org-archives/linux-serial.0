Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CD7C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 16:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819DA206FA
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 16:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+ZIROl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388649AbgHQQvy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389057AbgHQQvH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 12:51:07 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321ACC061389;
        Mon, 17 Aug 2020 09:51:07 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dd12so8112800qvb.0;
        Mon, 17 Aug 2020 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNLxkZZ4kNlkkfstMBWaM/B0SrPnIi7HLhzFmB2YAkU=;
        b=a+ZIROl3Fjw/ldgZVncfaWRYFAT8bbLXKl+DHoAezhEjri56MetuSlYgI+ag9Ivjit
         TtCN+YO10hlG5+Z8GvsKat/gX0kvaN1Xf1+CH2DFA8uNl3FkobzkjFYWGQNedTr6BcUA
         QDCSS8kfy4w/lpgla4e4TOpCuyod/6eDv7Jl9AYe3RYT5cRJQYPxTPu0QAeIZuWVIqS8
         YNSeNeeq/V330G37iOZ3UelzvpC904fFboDa9j+JXgtoz0Htdg9268jfabZtQPZoN6Hp
         8TTxi/6S5QUlqZ+t3wjFgg3OfoqavjqEaAXhcx5VSCcGcC3GwJSPh8M3K+15WMgsA9/+
         lUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNLxkZZ4kNlkkfstMBWaM/B0SrPnIi7HLhzFmB2YAkU=;
        b=Que84m64/V2QvlrYa8sdWHWJ6n8DTYjmHcurVdMORLY6Ic66dcMkRtfS3UbJ5uoF0V
         aiKiX0pXsIWM+kR6hCUFtB8LmGUhC4d9T17Qzq4XhYvtGyHDBtGuVic1gsf7wCCRii2D
         k2ghKnWgoDHhFcdovDPjo481D7EDN5enSf1t+/J0UkyvS3gZjcnV8jFInKC7kFdycNhp
         cg8mjdKziEBh1SW09GqbUtbQPrv4l9rwKLPnbko1dN08q+f6PVlXP7fcUJY2114M172M
         cWthdOMwtdJuuK9LhvOxhhVnJJzdBGuWxIdvL9LETWeTHA+1cC/4xdLTHlIZFvXW7gJH
         7CsQ==
X-Gm-Message-State: AOAM532jMS9q4lEkW5OFSyrhb8lVV+yiZNmIU83+9NgT+3q8W5Ms9jrp
        JUgRbiJG5N9HJulzY9mkCuE=
X-Google-Smtp-Source: ABdhPJwMEEBBlrZkRNL1EpD8Lp+J5CO9SyxDWyv0hhkU5ooGPiOOA+7cHhy0Sw0r4QOp12OlFhzu2Q==
X-Received: by 2002:ad4:4a27:: with SMTP id n7mr15493029qvz.184.1597683066435;
        Mon, 17 Aug 2020 09:51:06 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:c66:53f8:5dc7:25fa])
        by smtp.googlemail.com with ESMTPSA id x137sm18167779qkb.47.2020.08.17.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:51:05 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org
Cc:     ztong0001@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: fix earlycon dependency
Date:   Mon, 17 Aug 2020 12:50:59 -0400
Message-Id: <20200817165059.957748-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

parse_options() in drivers/tty/serial/earlycon.c calls
uart_parse_earlycon() in drivers/tty/serial/serial_core.c
therefore selecting SERIAL_EARLYCON should automatically
select SERIAL_CORE, otherwise will result in symbol not
found error during linking if SERIAL_CORE is not configured
as builtin

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 8a0352eb337c..42e844314cbb 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -8,6 +8,7 @@ menu "Serial drivers"
 
 config SERIAL_EARLYCON
 	bool
+	select SERIAL_CORE
 	help
 	  Support for early consoles with the earlycon parameter. This enables
 	  the console before standard serial driver is probed. The console is
-- 
2.25.1


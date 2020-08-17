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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F74EC433E3
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA669204EC
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 18:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA+o569b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbgHQSy6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730917AbgHQSy4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 14:54:56 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED041C061389;
        Mon, 17 Aug 2020 11:54:55 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 6so13276296qtt.0;
        Mon, 17 Aug 2020 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EyInuEBx4tu8/dpK6QVmoYclYZh/Tpg6DL8iKkTJkGU=;
        b=WA+o569b6qU9RIK8BsU79Xhczucyqu1v2kaoVouU7fMrqwOUY2OyVs9O7aiNYPuzfl
         avdb3ooAA8YBV5u5nvog6hB9QI+4Zu3Hcywk15YkFXfgkTKZpvbXvyJxFm8PNit0vxWb
         MCL6CkZwvbKmggNumNDl30FJvQfjWmAlFGqpQfbbhX2RbABWBKLeAUJHT6dl5EVWzyt3
         PRbcXED8PgwrPH3jLFqA2lmIcSNXW8uL2ngTMKUIrcY06yjln5EPuX7OSmr5AqYkzCvw
         BRPWf/YRFhdul+WTxFcaiqgDtgjuLswXlYksDLI0omlITnTOz+vWaQxrYds/lfvGIPxq
         GfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EyInuEBx4tu8/dpK6QVmoYclYZh/Tpg6DL8iKkTJkGU=;
        b=j74txvyTsmf1BePC0+JhhhO+oeXByoXiAosVJU05Lnjdq2fRmeN98dSHGrqAHQDMIg
         Z5mB65ov0XmbXJIV7Z7luwlBRLmUNbQjqUmpkIe+Uu9hEp7tBXG+RMCGmyTgRJhxVVfV
         UrVQCCXHXiD0UXixHOSMcgn7tuQyJWpQmr9qV6Lc1jHuk/pPUpszJXD3eSokvyOK+Y7b
         QieihtBv1nEB05BCxb3Ur+Y7+3svteCe5r8B/ChPlEp6qQyGVJkyoCmIJhK+su/0MKN3
         kCt/G0aDAqU2TBgEWoajXKJGykSWSc4eKbbmE2RPArfpU66872HaxqHLogyo01fQxU7Z
         Sp5Q==
X-Gm-Message-State: AOAM532oRaWOYplV+iFyWgvMP7kyXwfZOJqdNPVwReSBkcs0zQ2kS+vl
        xifTywEeF2IzcwJuhYRusMY=
X-Google-Smtp-Source: ABdhPJyOu0pQY8yotrl8IF2bpoy442cARcsPMMim1bBFdx5ZWmsjekNfmiZ04J3F1AzoSCTJFVk3sQ==
X-Received: by 2002:ac8:4c86:: with SMTP id j6mr14725822qtv.65.1597690495228;
        Mon, 17 Aug 2020 11:54:55 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:c66:53f8:5dc7:25fa])
        by smtp.googlemail.com with ESMTPSA id w12sm17318534qkj.116.2020.08.17.11.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:54:54 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org
Cc:     ztong0001@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Fixes: tty: serial: earlycon dependency
Date:   Mon, 17 Aug 2020 14:54:19 -0400
Message-Id: <20200817185419.1133596-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200817170038.GA725471@kroah.com>
References: <20200817170038.GA725471@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

parse_options() in drivers/tty/serial/earlycon.c calls uart_parse_earlycon
in drivers/tty/serial/serial_core.c therefore selecting SERIAL_EARLYCON
should automatically select SERIAL_CORE, otherwise will result in symbol
not found error during linking if SERIAL_CORE is not configured as builtin

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


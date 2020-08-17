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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D82EC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D6CF204EC
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 18:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe9fLNDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgHQSwu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391641AbgHQSwq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 14:52:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EA5C061344;
        Mon, 17 Aug 2020 11:52:45 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e5so13232606qth.5;
        Mon, 17 Aug 2020 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EyInuEBx4tu8/dpK6QVmoYclYZh/Tpg6DL8iKkTJkGU=;
        b=Pe9fLNDEEnHmY37636XimvnOUgmaRGT+7ZjrZXOCOn5ANBcz/YnSzYtj1opCJoE4XN
         m+0gf0HV0Z7EzBplf8sVlk6FH0vTjVtbelDqTqzTkyfd2ULr4QPGVwYN1dK4DyKiqJMs
         80qrV3w1Icy5C7jFtQ5q4JERbSW62pKtVkH9qWljKgo0RISyJCyUXrlqTkudkBg+AQZY
         hQyFwQsPpIHnc5RxawZHiHucwiB1s/C24VskGr9EOfwPIlkvXP2YrLNLrnKQb0LUjvzC
         eqH/U0VQW/9Wn57DRZ1ioqovhxxUDeEovsdl4BsCRNOcMGQ6ZH1FLr00+A3kDvDp7PWa
         QiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EyInuEBx4tu8/dpK6QVmoYclYZh/Tpg6DL8iKkTJkGU=;
        b=h2VvqgHLFBx+dj/BF/6xCC02RWvw6uMaEs3/T1NtHO5Q8QA1gq0InB96gnCTnjiZ1e
         O4JrnOKigZWJxEF6ZmD9lWdFdRyfk6MR705CbKZfcqjdBjP96N0dn5zpaNgcfKbwX514
         zkExsJa5YpyH2NZO/BxN/6qRZ9KO5+fBTIZO5MyWkbfeDe0TNgKYeY7ZckgOEigxDkK8
         +1BfDmGgGlCx+oJMKEjFKQ5FBtrUknbw4hCOIylLPIBWXLe1xD55pqgHq1tc9QQhcBoy
         uWWAYaicTk6OHaTr2rDnZXM7bMh8ZhYux2nOgA3ZrXGp+BK+QxWnqqBlhVrhcOvYa/rP
         j0iw==
X-Gm-Message-State: AOAM530/4oyOoAK6of76nAPXo8ODwiAumeTiDkJeetgW08w5IskmRyQ+
        wKPwy0kIZRvzE3WFAkYZuRrbTcaq3uUqNg==
X-Google-Smtp-Source: ABdhPJzqT11r5CkeXxxzIyr9TKN47NMEwxu3N2u39F6z7Hn7QAfDIhWSgHUxGQ+wjGPXz88CIW93kw==
X-Received: by 2002:ac8:7606:: with SMTP id t6mr15003326qtq.348.1597690364557;
        Mon, 17 Aug 2020 11:52:44 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:c66:53f8:5dc7:25fa])
        by smtp.googlemail.com with ESMTPSA id m30sm21903159qtm.46.2020.08.17.11.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:52:43 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     ztong0001@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Fixes: tty: serial: earlycon dependency
Date:   Mon, 17 Aug 2020 14:52:38 -0400
Message-Id: <20200817185238.1133509-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
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


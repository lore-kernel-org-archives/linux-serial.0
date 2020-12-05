Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E068CC433FE
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 17:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A65222F9
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 17:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgLERkE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 5 Dec 2020 12:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgLERic (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 5 Dec 2020 12:38:32 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ECFC02B8EA;
        Sat,  5 Dec 2020 06:20:38 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q22so5815086pfk.12;
        Sat, 05 Dec 2020 06:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XMzpUqbsYh6tucD8t3b/pxZ+nokdbHK9Um2tIj0ij8=;
        b=keJ1JScvSLvyzh5aE7IvycDBA3a6WADgqiltWBBDl3MLPNG9ej4RY9oTPvYQlwbput
         138FJXsuVlH+B8dVI/r+PMaJx0wbr/+sBqEIgX9qHuhCcOb8MYXdK4nosnb09g9/OW75
         o2lIu/1/mz0VFEagmU2MAIyVaD+WLXfCxuwxH6tX5v1DCl2vs+qbOneNjRiZnIGjze1h
         Y9I1a4oct5slywoUiRzWJU92eSQ+EmZp0g8GCNZF4LG/iZ4uUGBg9sgXYHGhRrMGHN8m
         nz25j9gcjcSfyzx0fHulzOx29+QKm1ChBDp2l/hQcjvIQZoD5vfTKQ9DaZ2H09Me082H
         qxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XMzpUqbsYh6tucD8t3b/pxZ+nokdbHK9Um2tIj0ij8=;
        b=BTW2iGFwGbdW/cwq2yB3AI7KB7w72INwgDelhW5BU5dAgDCSCH+9+c6TrFuPtIvWVJ
         G/+ul20vCpJlydcCZfHfaDOvFsBp/IbNSmUaop43wmDa5LDQQUBre7Pcq3uJf0CfiWDH
         88m8toGcjb6t3BaociZCMPpuj0l1TR+TqpNoV50hM/AIuM2nG//73LvjJNLxo57D4lBA
         3xc2K+W7+QtslJbcc+93i+w2AIAK3BwtK9b1DoSz1gMIsAVtE0GtXUz7ESZMV4xxpSrc
         YKtJVKGz1G8bCQ+FMzKPs6hl/IikI7wQDQfbLbFn6chnK6DWZyFqQ2ZUh1XbBRuBb7GB
         eHtA==
X-Gm-Message-State: AOAM531yIXTwcOJNSr1w45CX0AQSmiTUiyXZ+jBAVdslI2IyS15/eqRx
        H0GgN4UhPFty4+4akzXCz7U=
X-Google-Smtp-Source: ABdhPJw1/NYmwU0hBtyfKqjW3faLfJq8f2ZpRs0bo4J1G/kru0lHbF5w+0jSyKcDALPwKG6W6+Z/og==
X-Received: by 2002:a63:2e08:: with SMTP id u8mr11622566pgu.439.1607178038257;
        Sat, 05 Dec 2020 06:20:38 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f0c9:3f6:a1c3:a34c:b902])
        by smtp.gmail.com with ESMTPSA id m4sm9400202pfd.203.2020.12.05.06.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 06:20:37 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 3/8] tty: serial: jsm: Fixed file by added more spacing in line 612
Date:   Sat,  5 Dec 2020 19:50:10 +0530
Message-Id: <b6b9cb4bdbf225b2c1cbb218c286a444ce7c53b6.1607177807.git.rclemsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1607177807.git.rclemsmith@gmail.com>
References: <cover.1607177807.git.rclemsmith@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

        Fixed a coding style issue

        Signed-off-by: Clement Smith <rclemsmith@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 202d6ba93313..2bc5f32e59f4 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -609,7 +609,7 @@ void jsm_input(struct jsm_channel *ch)
 				 */
 				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
 					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i),  TTY_BREAK);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
+				else if (*(ch->ch_equeue + tail + i) & UART_LSR_PE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
 				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
-- 
2.27.0


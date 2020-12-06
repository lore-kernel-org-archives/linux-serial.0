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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81D7C4167B
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7665E2333D
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgLFHkb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Dec 2020 02:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLFHka (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Dec 2020 02:40:30 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924E2C0613D4;
        Sat,  5 Dec 2020 23:39:50 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w6so6884796pfu.1;
        Sat, 05 Dec 2020 23:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QkPyiFVzu7toVtUF/9i50V7n7tt3DwLwvbOtSyVqwVQ=;
        b=eORvqZkq9Fm4UlHvILVjiZSFZ8cCczsB9EiAu92uTM0gxWy6E3uS5ciEvqzGvGAoAN
         A77z+SvArxEZS652RKheOA1OkTLeg5b8Hb1phMSj0MF6uQED1cqYZYCj1+BWzDYWOZOH
         0B5puwl81YjkAm2scpq75vQVIp05VJZjMAjz6Geyi6mVoZWlGew0yEYP684e9smMjYwZ
         mnrWJsFBuOm4wmYMvqqcAvwVmIe4J1FQyFQwXi7AMnIpS50jSRd8Z4U6wX6cGsT1eDL8
         n6u5tJZFxjewYSngCMxeFhJadE6iJBFNmoo4TzJKsgxPa/FFIQntosmaNZifedFj/FM6
         5U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkPyiFVzu7toVtUF/9i50V7n7tt3DwLwvbOtSyVqwVQ=;
        b=nEdgSTR37J13ef2yhaOFREhWixo87kIoCmhC7NWM1e6mBZ6TR7CF5nvpG6ihgWynlX
         mrWMgC1wXcUR1TxBEXFkAKJytIzH9OuAPOZ81Uzkarmrz8gCcH/Uh3IZ4ZON/svgLOy6
         7j9/oASBRynHJHVMUyvKKuVgi+xg9X+oXla71XSmZxuhAp5124gsh3ZN/BCgreqO+/Hq
         S5FPfKJncKE7ELA0zmwbpOhKxNvQPFBekQXch1uGfkoLRiSif4JQg1HyKgM1KV2Bbv0U
         L/VnOoVBuIu1lvgJ5iJ0L9WtYS9hyy+p0ljRoKRWlwVxiNpHTMCfaD3Vd+LAq809fM2Y
         ROrw==
X-Gm-Message-State: AOAM533UaU3Bb2J/jQOZkt8WbmuLtobblDI600V48nhbBxGqxFoEUEMt
        NauQcB0dHR8zv6dz7TGD/vY=
X-Google-Smtp-Source: ABdhPJyEwMpaKGjCzNsJdYwQZ6SbfbHTk6fWQP7Dn6e60/dAI+wqNJdV5m751nVnmOql1p44nxmK2A==
X-Received: by 2002:a05:6a00:228a:b029:18b:212a:1af7 with SMTP id f10-20020a056a00228ab029018b212a1af7mr11046992pfe.55.1607240390160;
        Sat, 05 Dec 2020 23:39:50 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f092:5562:8d65:7204:31e])
        by smtp.gmail.com with ESMTPSA id mz1sm4101275pjb.33.2020.12.05.23.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 23:39:49 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 4/8] tty: serial: jsm: Fixed file by added more spacing
Date:   Sun,  6 Dec 2020 13:09:28 +0530
Message-Id: <dbae86037025f56c9e9d855b2ccf885483445029.1607240285.git.rclemsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
References: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
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
index 2bc5f32e59f4..45e212be64c4 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -610,7 +610,7 @@ void jsm_input(struct jsm_channel *ch)
 				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
 					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i),  TTY_BREAK);
 				else if (*(ch->ch_equeue + tail + i) & UART_LSR_PE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_PARITY);
 				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
 				else
-- 
2.27.0


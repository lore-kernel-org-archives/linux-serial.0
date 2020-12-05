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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D52C1B0D9
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 18:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC7522287
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 18:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbgLESXm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgLESXi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 5 Dec 2020 13:23:38 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA35FC02B8EE;
        Sat,  5 Dec 2020 06:20:46 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id iq13so4781167pjb.3;
        Sat, 05 Dec 2020 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSXpzxSQqG2mQMBQeGtYtXPGMJfKkS5MqIm02lG4uqo=;
        b=i1ZLvhRARRcY24m6bn05DcaCCh9RNK7U9IB9zb1mK6HJKJPJ+W8surHvmoret+R9EM
         ffQpzFYOxM7HvbiTzB8h7J6eBy3ggt1sGGXdhnmw0LZDpb8dNZBILb5qTVMWION3AfLA
         aJE6fS36mYUe31tSwC25e40OFKco5ObnyWeZg6bInX8Jd/15jjBXGwY4tZDWsdfZksMf
         kAwNVKR9NhGEYGEKctRbhJnWhpiS21UpD/pr3LN2uWaEwMbXpyHpaDjAYMxCDXJuVV3b
         PB6AOXXbA6LDa+3eEfPvMKxKe1NO0s+4DhcKxdHQqzmfAHBMgClh/3nAyEOaqKVtJ3hZ
         PWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSXpzxSQqG2mQMBQeGtYtXPGMJfKkS5MqIm02lG4uqo=;
        b=jIWWx8sUJkkYR/6EEGn4aifxCMWVmYmEXN9zHXNYtnAMulkDYtmAR7VYKuBVG7IDK8
         rwla+K7YLLxxOumfTUM4VvpWrCQXLmqzDJCnNoQ1vXnZ+WWvSSuwzGlKrTQS2az5zG0W
         kGmczglzjjPMNxnNbb9l7DtmMYzK8Pzc7UDUEHcrx60mdiI8Kl47wrZXPoiMQqNCYUuw
         6w82b0n/NV362twSALZQBtk/4U99tpekYD0n5uX3xo/B6dfJD9RK9/Rlj94NPAUPgzSG
         bIb3nVOv0zPpUaCzO8pgRzrWzkIpKzrVxh44S5GyHGxsW29HMPvlWgUyNrmRKk8iEwXF
         RhXg==
X-Gm-Message-State: AOAM5314r7y+2VeSww0yV9B0P39K4gDGvXSxJaMr5GePJgYGPkffbhVs
        KtIg21+ipFqGJkw0/YSRheAO4tfeSTNrdpij
X-Google-Smtp-Source: ABdhPJz9iZOyrS0FkSLoO3V4eFLlH4gCRELrJFTpVQbSaVAnUMaHS/Dsr7/64XGLcfMpZ80O8hCSVg==
X-Received: by 2002:a17:90a:fd08:: with SMTP id cv8mr8637386pjb.29.1607178046539;
        Sat, 05 Dec 2020 06:20:46 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f0c9:3f6:a1c3:a34c:b902])
        by smtp.gmail.com with ESMTPSA id m4sm9400202pfd.203.2020.12.05.06.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 06:20:46 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 7/8] tty: serial: jsm: Fixed file by added more spacing in line 616
Date:   Sat,  5 Dec 2020 19:50:14 +0530
Message-Id: <c6dc00f1bd148b3da7265367741d77b9c65c449c.1607177807.git.rclemsmith@gmail.com>
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
index 19d2f0bc6c10..eab82fb6b384 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -614,7 +614,7 @@ void jsm_input(struct jsm_channel *ch)
 				else if (*(ch->ch_equeue + tail + i) & UART_LSR_FE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_FRAME);
 				else
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_NORMAL);
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_NORMAL);
 			}
 		} else {
 			tty_insert_flip_string(port, ch->ch_rqueue + tail, s);
-- 
2.27.0


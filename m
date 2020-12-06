Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BF4C4167B
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7B5230FB
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgLFHkk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Dec 2020 02:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLFHkj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Dec 2020 02:40:39 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3090C061A51;
        Sat,  5 Dec 2020 23:39:53 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w16so6312449pga.9;
        Sat, 05 Dec 2020 23:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMPmWSEOQ1z0fknG64q8QyO+7zYlcRHZONwvF2A6vQk=;
        b=OkrffRsdhwyArvWisoecfH2zS9ougNcLpyR5w+5KoFSgvFzWuAbbE8VDFCZHK17+/l
         Hr0iunQTiucCe6OFkPjXlmES8AniyNGTlFKWOtgX62uZc8TtjiRRzLuStQBLEZrYYu+o
         teIIERMxTMfmmfh5bUcIWTN7GgWjl+3g1G3l8WI241a8bgHX1444htwFLMQGNfAP1XPq
         cYhm6GmCPNl2mpZyhrFb3rcHQrSmBoiFZmoVdxvKnuaMNGJh00XYMIPGlSgDgynupOcM
         it4V/M9JpzV2t/0ls1UPmDjdQ7oJMhckdFcjRlQPd+IVUT5seZZXzDQ5+4+B/wj8v+cB
         tKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMPmWSEOQ1z0fknG64q8QyO+7zYlcRHZONwvF2A6vQk=;
        b=G4QFV6NqOezM5OGv2WS+8EJNGR2BcXHEVpUFdLK20VPDYMBcCbqNKxSvmGmDYzW4EE
         oBsOWYejzmdF+SraEPPp7fVOL/sZD9gpvaY/3hr89RSxaNlpyoheQAvCsULZ2tzeVXiJ
         2XWLnf21Ix2KR1XTYRRaUzBgx55X2BcFQamoVuFhyZKqNH/7q8Ma8bbdHwgXUOqBoun6
         IOS0BJCrf+hN/smFLZgqYcPyY/MVYB7fQjQEtf4/UbKyuKw5yU/Fl/lq26PQU+bmW9aU
         gTDe0pYVRjeo+26EhJopnyBRZ+Y6WiDbnJ4hjFnFF7eR4jj09WRZK/73UIYy4pOBg9iy
         KBGQ==
X-Gm-Message-State: AOAM5315AZLp8Sf0ib2UMG57n0mkW8LrPO9ORwSRjQuojsb0XCfy2dpf
        sgwlRYdnXXIlolftDMv96Ug=
X-Google-Smtp-Source: ABdhPJzrX/7c04bcqSazUKxRyycGF7HkZlZgqOKrPVst4vWqXZM4WjOg6YMs2gNIDJ41vimIVY/oSg==
X-Received: by 2002:aa7:92c7:0:b029:197:e36f:fc5c with SMTP id k7-20020aa792c70000b0290197e36ffc5cmr11453400pfa.62.1607240393254;
        Sat, 05 Dec 2020 23:39:53 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f092:5562:8d65:7204:31e])
        by smtp.gmail.com with ESMTPSA id mz1sm4101275pjb.33.2020.12.05.23.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 23:39:52 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 5/8] tty: serial: jsm: Fixed file by added more spacing
Date:   Sun,  6 Dec 2020 13:09:29 +0530
Message-Id: <5c83d324feea2f9b54eca7c184716a2bf4d3b4b0.1607240285.git.rclemsmith@gmail.com>
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
index 45e212be64c4..75c9bfa5077c 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -611,7 +611,7 @@ void jsm_input(struct jsm_channel *ch)
 					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i),  TTY_BREAK);
 				else if (*(ch->ch_equeue + tail + i) & UART_LSR_PE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_PARITY);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
+				else if (*(ch->ch_equeue + tail + i) & UART_LSR_FE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
 				else
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_NORMAL);
-- 
2.27.0


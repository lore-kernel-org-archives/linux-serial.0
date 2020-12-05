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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76347C2BB3F
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 18:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4251522D01
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 18:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbgLESce (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgLES2x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 5 Dec 2020 13:28:53 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F1DC02B8EC;
        Sat,  5 Dec 2020 06:20:42 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id hk16so4836369pjb.4;
        Sat, 05 Dec 2020 06:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBdfoW+IfnGU4uiYs2fn5u4z5HaH23KZfZERfOV5QJQ=;
        b=OLbjerAM+fFtJJjSno9v4LBGz3LVvwyXcFf11dQjf0ExUXFzrh8L9HUV4W5+/nClK4
         sn+12DwN6IqgyIsUf3rxpZE1MLA9zzet9h8QrRhi0Rrv27qMOrWomPKCfik2z6HO/AxY
         n+ZwP0Af69go/MeeF/O/ZUvswpOBTapTZ5WC1R/sOMDST0eNl2+p21KN+YuVwG3E9bu6
         cMDruHAvgDpJOUkUj70WeylWkpClqbxjddgnJfETVNQ0wvGmyhoida+Zsl1UfR6fb3Nf
         MHG1dqS34incOsHGILwBvVUVLPIxx7NXonqjej5EOEs91hVyMLRfuOiOOTuVR05ViRgw
         JLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBdfoW+IfnGU4uiYs2fn5u4z5HaH23KZfZERfOV5QJQ=;
        b=JToqiVfJmak8WhQyyqux9yguVgi03FprYSx1qb6xiDTDBFpOTlNsawsBASuk/jZQvX
         ihw2/IAgpgFCC92cLR0xYI9blS33pRhpSq3eqADx8uEQfo+Y51hGtdFq52Q0+OhFpsTN
         1+ZwNvMTB7JUzqude7Tz1YgcWa9sWiLH80iYbWzn25QhgOZW4H//OLenDA9HQk/9dq7L
         hpu2prsj765Q2kEFYwPXS0bCh3l65/su/MrxvczZbphV60kXANNq341yIVA2daLEhhpk
         VxekvLt0nLPQTX/VDmQsCWA9UOaE4DLQj2tqswpUdFwCI+DtTHYiAxrpTsEtO2AhIG3S
         ffDA==
X-Gm-Message-State: AOAM530ShhXsCmorajuN8iH5psnSXIViU0LfViKpeg7Sc5G9Yp7U5UdK
        gWsJI2CABks2AdMTmi5ghw8=
X-Google-Smtp-Source: ABdhPJyRnSYt/w1OTVBXLbY8GnU8uk0/jYcsftNWTrEcvaSVTqYFn1h/9lRqRBbBW6+K2Q5tpG/S9w==
X-Received: by 2002:a17:902:8508:b029:da:8f7e:f645 with SMTP id bj8-20020a1709028508b02900da8f7ef645mr8652008plb.30.1607178042400;
        Sat, 05 Dec 2020 06:20:42 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f0c9:3f6:a1c3:a34c:b902])
        by smtp.gmail.com with ESMTPSA id m4sm9400202pfd.203.2020.12.05.06.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 06:20:41 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 5/8] tty: serial: jsm: Fixed file by added more spacing in line 614
Date:   Sat,  5 Dec 2020 19:50:12 +0530
Message-Id: <ee968518c5cfe6b5ea416c0f86df0a5255ba7e15.1607177807.git.rclemsmith@gmail.com>
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7ABC1B087
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FE122D2A
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgLFHlD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Dec 2020 02:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLFHlD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Dec 2020 02:41:03 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE52C061A53;
        Sat,  5 Dec 2020 23:39:59 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id e5so5568289pjt.0;
        Sat, 05 Dec 2020 23:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6RV3FaJwoXsg1iWqHQxcdc2D0CuomR4lDom9lAMu1g=;
        b=L6FE4bWRCKpP4T55wxxE16AH+IEv2+qOstT9C9gMneUqQvzOHqUOfe7cSl8w/VECsG
         s7CICivyuGuQ/6ZJDayf9U6kVBFU9w9jioe5SWBgCQoB5I95j9KsePZS0AnS8/BAvMBP
         zbKB4uL0T3fU0xKGwKqYIwGElmA+VaeV2wpb1SoAjszdhTFzA+JA6OyVuYNTC9YaMkWo
         8JNfHjHQDoVOZkwt7MujYkgRGREr5M9KOfoFfOPARUDEokm16LGrbHpO7scBTVk+1Ocz
         THVS2GcOTIzt4NVgqXpA4NxKQOomSnTZC4egmu+QrYEbbmv0lRyli+118NrMRHtoewb+
         g3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6RV3FaJwoXsg1iWqHQxcdc2D0CuomR4lDom9lAMu1g=;
        b=DipDpXSv8lKOWe1mImSL4hImhmPhoh6VN4N7laX81mI2NMCS2xdJODypR306/Ate5G
         7JV3/aGzpv91sa8ucl+cXCCt62ksrgAlHJqSbxNMwDTUveY3NrljQMFJJXsGy9GobQly
         j0qYU2kjRhEwXYH9TdL6Q3GDBi0SZyeVS+HYUq/7cJkWx67JngbfHez67KTKdSZhyG7I
         rBHP53sz4j3pHeLqEGaAO+s0GtLOcyVm3c8Ab0syHGdz7LwMW/DcfpUXWArUBSssee48
         CWYLhtR/jIXIpfBuivhm+JEjCsubnpjCDmek2d4AbWrx5NNhYaPLcRIDmg3yWUwxzJpP
         crDw==
X-Gm-Message-State: AOAM533LmBWo+2nF1DrcabHW/W9pTTch6+e189xhTI7diwgi5rxaEnRF
        AwSi7FsOTkOYM3Yb2pUxe7g=
X-Google-Smtp-Source: ABdhPJzRTdqnk4fMGn4CaHD0DoH+gHEWLcPHI7wozeDTKhHL3xKgMzK5CO+UnsU8xxdASJVBosI+zQ==
X-Received: by 2002:a17:902:868a:b029:da:ea50:d55f with SMTP id g10-20020a170902868ab02900daea50d55fmr2608768plo.84.1607240399091;
        Sat, 05 Dec 2020 23:39:59 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f092:5562:8d65:7204:31e])
        by smtp.gmail.com with ESMTPSA id mz1sm4101275pjb.33.2020.12.05.23.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 23:39:58 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 7/8] tty: serial: jsm: Fixed file by added more spacing
Date:   Sun,  6 Dec 2020 13:09:31 +0530
Message-Id: <7a6ccaa7711d5e94b75797121e7f642ae7d38308.1607240285.git.rclemsmith@gmail.com>
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


Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D77DC2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 07:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DAC613FA
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFYHhd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 03:37:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34446 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFYHhd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 03:37:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 25A3921C02;
        Fri, 25 Jun 2021 07:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624606512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yDrA5zvJ6UovGXrbLsbTuqRRrTIzDDZQuMZ99lD3lx8=;
        b=gi0YP5A1Vfafbk6zmkxW8cE1E/gSyadXcfcD6DxK5nFS7xRYnnfINzS7ZyHHVnDnV5wmN5
        TFUK2RIulATeblfQxlgM6vKTe4BlpJsw/GLmA5V8UooMiWaDKlrGl9xGJ90z52A337czjp
        dX3WL4op3aqxtbI9NU/P+kiDSleEDQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624606512;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yDrA5zvJ6UovGXrbLsbTuqRRrTIzDDZQuMZ99lD3lx8=;
        b=Ma29hMkudziuBxULJqz65E441UrR/8rwvfc/W9sUphJ3ehft405MPGeuTfC73af7mbYpmm
        1zgQ93FiX9RBpIAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 020B2A3BE9;
        Fri, 25 Jun 2021 07:35:11 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] tty: make linux/tty_flip.h self-contained
Date:   Fri, 25 Jun 2021 09:35:11 +0200
Message-Id: <20210625073511.4514-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If someone includes linux/tty_flip.h before linux/tty.h, they see
many compiler errors like:
 include/linux/tty_flip.h:23:30: error: invalid use of undefined type 'struct tty_port'
 include/linux/tty_flip.h:26:14: error: invalid use of undefined type 'struct tty_buffer'

tty_flip.h actually lexicographically sorts before tty.h. So if people
sort includes (as I tried in amiserial), the compilation suddenly
breaks.

Solve this by including linux/tty.h from linux/tty_flip.h, so that
everything is defined as needed.

Another alternative would be to uninline tty_insert_flip_char and just
insert forward declarations of tty_port and tty_buffer structs into
tty_flip.h as that inline is the only real user. But that would mean
slowing down the fast path without any good reason. (Provided the fix
is that easy and there were no real problems with this until now.)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty_flip.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index d6729281ec50..67d78dc553e1 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_TTY_FLIP_H
 #define _LINUX_TTY_FLIP_H
 
+#include <linux/tty.h>
+
 extern int tty_buffer_set_limit(struct tty_port *port, int limit);
 extern unsigned int tty_buffer_space_avail(struct tty_port *port);
 extern int tty_buffer_request_room(struct tty_port *port, size_t size);
-- 
2.32.0


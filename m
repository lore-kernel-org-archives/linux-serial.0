Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E4C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 11:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhKVLT5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:19:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53990 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhKVLT4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 06:19:56 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9672F1FD49;
        Mon, 22 Nov 2021 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637579809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NInrBXcW2ciYW2HCP5rtvcNjVJLzVYZYIRiz+AgoguE=;
        b=ng8TMVftz6FqAe608o63nb8iGFhmibL+L2mlPWP+TP1XE8+eePFXTXOO1ADtc9HXaZ8Ulv
        vprUC0scbWsyZgM1KI5hB8o+MWeFr9TRduaq0KDrpdhpp/rAQfhT4feEi1FcZ1SevmIT2N
        LYCW3uZquuRgUSefNT0KAwIJQK8uCHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637579809;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NInrBXcW2ciYW2HCP5rtvcNjVJLzVYZYIRiz+AgoguE=;
        b=Eu/ZtOEqyK5z8WCdfmbEw7CieHGyj7DHI90IAie7NUechSHCG2IWGYc6xrkIDFljqAi0zg
        xFgZ2DXFX4diWnCA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6B6E3A3B88;
        Mon, 22 Nov 2021 11:16:49 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v2 0/3] tty: drop tty_schedule_flip()
Date:   Mon, 22 Nov 2021 12:16:45 +0100
Message-Id: <20211122111648.30379-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are two identical functions: tty_schedule_flip and
tty_flip_buffer_push. Remove the former.

This is [v2] as [v1] was dropping tty_flip_buffer_push. And
tty_flip_buffer_push is spread wider, so remove the less used one as
proposed by Johan.

Jiri Slaby (3):
  tty: drivers/tty/, stop using tty_schedule_flip()
  tty: the rest, stop using tty_schedule_flip()
  tty: drop tty_schedule_flip()

 arch/alpha/kernel/srmcons.c               |  2 +-
 drivers/accessibility/speakup/spk_ttyio.c |  4 +--
 drivers/s390/char/keyboard.h              |  4 +--
 drivers/tty/goldfish.c                    |  2 +-
 drivers/tty/moxa.c                        |  4 +--
 drivers/tty/serial/lpc32xx_hs.c           |  2 +-
 drivers/tty/tty_buffer.c                  | 30 ++++++-----------------
 drivers/tty/vt/keyboard.c                 |  6 ++---
 drivers/tty/vt/vt.c                       |  2 +-
 include/linux/tty_flip.h                  |  1 -
 10 files changed, 21 insertions(+), 36 deletions(-)

-- 
2.33.1


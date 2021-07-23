Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E825FC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA54860EE2
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhGWJvP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:51:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55572 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhGWJvP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 05:51:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C6A2721ED6;
        Fri, 23 Jul 2021 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627036307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=k1Lj1AHmr+kFjSZHcMhZdheqlVstfQHqR/3iiFTJn/g=;
        b=2r/wk+VjtBQimHVjTauz+ODwE+hfKzWBI0/PXAUBGwIUvAekj4lPuSqoO6yyzapGPIVgpF
        2sIYKAz6YdKuFpLkD7L/h87ohz4YCeHS2exSk6xvvpAlYDufw2101g/ZKScSk9j0hK6lP8
        /7qzhdPNJhbEshf+2JkeeRYForruqYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627036307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=k1Lj1AHmr+kFjSZHcMhZdheqlVstfQHqR/3iiFTJn/g=;
        b=FccWBdmzJmw6/32TNUUcMa1azieqnUkjJyD62RDcErAFEQLnETNOhEgGGTGJcP54TmE+47
        NJwLxry/BMHMk+Cg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A5296A3B9D;
        Fri, 23 Jul 2021 10:31:47 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 0/8] tty: split and cleanup headers
Date:   Fri, 23 Jul 2021 12:31:39 +0200
Message-Id: <20210723103147.18250-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I started writing up kernel-doc documentation of the TTY layer. It
turned out that linux/tty.h is a header containing many structures and
even function definitions. With added kernel-doc documentation for
tty_port, tty_buffer, and other main structures, tty.h grew into a very
large file.

This series moves many declarations/definitions from tty.h to places
where they fit better. For that purpose, we also create two brave new
headers to move there tty_port and tty_buffer structs.

That way, the combination of documentation and code in the headers
remains on maintainable level.

Note: this series is independent (either can be applied first) on the
other series I posted and are not applied yet.

Jiri Slaby (8):
  tty: move tty_driver related prototypes to tty_driver.h
  tty: include kref.h in tty_driver.h
  tty: move ldisc prototypes to tty_ldisc.h
  tty: include list & lockdep from tty_ldisc.h
  tty: move tty_ldisc_receive_buf to tty_flip.h
  tty: move tty_buffer definitions to new tty_buffer.h
  tty: move tty_port to new tty_port.h
  tty: tty_flip.h needs only tty_buffer and tty_port

 include/linux/tty.h        | 275 +------------------------------------
 include/linux/tty_buffer.h |  59 ++++++++
 include/linux/tty_driver.h |  18 +++
 include/linux/tty_flip.h   |   8 +-
 include/linux/tty_ldisc.h  |  17 +++
 include/linux/tty_port.h   | 208 ++++++++++++++++++++++++++++
 6 files changed, 311 insertions(+), 274 deletions(-)
 create mode 100644 include/linux/tty_buffer.h
 create mode 100644 include/linux/tty_port.h

-- 
2.32.0


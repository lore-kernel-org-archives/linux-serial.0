Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFECC433DB
	for <linux-serial@archiver.kernel.org>; Sat, 13 Mar 2021 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14EF64F19
	for <linux-serial@archiver.kernel.org>; Sat, 13 Mar 2021 15:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhCMPCq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 13 Mar 2021 10:02:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232904AbhCMPCe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Mar 2021 10:02:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D42064F18;
        Sat, 13 Mar 2021 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615647753;
        bh=dn9d2sq0rqQOsUyglfcBnYfaTvD6EJjNv68ebbDAMVM=;
        h=Date:From:To:Cc:Subject:From;
        b=DNIDqxwoJR8tyozc4sWF2ZmIfA4caB1mhxBBeTIlYIrAD+S+5Ehd2je60kmRWzCvM
         rVbUY6/Vz0UDl+LTrIRXzoQwx9Pv3a8L3wgJl4v6YsMQO6fsqnGUlM0YE4iSL+uuEC
         A69L/hOl31O64boc/rlXKhlVMoxb9Pn2csAlF7wc=
Date:   Sat, 13 Mar 2021 16:02:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 5.12-rc3
Message-ID: <YEzUB0on5Uq36R2g@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.12-rc3

for you to fetch changes up to c776b77a279c327fe9e7710e71a3400766554255:

  Revert "drivers:tty:pty: Fix a race causing data loss on close" (2021-03-10 09:27:56 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.12-rc3

Here are some small tty and serial driver fixes for 5.12-rc3 to resolve
some reported problems:
	- led tty trigger fixes based on review and were acked by the
	  led maintainer
	- revert a max310x serial driver patch as it was causing
	  problems.
	- revert a pty change as it was also causing problems

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shiyan (1):
      Revert "serial: max310x: rework RX interrupt handling"

Greg Kroah-Hartman (1):
      Revert "drivers:tty:pty: Fix a race causing data loss on close"

Uwe Kleine-König (2):
      leds: trigger: Fix error path to not unlock the unlocked mutex
      leds: trigger/tty: Use led_set_brightness_sync() from workqueue

 drivers/leds/trigger/ledtrig-tty.c | 11 ++++-------
 drivers/tty/pty.c                  | 15 ++-------------
 drivers/tty/serial/max310x.c       | 29 +++++------------------------
 drivers/tty/tty_io.c               |  5 ++---
 4 files changed, 13 insertions(+), 47 deletions(-)

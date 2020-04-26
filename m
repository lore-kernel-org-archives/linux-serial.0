Return-Path: <SRS0=ZUfo=6K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09865C55199
	for <linux-serial@archiver.kernel.org>; Sun, 26 Apr 2020 10:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69C52071C
	for <linux-serial@archiver.kernel.org>; Sun, 26 Apr 2020 10:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587898125;
	bh=V/k/v4aEozm/UfTFRAq6lXU0NttaDGGoCLBsiXSAQpQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=khc1C+DVUBACKnlXSoDpp8Un+29FvmjFNRoBcXwjFGkrzAchwhBV9ac2+RJBcGUQ8
	 5HCG9o48u6W8QDgyTj+V7vg+FkZVbqHmuT3Gdwh1aSKP5ukLHBA7tII+iSMmCshZ50
	 F0BbZf8kvS1xjJLg7lpoA8KyItHNB011Bj2ymqj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgDZKsp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgDZKsp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Apr 2020 06:48:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44D6206BF;
        Sun, 26 Apr 2020 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587898124;
        bh=V/k/v4aEozm/UfTFRAq6lXU0NttaDGGoCLBsiXSAQpQ=;
        h=Date:From:To:Cc:Subject:From;
        b=B79o5DK7DQNJezJ9r2oNG2PXCiG7+lCua8Hl7j6XvHYISXeKko1TadRUoJWc8KxHY
         //cXKef35fTwj4KSHRX4zzFaR0KbUcmi+oYEKXprl3MCwRfmlTcUk/UTUPwojdG6me
         zSnb1TZyKMOVdejtROOso9GUhwDOMwQ1TBEijMi4=
Date:   Sun, 26 Apr 2020 12:48:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.7-rc3
Message-ID: <20200426104842.GA2121011@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc3

for you to fetch changes up to 9a9fc42b86c06120744555fea43fdcabe297c656:

  tty: hvc: fix buffer overflow during hvc_alloc(). (2020-04-23 16:02:07 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 5.7-rc3

Here are some tty and serial driver fixes for 5.7-rc3.

The "largest" in here are a number of reverts for previous changes to
the uartps serial driver that turned out to not be a good idea at all.

The others are just small fixes found by people and tools.  Included in
here is a much-reported symbol export needed by previous changes that
happened in 5.7-rc1.  All of these have been in linux-next for a while
with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Amit Singh Tomar (1):
      tty: serial: owl: add "much needed" clk_prepare_enable()

Andrew Melnychenko (1):
      tty: hvc: fix buffer overflow during hvc_alloc().

Andy Shevchenko (1):
      serial: sunhv: Initialize lock for non-registered console

Dmitry Safonov (1):
      tty/sysrq: Export sysrq_mask(), sysrq_toggle_support()

Jiri Slaby (1):
      tty: rocket, avoid OOB access

Kazuhiro Fujita (1):
      serial: sh-sci: Make sure status register SCxSR is read in correct sequence

Michal Simek (7):
      Revert "serial: uartps: Fix uartps_major handling"
      Revert "serial: uartps: Use the same dynamic major number for all ports"
      Revert "serial: uartps: Fix error path when alloc failed"
      Revert "serial: uartps: Do not allow use aliases >= MAX_UART_INSTANCES"
      Revert "serial: uartps: Change uart ID port allocation"
      Revert "serial: uartps: Move Port ID to device data structure"
      Revert "serial: uartps: Register own uart console and driver structures"

Nicolas Pitre (2):
      vt: don't use kmalloc() for the unicode screen buffer
      vt: don't hardcode the mem allocation upper bound

Zou Wei (1):
      tty: serial: bcm63xx: fix missing clk_put() in bcm63xx_uart

 drivers/tty/hvc/hvc_console.c      |  23 ++--
 drivers/tty/rocket.c               |  25 +++--
 drivers/tty/serial/bcm63xx_uart.c  |   4 +-
 drivers/tty/serial/owl-uart.c      |   7 ++
 drivers/tty/serial/sh-sci.c        |  13 ++-
 drivers/tty/serial/sunhv.c         |   3 +
 drivers/tty/serial/xilinx_uartps.c | 211 +++++++++----------------------------
 drivers/tty/sysrq.c                |   2 +
 drivers/tty/vt/vt.c                |   7 +-
 9 files changed, 106 insertions(+), 189 deletions(-)

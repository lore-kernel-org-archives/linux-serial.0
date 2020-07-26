Return-Path: <SRS0=PqTn=BF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC8C433E4
	for <linux-serial@archiver.kernel.org>; Sun, 26 Jul 2020 11:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009CA2070A
	for <linux-serial@archiver.kernel.org>; Sun, 26 Jul 2020 11:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595761942;
	bh=93Eu6iILE8VmwYVNjEyASrY6lLnr9U0g8lfkvO52+zc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gxrp9dnfc5tsz05VnZay50e/+D4t15JfUMEO6XKtmmIFAhBHCRMcRAcwAVvwwSLuO
	 NBOF0pDnoOw4DhiVlj7bxR3OvFwrDaZ2CWWI16YGKkjdiDApN0jfUJyyLEs/fJiCab
	 FGmP3FQv6unD5F9aI1tyVK68y5Jneonkf2V5VdrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGZLMV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGZLMV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Jul 2020 07:12:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87F1206D8;
        Sun, 26 Jul 2020 11:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595761939;
        bh=93Eu6iILE8VmwYVNjEyASrY6lLnr9U0g8lfkvO52+zc=;
        h=Date:From:To:Cc:Subject:From;
        b=HdBkWGOrvROIwUucIDrucDBvgpFoVZ3z/1i0IU/5GGj3nPch/AuRruw17G6L+yEhv
         69ijoXEHEJAepjxKxfVB+VrrD+a3iOotcY/cIC6aPHFJbVXmam8ld22QXaOB899PSa
         ZElnweHjS0bXzv9FEA9YYA9mM3sIkgw86GUOH/zE=
Date:   Sun, 26 Jul 2020 13:12:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.8-rc7
Message-ID: <20200726111217.GA1283587@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.8-rc7

for you to fetch changes up to 5fdbe136ae19ab751daaa4d08d9a42f3e30d17f9:

  serial: exar: Fix GPIO configuration for Sealevel cards based on XR17V35X (2020-07-24 10:58:14 +0200)

----------------------------------------------------------------
TTY/Serial/fbcon fixes for 5.8-rc7

Here are some small tty and serial and fbcon fixes for 5.8-rc7 to
resolve some reported issues.

The fbcon fix is in here as it was simpler to take it this way (and it
was acked by the maintainer) as it was related to the vt console fix as
well, both of which resolve syzbot-found issues in the console handling
code.

The other serial driver fixes are for small issues reported in the -rc
releases.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Helmut Grohne (1):
      tty: xilinx_uartps: Really fix id assignment

Johan Hovold (2):
      serial: tegra: fix CREAD handling for PIO
      serial: tegra: drop bogus NULL tty-port checks

Matthew Howell (1):
      serial: exar: Fix GPIO configuration for Sealevel cards based on XR17V35X

Serge Semin (1):
      serial: 8250_mtk: Fix high-speed baud rates clamping

Tetsuo Handa (2):
      vt: Reject zero-sized screen buffer size.
      fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.

Yang Yingliang (1):
      serial: 8250: fix null-ptr-deref in serial8250_start_tx()

 drivers/tty/serial/8250/8250_core.c  |  2 +-
 drivers/tty/serial/8250/8250_exar.c  | 12 +++++++++++-
 drivers/tty/serial/8250/8250_mtk.c   | 18 ++++++++++++++++++
 drivers/tty/serial/serial-tegra.c    | 16 +++++++---------
 drivers/tty/serial/xilinx_uartps.c   |  8 ++++++--
 drivers/tty/vt/vt.c                  | 29 ++++++++++++++++++-----------
 drivers/video/fbdev/core/bitblit.c   |  4 ++--
 drivers/video/fbdev/core/fbcon_ccw.c |  4 ++--
 drivers/video/fbdev/core/fbcon_cw.c  |  4 ++--
 drivers/video/fbdev/core/fbcon_ud.c  |  4 ++--
 10 files changed, 69 insertions(+), 32 deletions(-)

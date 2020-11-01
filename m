Return-Path: <SRS0=ovE7=EH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383A3C2D0A3
	for <linux-serial@archiver.kernel.org>; Sun,  1 Nov 2020 13:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55A520B1F
	for <linux-serial@archiver.kernel.org>; Sun,  1 Nov 2020 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604236093;
	bh=OKRuyWuvdAwioq0aYuC57xGX8H+1JImte1OFYpAUBT8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fbIl/znhGJ0mH7iK1ldBYf4XwpOl3ElIbtzvzNkJjnul0yEaanTMF1dBVcsKD9HC5
	 rHcHXWdN8peW1HpU+K8OKtafnD+7wUAZC0Yxv7onjhiZU0lhR0HqGCoQ46/BLeUviQ
	 e3Xvaye2EZvOFoRE0IKjgRhWO9soTRIQxDrZHpOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgKANIM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 1 Nov 2020 08:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:52926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgKANIL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 1 Nov 2020 08:08:11 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85639208B6;
        Sun,  1 Nov 2020 13:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604236091;
        bh=OKRuyWuvdAwioq0aYuC57xGX8H+1JImte1OFYpAUBT8=;
        h=Date:From:To:Cc:Subject:From;
        b=H+UIuYbH8OMFaQCZhPkBizOJ5EevbMKfDddKFGaOn/qI4Gajm6d0sjhS1qWsGWVOz
         B61Z3v1GxMFRMhPJAFryUyPsbOYIi9h16AuyAwUnrOtgFmV80BGCf81hRT4sKCwj3E
         1Lbdd/YOnhiUVCozXeJwod6Iw708CxVAmH8rOgjg=
Date:   Sun, 1 Nov 2020 14:08:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.10-rc2
Message-ID: <20201101130854.GA4114977@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc2

for you to fetch changes up to d54654790302ccaa72589380dce060d376ef8716:

  vt_ioctl: fix GIO_UNIMAP regression (2020-10-28 13:41:17 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.10-rc2

Here are some small TTY and Serial driver fixes for reported issues for
5.10-rc2.  They include:
	- vt ioctl bugfix for reported problems
	- fsl_lpuart serial driver fix
	- 21285 serial driver bugfix

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Jiri Slaby (3):
      vt: keyboard, simplify vt_kdgkbsent
      vt: keyboard, extend func_buf_lock to readers
      vt_ioctl: fix GIO_UNIMAP regression

Russell King (1):
      tty: serial: 21285: fix lockup on open

Vladimir Oltean (1):
      tty: serial: fsl_lpuart: LS1021A has a FIFO size of 16 words, like LS1028A

 drivers/tty/serial/21285.c      | 12 ++++++------
 drivers/tty/serial/fsl_lpuart.c | 13 +++++++------
 drivers/tty/vt/keyboard.c       | 39 +++++++++++++++++++--------------------
 drivers/tty/vt/vt_ioctl.c       | 11 +++++------
 4 files changed, 37 insertions(+), 38 deletions(-)

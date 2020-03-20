Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075BDC4332D
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 14:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA232072D
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 14:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584714440;
	bh=7XWuZryHtfWvsLZhM76IcRNhObhLjJKgrixahU+eeQM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=pFEP32oBLapNWayb82h7E48Ww6UEei/Hh5J6McjxW+ganp+0rno2S/6ur0bsg62Gy
	 QadxF1iREhxV5nK0/i2r5bslghX9J1ubAhIezJu6NRmZ0Y2ncAAajr9Qy47Vq4+7+/
	 2rKdn2/dAby6ZGU468FCnLFDiJXEUMMKMnAN0V/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgCTO1U (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgCTO1U (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 10:27:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B4DF2070A;
        Fri, 20 Mar 2020 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584714439;
        bh=7XWuZryHtfWvsLZhM76IcRNhObhLjJKgrixahU+eeQM=;
        h=Date:From:To:Cc:Subject:From;
        b=g4W1ECiUIITNnXksH9VzXhGLRRSP5/V9gZjmfQ7KfpoWYvZRZHike4FkBu3tgTPSl
         y4zojU/zgWPyfgEOQ/rzAK/zKwhGovWSpBv2bjWT3/s5lu7/QnSS1n3VBIjpcb7RwS
         luutaZRnJs8O0GqWlEnPn+L5C/ob24MYFs/+iq+o=
Date:   Fri, 20 Mar 2020 15:27:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY driver fixes for 5.6-rc7
Message-ID: <20200320142715.GA760292@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

  Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc7

for you to fetch changes up to 6e622cd8bd888c7fa3ee2b7dfb3514ab53b21570:

  tty: fix compat TIOCGSERIAL checking wrong function ptr (2020-03-18 13:15:13 +0100)

----------------------------------------------------------------
TTY fixes for 5.6-rc7

Here are 3 small tty_io bugfixes for reported issues that Eric has
resolved for 5.6-rc7

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Eric Biggers (3):
      tty: drop outdated comments about release_tty() locking
      tty: fix compat TIOCGSERIAL leaking uninitialized memory
      tty: fix compat TIOCGSERIAL checking wrong function ptr

 drivers/tty/tty_io.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

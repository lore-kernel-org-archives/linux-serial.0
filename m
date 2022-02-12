Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080CFC433EF
	for <linux-serial@archiver.kernel.org>; Sat, 12 Feb 2022 10:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiBLKbD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 12 Feb 2022 05:31:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiBLKbD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 12 Feb 2022 05:31:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D2426130;
        Sat, 12 Feb 2022 02:31:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 109E960B78;
        Sat, 12 Feb 2022 10:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD437C340E7;
        Sat, 12 Feb 2022 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644661859;
        bh=AZ7gppmh0+EiNtTyIVc8Zwcw1EbDUPBE3RcP3FL6ZEk=;
        h=Date:From:To:Cc:Subject:From;
        b=XnH2HTs9alN041sKR4RHOVRdtVmxCWSWvIC85uij30KW2np+nK4kCz9CxENMPD8Rz
         idRgkqd5fIZ9Ngmgyx25yUA4Wed6tIqImPJrDaSxBUa4v0Qrt6WIkLLkTcSZll/0Nn
         sUdb1ZpmX6Wa5QSUet3n11zHBiBe4zRT0SitJvNY=
Date:   Sat, 12 Feb 2022 11:30:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.17-rc4
Message-ID: <YgeMYDjVOe8n4Cis@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.17-rc4

for you to fetch changes up to 28cb138f559f8c1a1395f5564f86b8bbee83631b:

  vt_ioctl: add array_index_nospec to VT_ACTIVATE (2022-02-04 15:36:02 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.17-rc4

Here are 4 small tty/serial fixes for 5.17-rc4.  They are:
	- 8250_pericom change revert to fix a reported regression
	- 2 speculation fixes for vt_ioctl
	- n_tty regression fix for polling

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: 8250_pericom: Revert "Re-enable higher baud rates"

Jakob Koschel (2):
      vt_ioctl: fix array_index_nospec in vt_setactivate
      vt_ioctl: add array_index_nospec to VT_ACTIVATE

TATSUKAWA KOSUKE (立川 江介) (1):
      n_tty: wake up poll(POLLRDNORM) on receiving data

 drivers/tty/n_tty.c                    | 4 ++--
 drivers/tty/serial/8250/8250_pericom.c | 2 +-
 drivers/tty/vt/vt_ioctl.c              | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

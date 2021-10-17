Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4913EC433F5
	for <linux-serial@archiver.kernel.org>; Sun, 17 Oct 2021 10:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2780360FF2
	for <linux-serial@archiver.kernel.org>; Sun, 17 Oct 2021 10:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245269AbhJQKIY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 Oct 2021 06:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245267AbhJQKIX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 Oct 2021 06:08:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F39160F56;
        Sun, 17 Oct 2021 10:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634465173;
        bh=yDerk6JARt/9kZauK/QppOeDo+OiXfAdBX6sWnM4Tqk=;
        h=Date:From:To:Cc:Subject:From;
        b=Fecw5fjUYGoOLhQU2U7vIPP9OBXhTj5Bh8PwvrEFs/1xSEqXMwGJEhHtUhayV+haI
         zgKBgGYBeskVaKk040IPxoH1GXrUhzexC/Mq0qHqNrprtxHJ5G9ayNCYlhbqsBcwdw
         A/IeEFW2BU1Cye5cMP3gVBA2tAyUcZcwXj42qjBo=
Date:   Sun, 17 Oct 2021 12:06:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.15-rc6
Message-ID: <YWv1k5ygiW+Avl05@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.15-rc6

for you to fetch changes up to cb2282213e84f04ab7e93fd4537815da5db2f010:

  serial: 8250: allow disabling of Freescale 16550 compile test (2021-10-05 15:07:44 +0200)

----------------------------------------------------------------
Serial driver fix for 5.15-rc6

Here is a single 8250 Kconfig fix for 5.15-rc6 that resolves a
regression that showed up in 5.15-rc1.  It has been in linux-next for a
while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Johan Hovold (1):
      serial: 8250: allow disabling of Freescale 16550 compile test

 drivers/tty/serial/8250/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

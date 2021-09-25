Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2741CC433F5
	for <linux-serial@archiver.kernel.org>; Sat, 25 Sep 2021 14:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF1E610CB
	for <linux-serial@archiver.kernel.org>; Sat, 25 Sep 2021 14:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245756AbhIYOPD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Sep 2021 10:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233738AbhIYOOw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Sep 2021 10:14:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29CAA60F51;
        Sat, 25 Sep 2021 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632579197;
        bh=5z3H+QaxnFsBPyB7eVlx/so+FcR535RNkuZdYokQgO4=;
        h=Date:From:To:Cc:Subject:From;
        b=TMDmux9tS5IvW292jeiR5D3RWbSa2BJ/YAuYOdhE91tfgbuClI0eyNWSGH2lmBfmU
         oK9qS3T4FZQKn5lKc5eF/jjjLvZ6KyYOwiqVW9H05IA4d57zhJoPsA+CpbmXs9W3t5
         mN2Phoyc/A62XhR5hTBHyW14CAaoU0+N0fk7A0/Q=
Date:   Sat, 25 Sep 2021 16:13:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.15-rc3
Message-ID: <YU8ue5u+44spJB0v@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.15-rc3

for you to fetch changes up to 7049d853cfb928f50b6041cb4a5c6d6c1d8dd201:

  tty: unexport tty_ldisc_release (2021-09-14 11:18:47 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 5.15-rc3

Here are 4 small tty/serial driver fixes for 5.15-rc3.  They include:
	- remove an export now that no one is using it anymore
	- mvebu-uart tx_empty callback fix
	- 8250_omap bugfix
	- synclink_gt build fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Jiri Slaby (1):
      tty: unexport tty_ldisc_release

Nishanth Menon (1):
      serial: 8250: 8250_omap: Fix RX_LVL register offset

Pali Rohár (1):
      serial: mvebu-uart: fix driver's tx_empty callback

Randy Dunlap (1):
      tty: synclink_gt: rename a conflicting function name

 drivers/tty/serial/8250/8250_omap.c |  2 +-
 drivers/tty/serial/mvebu-uart.c     |  2 +-
 drivers/tty/synclink_gt.c           | 44 ++++++++++++++++++-------------------
 drivers/tty/tty_ldisc.c             |  1 -
 4 files changed, 24 insertions(+), 25 deletions(-)

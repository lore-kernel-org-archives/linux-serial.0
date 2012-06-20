From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] TTY/serial patches for 3.5-rc4
Date: Wed, 20 Jun 2012 13:52:25 -0700
Message-ID: <20120620205225.GA19105@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46096 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2FTUw2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jun 2012 16:52:28 -0400
Received: by pbbrp8 with SMTP id rp8so1105529pbb.19
        for <linux-serial@vger.kernel.org>; Wed, 20 Jun 2012 13:52:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.5-rc4

for you to fetch changes up to 78d80c5a720ea370defa3e3124c0f7f7179bdfe5:

  serial/amba-pl011: move custom pin control to driver (2012-06-12 15:41:44 -0700)

----------------------------------------------------------------
Serial driver fixes for 3.5-rc4

Here are 3 patches resolving a boot regression (the mop500 fix), a build
warning fix, and a kernel-doc fix.  All tiny, but should go into the
final 3.5 release.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Linus Walleij (1):
      serial/amba-pl011: move custom pin control to driver

Randy Dunlap (2):
      serial: fix kernel-doc warnings in 8250.c
      serial: fix serial_txx9.c build warning/typo

 arch/arm/mach-ux500/board-mop500.c |   54 +-----------------------------------
 drivers/tty/serial/8250/8250.c     |    2 +-
 drivers/tty/serial/amba-pl011.c    |   45 +++++++++++++++++++++++++++---
 drivers/tty/serial/serial_txx9.c   |    2 +-
 4 files changed, 44 insertions(+), 59 deletions(-)

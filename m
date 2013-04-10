From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] TTY/Serial fixes for 3.9-rc6
Date: Wed, 10 Apr 2013 15:48:40 -0700
Message-ID: <20130410224840.GA32608@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:43372 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933304Ab3DJWsn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Apr 2013 18:48:43 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so408541dak.16
        for <linux-serial@vger.kernel.org>; Wed, 10 Apr 2013 15:48:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.9-rc6

for you to fetch changes up to 1b581f173992cded311f810346378f763a1f1e5d:

  tty: mxser: fix cycle termination condition in mxser_probe() and mxser_module_init() (2013-04-08 11:30:04 -0700)

----------------------------------------------------------------
TTY/Serial fixes for 3.9-rc6

Here are 4 small tty/serial fixes for 3.9.

One fixes a bug where we broke the documentation build, and the others
fix reported problems in some serial drivers.

All have been in linux-next for a while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexey Khoroshilov (1):
      tty: mxser: fix cycle termination condition in mxser_probe() and mxser_module_init()

Alexey Pelykh (1):
      OMAP/serial: Revert bad fix of Rx FIFO threshold granularity

Guennadi Liakhovetski (1):
      tty: Documentation: fix a path in a DocBook template

Sean Young (1):
      Revert "tty/8250_pnp: serial port detection regression since v3.7"

 Documentation/DocBook/device-drivers.tmpl |  2 +-
 drivers/tty/mxser.c                       |  8 ++++----
 drivers/tty/serial/8250/8250_pnp.c        | 12 +++++-------
 drivers/tty/serial/omap-serial.c          | 11 +++++++++++
 4 files changed, 21 insertions(+), 12 deletions(-)

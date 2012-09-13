From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] TTY fixes for 3.6-rc6
Date: Thu, 13 Sep 2012 10:45:02 -0700
Message-ID: <20120913174502.GA21928@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43108 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab2IMRpH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Sep 2012 13:45:07 -0400
Received: by obbuo13 with SMTP id uo13so4935791obb.19
        for <linux-serial@vger.kernel.org>; Thu, 13 Sep 2012 10:45:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.6-rc6

for you to fetch changes up to 7be0670f7b9198382938a03ff3db7f47ef6b4780:

  tty: serial: imx: don't reinit clock in imx_setup_ufcr() (2012-09-05 12:44:44 -0700)

----------------------------------------------------------------
TTY fixes for 3.6-rc6

Here are 2 tiny patches for a serial driver to resolve issues that
people have reported with the 3.6-rc tree.

Both of these have been in the linux-next tree for a while now.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dirk Behme (1):
      tty: serial: imx: don't reinit clock in imx_setup_ufcr()

Xinyu Chen (1):
      tty: serial: imx: console write routing is unsafe on SMP

 drivers/tty/serial/imx.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

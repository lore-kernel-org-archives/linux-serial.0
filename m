From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] TTY/Serial fix for 3.7-rc7
Date: Mon, 26 Nov 2012 15:19:23 -0800
Message-ID: <20121126231923.GA21621@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:38422 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754842Ab2KZXT0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Nov 2012 18:19:26 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba6=
3681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-3.7-rc7

for you to fetch changes up to b1a925f44a3a21c538144e30b08f966cad7adb63=
:

  tty vt: Fix a regression in command line edition (2012-11-21 16:45:32=
 -0800)

----------------------------------------------------------------
TTY fix for 3.7-rc7

Here is a single fix for a reported regression in 3.7-rc5 for the tty
layer.  This fix has been in the linux-next tree and solves the reporte=
d
problem.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Jean-Fran=E7ois Moine (1):
      tty vt: Fix a regression in command line edition

 drivers/tty/vt/vt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

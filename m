From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] Serial fixes for 3.14-rc1
Date: Mon, 27 Jan 2014 15:48:28 -0800
Message-ID: <20140127234828.GA15394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37210 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679AbaA0XrX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Jan 2014 18:47:23 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

The following changes since commit 8bc661bfc0c2d221e209f4205bdaaf574d50=
100c:

  tty/serial: at91: disable uart timer at start of shutdown (2014-01-13=
 15:55:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-3.14-rc1

for you to fetch changes up to 4fbd269f1f9f8020dd9474b60e55c4f34d267b08=
:

  Merge branch 'fixes' into tty-next (2014-01-22 13:42:19 -0800)

----------------------------------------------------------------

Serial fixes for 3.14-rc1

Here are tiny and assorted serial driver fixes that have been in a
branch in my tree for a while and somehow did not get properly merged
into my big TTY / Serial pull request for 3.14-rc1.  Sorry about that.

All have been in linux-next for a while with no issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      serial: icom: dereference after free in load_code()

Greg Kroah-Hartman (1):
      Merge branch 'fixes' into tty-next

Heiko St=FCbner (1):
      serial: samsung: move clock deactivation below uart registration

Jonathan Woithe (1):
      serial: 8250: Fix initialisation of Quatech cards with the AMCC P=
CI chip

Mika Westerberg (1):
      serial: 8250_dw: add new ACPI IDs

Sebastian Andrzej Siewior (1):
      tty: serial: pch: don't crash if DMA enabled but not loaded

Soren Brinkmann (1):
      tty: xuartps: Properly guard sysrq specific code

 drivers/tty/serial/icom.c     |  4 ++--
 drivers/tty/serial/pch_uart.c | 10 +++++++---
 drivers/tty/serial/samsung.c  |  8 +++++++-
 3 files changed, 16 insertions(+), 6 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

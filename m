From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] TTY/serial patches for 3.4-rc4
Date: Fri, 20 Apr 2012 10:21:27 -0700
Message-ID: <20120420172127.GB21573@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:36898 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab2DTRVb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Apr 2012 13:21:31 -0400
Received: by dake40 with SMTP id e40so13274624dak.11
        for <linux-serial@vger.kernel.org>; Fri, 20 Apr 2012 10:21:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.4-rc4

for you to fetch changes up to d3a7b83f865b46bb7b5e1ed18a129ce1af349db4:

  drivers/tty/amiserial.c: add missing tty_unlock (2012-04-19 19:15:35 -0700)

----------------------------------------------------------------
TTY fixes for 3.4-rc4

Here are 3 tiny bugfixes for 3.4-rc4.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shiyan (1):
      ARM: clps711x: serial driver hungs are a result of call disable_irq within ISR

Julia Lawall (1):
      drivers/tty/amiserial.c: add missing tty_unlock

Tomoya MORINAGA (1):
      pch_uart: Fix dma channel unallocated issue

 drivers/tty/amiserial.c       |    4 +++-
 drivers/tty/serial/clps711x.c |   14 ++++++++------
 drivers/tty/serial/pch_uart.c |    4 +++-
 3 files changed, 14 insertions(+), 8 deletions(-)

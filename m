Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5A192589;
	Sun, 16 Feb 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739718765; cv=none; b=O0O73LzIbKhGazY3SoLz9/O4OLcwxn3laxzXTNbYwM2OzummkPkTTsIn/4ynSXhKLPaGBqLjpeSg3Cg37krJwHpOUNvzhrlsRjSjumv0FknoaodkoYqO24+wRcBVTC/+OjwqbPvz2szOdHlq1ZwHaKpYxcQ2j/OZ6YH2ZGSQ7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739718765; c=relaxed/simple;
	bh=xnxUTScNc+hOToT5nb5v5E0I5xkJ1Sn1mdocFQWWYuw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LT0BuPQh8HbBi2BPGv8ZGrzNmwyK+WpqjU2bkxVWxk1+7V/DcRZNUAKcbr5knOPpWtbuvSQLANxS335g0XrHLRCC8PjF7nqt1uCSd/5IsSgyo2ICUb60WAZLmgefRlGBsMcmg/68Bt3bwkCDJoAnxLeMEBoJuX0t1NYyML0aVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NmjxKegH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NmjxKegH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D95C4CEDD;
	Sun, 16 Feb 2025 15:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739718764;
	bh=xnxUTScNc+hOToT5nb5v5E0I5xkJ1Sn1mdocFQWWYuw=;
	h=Date:From:To:Cc:Subject:From;
	b=NmjxKegHxbyBD2RQqHUsf0meLKDr02/v0fcTT6iq7xsP2fMb/lYI9t2xy6t44stOj
	 lHZMgaoA76r7AXRTmLW4GrVebPpMFzYuWkSpGH59kuHs7ZFMYk7iCOlNIiwKGqWhi/
	 6TkzBL7yv87DKnsHBjcq0h6YC2+h41/eC6ejlJXI=
Date: Sun, 16 Feb 2025 16:12:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 6.14-rc3
Message-ID: <Z7IAaY1o908PmAmC@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.14-rc3

for you to fetch changes up to 9e512eaaf8f4008c44ede3dfc0fbc9d9c5118583:

  serial: 8250: Fix fifo underflow on flush (2025-02-14 09:50:55 +0100)

----------------------------------------------------------------
Serial driver fixes for 6.14-rc3

Here are some small serial driver fixes for some reported problems for
6.14-rc3.  Nothing major, just:
  - sc16is7xx irq check fix
  - 8250 fifo underflow fix
  - serial_port and 8250 iotype fixes

Most of these have been in linux-next already, and all have passed 0-day
testing.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andre Werner (1):
      serial: sc16is7xx: Fix IRQ number check behavior

Andy Shevchenko (6):
      serial: port: Assign ->iotype correctly when ->iobase is set
      serial: port: Always update ->iotype in __uart_read_properties()
      serial: port: Make ->iotype validation global in __uart_read_properties()
      serial: 8250_of: Remove unneeded ->iotype assignment
      serial: 8250_platform: Remove unneeded ->iotype assignment
      serial: 8250_pnp: Remove unneeded ->iotype assignment

John Keeping (1):
      serial: 8250: Fix fifo underflow on flush

 drivers/tty/serial/8250/8250.h          |  2 ++
 drivers/tty/serial/8250/8250_dma.c      | 16 ++++++++++++++++
 drivers/tty/serial/8250/8250_of.c       |  1 -
 drivers/tty/serial/8250/8250_platform.c |  9 ---------
 drivers/tty/serial/8250/8250_pnp.c      | 10 ----------
 drivers/tty/serial/8250/8250_port.c     |  9 +++++++++
 drivers/tty/serial/sc16is7xx.c          |  2 +-
 drivers/tty/serial/serial_port.c        | 12 +++++++-----
 8 files changed, 35 insertions(+), 26 deletions(-)

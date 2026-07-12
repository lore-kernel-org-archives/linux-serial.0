Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7938A725;
	Sun, 12 Jul 2026 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783845724; cv=none; b=DB5FQICVl1OLPDbhMGjYbohQVyE/lP9re85ngTCYlFxei7YqX1j3WkVI6UijpUj2kJsJ0PmqGgT5so/d1ZRhycNrUII7szcREqJ1qXZPmv/Rrzb63q7gqj9pSZnvR2W4XPnlBjhHH3wFNFABqv85Mcramp3KZyfcWPX4qcALDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783845724; c=relaxed/simple;
	bh=FQueeHfyTZVwq5F0+fEOYsyozrPMPR+IeLhIFE2G//g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VSq0dB68n6J5OJM2SmgafsAayBpF5QWK9QmMDS1iiv5GSaOUFqW3GzvadaWX5VRMjMYcC4bI8OVr0/N5ZRg7Ge+vSm0RsrPcTl9KWWBdfOjc1OuvcCti6UQ4nZuOnVB3xqE2l41LLewi2r+vpTU7InlYLvzAjKJjuy731ITUEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w06HRhjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w06HRhjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFE81F000E9;
	Sun, 12 Jul 2026 08:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783845719;
	bh=Xsp566+5iJkyWrvcztgoSfpZ0QGTvdpDVo/e1pkSnC4=;
	h=Date:From:To:Cc:Subject;
	b=w06HRhjUvq3K+h9ZeHBcbjabp6azTRs3T2qY8xNcoR+vZhanieq7yDDXluaTh5Lcq
	 48rLOcvC8Y1FrObwauav1piZWhGy2AENpcq4y4k0veHChKj45TffipwxAiCA7J0P64
	 Lsb2moDYMGI5J3W/Y30Jr9m6iwHkA8PvSbiRvjnk=
Date: Sun, 12 Jul 2026 10:41:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 7.2-rc3
Message-ID: <alNTUs9uo0TesjLv@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc3

for you to fetch changes up to 302fbbb4fcbdeac2dc8c63a56c1c4e38c4781958:

  serial: 8250: Ignore flow control on suspend/resume with no_console_suspend (2026-07-10 14:47:30 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 7.2-rc3

Here are some small tty/serial/vt fixes for 7.2-rc3 that resolve some
reported problems.  Included in here are:
  - vt spurious modifier issue that showed up in -rc1 (reported a bunch)
  - 8250 driver bugfixes
  - msm serial driver bugfix
  - max310x serial driver bugfix

All of these have been in linux-next with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: 8250_mid: Disable DMA for selected platforms

John Ogness (1):
      serial: 8250: Ignore flow control on suspend/resume with no_console_suspend

Matthias Feser (1):
      serial: 8250_omap: clear rx_running on zero-length DMA completes

Nicolas Pitre (1):
      vt: fix spurious modifier in CSI/cursor key sequences

Stephan Gerhold (1):
      serial: msm: Disable DMA for kernel console UART

Tapio Reijonen (1):
      serial: max310x: implement gpio_chip::get_direction()

 drivers/tty/serial/8250/8250_mid.c  | 13 +++++++++++--
 drivers/tty/serial/8250/8250_omap.c |  3 ++-
 drivers/tty/serial/8250/8250_port.c | 10 ++++++++--
 drivers/tty/serial/max310x.c        | 12 ++++++++++++
 drivers/tty/serial/msm_serial.c     |  3 ++-
 drivers/tty/vt/keyboard.c           | 12 +++++++++---
 6 files changed, 44 insertions(+), 9 deletions(-)

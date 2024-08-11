Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32DE3F9C5;
	Sun, 11 Aug 2024 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382644; cv=none; b=gYTfzj0nadItgdAaudBtj5nq65tgHhJNXPXLTo5/D8gyvtgbOCzReRn4P7jVa4F7ywI+pnWKwBHHau1NhtXBb1vYqfI/RW6JANlyM7b7/Mnl7WykFWFo1SsrYgwWK3C+9MKIaBG/YXKPMorVUOTrvFH5fpUvOAE63UP0CpIL7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382644; c=relaxed/simple;
	bh=gG2idkdXx+dqi+4VS16L6uh+EdJH4OL7szIt8LtidB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H236/MDghFa8d2rc7xSu6+4k8zr90TMptV1fO6810rZr0DAK5ZAStAblhM5aQFYl3EIlP1VetkwWzI+VKTHQbFf1wUE+fkysQ9S70TJjtXZ5m0OnUma/8W1aBm2tDtUm5e3jJrt5Z0QK3C8TXkiJMxR5WXe6koDef0G3mSX1MMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=obeBcN3X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="obeBcN3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A73C32786;
	Sun, 11 Aug 2024 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723382644;
	bh=gG2idkdXx+dqi+4VS16L6uh+EdJH4OL7szIt8LtidB0=;
	h=Date:From:To:Cc:Subject:From;
	b=obeBcN3XR0eyBAYeu0n3e25pnEOqIfC+g29cbqbFU70hGrF7ZZXfM/9hRShHlS25+
	 KIK7+3Iw7ZkHpWVPs0She67C6IpOHtK2rzPHgDtJGIyMfpjEb54nMaN6tLs/+nKgbf
	 2BQr+yY70vOg9fDJ6dr4127V3B1YkTsZ7ZeCJbv0=
Date: Sun, 11 Aug 2024 15:24:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 6.11-rc3
Message-ID: <Zri7cUG-SZsEn2vY@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.11-rc3

for you to fetch changes up to 6e20753da6bc651e02378a0cdb78f16c42098c88:

  tty: vt: conmakehash: cope with abs_srctree no longer in env (2024-07-31 12:31:32 +0200)

----------------------------------------------------------------
tty/serial driver fixes for 6.11-rc3

Here are some small tty and serial driver fixes for reported problems
for 6.11-rc3.  Included in here are:
 - sc16is7xx serial driver fixes
 - uartclk bugfix for a divide by zero issue
 - conmakehash userspace build issue fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
George Kennedy (1):
      serial: core: check uartclk for zero to avoid divide by zero

Hugo Villeneuve (2):
      serial: sc16is7xx: fix TX fifo corruption
      serial: sc16is7xx: fix invalid FIFO access with special register set

Max Krummenacher (1):
      tty: vt: conmakehash: cope with abs_srctree no longer in env

 drivers/tty/serial/sc16is7xx.c   | 25 +++++++++++++++----------
 drivers/tty/serial/serial_core.c |  8 ++++++++
 drivers/tty/vt/conmakehash.c     | 20 +++++++-------------
 3 files changed, 30 insertions(+), 23 deletions(-)

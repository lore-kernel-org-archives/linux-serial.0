Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63E14F63
	for <linux-serial@vger.kernel.org>; Sat,  9 Dec 2023 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y9Bmdkr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC58EC433C8;
	Sat,  9 Dec 2023 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702130013;
	bh=NGosgo9icqUGfR9kDXlIy5kT5uIVLre2hE6LsRIINVM=;
	h=Date:From:To:Cc:Subject:From;
	b=y9Bmdkr0b7scSy9hvqejhBkxHhSagzPsxJUCSSuIHC7MMRAP8mIzp8gqQDQSUDV6H
	 U52m8AwYIKOPKy8wTtkIpKjnZvkuKBcusUZsACl8Jyh517LpKGeok9wNSrtikgSxBo
	 mhSg/OroQAX3kShaw1AeD3mykaHh3yLC15W2CPUk=
Date: Sat, 9 Dec 2023 14:53:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.7-rc5
Message-ID: <ZXRxWubSRJ4lGC1N@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.7-rc4

for you to fetch changes up to e92fad024929c79460403acf946bc9c09ce5c3a9:

  serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART (2023-12-07 10:48:56 +0900)

----------------------------------------------------------------
Serial driver fixes for 6.7-rc4

Here are some small serial driver fixes for 6.7-rc4 to resolve some
reported issues.  Included in here are:
  - pl011 dma support fix
  - sc16is7xx driver fix
  - ma35d1 console index fix
  - 8250 driver fixes for small issues

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andi Shyti (1):
      serial: ma35d1: Validate console index before assignment

Andy Shevchenko (1):
      serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART

Arnd Bergmann (1):
      ARM: PL011: Fix DMA support

Daniel Mack (1):
      serial: sc16is7xx: address RX timeout interrupt errata

Ronald Wahl (3):
      serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
      serial: 8250_omap: Add earlycon support for the AM654 UART controller
      serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit

 drivers/tty/serial/8250/8250_dw.c    |   1 +
 drivers/tty/serial/8250/8250_early.c |   1 +
 drivers/tty/serial/8250/8250_omap.c  |  14 +++--
 drivers/tty/serial/amba-pl011.c      | 112 +++++++++++++++++------------------
 drivers/tty/serial/ma35d1_serial.c   |  10 +++-
 drivers/tty/serial/sc16is7xx.c       |  12 ++++
 6 files changed, 85 insertions(+), 65 deletions(-)

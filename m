Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826098;
	b=VwWY+kaC3PAwe5hjkV3tDGhfNodZbm84NJfZGfq6YggpcUgjsTuTvz1XMcqJFlbzVscI
	 iyjeiQC10lnqn5ShNImfKQeaT1dZAoMqIZ37lYcJs2hx0rN7Zm7UJXDNRH2/CpA55YuhG
	 +YhqTYDS/bIgwE5spbgdzgG5RuMrHiS3v2SztHk5FoEwTbmov7PUwsy9gknluOVuz4vvE
	 lOKtxC6/ZB/WajV/vR5Hat5fRWl3TPRIf1L0wPh9NNd8W79i0Jpm8N3k7xmbLDvI/OlLL
	 7ijELZFsrzcEI/Lsb8i/XvGukOVSFTJbS5nd5bdwr7f3SXpRs2fjHWS6VU1lMaYoq0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826098;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=ORgCn/zSCjaESonYZxaj8n9W6R9D+JiZRmk6Bhv3/vo=;
	b=BZN5dwVZEtbgXK6zsgPt3Jxl5lgmQN9AlLM52kSh95HbalaSC3gKvFz817MwNbxFY/Or
	 jsK5aZpgva1a9/Z3meARrfVKIKv12oFcCPUHLrjXJe/G9M5s9LMs4ZCkRKWtrG9tUjKtl
	 vskCdfI6Xnt4fSbXDULpXa+XhcyBH1T0peaREinmq90lMF4Upemot5kyGksT3QHjV8/1H
	 tElDiA4+L+YRfXCXGIjpbcrjF68x7+555+Yt/U1BKe5ye8RhVEFoqOqVXA2keGTnH0o3M
	 zsBIhdw101n8bAK5DniQH+TNvgVkQ3lCwSew3ORogBMzddmLIN7pqM9UyAUGhUehuaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JXIl0QDP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A50606A339;
	Mon, 16 Nov 2026 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JXIl0QDP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552531F000C9;
	Mon, 16 Nov 2026 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794826097;
	bh=ORgCn/zSCjaESonYZxaj8n9W6R9D+JiZRmk6Bhv3/vo=;
	h=Date:From:To:Cc:Subject;
	b=JXIl0QDPHEqnWOFw+xu+M1f/zLs2gNRYXbXDO7oNqir1xyTmrfAXFEru4bXCihDSV
	 Gp5PzG3DvCR8d5nnL6ZyyvOHIR0zbSg84MBCJcLRvjBdKb9EWeXRxTftxB81DcoVPV
	 hdPhlBLsh+F6zvdD8HpfoHDb+qfZJQOu3B7rFqgg=
Date: Mon, 16 Nov 2026 11:48:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 7.4-rc4
Message-ID: <avrfbLonPT9vBmMC@kroah.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.4-rc4

for you to fetch changes up to eedf2cf3505c1562a2fb24f8b997056f023d242b:

  serial: samsung: put the previous baud clock (2026-11-03 13:28:53 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 7.4-rc4

Here are some small tty and serial driver fixes for reported problems
for 7.4-rc4.  Included in here are:
  - tty driver and vt fixes reported and fixed by Josef Bacik and Chris
    Mason.
  - some serial driver fixes by Jiri for found problems.

All of these have been in linux-next for almost 2 weeks now, with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chris Mason (1):
      vt: serialise the producers of the flip buffer

Jiri Slaby (SUSE) (3):
      serial: 8250_exar: check priv->gpio properly
      serial: 8250_hp300: reorder HPDCA code
      tty: fix misapplied compat_ptr() in tty_compat_ioctl()

Josef Bacik (8):
      serial: core: respect runtime PM when sending x_char
      serial: 8250_lpss: don't divide by 0 above 6.25 Mbaud
      serial: 8250_mxpcie: handle hangup during break
      serial: fsl_lpuart: fix tty ref of wakeup event
      serial: imx: fix the tty reference of the wakeup event
      serial: rda: free the interrupt on shutdown
      serial: samsung: don't leak the tty on an RX IRQ
      serial: samsung: put the previous baud clock

 drivers/tty/serial/8250/8250_exar.c   |  2 +-
 drivers/tty/serial/8250/8250_hp300.c  | 62 +++++++++++++++--------------------
 drivers/tty/serial/8250/8250_lpss.c   |  3 ++
 drivers/tty/serial/8250/8250_mxpcie.c | 13 +++++---
 drivers/tty/serial/fsl_lpuart.c       | 10 ++++--
 drivers/tty/serial/imx.c              | 10 ++++--
 drivers/tty/serial/rda-uart.c         |  2 ++
 drivers/tty/serial/samsung_tty.c      |  8 +++--
 drivers/tty/serial/serial_core.c      | 25 ++++++++------
 drivers/tty/serial/serial_port.c      |  4 +--
 drivers/tty/tty_io.c                  |  3 +-
 drivers/tty/vt/keyboard.c             |  6 ++++
 drivers/tty/vt/vt.c                   |  2 ++
 13 files changed, 88 insertions(+), 62 deletions(-)

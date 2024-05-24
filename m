Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EFE273FD;
	Fri, 24 May 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536926; cv=none; b=I5GUKOSZibF6BFLNxDSC78SUSGwXm8Cg+ZV8VSb7l9KHNfGU4MQPGwplwrSN7RIWhoGt3quOu7VgUwzBAqLbDAeWhALfjUArlu2Z7Gtq357GTbkZy8DXjdy0fId63M/OIn8dRncSDjijXKOMqxjDux2uK1G7v4UcT1AjO/v8MNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536926; c=relaxed/simple;
	bh=2K1g3kVDeJ3awJXb/+t4b51AojlZaPt6EK7sOJ+IxGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LtllYbxPVrmHbCPeZ+3A9K4tAIGpNBXMXaFESf2kHADKHmMwIHRO2xquzHGwU8qqZbYtEpkl8FL2pIYH6WUZ3yD7u37BRP7BC7Dt1teNY+kSVt8fBeQsbDDQLmFzRX7YQV13ARLxLrYAx5PxopvtOh1zPXxQvTNAPriqzmNIMgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tft+xQRl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tft+xQRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A93DC2BBFC;
	Fri, 24 May 2024 07:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716536925;
	bh=2K1g3kVDeJ3awJXb/+t4b51AojlZaPt6EK7sOJ+IxGw=;
	h=Date:From:To:Cc:Subject:From;
	b=Tft+xQRleT3xVUTSnGAV36rvOMvYMtlb/FYHk89uQf8yNhIx0fw1Gl4oB6+L8vuFs
	 FYzIjzxCPqQFYOe2pR/Ef4UmggVgL7a+Mwlz5v2HjpTFLkHaFkCO2pKIvAvb85IreD
	 l3Zcat7u28gZ1oun9Bztjgcmg9rVUlpMsEUdrmsI=
Date: Fri, 24 May 2024 09:48:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.10-rc1
Message-ID: <ZlBGWwX-98c6wnGW@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc1-fixes

for you to fetch changes up to 8492bd91aa055907c67ef04f2b56f6dadd1f44bf:

  serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using prescaler (2024-05-04 18:14:14 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 6.10-rc1

Here are some small TTY and Serial driver fixes that missed the
6.9-final merge window, but have been in my tree for weeks (my fault,
travel caused me to miss this.)

These fixes include:
  - more n_gsm fixes for reported problems
  - 8520_mtk driver fix
  - 8250_bcm7271 driver fix
  - sc16is7xx driver fix

All of these have been in linux-next for weeks without any reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Daniel Starke (2):
      tty: n_gsm: fix possible out-of-bounds in gsm0_receive()
      tty: n_gsm: fix missing receive state reset after mode switch

Doug Berger (1):
      serial: 8250_bcm7271: use default_mux_rate if possible

Hugo Villeneuve (1):
      serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using prescaler

Pin-yen Lin (1):
      serial: 8520_mtk: Set RTS on shutdown for Rx in-band wakeup

 drivers/tty/n_gsm.c                    | 140 +++++++++++++++++++++++----------
 drivers/tty/serial/8250/8250_bcm7271.c |  99 +++++++++++++----------
 drivers/tty/serial/8250/8250_mtk.c     |   8 +-
 drivers/tty/serial/sc16is7xx.c         |  23 ++++--
 4 files changed, 180 insertions(+), 90 deletions(-)

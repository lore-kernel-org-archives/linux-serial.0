Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A771A930;
	Sun, 20 Jul 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753008401; cv=none; b=uW7meqfRrifvrelW4sHKheLFGC+NVu97vq+EU9zVZta03NCWo+W4W6kPY2R9r310TZ+DDzdMfiH7wxKe9ktaYW+a3KmpeN9E7dRWSviNOSFygAf8IsKDmTm8wOO4p0upCaidz5LQXgsOdyeX3BpzsOwNU3GwCD+y5vF7Nze/aoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753008401; c=relaxed/simple;
	bh=7WWhOhRwtbaiwl4NoaMbTlFWnvykC55S9j1bQmJKxYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mU+lni6rz9aB1GjBRfNsS4/QaxE+0xw1tyVyke9PvapcaasFzJ9Xnjh0FRk5NFtRnOixgpbScoYf5sIB/G0iqtdj5dmAwufagSPrD5JKlTuY62AP3M4VMp+BCM22vXKcO1NE7C2u78hmbEpIREJLT39E/FTEPRfROJGtvbfnML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LGMyiE9e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LGMyiE9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1CEC4CEE7;
	Sun, 20 Jul 2025 10:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753008400;
	bh=7WWhOhRwtbaiwl4NoaMbTlFWnvykC55S9j1bQmJKxYE=;
	h=Date:From:To:Cc:Subject:From;
	b=LGMyiE9egIwP8wLPCUTWk1uSXA4Y63m+gEMWYOjhQSMOvzspyhJhE65HdoJeDKzo0
	 4ZiDnoXccYM7SGeDguJikdF2j1Rfx383wnUnw4Ij1yp3yfmXloV+yKkQFm5gV5SQzI
	 yEZ2PljFoxs/OxGGNPaLajPwsrRV8RqO+Wx+5rZY=
Date: Sun, 20 Jul 2025 12:46:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] Serial driver fixes for 6.16-rc6
Message-ID: <aHzJDbazSNDl7kv4@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc6

for you to fetch changes up to 6c0e9f05c9d7875995b0e92ace71be947f280bbd:

  pch_uart: Fix dma_sync_sg_for_device() nents value (2025-07-09 13:43:02 +0200)

----------------------------------------------------------------
Serial driver fixes for 6.16-rc6

Here are two serial driver fixes for 6.16-rc6 that do:
  - fix for the serial core OF resource leak
  - pch_uart driver fix for a "incorrect variable" issue

Both of these have been in linux-next for over a week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Johan Hovold (1):
      serial: core: fix OF node leak

Thomas Fourier (1):
      pch_uart: Fix dma_sync_sg_for_device() nents value

 drivers/tty/serial/pch_uart.c        | 2 +-
 drivers/tty/serial/serial_base_bus.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A642DF716;
	Sun, 28 Dec 2025 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766925853; cv=none; b=tvOX2mU/lUtgcdLQNo3ykdkjjUvSOM2Mbtxefu/uo0QLp2YHjmp+7DlG6kRmZ5evP3gVuHZJu/MOUtlGqraLd79KKbR8f03GM0r9u5DgSZakkwh9FxcIcbGyM3ixgYtCSuOUWNno5yVP6X7PpddlvvMVx6ZUvpCjDEYJTiY2+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766925853; c=relaxed/simple;
	bh=yipT8W46+4H8a69Al/HxAa8jZec9ZO8yY0wRB+ZgYOE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cNGECWGUhtsBbwD25bH0I8zaIGxjFxvoxtnVfkyPRryRMtiMLBm+84vP8z/z7lm/qNUBgnlf4qwLZ8/uWMhwGZ9FNYK3SNfrC1C0s5HgQaYUzJylWrsrvnWB7lHnA0qf7rWFX6VlxA9C2QinZntPjYODfRReaSNjIoe96wTRwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gfrQsEgt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gfrQsEgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D4CC19423;
	Sun, 28 Dec 2025 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766925852;
	bh=yipT8W46+4H8a69Al/HxAa8jZec9ZO8yY0wRB+ZgYOE=;
	h=Date:From:To:Cc:Subject:From;
	b=gfrQsEgtNGyv04ljqEMDLzRpWaZYMiXB7aAVwLur0bZc/7nHUb8xRgmAf670ETjY3
	 1chKvjoNnIpevsLaywMrdVlriw5qKychluZdP5bl9PBHvq4HbdT8ADcUzJlCvlwqiv
	 hmQoD694wd3iDb9gKVqj/oiKeEuWSPpcpfG+ykZI=
Date: Sun, 28 Dec 2025 13:44:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] Serial driver fixes for 6.19-rc3
Message-ID: <aVEmGSlYL_sUQhXa@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.19-rc3

for you to fetch changes up to 267ee93c417e685d9f8e079e41c70ba6ee4df5a5:

  serial: xilinx_uartps: fix rs485 delay_rts_after_send (2025-12-23 11:55:16 +0100)

----------------------------------------------------------------
Serial driver fixes for 6.19-rc3

Here are some small serial driver fixes for some reported issues.
Included in here are:
  - serial sysfs fwnode fix that was much reported
  - sh-sci driver fix
  - serial device init bugfix
  - 8250 bugfix
  - xilinx_uartps bugfix

All of these have passed 0-day testing and individual testing

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Stein (1):
      serial: core: Fix serial device initialization

Andy Shevchenko (1):
      serial: core: Restore sysfs fwnode information

Claudiu Beznea (1):
      serial: sh-sci: Check that the DMA cookie is valid

Dan Carpenter (1):
      serial: 8250: longson: Fix NULL vs IS_ERR() bug in probe

j.turek (1):
      serial: xilinx_uartps: fix rs485 delay_rts_after_send

 drivers/tty/serial/8250/8250_loongson.c |  4 ++--
 drivers/tty/serial/serial_base_bus.c    | 11 +++++++----
 drivers/tty/serial/sh-sci.c             |  2 +-
 drivers/tty/serial/xilinx_uartps.c      | 14 +++++++-------
 4 files changed, 17 insertions(+), 14 deletions(-)

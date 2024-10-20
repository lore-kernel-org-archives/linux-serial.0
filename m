Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7A192584;
	Sun, 20 Oct 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431447; cv=none; b=M2W126WJ6jkTsTW9j+mUNVJKUz+/HjHs7TFIxr2dWc9a94rPiWfDGVkfLyHmH0JLpCpjv4B50yRoS3zw+4B0BBjufTIuaIqnI8646iESALJbZjq4sPEE5g6KeShKemVpM1t4cWD8UuiD8LqJQCha6FkEE0LzTVW9l7SunmyFK8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431447; c=relaxed/simple;
	bh=5kVXWUm2KQAMiSiPiIX9smJCWHSx6GTgKnjO07hMmf0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ekIBTgCGMwvBu9yS0TZhdXf37yr2NdCOERVnQXaiyJ8v+9PMwvngh9hNmD/dSAEQYPjbNUlXOXzQjVHv+ThRh/hRIG0qv4cJoYL0hq2L66rXQk3Qdy5fYfZ3jzdMgf1uoGEuvLwkUmgIwm+uLr7DY+ELydfgrQq/tmi7vbPvgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NsKsttsY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NsKsttsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2680DC4CEC6;
	Sun, 20 Oct 2024 13:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729431445;
	bh=5kVXWUm2KQAMiSiPiIX9smJCWHSx6GTgKnjO07hMmf0=;
	h=Date:From:To:Cc:Subject:From;
	b=NsKsttsY3BpHX2FELotW+3Saa5YYuAZ3jydOz/N6Rf5hdbygAFXgdqsN2ueZjxrrt
	 k9PNwZSFfPGT86g9Gg6hWFBhJR6urIRd0QvSnn/jEHCiTlVW6j20gljJfSObtoeIF1
	 XoCq6UWpU7rFWtK+GMauhQjaEdFbOLYw7TW6ZX3I=
Date: Sun, 20 Oct 2024 15:37:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 6.12-rc4
Message-ID: <ZxUHkmIo91tAeyFl@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.12-rc4

for you to fetch changes up to be847a3a8d4ec4bf270c2455376d11f2de61bfb3:

  serial: qcom-geni: rename suspend functions (2024-10-11 08:39:24 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.12-rc4

Here are some small tty and serial driver fixes for 6.12-rc4.  Included
in here are:
  - qcom-geni serial driver fixes, wow what a mess of a UART chip that
    thing is...
  - vt infoleak fix for odd font sizes
  - imx serial driver bugfix
  - yet-another n_gsm ldisc bugfix, slowly chipping down the issues in
    that piece of code.

All of these have been in linux-next for over a week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Jeongjun Park (1):
      vt: prevent kernel-infoleak in con_font_get()

Johan Hovold (9):
      serial: qcom-geni: fix polled console initialisation
      serial: qcom-geni: revert broken hibernation support
      serial: qcom-geni: fix shutdown race
      serial: qcom-geni: fix dma rx cancellation
      serial: qcom-geni: fix receiver enable
      serial: qcom-geni: fix rx cancel dma status bit
      serial: qcom-geni: drop flip buffer WARN()
      serial: qcom-geni: drop unused receive parameter
      serial: qcom-geni: rename suspend functions

Longlong Xia (1):
      tty: n_gsm: Fix use-after-free in gsm_cleanup_mux

Marek Vasut (1):
      serial: imx: Update mctrl old_status on RTSD interrupt

 drivers/tty/n_gsm.c                   |   2 +
 drivers/tty/serial/imx.c              |  15 +++++
 drivers/tty/serial/qcom_geni_serial.c | 103 ++++++++++++++++------------------
 drivers/tty/vt/vt.c                   |   2 +-
 include/linux/soc/qcom/geni-se.h      |   2 +-
 5 files changed, 67 insertions(+), 57 deletions(-)

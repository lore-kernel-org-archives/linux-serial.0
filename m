Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E124291B;
	Sun, 14 Sep 2025 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850919; cv=none; b=rWrE6IH7aX+0jlrJ52fPOSJFfCSPOQ1lTwp7XXfEB9NhiprGqqX0BGGCmWL80XDd9bgns+laTXyZM9qZdtud18PDKrnqmRpD+OCGtK2qsH0WGOJaz8Sw+P/41IGkLdW85bO/UVOy6qSuKdumCLrNa0xD9uw1TQ9XJTjMU4R+iGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850919; c=relaxed/simple;
	bh=taIHnvxPpKsVVdKxNWQcAxD/Y7kDSuAL2dKrQGpl7+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VznLmUa7SXFoJFipd+YkE54LxxlsiFyovP0NPOl7/mbUhWGndKSNpFx/oYvcy7CoIgsYmOkriVQ/2vtw0QyPXmVriXkkbND0dPY+lzTn5lIAVDvotCq60lobldYBki6vuBYmzsLd6leBTTT86rwCwP005QTJvjok32Sd/TgAMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KUOH/N1O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KUOH/N1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D6AC4CEF0;
	Sun, 14 Sep 2025 11:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757850918;
	bh=taIHnvxPpKsVVdKxNWQcAxD/Y7kDSuAL2dKrQGpl7+g=;
	h=Date:From:To:Cc:Subject:From;
	b=KUOH/N1O2iZZrT5oOHL7+dQBHihuWYapSsqdxfTetDuxyhwrt/ki+4wsbNIHaphyA
	 g5xG4aI6Ye8n9W+YymvNpUy1Z1MV8MS8g3FAR9mNCoPsCk6cKKqsNxPh+egR4thG4g
	 Bj1O3ZgzkqKAqAeh52SzZVU+wfd8CmwOvhzUrjAU=
Date: Sun, 14 Sep 2025 13:55:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 6.17-rc6
Message-ID: <aMatIn1m6zRXmzC-@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.17-rc6

for you to fetch changes up to b5e3277c0f1c3439dd02b58997c06201d0ee8dbf:

  serial: xilinx_uartps: read reg size from DTS (2025-09-06 15:51:47 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 6.17-rc6

Here are some small tty and serial driver fixes for 6.17-rc6 that
resolve some reported problems.  Included in here are:
  - 8250 driver dt bindings fixes
  - broadcom serial driver binding fixes
  - hvc_console bugfix
  - xilinx serial driver bugfix
  - sc16is7xx serial driver bugfix

All of these have been in linux-next for the past week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alex Elder (2):
      dt-bindings: serial: 8250: move a constraint
      dt-bindings: serial: 8250: allow "main" and "uart" as clock names

Fabian Vogt (1):
      tty: hvc_console: Call hvc_kick in hvc_write unconditionally

Harshit Shah (1):
      serial: xilinx_uartps: read reg size from DTS

Hugo Villeneuve (1):
      serial: sc16is7xx: fix bug in flow control levels init

Krzysztof Kozlowski (1):
      dt-bindings: serial: brcm,bcm7271-uart: Constrain clocks

 Documentation/devicetree/bindings/serial/8250.yaml | 56 ++++++++++++----------
 .../bindings/serial/brcm,bcm7271-uart.yaml         |  2 +-
 drivers/tty/hvc/hvc_console.c                      |  6 +--
 drivers/tty/serial/sc16is7xx.c                     | 14 +-----
 drivers/tty/serial/xilinx_uartps.c                 | 10 ++--
 5 files changed, 42 insertions(+), 46 deletions(-)

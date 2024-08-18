Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B433CFC;
	Sun, 18 Aug 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723995544; cv=none; b=u6LYfbdUTqixrtLvw0mFNteTinXmgLWnPcAFV6MtWhoqfEZacxqA7IIzDPmuJcsAl4xHuj4TdCCHQa8pXKSwFYTgx4sA1q+bNNK5VBGviYfD2poV2JDaJbJA1Kub1gvum11WyDBcyKg7B960aPPK0/G9O0rsBk9T1Wq6sZyOXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723995544; c=relaxed/simple;
	bh=B0LVImnxgSRlqYvil3XLccM+KZP17A6/A4dNNrbsXLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gtfy49EeRVNf3dKT/m+uzTk8IQZd5OmJAiVmZkhNYQCd1GqXYxix1RjjfVQBAfc8+AZu/HyNHFPF1jnYypNjd5ZCev2ucOPExwBNt152CpP5OWIeZEiUqSoKpOFMZCwZOFifdBmeiYY0PU1uBgBIZM1zEebvy2hxJO/qvgI5A/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N8hxFEjj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N8hxFEjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E18C32786;
	Sun, 18 Aug 2024 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723995544;
	bh=B0LVImnxgSRlqYvil3XLccM+KZP17A6/A4dNNrbsXLA=;
	h=Date:From:To:Cc:Subject:From;
	b=N8hxFEjjyLYRqcIFfFWr/66c/jke8+tp1qhOmAGbrJWOPW+QPXD/aGekT8bLR9+QD
	 OTwUApu9vgQIdcrLLo9HMYZamM7/2hHj8MCTz+lZx0W9liHCupIMAOHhFHEu0gGQ4N
	 9n2+FlFbpiNmvea4rVTfRrCcRzPPXyv4Gv/dVetY=
Date: Sun, 18 Aug 2024 17:39:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 6.11-rc4
Message-ID: <ZsIVlRGstB9mxtQU@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7c626ce4bae1ac14f60076d00eafe71af30450ba:

  Linux 6.11-rc3 (2024-08-11 14:27:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.11-rc4

for you to fetch changes up to 0863bffda1131fd2fa9c05b653ad9ee3d8db127e:

  Revert "serial: 8250_omap: Set the console genpd always on if no console suspend" (2024-08-15 07:22:10 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 6.11-rc4

Here are some small tty and serial driver fixes for 6.11-rc4 to resolve
some reported problems.  Included in here are:
  - conmakehash.c userspace build issues
  - fsl_lpuart driver fix
  - 8250_omap revert for reported regression
  - atmel_serial rts flag fix

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Griffin Kroah-Hartman (1):
      Revert "serial: 8250_omap: Set the console genpd always on if no console suspend"

Masahiro Yamada (1):
      tty: vt: conmakehash: remove non-portable code printing comment header

Mathieu Othacehe (1):
      tty: atmel_serial: use the correct RTS flag.

Peng Fan (1):
      tty: serial: fsl_lpuart: mark last busy before uart_add_one_port

 drivers/tty/serial/8250/8250_omap.c | 33 +++++----------------------------
 drivers/tty/serial/atmel_serial.c   |  2 +-
 drivers/tty/serial/fsl_lpuart.c     |  1 +
 drivers/tty/vt/conmakehash.c        | 12 ++----------
 4 files changed, 9 insertions(+), 39 deletions(-)

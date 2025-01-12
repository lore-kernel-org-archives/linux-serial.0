Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923D21B423F;
	Sun, 12 Jan 2025 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736690733; cv=none; b=LkxC0ZNGmjImFitZ67XNVGyOlXLsBDnrfzHxoPZq6m7k6XTIVxRtSLprk208ul9cIiwCdYtW+JcktJVWQKlqivhCODVxeDi4F+rEUqfTkq8NP6co5IncJxXEQZCFMGZ6038CLkh/dKDTIA6qPLx/Czed6v/ppHa7ojcBKCjbYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736690733; c=relaxed/simple;
	bh=7+aImGvvqN0TfcMD0QWXw4lcY5YCyZxmFoH4mRSVCcE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i9FiX38rT8IIkyAhqeG1y74CSZQdwZxDTWoXb3rjDzHIzvATI3KAkuTjciqGFCRfVlyajsG7NqPfgC7h/CnAmHzyI06TcV/hv97ceueZQ/otTFL3zubuy90hQcSTJqCeGJ3Ff9WNTpmPtW1ykYQc9t+3VAemMq+xzELHnjnizzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SHyG5kQb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SHyG5kQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F78C4CEDF;
	Sun, 12 Jan 2025 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736690733;
	bh=7+aImGvvqN0TfcMD0QWXw4lcY5YCyZxmFoH4mRSVCcE=;
	h=Date:From:To:Cc:Subject:From;
	b=SHyG5kQbnUMZuCoepuck9+q6YgGSMHA1gADYMjX0UQLuJnmCpR2it5sTU2KObk9K5
	 ZuWfVRDUhTO7B7wnkngeJISjFh/24m6PYsQNZrv9Xt4NA5e9zAjqYCvG+QGCdc+mUk
	 DlqPcaH/tUgtUOYou/xkVk1N0o/0ccEK3W7kxhiQ=
Date: Sun, 12 Jan 2025 15:05:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] Serial driver fixes for 6.13-rc7
Message-ID: <Z4PMKaKtcsI_zmU4@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8:

  Linux 6.13-rc3 (2024-12-15 15:58:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc7

for you to fetch changes up to 0cfc36ea51684b5932cd3951ded523777d807af2:

  serial: stm32: use port lock wrappers for break control (2024-12-23 19:01:54 +0100)

----------------------------------------------------------------
Serial driver fixes for 6.13-rc7

Here are 3 small serial driver fixes tree.  They resolve some reported
issues:
  - stm32 break control fix
  - 8250 runtime pm usage counter fix
  - imx driver locking fix.

All have been in my tree and linux-next for 3 weeks now, with no
reported issues:

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ben Wolsieffer (1):
      serial: stm32: use port lock wrappers for break control

Ilpo Järvinen (1):
      tty: serial: 8250: Fix another runtime PM usage counter underflow

Xiaolei Wang (1):
      serial: imx: Use uart_port_lock_irq() instead of uart_port_lock()

 drivers/tty/serial/8250/8250_core.c | 3 +++
 drivers/tty/serial/imx.c            | 4 ++--
 drivers/tty/serial/stm32-usart.c    | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

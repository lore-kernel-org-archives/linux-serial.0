Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681F328B71;
	Sat,  8 Aug 2026 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786203151; cv=none; b=LS4I2DWRPxNsLV8hSt9wZBvLzfuZoQxRunz2gemDp+y/EzmZ80eP+7bswa8xgOmsrXDFLSB7n+PwR1At2BRsYHSZsIfkd4R3KT/QegmR3r6nOkLxRfanUhnNy3Bdd6nc+C/+bQIcx6T6JixqRAB15ZY1CSs6Rj5tQ97cBgcIzjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786203151; c=relaxed/simple;
	bh=bKgyoQXycvt5CyDplhMliDcdwTzlvhtgERdU5/iDXVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QvO+mpfGhj95r8ItpqoNYVV1iJUzoiSpV/b4OmOeZVYtDjEdKS2eGW0A7ZL3K/I3peUhIcWIMWKJCoJ//oDWO1YNWKBZpqSw9LxpfjDvtIqu+n0hPLnvBot+QiF7z4boxASEZm9BVgryuOWFitlAOvhIG4d7ZCyDiikkruA9XC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mrK51tlt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mrK51tlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82A41F000E9;
	Sat,  8 Aug 2026 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786203150;
	bh=b20gGPHORZgEjqGv4/1/krbhgeFCIjDGHZJaU85iWpg=;
	h=Date:From:To:Cc:Subject;
	b=mrK51tltmOleF3Fdl65asSWCqnovnog0XO+fESkXZGdZ2+hQQ3rgixdHTYCDzoyw8
	 QtFfEcAW5JIhoRXWw+nHUGxxYlaIOouapy36huSd1NNZm18iqevYzoUTwKAm+xETvA
	 JCPyndR517L34sktoQFIPIe6AgzFQ3VFrtQB7tRU=
Date: Sat, 8 Aug 2026 17:32:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 7.2-rc7
Message-ID: <andL-wLl02Hoj3BL@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc7

for you to fetch changes up to 440915499231e9db1c361aa45bb702e8fd3b4a32:

  serial: amba-pl011: synchronize DMA teardown (2026-08-03 16:31:22 +0200)

----------------------------------------------------------------
TTY / Serial / VT driver fixes for 7.2-rc7

Here are some small serial and vt tty driver fixes for 7.2-rc7 that
resolve some reported problems.  Included in here are:
  - 2 vt core fixes
  - amba-pl011 serial driver fixes
  - 8250_of and 8250_dma driver fixes
  - qcom-geni serial driver fix
  - sc16is7xx serial driver fix

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Cunhao Lu (1):
      serial: 8250_dma: Clear stale RX state on shutdown

Fan Wu (3):
      serial: amba-pl011: fix indefinite RS485 post-send delay
      serial: amba-pl011: cancel RS485 hrtimers after freeing IRQ
      serial: amba-pl011: synchronize DMA teardown

Jan Sebastian Götte (1):
      serial: qcom-geni: fix TX DMA buffer flush

Joshua Rogers (2):
      vt: stabilize tty reference in kbd_keycode with tty_port_tty_get
      vt: add permission check for KDSKBMETA ioctl

Luca Fresi (1):
      serial: sc16is7xx: enable THRI before filling TX FIFO

Ryan Wilbur (1):
      serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx

 drivers/tty/serial/8250/8250_dma.c    | 12 +++--
 drivers/tty/serial/8250/8250_of.c     | 38 ++++++++++++++++
 drivers/tty/serial/amba-pl011.c       | 86 ++++++++++++++++++++++-------------
 drivers/tty/serial/qcom_geni_serial.c | 43 +++++++++---------
 drivers/tty/serial/sc16is7xx.c        |  3 ++
 drivers/tty/vt/keyboard.c             |  5 +-
 drivers/tty/vt/vt_ioctl.c             |  2 +
 7 files changed, 130 insertions(+), 59 deletions(-)

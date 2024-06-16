Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EE186E46;
	Sun, 16 Jun 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718535114; cv=none; b=HK51flQNCHPC0hVvjzGRzNpeuALXyqShTrk7B+vDQBSkZaUJaue36sL8ox9XnLx/PiBSKCMNUzM74ho3bmMDJhBHPKLW9TQOggpzXtoT7CdRQh5N+M/DWP1XpZjBKPuvrxE8PQfEiddPpFeijwHpaXgjVM5jIUOETZQadOVMDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718535114; c=relaxed/simple;
	bh=ZQI+e2ZN+PjO5S7Hc3TDRORuGolamrnM3hVFAOAjbDM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qQ0fKMUFSfKMfdCA8+wwpvz6KUd+Vqr8342ow8NgH33bhO5w8N/+g4Mj6N/kqA9oHx+Fa8it0HSjVnQK73+Gf0ekJznpTlIeITtgRc4FaIK8hvrYHpAcmowBzk4e6KbGUXAgsKLVjGKhfEbVLc4dc/BE91fYFFa2+bG/4WxrNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uUgwqt+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uUgwqt+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC765C2BBFC;
	Sun, 16 Jun 2024 10:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718535114;
	bh=ZQI+e2ZN+PjO5S7Hc3TDRORuGolamrnM3hVFAOAjbDM=;
	h=Date:From:To:Cc:Subject:From;
	b=uUgwqt+GklmhhSNW8SY4xvypzuGELWI5HKv3Ai331IjpMheoFCIpeOzVx0JgVWCvE
	 dNFGe58ews1SmBRK0rNx6v2TWmSvYLsJEY/OTnbiKYF+4GtkV8lOuLhp6Ci5zYTSid
	 tBV+mNBayPKhch4R4Q4QAbs1P/EphgU4h7CZrzZc=
Date: Sun, 16 Jun 2024 12:51:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 6.10-rc4
Message-ID: <Zm7Dx7SLTxsUt1u6@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc4

for you to fetch changes up to ae01e52da244af5d650378ada1bfd2d946dc1b45:

  serial: drop debugging WARN_ON_ONCE() from uart_write() (2024-06-04 14:10:43 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.10-rc4

Here are some small tty and serial driver fixes that resolve som
reported problems.  Included in here are:
  - n_tty lookahead buffer bugfix
  - WARN_ON() removal where it was not needed
  - 8250_dw driver bugfixes
  - 8250_pxa bugfix
  - sc16is7xx Kconfig fixes for reported build issues

All of these have been in linux-next for over a week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      serial: 8250_dw: Don't use struct dw8250_data outside of 8250_dw
      serial: 8250_dw: Revert "Move definitions to the shared header"

Doug Brown (1):
      serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level

Douglas Anderson (1):
      serial: port: Don't block system suspend even if bytes are left to xmit

Hugo Villeneuve (2):
      serial: sc16is7xx: rename Kconfig CONFIG_SERIAL_SC16IS7XX_CORE
      serial: sc16is7xx: re-add Kconfig SPI or I2C dependency

Ilpo Järvinen (1):
      tty: n_tty: Fix buffer offsets when lookahead is used

Tetsuo Handa (1):
      serial: drop debugging WARN_ON_ONCE() from uart_write()

 drivers/tty/n_tty.c                  | 22 ++++++++++++++++------
 drivers/tty/serial/8250/8250_dw.c    | 36 ++++++++++++++++++++++++++++++++++--
 drivers/tty/serial/8250/8250_dwlib.c |  3 +--
 drivers/tty/serial/8250/8250_dwlib.h | 33 +--------------------------------
 drivers/tty/serial/8250/8250_pxa.c   |  1 +
 drivers/tty/serial/Kconfig           |  3 ++-
 drivers/tty/serial/Makefile          |  2 +-
 drivers/tty/serial/serial_core.c     |  2 +-
 drivers/tty/serial/serial_port.c     |  7 +++++++
 9 files changed, 64 insertions(+), 45 deletions(-)

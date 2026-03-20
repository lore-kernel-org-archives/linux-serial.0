Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC63D524E;
	Fri, 20 Mar 2026 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027606; cv=none; b=fo6uteyoObzEzrAnayZS1V30yrEzTTx1c9Vv9dMJLQStVtTsrcqrp3c+WDR606i5VZAd3jqWPNr5Fax6G1lGFw3kcgOOOg9PCCq3mMOhCEI9sK3qaoWaw+U0cfO3iLYY1cQcpTITiSKfaqCvbhrTgcSUKg++ZkNq/NJF1S9R3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027606; c=relaxed/simple;
	bh=vtArZyMpXGFFMqsxDlf7GOdiwTaxsJ1G66hOx9CZdHk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YLji7jaGpPVVO6aNb7e6zl9d0uKqltZ//+ZLgvPj7Wz0D7hWeDlOaRxarP/PIhKahiTXSZ/0ysv6WGPRi26aY3EvLz03n7tq6W7ozDEfsyXJBL7tjKYq645ri5B3TS4aTgG6SA8qC+7CsHN46MA5Q5hafQDtD0lqiSeD2CmS6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2F1XeJAn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2F1XeJAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD7EC19425;
	Fri, 20 Mar 2026 17:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774027606;
	bh=vtArZyMpXGFFMqsxDlf7GOdiwTaxsJ1G66hOx9CZdHk=;
	h=Date:From:To:Cc:Subject:From;
	b=2F1XeJAnWNQBtcogqWPKI3FUxtTxEBhE8+O7IGQkrWvBH0YrmdlUrW77K+aVfo/I0
	 V5FnaaJn5F5jhG7nGQc5h0BNw6z1aJYQjCbB+EmFwxh831tVV2CmhkJwWcdW4Fko7N
	 DDc6kcBBctqxIEO5CkOEAEcajDSg7N84A4u84bHw=
Date: Fri, 20 Mar 2026 18:26:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 7.0-rc5
Message-ID: <ab2DKnELM8LPfew8@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.0-rc5

for you to fetch changes up to 5eb608319bb56464674a71b4a66ea65c6c435d64:

  vt: save/restore unicode screen buffer for alternate screen (2026-03-13 09:15:58 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 7.0-rc5

Here are some small tty/vt and serial driver fixes for 7.0-rc5.
Included in here are:
  - 8250 driver fixes for reported problems
  - serial core lockup fix
  - uartlite driver bugfix
  - vt save/restore bugfix

All of these have been in linux-next for over a week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ilpo Järvinen (7):
      serial: 8250: Protect LCR write in shutdown
      serial: 8250_dw: Avoid unnecessary LCR writes
      serial: 8250: Add serial8250_handle_irq_locked()
      serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
      serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
      serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY
      serial: 8250_dw: Ensure BUSY is deasserted

Jiayuan Chen (1):
      serial: core: fix infinite loop in handle_tx() for PORT_UNKNOWN

Maciej Andrzejewski ICEYE (1):
      serial: uartlite: fix PM runtime usage count underflow on probe

Martin Roukala (né Peres) (1):
      serial: 8250_pci: add support for the AX99100

Nicolas Pitre (1):
      vt: save/restore unicode screen buffer for alternate screen

Peng Zhang (1):
      serial: 8250: always disable IRQ during THRE test

Raul E Rangel (1):
      serial: 8250: Fix TX deadlock when using DMA

 drivers/tty/serial/8250/8250.h      |  25 +++
 drivers/tty/serial/8250/8250_dma.c  |  15 ++
 drivers/tty/serial/8250/8250_dw.c   | 304 ++++++++++++++++++++++++++++--------
 drivers/tty/serial/8250/8250_pci.c  |  17 ++
 drivers/tty/serial/8250/8250_port.c |  75 +++++----
 drivers/tty/serial/serial_core.c    |   5 +-
 drivers/tty/serial/uartlite.c       |   1 +
 drivers/tty/vt/vt.c                 |   8 +
 include/linux/console_struct.h      |   1 +
 include/linux/serial_8250.h         |   1 +
 10 files changed, 356 insertions(+), 96 deletions(-)

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4C7C4320E
	for <linux-serial@archiver.kernel.org>; Sun,  8 Aug 2021 11:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF5660F9E
	for <linux-serial@archiver.kernel.org>; Sun,  8 Aug 2021 11:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhHHLb0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 8 Aug 2021 07:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230420AbhHHLbZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Aug 2021 07:31:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C3816101D;
        Sun,  8 Aug 2021 11:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628422267;
        bh=cQR9HjELS5wfqjRmJ6RrRMXOCCvZAs4SRF+f6Wp2mbs=;
        h=Date:From:To:Cc:Subject:From;
        b=yhvoNhcaPEmU/LPg9keHrZIAsz8IVOqM8MNYDBMYyuF/EyyTyyWeLUecTWvvoSHwp
         Thtusv7zMDFjK7GHUyLZBaR5AQOebPK8nyL9ibXgAQ9bFU6aBO4m5z0covl8lDMent
         ampsx/A6UxORIDLmUEkZPWaIh+TrLs9gg/pRb1+w=
Date:   Sun, 8 Aug 2021 13:31:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.14-rc5
Message-ID: <YQ/AeMGGzEwsxJkh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.14-rc5

for you to fetch changes up to 341abd693d10e5f337a51f140ae3e7a1ae0febf6:

  serial: 8250_pci: Avoid irq sharing for MSI(-X) interrupts. (2021-07-30 13:06:19 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 5.14-rc5

Here are some small tty/serial driver fixes for 5.14-rc5 to resolve a
number of reported problems.

They include:
	- mips serial driver fixes
	- 8250 driver fixes for reported problems
	- fsl_lpuart driver fixes
	- other tiny driver fixes

All have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      serial: max310x: Unprepare and disable clock in error path
      serial: 8250_pci: Enumerate Elkhart Lake UARTs via dedicated driver

Johan Hovold (1):
      serial: 8250: fix handle_irq locking

Jon Hunter (1):
      serial: tegra: Only print FIFO error message when an error occurs

Maciej W. Rozycki (2):
      serial: 8250: Mask out floating 16/32-bit bus bits
      MIPS: Malta: Do not byte-swap accesses to the CBUS UART

Mario Kleiner (1):
      serial: 8250_pci: Avoid irq sharing for MSI(-X) interrupts.

Sherry Sun (1):
      tty: serial: fsl_lpuart: fix the wrong return value in lpuart32_get_mctrl

Zhiyong Tao (1):
      serial: 8250_mtk: fix uart corruption issue when rx power off

 arch/mips/mti-malta/malta-platform.c        |  3 ++-
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  5 +++--
 drivers/tty/serial/8250/8250_fsl.c          |  5 +++--
 drivers/tty/serial/8250/8250_mtk.c          |  5 +++++
 drivers/tty/serial/8250/8250_pci.c          |  7 +++++++
 drivers/tty/serial/8250/8250_port.c         | 17 ++++++++++++-----
 drivers/tty/serial/fsl_lpuart.c             |  2 +-
 drivers/tty/serial/max310x.c                |  3 ++-
 drivers/tty/serial/serial-tegra.c           |  6 ++++--
 include/linux/serial_core.h                 | 24 ++++++++++++++++++++++++
 10 files changed, 63 insertions(+), 14 deletions(-)

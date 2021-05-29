Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727C3C4708E
	for <linux-serial@archiver.kernel.org>; Sat, 29 May 2021 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4778A6105A
	for <linux-serial@archiver.kernel.org>; Sat, 29 May 2021 14:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhE2O23 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 May 2021 10:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhE2O23 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 May 2021 10:28:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BC3F610CB;
        Sat, 29 May 2021 14:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622298413;
        bh=LSmQ2LDJn8ITh7Jv+KxyGNejWDI4h0ZJP+HULqoon2Y=;
        h=Date:From:To:Cc:Subject:From;
        b=avz1N1Cr94dBzNn0b4gaFlStzU5TWL2aySVbQTAPJaWa+7bHjV695KRJ2KDvwL3wt
         ALqVULs//+OHYPl9rmRJ58uVtuqesS8ugiu9HevOM/Y0v4/cmOUxLjPnm8Sjf6BNXL
         uk8rVMLFChN4tLZeTSf93vz0aHxC+go9IoWmLhAY=
Date:   Sat, 29 May 2021 16:26:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.13-rc4
Message-ID: <YLJPKme41JEplEPQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.13-rc4

for you to fetch changes up to 56dde68f85be0a20935bb4ed996db7a7f68b3202:

  Revert "serial: 8250: 8250_omap: Fix possible interrupt storm" (2021-05-28 10:58:49 +0200)

----------------------------------------------------------------
TTY / Serial driver fixes for 5.13-rc4

Here are some small fixes for reported problems for tty and serial
drivers for 5.13-rc4.

They consist of:
	- 8250 bugfixes and new device support
	- lockdown security mode fixup
	- syzbot found problems fixed
	- 8250_omap fix for interrupt storm
	- revert of 8250_omap driver fix as it caused worse problem than
	  the original issue

All but the last patch have been in linux-next for a while, the last one
is a revert of a problem found in linux-next with the 8250_omap driver
change.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrew Jeffery (2):
      serial: 8250: Add UART_BUG_TXRACE workaround for Aspeed VUART
      serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*

Christian Gmeiner (1):
      serial: 8250_pci: handle FL_NOIRQ board flag

Colin Ian King (1):
      serial: tegra: Fix a mask operation that is always true

Geert Uytterhoeven (1):
      serial: sh-sci: Fix off-by-one error in FIFO threshold register setting

Greg Kroah-Hartman (1):
      Revert "serial: 8250: 8250_omap: Fix possible interrupt storm"

Maximilian Luz (1):
      serial: 8250_dw: Add device HID for new AMD UART controller

Ondrej Mosnacek (1):
      serial: core: fix suspicious security_locked_down() call

Randy Wright (1):
      serial: 8250_pci: Add support for new HPE serial device

Vignesh Raghavendra (1):
      serial: 8250: 8250_omap: Fix possible interrupt storm

Zheyu Ma (1):
      serial: rp2: use 'request_firmware' instead of 'request_firmware_nowait'

 drivers/acpi/acpi_apd.c                     |  1 +
 drivers/tty/serial/8250/8250.h              | 32 +++++++++---------
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  1 +
 drivers/tty/serial/8250/8250_dw.c           |  1 +
 drivers/tty/serial/8250/8250_pci.c          | 47 +++++++++++++++++++-------
 drivers/tty/serial/8250/8250_port.c         | 12 +++++++
 drivers/tty/serial/rp2.c                    | 52 ++++++++++-------------------
 drivers/tty/serial/serial-tegra.c           |  2 +-
 drivers/tty/serial/serial_core.c            |  8 +++--
 drivers/tty/serial/sh-sci.c                 |  4 +--
 10 files changed, 92 insertions(+), 68 deletions(-)

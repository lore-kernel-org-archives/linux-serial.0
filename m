Return-Path: <SRS0=iYMu=4J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DCBC35646
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 11:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F57222C4
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582285178;
	bh=hc4FcMAeggFoJpya7620WWcfqhK4nw50PW75yzMLpWs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tgHZ04rQFVypCAeYhuiWv+f9evqQ3yZiNoA3GcAorsZVHcBidkGHRV/8EdJUt0TyE
	 P3h53GTx12AzuHJ30zQ/q9XH9xAADoOX5Gq13HqJ3czopyfgxZ+doJTHyQv6yM8GGT
	 PScgIgrilCzeLoxvgDfPmovOiP/9cjVmi/LYsvcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBULjd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgBULjc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Feb 2020 06:39:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7222A222C4;
        Fri, 21 Feb 2020 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285171;
        bh=hc4FcMAeggFoJpya7620WWcfqhK4nw50PW75yzMLpWs=;
        h=Date:From:To:Cc:Subject:From;
        b=RxG76NC8uFFNLT3hg3DluvZFYN3dthMsgJYF8jhJkmSdPRw6DNsCrxLh2YhUP/2JV
         9POMBO16/e85Su7UYcEhFS9sh1Q3svocxxf4vdcP6quqPek4UmoH8CGXnzBToXF23l
         JU4X7EwUOf5uZ6eBLIeX9dMnKLS+6VMgC+89cQoE=
Date:   Fri, 21 Feb 2020 12:39:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.6-rc3
Message-ID: <20200221113929.GA114227@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc3

for you to fetch changes up to 07e6124a1a46b4b5a9b3cacc0c306b50da87abf5:

  vt: selection, close sel_buffer race (2020-02-13 12:10:07 -0800)

----------------------------------------------------------------
TTY/Serial driver fixes for 5.6-rc3

Here are a number of small tty and serial driver fixes for 5.6-rc3 that
resolve a bunch of reported issues.

They are:
  - vt selection and ioctl fixes
  - serdev bugfix
  - atmel serial driver fixes
  - qcom serial driver fixes
  - other minor serial driver fixes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: 8250: Check UPF_IRQ_SHARED in advance

Daniel Golle (1):
      serial: ar933x_uart: set UART_CS_{RX,TX}_READY_ORIDE

Dmitry Osipenko (1):
      tty: serial: tegra: Handle RX transfer in PIO mode if DMA wasn't started

Eric Dumazet (1):
      vt: vt_ioctl: fix race in VT_RESIZEX

Fugang Duan (1):
      tty: serial: imx: setup the correct sg entry for tx dma

Jiri Slaby (2):
      vt: selection, handle pending signals in paste_selection
      vt: selection, close sel_buffer race

Johan Hovold (1):
      serdev: ttyport: restore client ops on deregistration

Nicolas Ferre (1):
      tty/serial: atmel: manage shutdown in case of RS485 or ISO7816 mode

Nicolas Pitre (1):
      vt: fix scrollback flushing on background consoles

Rasmus Villemoes (1):
      serial: cpm_uart: call cpm_muram_init before registering console

satya priya (1):
      tty: serial: qcom_geni_serial: Fix RX cancel command failure

 drivers/tty/serdev/serdev-ttyport.c         |  6 ++---
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  1 -
 drivers/tty/serial/8250/8250_core.c         |  5 ++---
 drivers/tty/serial/8250/8250_of.c           |  1 -
 drivers/tty/serial/8250/8250_port.c         |  4 ++++
 drivers/tty/serial/ar933x_uart.c            |  8 +++++++
 drivers/tty/serial/atmel_serial.c           |  3 ++-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  1 +
 drivers/tty/serial/imx.c                    |  2 +-
 drivers/tty/serial/qcom_geni_serial.c       | 18 +++++++++++----
 drivers/tty/serial/serial-tegra.c           | 35 +++++++++++++----------------
 drivers/tty/tty_port.c                      |  5 +++--
 drivers/tty/vt/selection.c                  | 32 ++++++++++++++++++++------
 drivers/tty/vt/vt.c                         | 15 +++++++++++--
 drivers/tty/vt/vt_ioctl.c                   | 17 +++++++++-----
 include/linux/tty.h                         |  2 ++
 16 files changed, 104 insertions(+), 51 deletions(-)

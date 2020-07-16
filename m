Return-Path: <SRS0=PhEQ=A3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A7C433E5
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jul 2020 15:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6B72076A
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jul 2020 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594913365;
	bh=FzucnMldDqmK+Cy2gUOBiRptVK7gB8amQqI3OD5XAPY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=oTMW0bakEj8jwucQIj2GH3IBCXv6YadDz5KoR5bjBb/9ehvoLSg4pxDFLlwSIE9QW
	 UryiRa05emPW4uf78VNTUNg6osehZk+XpohHlEQfFEqarNYksiEWg6rd4G35C10Lam
	 YIvK9vmPvX1UM9vAUCr7lc/0YNm+mouUoH+7n2Go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgGPP3Z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgGPP3Z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jul 2020 11:29:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551AE2065F;
        Thu, 16 Jul 2020 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594913364;
        bh=FzucnMldDqmK+Cy2gUOBiRptVK7gB8amQqI3OD5XAPY=;
        h=Date:From:To:Cc:Subject:From;
        b=Ne3w8Bmm3s7y+REZ9uQP1EUd88b8tVS50zb2XpAk1MkNm/nhJ0PexdK+nNuYeMgf1
         au3JsLCZ1R9GvlGJMiWz6FsCzs3NGsS23NVxZRd+NeMYkjVFcAEiX6WnqGiwCTV2XF
         x1IkjLGTH0O4wWLKWchuk2Xmb3Pfvrhmq0pMAz3w=
Date:   Thu, 16 Jul 2020 17:29:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.8-rc6
Message-ID: <20200716152917.GA2378726@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.8-rc6

for you to fetch changes up to f743061a85f5e9989df22ccbf07c80c98fc90e08:

  serial: core: Initialise spin lock before use in uart_configure_port() (2020-07-10 14:44:46 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 5.8-rc6

Here are some small tty and serial driver fixes for 5.8-rc6.

The largest set of patches in here is a revert of the sysrq changes that
went into 5.8-rc1 but turned out to cause a noticable overhead and cpu
usage.

Other than that, there's a few small serial driver fixes to resolve
reported issues, and finally resolving the spinlock init problem on many
serial driver consoles.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: core: Initialise spin lock before use in uart_configure_port()

Christophe Leroy (1):
      tty: serial: cpm_uart: Fix behaviour for non existing GPIOs

Chuhong Yuan (1):
      serial: mxs-auart: add missed iounmap() in probe failure and remove

Jan Kiszka (1):
      Revert "tty: xilinx_uartps: Fix missing id assignment to the console"

Johan Hovold (3):
      Revert "serial: core: Refactor uart_unlock_and_check_sysrq()"
      serial: core: fix sysrq overhead regression
      serial: core: drop redundant sysrq checks

Lad Prabhakar (1):
      serial: sh-sci: Initialize spinlock for uart console

Randy Dunlap (1):
      tty/serial: fix serial_core.c kernel-doc warnings

 drivers/tty/serial/cpm_uart/cpm_uart_core.c |   9 ++-
 drivers/tty/serial/mxs-auart.c              |  12 ++-
 drivers/tty/serial/serial_core.c            | 115 ++++------------------------
 drivers/tty/serial/sh-sci.c                 |   3 +
 drivers/tty/serial/xilinx_uartps.c          |   1 -
 include/linux/serial_core.h                 | 102 +++++++++++++++++++++++-
 6 files changed, 134 insertions(+), 108 deletions(-)

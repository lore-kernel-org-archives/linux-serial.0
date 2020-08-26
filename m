Return-Path: <SRS0=CfSU=CE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FEAC433DF
	for <linux-serial@archiver.kernel.org>; Wed, 26 Aug 2020 13:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B2121741
	for <linux-serial@archiver.kernel.org>; Wed, 26 Aug 2020 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598449426;
	bh=bp5RdPShh4m+p+wKH0LbTr4nyPsyLIDHModZ1ACSoEQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=lSHN4VGb4mgkaxC2aD+J07CU97bJ2iqQgxZSYwd4POVSMcl/KMUpf/qNpwlhvxOXV
	 Xt5SSCVTXdJ4zgzGJ4/8fiEGOENy7SJyWMIChmTV8Y63r1VX+Id5dvMnEKds0oiKjT
	 okErctEFfyP8Ul4zNXyfMG4nGKm3PXItfxaJwwB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgHZNnk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730140AbgHZNnO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Aug 2020 09:43:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 062A7208E4;
        Wed, 26 Aug 2020 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598449362;
        bh=bp5RdPShh4m+p+wKH0LbTr4nyPsyLIDHModZ1ACSoEQ=;
        h=Date:From:To:Cc:Subject:From;
        b=rqjb1gR1SvucF/OIj7B+TfPHgx+kY7CJx7Wyb6vpn5lukSMPhIfy93fYkDEgZHmnq
         yRm4gmaewM6OrI8ooIG19Rcd9ZDRSE6hH4ZsCIXOJug6aINP/gOQ2dl1BwcAOhtovw
         BAxKNuMrXL5aZfpUZd8KXA/3A+93XpvCND6K+mlQ=
Date:   Wed, 26 Aug 2020 15:42:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.9-rc3
Message-ID: <20200826134257.GA3882407@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.9-rc3

for you to fetch changes up to ea1fc02e12b647d8dd7515d1dba137847d8e951d:

  tty: serial: imx: add dependence and build for earlycon (2020-08-18 13:54:34 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 5.9-rc3

Here are a few small TTY/Serial/vt fixes for 5.9-rc3

Included in here are:
	- qcom serial fixes
	- vt ioctl and core bugfixes
	- pl011 serial driver fixes
	- 8250 serial driver fixes
	- other misc serial driver fixes

and for good measure:
	- fbcon fix for syzbot found problem.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Douglas Anderson (1):
      serial: qcom_geni_serial: Fix recent kdb hang

Fugang Duan (1):
      tty: serial: imx: add dependence and build for earlycon

George Kennedy (2):
      fbcon: prevent user font height or width change from causing potential out-of-bounds access
      vt_ioctl: change VT_RESIZEX ioctl to check for error return from vc_resize()

Holger Assmann (1):
      serial: stm32: avoid kernel warning on absence of optional IRQ

John Stultz (1):
      tty: serial: qcom_geni_serial: Drop __init from qcom_geni_console_setup

Lukas Wunner (2):
      serial: pl011: Don't leak amba_ports entry on driver register error
      serial: pl011: Fix oops on -EPROBE_DEFER

Sergey Senozhatsky (1):
      serial: 8250: change lock order in serial8250_do_startup()

Tamseel Shams (1):
      serial: samsung: Removes the IRQ not found warning

Tetsuo Handa (1):
      vt: defer kfree() of vc_screenbuf in vc_do_resize()

Valmer Huhn (1):
      serial: 8250_exar: Fix number of ports for Commtech PCIe cards

 drivers/tty/serial/8250/8250_exar.c   | 24 +++++++++++++++++++++---
 drivers/tty/serial/8250/8250_port.c   |  9 ++++++---
 drivers/tty/serial/Kconfig            |  1 +
 drivers/tty/serial/Makefile           |  1 +
 drivers/tty/serial/amba-pl011.c       | 16 +++++++++-------
 drivers/tty/serial/qcom_geni_serial.c | 11 ++++++++---
 drivers/tty/serial/samsung_tty.c      |  8 +++++---
 drivers/tty/serial/stm32-usart.c      |  2 +-
 drivers/tty/vt/vt.c                   |  5 +++--
 drivers/tty/vt/vt_ioctl.c             | 12 +++++++++++-
 drivers/video/fbdev/core/fbcon.c      | 25 +++++++++++++++++++++++--
 11 files changed, 89 insertions(+), 25 deletions(-)

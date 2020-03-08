Return-Path: <SRS0=hEVs=4Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94534C10DCE
	for <linux-serial@archiver.kernel.org>; Sun,  8 Mar 2020 09:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A09B20838
	for <linux-serial@archiver.kernel.org>; Sun,  8 Mar 2020 09:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583661143;
	bh=aClfJhRVUpo3PCuXqoqwX30Iyd3D3/80J4zgP7p2bRQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=b/qg0BsqBJ2Pcptkn/83HD4K4ORR8BbKejUx/LqzUqJMugS3uXGt6XyStF6FRNTPB
	 VgcntJah7InbzwGaUDoc8f+i1pNQmcVjoj+XfCYn2jURrmSKwj6oJJ4jnetDovzI2Q
	 GtM4kQ/OjXgkbgTqul74tpR2jAufffLVI7EUKt2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgCHJwX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 8 Mar 2020 05:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgCHJwW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Mar 2020 05:52:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2608B20828;
        Sun,  8 Mar 2020 09:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583661141;
        bh=aClfJhRVUpo3PCuXqoqwX30Iyd3D3/80J4zgP7p2bRQ=;
        h=Date:From:To:Cc:Subject:From;
        b=AxPYUc5oWmiAeIxFcvKQOpf3UKx/Y9pvGjsEFi32u1/xRJeretZkEKBPxLJ4G9uLb
         lsK3yEpSfiL8UlSURxWXX3a32XnwTO+7dqNPqTMd2HoTVcFRsWZFd8/hedHbimnKox
         6CnTzKN9VjvYDfn81wx1M5RM5JXLa8U5WZHGwoYk=
Date:   Sun, 8 Mar 2020 10:52:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.6-rc5
Message-ID: <20200308095219.GA4026988@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc5

for you to fetch changes up to 2b2e71fe657510a6f71aa16ef0309fa6bc20ab3d:

  tty: serial: fsl_lpuart: free IDs allocated by IDA (2020-03-06 14:10:44 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.6-rc5

Here are some small tty/serial fixes for 5.6-rc5

Just some small serial driver fixes, and a vt core fixup, full details
are:
	- vt fixes for issues found by syzbot
	- serdev fix for Apple boxes
	- fsl_lpuart serial driver fixes
	- MAINTAINER update for incorrect serial files
	- new device ids for 8250_exar driver
	- mvebu-uart fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      MAINTAINERS: Add missed files related to Synopsys DesignWare UART

Jay Dolan (1):
      serial: 8250_exar: add support for ACCES cards

Jiri Slaby (2):
      vt: selection, push console lock down
      vt: selection, push sel_lock up

Michael Walle (2):
      Revert "tty: serial: fsl_lpuart: drop EARLYCON_DECLARE"
      tty: serial: fsl_lpuart: free IDs allocated by IDA

Ronald Tschalär (1):
      serdev: Fix detection of UART devices on Apple machines.

tangbin (1):
      tty:serial:mvebu-uart:fix a wrong return

 MAINTAINERS                         |  2 ++
 drivers/staging/speakup/selection.c |  2 --
 drivers/tty/serdev/core.c           | 10 +++++++++
 drivers/tty/serial/8250/8250_exar.c | 33 +++++++++++++++++++++++++++++
 drivers/tty/serial/fsl_lpuart.c     | 41 +++++++++++++++++++++++--------------
 drivers/tty/serial/mvebu-uart.c     |  2 +-
 drivers/tty/vt/selection.c          | 27 ++++++++++++++++--------
 drivers/tty/vt/vt.c                 |  2 --
 8 files changed, 90 insertions(+), 29 deletions(-)

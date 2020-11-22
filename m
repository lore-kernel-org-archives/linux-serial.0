Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBABC5519F
	for <linux-serial@archiver.kernel.org>; Sun, 22 Nov 2020 11:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CD520936
	for <linux-serial@archiver.kernel.org>; Sun, 22 Nov 2020 11:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dvjaQypO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgKVLmN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 22 Nov 2020 06:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgKVLmN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 22 Nov 2020 06:42:13 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55222208C3;
        Sun, 22 Nov 2020 11:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606045332;
        bh=BTIX4SRmJ9K3trvbwYZSzLzT5ufZbMHeP9ieJTfVPDw=;
        h=Date:From:To:Cc:Subject:From;
        b=dvjaQypOyvnNE5CSV4GqtF6qR51aq6dCu/mSaM3bUpEJVgDoanaKoB7UHhgtfHTXN
         ZFypWwYMIgt4+uAMu9aWfLTcDu1hZP+lrPxEFtjLaMvhWglOiYl5uB60sy4K7iOmWV
         HRpQqqFKrgrp2ag18a6MvICdS+aKter7Y5WZixPo=
Date:   Sun, 22 Nov 2020 12:42:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.10-rc5
Message-ID: <X7pOurJAAFWxYMG/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc5

for you to fetch changes up to 425af483523b76bc78e14674a430579d38b2a593:

  serial: ar933x_uart: disable clk on error handling path in probe (2020-11-12 09:41:07 +0100)

----------------------------------------------------------------
TTY fixes for 5.10-rc5

Here are some small tty/serial fixes for 5.10-rc5 that resolve some
reported issues:
	- speakup crash when telling the kernel to use a device that
	  isn't really there
	- imx serial driver fixes for reported problems
	- ar933x_uart driver fix for probe error handling path

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Fugang Duan (1):
      tty: serial: imx: keep console clocks always on

Sam Nobs (1):
      tty: serial: imx: fix potential deadlock

Samuel Thibault (1):
      speakup: Do not let the line discipline be used several times

Zheng Zengkai (1):
      serial: ar933x_uart: disable clk on error handling path in probe

 drivers/accessibility/speakup/spk_ttyio.c | 12 +++++++++++-
 drivers/tty/serial/ar933x_uart.c          |  6 ++++--
 drivers/tty/serial/imx.c                  | 30 +++++++++++-------------------
 3 files changed, 26 insertions(+), 22 deletions(-)

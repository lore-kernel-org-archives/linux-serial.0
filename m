Return-Path: <SRS0=Pw1G=6W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5884C38A2A
	for <linux-serial@archiver.kernel.org>; Fri,  8 May 2020 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88EF24957
	for <linux-serial@archiver.kernel.org>; Fri,  8 May 2020 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588947461;
	bh=z6fbe8w+RwxkvSNeRN3EkkyZIHuGcL9vC9zLiGL4ddw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=AHyg7IfYJssAP8YvHGUL6dH01sBtn4wMCxtD1H/9nbysJ6sz29LDstb0YdqayYdmy
	 AR7T0l6qepNN0NyvcbR5RFpkzwmdqFSN9VyT4nYGA8vy+u+XEMxonhPH/Eox0rr1ur
	 FHxFpIUjb/YKy0TIIXry+bheWplaG5i8zgFSn/t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgEHORl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 May 2020 10:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHORl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 May 2020 10:17:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E64A24956;
        Fri,  8 May 2020 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588947459;
        bh=z6fbe8w+RwxkvSNeRN3EkkyZIHuGcL9vC9zLiGL4ddw=;
        h=Date:From:To:Cc:Subject:From;
        b=qVDInJXMDflY8epY1cXlVGKuYL+LtnsdV9zKPwKBkinGJxJcs+e6c0LuR/q8VVNXk
         So4NJq/mKIbjfqVOj2o6SR/vhUAAD2FxEP1lzjRRQIQYn1s8gGGyoWIcCKHeJz61QP
         gVeeZ5wCypVLLNi/PYF410v8jXDkMfhrYCBBQtK8=
Date:   Fri, 8 May 2020 16:17:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.7-rc5
Message-ID: <20200508141737.GA350607@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc5

for you to fetch changes up to 2ae11c46d5fdc46cb396e35911c713d271056d35:

  tty: xilinx_uartps: Fix missing id assignment to the console (2020-05-04 18:55:45 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 5.7-rc5

Here are 3 small TTY/Serial/VT fixes for 5.7-rc5:
	- revert for the bcm63xx driver "fix" that was incorrect
	- vt unicode console bugfix
	- xilinx_uartps console driver fix

All of these have been in linux next with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Florian Fainelli (1):
      Revert "tty: serial: bcm63xx: fix missing clk_put() in bcm63xx_uart"

Nicolas Pitre (1):
      vt: fix unicode console freeing with a common interface

Shubhrajyoti Datta (1):
      tty: xilinx_uartps: Fix missing id assignment to the console

 drivers/tty/serial/bcm63xx_uart.c  | 4 +---
 drivers/tty/serial/xilinx_uartps.c | 1 +
 drivers/tty/vt/vt.c                | 9 +++++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

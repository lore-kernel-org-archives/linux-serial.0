Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42A1C282DD
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 21:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CC520838
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578690518;
	bh=7k/3WJi+NYzL/NKLuCvvykW0NIV1US+apZoWCLsOrVk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=T6qNa6wFwDm1TF95Y5A2MhFlgOZnsXA21eHfwiW/Q2CCdRY9R+0bv4N8cFZMdUaza
	 ZLKU6HQpCXTd+5vLoiHiqaSHgfysbTl/ggXUxq6Tz0azx+AdSjfGhJr71xdELFQMxy
	 shMIY60D5t7jXr5c7ikN/PHfhf7mX2xIjFpEB49Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgAJVIi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:08:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgAJVIh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 16:08:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3B9C205F4;
        Fri, 10 Jan 2020 21:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578690517;
        bh=7k/3WJi+NYzL/NKLuCvvykW0NIV1US+apZoWCLsOrVk=;
        h=Date:From:To:Cc:Subject:From;
        b=OOHUodEHEzp9BAGomUZgt3So4I0FWHJhHYYFBaZdz+40MoqlfiCPt5RdAHWDPd+Du
         PqjEGb6hwz27qzccdy7HyX8NGoX5k/W7J4DBXByiUdps361EaWgCkuzDv3uZKl3JiX
         yB0wxKBFW47hpSnzjT+j2nzhrNy9mp622Pmfb/zs=
Date:   Fri, 10 Jan 2020 22:08:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.5-rc6
Message-ID: <20200110210835.GA1871048@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc6

for you to fetch changes up to c5ee0b3104e0b292d353e63fd31cb8c692645d8c:

  serdev: Don't claim unsupported ACPI serial devices (2020-01-06 20:00:44 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.5-rc6

Here are two tty/serial driver fixes for 5.5-rc6.

The first fixes a much much reported issue with a previous tty port link
patch that is in your tree, and the second fixes a problem where the
serdev driver would claim ACPI devices that it shouldn't be claiming.

Both have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Punit Agrawal (1):
      serdev: Don't claim unsupported ACPI serial devices

Sudip Mukherjee (1):
      tty: always relink the port

 drivers/tty/serdev/core.c | 10 ++++++++++
 drivers/tty/tty_port.c    |  3 +--
 2 files changed, 11 insertions(+), 2 deletions(-)

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D30C48BE5
	for <linux-serial@archiver.kernel.org>; Sat, 12 Jun 2021 15:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445E361376
	for <linux-serial@archiver.kernel.org>; Sat, 12 Jun 2021 15:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhFLP5H (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 12 Jun 2021 11:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231358AbhFLP5H (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 12 Jun 2021 11:57:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D63B3610FC;
        Sat, 12 Jun 2021 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623513295;
        bh=EDNW8qcQ6bxhsUUgeTf9VlCr0Q/8pLhBmFNUlwYgfuk=;
        h=Date:From:To:Cc:Subject:From;
        b=u4NbBkFdja5kodz5RNxbK89yu42OrBd5/J+quHqqNI4MjSQh4byaLHXW6HhpI2XFd
         ms6rYhkJ66q+2Oj/7nzrNeRvDNfSuxHYwbTv9rfbBo30nNYmanLd32td+UN71QlD67
         nNnjuSrDRQtuxzvG63cKfbLR/LWri1zlA4m7LWxQ=
Date:   Sat, 12 Jun 2021 17:54:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fix for 5.13-rc6
Message-ID: <YMTYzUp9cv+e4U6R@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.13-rc6

for you to fetch changes up to 7c3e8d9df265bd0bdf6e328174cdfba26eb22f1c:

  serial: 8250_exar: Avoid NULL pointer dereference at ->exit() (2021-06-09 14:40:48 +0200)

----------------------------------------------------------------
Serial driver fix for 5.13-rc6

Here is a single 8250_exar serial driver fix for a reported problem with
a change that happened in 5.13-rc1.

It has been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: 8250_exar: Avoid NULL pointer dereference at ->exit()

 drivers/tty/serial/8250/8250_exar.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

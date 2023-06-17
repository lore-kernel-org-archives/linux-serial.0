Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9105EB64D9
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jun 2023 13:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjFQNpm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Jun 2023 09:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjFQNpl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Jun 2023 09:45:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5502BB5;
        Sat, 17 Jun 2023 06:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E477F60FDB;
        Sat, 17 Jun 2023 13:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C73C433C8;
        Sat, 17 Jun 2023 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687009539;
        bh=515kJg1FdqpFjdn3gg9aegqgzVmsa2/mpFPUsH5OFE8=;
        h=Date:From:To:Cc:Subject:From;
        b=H9zP4ey3sL1fFWePRj1bNUf9IZGtBIxllt1agkJXkUiG0WUM0eAKKvtz2R1JryiwA
         v1VjyB8HkLz4eDd9Hny1hE2lfTtLX4HAZhzVDBbpWhHJPZnuY93M8tmM/bBjXa0Alf
         /uaoB46kINBF9e/YnquPTSMV7iI5pa+lBsWQyH5U=
Date:   Sat, 17 Jun 2023 15:45:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.4-rc7
Message-ID: <ZI25AEWr36a7coy5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc7

for you to fetch changes up to a82c3df955f8c1c726e4976527aa6ae924a67dd9:

  tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A (2023-06-13 12:31:45 +0200)

----------------------------------------------------------------
Serial driver fixes for 6.4-rc7

Here are two small serial driver fixes for 6.4-rc7 that resolve some
reported problems:
 - lantiq serial driver irq fix
 - fsl_lpuart serial driver watermark fix

Both of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bernhard Seibold (1):
      serial: lantiq: add missing interrupt ack

Robert Hodaszi (1):
      tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A

 drivers/tty/serial/fsl_lpuart.c | 2 +-
 drivers/tty/serial/lantiq.c     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

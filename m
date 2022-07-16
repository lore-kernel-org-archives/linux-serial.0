Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86717C43334
	for <linux-serial@archiver.kernel.org>; Sat, 16 Jul 2022 18:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiGPS0R (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 16 Jul 2022 14:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiGPS0Q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 16 Jul 2022 14:26:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ABF192AF;
        Sat, 16 Jul 2022 11:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BED7AB80C94;
        Sat, 16 Jul 2022 18:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 726C5C34114;
        Sat, 16 Jul 2022 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657995973;
        bh=vEIPtwSra6H2rxOkPVfL4UFO+7o+280dJ4Dh4bnd2RA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FBHImOLH5lDByXd8vcRYXd6+DGR2L0N+HJcDFWMW0oRAlHaNA9oOoN/f6Yo0h89Id
         c9LMJ0DmSH6n7JfZR1/oreL2xCnWjn0x1LMYnvEof0e98C8JVVZicmC00jfBU+wg0h
         66HTRGBWBdEnAzmFt9hpfkX1ASYQRk5h31ZRcYxkA/Cu2i8Pa4iv0RFoRckPfv8jfB
         /7OolKFOYWZkzoFlHkJxItI8svOqcUwXA5HrkSsfRi1npRR/y9ojQl7tXZfejrGotn
         ABJbEO6NYD0KuDj9zrM7OFzTK90XgQEL1u82ZLt5S05qhFQMJ5y/MREpNIR3sFPhNZ
         W4pL3CkpX3IgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F47CE45227;
        Sat, 16 Jul 2022 18:26:13 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YtJZegRfm6IsdY/i@kroah.com>
References: <YtJZegRfm6IsdY/i@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <YtJZegRfm6IsdY/i@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.19-rc7
X-PR-Tracked-Commit-Id: a501ab75e7624d133a5a3c7ec010687c8b961d23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c91723ac9c60840e3a9819e5f767af3e7ca2660
Message-Id: <165799597338.16639.16094206371245420578.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jul 2022 18:26:13 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sat, 16 Jul 2022 08:23:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c91723ac9c60840e3a9819e5f767af3e7ca2660

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADCFC433FE
	for <linux-serial@archiver.kernel.org>; Sat, 30 Apr 2022 17:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383251AbiD3RbO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 30 Apr 2022 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383243AbiD3RbL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 30 Apr 2022 13:31:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA029C95;
        Sat, 30 Apr 2022 10:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8309BCE0EBC;
        Sat, 30 Apr 2022 17:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC426C385AA;
        Sat, 30 Apr 2022 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651339665;
        bh=Ite4PphQd+nVAtDfdorrVtrtB0fI2gM3M0A54RpPShc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ns1KV7EYiJeps224sfwm50b/Jds+dU1xdyD+hhRHeG7NLYur1lXcBxecYGzah1smG
         5AKzUz6udBDHrAzC0iDJTJ+Bjg2MRvgAYfs+aP+ftX7+gdMfy0/NNRKwbvLxKiJD9s
         +ezg6nRfYYJTEHMvC4yRgUmRjzWvcJ/IeObuyNvbvmizFOwvoIEM5zkFdsQVkn14TQ
         p8abERPJ5l6ebR22KBgLfgZYCkwV1/2begx1KaEOR99abE99UEVhrrUQe4Y8R7b2rs
         M4rRviyQz8kRrKKLj/OPly/qJIO313YrkFH4p2QRwkPAoOh10aRAR1QNckbmX6nB8x
         08hj6FuPUPsbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B725CE8DBDA;
        Sat, 30 Apr 2022 17:27:45 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ym1bYgkmZYmrF6x5@kroah.com>
References: <Ym1bYgkmZYmrF6x5@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ym1bYgkmZYmrF6x5@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc5
X-PR-Tracked-Commit-Id: 19317433057dc1f2ca9a975e4e6b547282c2a5ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6b5c5dc06a4b25fc7690a7a25a7c095d3f16fa9
Message-Id: <165133966574.20469.15841248621813968562.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Apr 2022 17:27:45 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sat, 30 Apr 2022 17:53:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6b5c5dc06a4b25fc7690a7a25a7c095d3f16fa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

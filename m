Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73C5C77B73
	for <linux-serial@archiver.kernel.org>; Sun,  4 Jun 2023 12:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjFDM4j (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 4 Jun 2023 08:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFDM4i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 4 Jun 2023 08:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002ECA3;
        Sun,  4 Jun 2023 05:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C874612E6;
        Sun,  4 Jun 2023 12:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA047C433D2;
        Sun,  4 Jun 2023 12:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685883397;
        bh=tSS9/K6Ccz2DHeltrRRHIjFPsh19TKM3/bK2aJy3b9c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XbArey0fuSpqRsrwgEy2gILYmkSIzV06XtuG7tqtbRrfTGaHn3BSL5G5+JXpr4Gcn
         Af/U4m7Ifx6kKFHvfE9RS5o+fFfgDFPPeaN4WkUNZgzkKe0KVJS3YR9SZy2WcmbwQM
         UwysVGuNlniQEfuEKKN5a5meHBmve+LIwp0FMKuF+79u1o7/asSGUgvj7d+k5cuBgL
         itudFt6BfP4m+vVcz3mXVMDRx+msvO3hW3849DQU0mkoD2DOWdyFu3j6azUKeB/7Hx
         wwkUCiomfpDS+ChHFs/OiEsHRVMdJMpeI942eVktxyb6NNXuIQF9BYEe/+bRvCXXOD
         G5ZB6fOu9J1Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C84C0E52C02;
        Sun,  4 Jun 2023 12:56:36 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHxFm2rPU9WaxXbL@kroah.com>
References: <ZHxFm2rPU9WaxXbL@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZHxFm2rPU9WaxXbL@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc5
X-PR-Tracked-Commit-Id: 403e97d6ab2cb6fd0ac1ff968cd7b691771f1613
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12c2f77b32b5de3f5cc4a9ae2eb2b1f68f86df31
Message-Id: <168588339670.18655.14209069182389147026.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jun 2023 12:56:36 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sun, 4 Jun 2023 10:04:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12c2f77b32b5de3f5cc4a9ae2eb2b1f68f86df31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A8AC4332F
	for <linux-serial@archiver.kernel.org>; Sat,  4 Nov 2023 02:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbjKDCKM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Nov 2023 22:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjKDCKL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Nov 2023 22:10:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62FAD52;
        Fri,  3 Nov 2023 19:10:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B08B4C433C8;
        Sat,  4 Nov 2023 02:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699063808;
        bh=0/4E5bFRqgaWD81jfVf+AMmIozzxn011jTVGtHYUEWo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jIJpf2Oa61URsqYsXjUI+KsBqpi7BaSknhPaIU5F2XIBm9qzYH1m13Ghqi1cjHd8X
         v/u/FoOSQ8iLwSPYoz1Pqa4A3Y7/RQg93pScpdYQp59EynU8fqHM3D36y1beP0iSEp
         IHilKUisH70xtUFh3BTk/MPf3GusAUluuPfkdjKnjXayrVmUUG6IZaaUKVloYVFA6m
         ereUJ+7daHqB/EPgS/CSgZjpw38iDjAbqB5ui9MPL96PvZMyA6fvBtzx97KQp6jZG2
         Hdfqvz3IpTzOu3FoDmhmZbvGM/c+IPkv/L4uVTBOHnmUySZ5LG3xq16BHx+E9S+fGw
         WR9B0HM5RLp+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 982F0EAB08A;
        Sat,  4 Nov 2023 02:10:08 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUTiQ-zSU7oE1BhJ@kroah.com>
References: <ZUTiQ-zSU7oE1BhJ@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUTiQ-zSU7oE1BhJ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.7-rc1
X-PR-Tracked-Commit-Id: 64ebf8797249e792af2143eb9e4bd404d10a022e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f24458a1071f006e3f7449c08ae0f12af493923
Message-Id: <169906380859.26291.4137859041226693206.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 02:10:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 13:06:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f24458a1071f006e3f7449c08ae0f12af493923

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

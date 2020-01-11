Return-Path: <SRS0=GYIK=3A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FBEC282DD
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163B620842
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578753935;
	bh=tcWWBa8JAIlJo0eqgfrqcM9l4c/KaWN5zRdwvnRbBH8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vBn3jULyb3+yVOQECh3Ya3uUSYoEwNwIGDDZAgdPVh4c/XiO8I0Mkt2nQMk7RsoD2
	 XRBXbBmGj2eDdZBQ3enir/OAqkCBDKJrDLlvFL/nRAO0tLnFZW2gH+cKRrxl/zQHe7
	 wv49ZQX9+O7lb1fMNGFW0fH/fve+9rFZmoZzsObs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgAKOp1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jan 2020 09:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbgAKOpI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:08 -0500
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753907;
        bh=tcWWBa8JAIlJo0eqgfrqcM9l4c/KaWN5zRdwvnRbBH8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dXnbUi+5YZMW6XxrqXUgpoaXM4jERQqY+6sTIPOCPJFj7+KFaMBoLYqbGCYh2o/Ki
         mmM0Am1eKMGBAC3rQX8UX9G8yV5bduwQnbevXbJx2fWmeHYY6nyf2LBW9taGkDy1Sj
         9ESKUpP8wapGgKZz8Y1dbqOkxDs3bsR+hqH1r4Ug=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200110210835.GA1871048@kroah.com>
References: <20200110210835.GA1871048@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200110210835.GA1871048@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc6
X-PR-Tracked-Commit-Id: c5ee0b3104e0b292d353e63fd31cb8c692645d8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a96c0bbff8690afb3a2fcfc80208cd6590f6e88
Message-Id: <157875390768.30634.11870665450842288025.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 22:08:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a96c0bbff8690afb3a2fcfc80208cd6590f6e88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

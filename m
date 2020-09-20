Return-Path: <SRS0=gJKf=C5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EF5C43465
	for <linux-serial@archiver.kernel.org>; Sun, 20 Sep 2020 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C7420874
	for <linux-serial@archiver.kernel.org>; Sun, 20 Sep 2020 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600624826;
	bh=v05ulbWRT6s1w8PSmS5eFWwrdDU2hzCrjQXGVwKOYGg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=a4HfZk6WhOJ/wfD8b9hcCQa11QmLQ5uuLlOcAVxRmK8YWgd3rUl/H3fTYGsbVC6eI
	 kEo40qQrAjiXMp9MwTfEiQp1CDfKNPGlUyzuqmd0zDVd3vb6y/y59JWQEU93woa727
	 Hs8E2K+ro+aYAGjomV9Iybx4TQzGLvgaIWzO08hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgITSAZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 20 Sep 2020 14:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgITSAY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Sep 2020 14:00:24 -0400
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600624823;
        bh=v05ulbWRT6s1w8PSmS5eFWwrdDU2hzCrjQXGVwKOYGg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QIvkg4CT/mYEyiH2ZBOIrriq0i1vq7h0q/dGHugyKNdgfUg1MsWYnctV9iIPmLxz+
         pTvx6pHYIUdNCkInGwk/xXw1iJYyeXTStiLaXS2qbCV6qvnwNilhaxH1cz8ixoQouU
         T45qBPjV66Dt8fgMyxr/4yQdfN46LyYN3KWgTv9U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200920132811.GA2844860@kroah.com>
References: <20200920132811.GA2844860@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200920132811.GA2844860@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.9-rc6
X-PR-Tracked-Commit-Id: ec0972adecb391a8d8650832263a4790f3bfb4df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f44f3f83d895b830a85f62790cedd5605a399ac4
Message-Id: <160062482373.2021.16185340185118505983.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Sep 2020 18:00:23 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sun, 20 Sep 2020 15:28:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f44f3f83d895b830a85f62790cedd5605a399ac4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

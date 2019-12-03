Return-Path: <SRS0=2gYx=ZZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAF1C432C0
	for <linux-serial@archiver.kernel.org>; Tue,  3 Dec 2019 22:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905D32080F
	for <linux-serial@archiver.kernel.org>; Tue,  3 Dec 2019 22:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575411334;
	bh=+Z+a5IEPBZ5qDsgOA0OTGJytu+b3FaX06DhdC0cd9Mo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UXo8aIuzwC/PjwnLwz7OjITHWSEtuLjgrP+qg8N7TojgXt8B7g76yeYniyYN7Nw1x
	 /2pfI/4M1LxQzB4MzaFmpoOKF5jPwon4tgafbhdIENPp+mESqwqWxgecnfzXqz2P2h
	 o3sxkUJwTNh/DmDkCVmp4iE7Gimyn+rM1GIuFYPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfLCWP0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:32902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfLCWPZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Dec 2019 17:15:25 -0500
Subject: Re: [GIT PULL] TTY/Serial patches for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575411325;
        bh=+Z+a5IEPBZ5qDsgOA0OTGJytu+b3FaX06DhdC0cd9Mo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mPwQQZ4gc6XqGCiednwfZXncxE2JzKwQ4Dz34LabAIsUpkDn1A7BrEaTcNM+BJdQ9
         l/GklyIzYZeEQ4whfjn/PPyZiwiYB+RVQdFnTtpPxwnw0CtjUyKSQYTSz8gENTUSnd
         v3qgpLrgdrDWh2dG+xF5p0SnNeLeAInYbkk0BC7Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191203202946.GA3188593@kroah.com>
References: <20191203202946.GA3188593@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191203202946.GA3188593@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc1
X-PR-Tracked-Commit-Id: 27ed14d0ecb38516b6f3c6fdcd62c25c9454f979
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 537bd0a159a041fad72d257d755205cef77582e1
Message-Id: <157541132537.3528.14317594495130905675.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 22:15:25 +0000
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

The pull request you sent on Tue, 3 Dec 2019 21:29:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/537bd0a159a041fad72d257d755205cef77582e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

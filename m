Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67E2C433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 18:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A267B613C6
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 18:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhDZShF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 14:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234796AbhDZShE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 14:37:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 43BA5613C8;
        Mon, 26 Apr 2021 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619462182;
        bh=CaReIQ34gWIoWE9NuxVH/NeYh6pBpOqTba4GwcpcKY0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b7ifnQBtr+soQN7hc2vtsCWgOQfrQvmblVWNKAcD1qQ/aKjeA0FcMaEnxWmzprjGj
         nziYTW7935vq8b7nnnqa+Fl2Dx6dd4YgOx4iId4hD5wFctFeFD7NdrgnZIwLoWV/MF
         fDo9GYauE+tLYCJ1l/m0VyA354VA9m/OppGymr3PbYfrHx9VQgpqKVO7ta0vt5/7k/
         fYkSiVWsnwrj1f5++ZsYSe6Cs4Df+xDl98UJ/csIQ77F7qvZpfE3YXKlC5G49+Fi0m
         vlCwR2IEiwDTNtGJkKG56Jqv5W3RD6a+LueK8tG2LEwEmG/W6zQd5MSIdG8wQRxBAV
         cYHHCLPu2TgPg==
Subject: Re: [GIT PULL] TTY/Serial driver updates for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIa3d/xiS/pbBudv@kroah.com>
References: <YIa3d/xiS/pbBudv@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIa3d/xiS/pbBudv@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.13-rc1
X-PR-Tracked-Commit-Id: 8720037d55dbfa3011b8795ca2187b00bb05ee03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d08410d8c9908058a2f69b55e24edfb0d19da7a1
Message-Id: <161946218224.19244.222579071346696373.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 18:36:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 14:52:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d08410d8c9908058a2f69b55e24edfb0d19da7a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

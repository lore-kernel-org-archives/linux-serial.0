Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79AAC433E0
	for <linux-serial@archiver.kernel.org>; Sun, 21 Feb 2021 05:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE8C65000
	for <linux-serial@archiver.kernel.org>; Sun, 21 Feb 2021 05:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhBUFlM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 Feb 2021 00:41:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229876AbhBUFlL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Feb 2021 00:41:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id DF60764D74;
        Sun, 21 Feb 2021 05:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613886030;
        bh=GBlRMtpN385NlAlufgvbYRtE+HSJpdvm0r8Fsm/y24o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cS01jr6in5NDJ8i+dWexDIHG13oPCSLe7Co2h5IcFqdu7QjfoEP+i04kkyt+dqFqD
         x9ThSAc7DtvyGi5j7Qhvjz6fcLXmUJqvwooh+V0jzEjCHo6F09d5uWHt1GuHLey0TZ
         C8rAmEIkgIqugcQSRLdxGWA3yrIzBY9mMz+tdBPRRxX/TD939cgeOLBxqUzMiMEvPO
         sHWg5Vv012PiE5DFcoVQezrNHa1MkIqy00r3VbLTWltANNBqYAimxgfwB5Uj84c54q
         SiuiOtlVm2g8OpcjaHE5Wj0QiX7LaDXlg3K5K5aMaOF7DlrYWwxQCjbBEd94dHMlsb
         /GC/4wMcgpZ3w==
Subject: Re: [GIT PULL] TTY / Serial driver changes for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YCqg5ufpr1yD9tvk@kroah.com>
References: <YCqg5ufpr1yD9tvk@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YCqg5ufpr1yD9tvk@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.12-rc1
X-PR-Tracked-Commit-Id: a157270fbf37f822e1fa9e9faa8ed8c81da1eb28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4286926abbbaab9b047c8bc25cae78ec990928f
Message-Id: <161388603074.26679.6664133441126574863.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:40:30 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 17:27:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4286926abbbaab9b047c8bc25cae78ec990928f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

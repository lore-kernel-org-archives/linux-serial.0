Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B710C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 03:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E3560E53
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 03:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhJRDYk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 Oct 2021 23:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhJRDYi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 Oct 2021 23:24:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 70CCE60EB9;
        Mon, 18 Oct 2021 03:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634527348;
        bh=mHROm8xKap22atusGEWBpuppVZmlM/UAywyi357IXbk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=guaDq09gkksNyJdc7YuXEYClRlpf6CiFK8hSqsnbXLS3mQvS0x2IAeoYJOqVSjKiF
         QXxoYHVIhofbkBAf4Ukz/P92sy4G4hJViWJ9sbrS2ZD3HZYbVimhVZr0/Mn6o6gNUC
         BT6PvSaVXp+PHIFIe/gy4hD4H1DJnUYT1gFtkeg27uYtoC/LUmyOBqkcgLSUlRwr6/
         0l1uu6EP19oa1j3ixi7sHIdWWUFxzVWPs+8Gw9HT5mPCq1qdZwKG/n+r51Y6tW+SAv
         Laf6Craer4Y+/X9Izj0cq27gwq4jJEIOOwUGSJhn/mCxRt+P+Ar5UFl3iRFclrhtQA
         fkOamrn0ydnJw==
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWv1k5ygiW+Avl05@kroah.com>
References: <YWv1k5ygiW+Avl05@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWv1k5ygiW+Avl05@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.15-rc6
X-PR-Tracked-Commit-Id: cb2282213e84f04ab7e93fd4537815da5db2f010
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9e42b3cf237d8a5d093d5d451d6ea75f95743d0
Message-Id: <163452734843.4914.18048676919366007010.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 03:22:28 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 12:06:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9e42b3cf237d8a5d093d5d451d6ea75f95743d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

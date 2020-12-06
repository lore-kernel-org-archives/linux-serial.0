Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44867C433FE
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 19:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F80A23380
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 19:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgLFTxV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:53:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbgLFTxV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Dec 2020 14:53:21 -0500
Subject: Re: [GIT PULL] TTY fixes for 5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607284361;
        bh=V8kjLr14CqeIJQ0pb5hHWwV5IcNaw6bEvSbpZUHhrN8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UfBnzRF8IuaQMObG+cf34nykoNQcvs8AiBKDMYR6AehdNhDOOHHqOUFnqLLaWzaN4
         w0Pxgi2ZmRJeFhrekLD12PpqApQA8uV9EFvzjK7LFVv91+Fdb72/5CA4OQ6RO1c6en
         JBupZSLzopo6N/PST/4DzwdFjxr5g9pfAvV+wC/xvlp/9ySyh/UVTZFSOi3wjvvwqr
         rUkGQM30nMf7bSqF2O+Mp8f5YAOFW7CIhKp8hSnbiAqbocoWpDycFKxErBRiD/g8g/
         E3bXDgbbFvtMPvodoGB7wTRF46kFrVtE7t1/UJcKuETVjvPFG5UvJcUkxOvCmLZaD0
         aWq3Mj9U/hkBg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X8zsR9l1TDdgzYMi@kroah.com>
References: <X8zsR9l1TDdgzYMi@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <X8zsR9l1TDdgzYMi@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc7
X-PR-Tracked-Commit-Id: c8bcd9c5be24fb9e6132e97da5a35e55a83e36b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d49248eb25a223b238cd7687ea92b080f595a323
Message-Id: <160728436091.18476.8366843064195819410.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Dec 2020 19:52:40 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sun, 6 Dec 2020 15:35:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d49248eb25a223b238cd7687ea92b080f595a323

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

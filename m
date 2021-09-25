Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008CAC433EF
	for <linux-serial@archiver.kernel.org>; Sat, 25 Sep 2021 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2CB610C7
	for <linux-serial@archiver.kernel.org>; Sat, 25 Sep 2021 17:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhIYRt3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Sep 2021 13:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhIYRt3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Sep 2021 13:49:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 560836044F;
        Sat, 25 Sep 2021 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632592074;
        bh=Ze6vBwvmZ7wdt9L6CTjw5sWkpWB96STO+ZNkkh07R5E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PbKZR+00VfR+FL5k9tA3g4t3FDgv5zq7JByPw7oyS7xee8Tr71JqTVrbcfAQd4hbK
         PVDbYVJuGx/5aCBn8Id9NbfYYU5kfZMf/6VFr4D9VNiTFBMggoO/on/jkVZ53nQ827
         qlU3MVUiGYjDRXlNSv+u07WVHgU+HZdEj4zOdwbpaXKcb+zOtk3fvnBROtDOGpCBei
         yoX7w7ro4cQbKnyfAAXa/wfPY+pzSdgfuDmkA+3GZaABH6TvF9lzCfXXC6kuSpJOTZ
         SBKmpxmue6LZASy1HvLUq4AA0XD1M4mERUs+yf/mlwUOsgDLnCwwvHuSex0a9TvmiW
         8o8s3QWzWvGwg==
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YU8ue5u+44spJB0v@kroah.com>
References: <YU8ue5u+44spJB0v@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YU8ue5u+44spJB0v@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.15-rc3
X-PR-Tracked-Commit-Id: 7049d853cfb928f50b6041cb4a5c6d6c1d8dd201
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9d4be2507cfec4d4878fac7d3b85ae9a77da2ce
Message-Id: <163259207432.4008.10429622150977510637.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Sep 2021 17:47:54 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sat, 25 Sep 2021 16:13:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9d4be2507cfec4d4878fac7d3b85ae9a77da2ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6295C004D4
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 19:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjAUTXk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 14:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjAUTXk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 14:23:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD3229439;
        Sat, 21 Jan 2023 11:23:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E16B360B67;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 527CBC4339C;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674329018;
        bh=3S4I5zQbEWOpxCSUwMDD0Yku8IfPmTYUQFlcTndEuVE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OjPcJvRUEPja3M+TBUhEAV6admXZ1Is9EidmNZT/7Ot98DFxM4ewMP11nDfMXOt8v
         JOFVjjBf36raggzP58aZSfdQO7AVhLM9jJErES1DNaqlgqqbI8R9NXQ99P5oBOXanQ
         ciK9/8KXE1kXDSyFKkg7z68hn85KFdXKnN6aDCTIY7c8U4+ac2TA8EIl4aF5nJEypX
         x1cxHzxmEUEVDsc9hJNMxLwpiySzFgU4A8XOZ24SiuFXLhmKKOs/aiZ84QaUXv33Yx
         TIK+stXCW9dzDUTHquXd54xQgSj/8BUooHDbcJpzAtmS8EnTT54GzZPlYeywmK5m/l
         BCCKeg4WIInLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38C18C4167B;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8wEx5F+nUsgqj4Z@kroah.com>
References: <Y8wEx5F+nUsgqj4Z@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8wEx5F+nUsgqj4Z@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.2-rc5
X-PR-Tracked-Commit-Id: 14ee78d5932afeb710c8305196a676a715bfdea8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd5cc6ee8f4e823e466a075a79db3cd355cee28e
Message-Id: <167432901822.17568.9697005451576410207.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Jan 2023 19:23:38 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sat, 21 Jan 2023 16:29:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd5cc6ee8f4e823e466a075a79db3cd355cee28e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

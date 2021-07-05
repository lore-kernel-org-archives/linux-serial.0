Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42702C07E99
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jul 2021 21:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A9D6198B
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jul 2021 21:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhGEV1s (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Jul 2021 17:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhGEV1r (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Jul 2021 17:27:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 54CD561985;
        Mon,  5 Jul 2021 21:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625520310;
        bh=afWSVCp2J9e+bVWI3DB/r5TI+UsJ0qI/K52qbyGvJXI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GfgGB4TupKyXcn8/xjQpW6feV4LFr/uMj+ubS2nzCn0AGxRaoWgJXPsnCcRIl96+k
         v6RAbeUxe6JzDQyJhlO01ky9+9FAhXe/+a81pK9LhWFf3lh0VlGr8V9kiqrjOGwURa
         Ji3Ia3L75JuG4qnFU7dbkRYuVgNSXfRTBuvSZxhiDBUGBtHVVvRRVzp6g7h4znVbq1
         MfxNlO90jwJBo923KIifKDttcQKIkym8lNoIPKvZ3pNSUSMt/lFw8Ps4Ywcyzeyepb
         yV6fImMfSR19Fh2fXWCVcJLtWQ7e/+y+PxfnvatsuSnIVh2FBIPBR/OByJTchTWrPt
         d9bmIPLJg60ag==
Subject: Re: [GIT PULL] TTY/Serial driver changes for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOM9n3QwCwN/2FiW@kroah.com>
References: <YOM9n3QwCwN/2FiW@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOM9n3QwCwN/2FiW@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-5.14-rc1
X-PR-Tracked-Commit-Id: 15279ebe99d7c6142d9f1a6ae4ded66c0f168678
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c932ed0adb09a7fa6d6649ee04dd78c83ab07ada
Message-Id: <162552031031.6675.7154187358586863660.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Jul 2021 21:25:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Mon, 5 Jul 2021 19:13:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c932ed0adb09a7fa6d6649ee04dd78c83ab07ada

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

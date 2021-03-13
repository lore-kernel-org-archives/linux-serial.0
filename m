Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1865AC433E6
	for <linux-serial@archiver.kernel.org>; Sat, 13 Mar 2021 20:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8F064ED1
	for <linux-serial@archiver.kernel.org>; Sat, 13 Mar 2021 20:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhCMUqA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 13 Mar 2021 15:46:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234385AbhCMUpi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Mar 2021 15:45:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id F01A664ECE;
        Sat, 13 Mar 2021 20:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615668338;
        bh=bNoiIMKloPBQB4hoGmAfRsNiVFmQc3gauhyUGBZuN1I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XMYaPbXjOS7r31s+AUjCXFWCZFJ1TaUa9JQCMrCmduOrmGnM1A8F8f1MKuDleFhcl
         p57glxnSOddCaPaoDOeO7cxf1+FRKn8Xc08uW09rMVjeE9akdYvmTZ7jJns4pCF8U5
         cAGqOB9QmdBGsGzFKF9HsJThnJF53tydByo7s9l/qHbWIeO7QNF/IgIAms/ieQr/Ur
         82TF65uW0ySBTAtLct/qskYTMnmppRO9muenyHcN0cJaU51lHymvxNgYqjmLVgxmXf
         Q9AP8fuN+xAM5/0TWqX0Vng8/2XGmMA/6bfdU9doS/UAcOjMnVyB5yLIvXX/Jm3eLG
         rCCIXl1GigqZw==
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YEzUB0on5Uq36R2g@kroah.com>
References: <YEzUB0on5Uq36R2g@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <YEzUB0on5Uq36R2g@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.12-rc3
X-PR-Tracked-Commit-Id: c776b77a279c327fe9e7710e71a3400766554255
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc14086f22980fd15bec4488ecfbecb4f904cd35
Message-Id: <161566833795.19597.6898826458483322765.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Mar 2021 20:45:37 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sat, 13 Mar 2021 16:02:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc14086f22980fd15bec4488ecfbecb4f904cd35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

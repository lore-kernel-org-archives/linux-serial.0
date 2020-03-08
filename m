Return-Path: <SRS0=hEVs=4Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83087C10F27
	for <linux-serial@archiver.kernel.org>; Sun,  8 Mar 2020 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5725B20848
	for <linux-serial@archiver.kernel.org>; Sun,  8 Mar 2020 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583682918;
	bh=5lw+Mm2TxOGqwFrV5NMFtQJacPD1be2WveH0rS3Wu/w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TDibr/DzbiOKlb+BIGg1LNvFCtY1Xnb0ff2GkbZmuoKkzOSMIXuZxbtj99j/cNfTX
	 Zda95mgUwLyvE+5boJjCv0BwEcTF5l5KZ2Ov+f3yOaEcR2CazCjjPgSJo78FSuSOTk
	 CSP/GGU8udOkkp6/uya00ueBkEczuUdJRTkgQAh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCHPzP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 8 Mar 2020 11:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgCHPzF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Mar 2020 11:55:05 -0400
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583682905;
        bh=5lw+Mm2TxOGqwFrV5NMFtQJacPD1be2WveH0rS3Wu/w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HwChq2Z8tj9nf7GAp/IknsKF1bRyr09IJX8h/+bUPaQVAp2DyB0i3xL+T0Hkln5UQ
         +EXtFkfQUZGLXMecD6jVWPAyKYaONb1I5iWFWUf3LU6vy5HeZ+rVgB1E5s15JfFe1u
         5xg6GCvVZbUsWvKp/AIGIqiEjOjrRj09bPig8Kn8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200308095219.GA4026988@kroah.com>
References: <20200308095219.GA4026988@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200308095219.GA4026988@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc5
X-PR-Tracked-Commit-Id: 2b2e71fe657510a6f71aa16ef0309fa6bc20ab3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc432aee7d5a5cd6c8ae4dd9f5bae56428d1fca2
Message-Id: <158368290556.12496.8721739619846796777.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Mar 2020 15:55:05 +0000
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

The pull request you sent on Sun, 8 Mar 2020 10:52:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc432aee7d5a5cd6c8ae4dd9f5bae56428d1fca2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

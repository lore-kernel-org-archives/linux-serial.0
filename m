Return-Path: <SRS0=RtBO=BQ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726C9C433E0
	for <linux-serial@archiver.kernel.org>; Thu,  6 Aug 2020 21:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2372173E
	for <linux-serial@archiver.kernel.org>; Thu,  6 Aug 2020 21:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596751168;
	bh=1s5EEz2d2DdGu35ZasPK184T7BJ1KOXm6ralg4+l7cc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1rdSJIN0qchy+jb25xlQbVdQYoBFKlXFh/LYR8CRGJBzicFRzPeMVDfDlOAYK3KBc
	 i/PrUyLTqQkfZQEHTgNIx2V0A7uvyov7aoN8zg3kuDE27U+X9Ud3tD2OLr4tiZCRy0
	 IX9odMYeLK9PrvlHFdBNNYuyDYjl1RmyZUrFX+BE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgHFV71 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgHFV7X (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Aug 2020 17:59:23 -0400
Subject: Re: [GIT PULL] TTY/Serial driver patches for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596751163;
        bh=1s5EEz2d2DdGu35ZasPK184T7BJ1KOXm6ralg4+l7cc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PORlSEegrD4S8MNc49BC99ruN1BdIvA2ZP5WmzC9Gx+egUTY8H9WXxhMqspPXS8g9
         6GMJd52wKCEGNEzzHxH4RcEOwI0o5DBg22mMUcVpmDt1u2OxEZjhRXzBq05c3Bpzoy
         03GpQSNblhA1c47H3SjQbQ63WydE2r45nkYDchZA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200806123354.GA2858200@kroah.com>
References: <20200806123354.GA2858200@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200806123354.GA2858200@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.9-rc1
X-PR-Tracked-Commit-Id: f6c6eb2fe8223f8e64babcdaad2838ba6ede277d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6efb3ac3e6c19ab722b28bdb9252bae0b9676b6
Message-Id: <159675116311.18694.16427192806597829568.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 21:59:23 +0000
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

The pull request you sent on Thu, 6 Aug 2020 14:33:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6efb3ac3e6c19ab722b28bdb9252bae0b9676b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

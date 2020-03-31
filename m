Return-Path: <SRS0=U7OZ=5Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C53C2D0F0
	for <linux-serial@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBB420678
	for <linux-serial@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585698913;
	bh=UOe3hAzjJP3cEHW26WIiaaqokN487k//4mNygjs9d5g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=E1fgIeafWv0BFETGTEMXVrVDfsOmGxyPn6I65Wn+MuY1oJvsVl7te9Rjs4rG8jUU4
	 Bu+rpCGC8WUsXb2ppzr39YWzjHF5jtc+8LNUVMWK9b7iKk1IGIdexg6J1r35IoisAW
	 MnSYJjbt9O+2XgOneNhxaCor/5zKfQWsnRWcA4CI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbgCaXzM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732027AbgCaXzL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Mar 2020 19:55:11 -0400
Subject: Re: [GIT PULL] TTY/Serial driver patches for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585698910;
        bh=UOe3hAzjJP3cEHW26WIiaaqokN487k//4mNygjs9d5g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D6stzbEa9x1tpQx1oE/GwEfhxHkhgrM2PFjRVY66SV5/SZwpluVq7oFO4sYjKk7cC
         CajOPtVTmoZz9SnIxBmNrhGNb/ok5Yzn+rL2JEYuVCkRPOUjbdrnpXhGIBU9N9xpBo
         iKxmT+++bdzFp387sugom5Wz1Yw6RjfMWhEMKspk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331073140.GA855734@kroah.com>
References: <20200331073140.GA855734@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331073140.GA855734@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc1
X-PR-Tracked-Commit-Id: 8d5b305484e8a3216eeb700ed6c6de870306adbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f944f976d7ef8a29d1ad296253d3a9387c58e62
Message-Id: <158569891089.16027.10522517027115385120.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 23:55:10 +0000
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

The pull request you sent on Tue, 31 Mar 2020 09:31:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f944f976d7ef8a29d1ad296253d3a9387c58e62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D8C48BE5
	for <linux-serial@archiver.kernel.org>; Sat, 12 Jun 2021 19:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB898611B0
	for <linux-serial@archiver.kernel.org>; Sat, 12 Jun 2021 19:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFLTjm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 12 Jun 2021 15:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229985AbhFLTjm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 12 Jun 2021 15:39:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7A1CD611AC;
        Sat, 12 Jun 2021 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623526662;
        bh=jvesKrSZ3Xly2Ed/3HnK2XfqALyBoP5dwqi7D87pbQ0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D7iJrmi4ln6j/hc9dXXX6j0TNhAag0Dmkxc9kCvyyxApGdmFyAwoXhdGLSol7Ypwp
         LTYRpAsaF/00VY7oI1XNZVIe+EVvkIiveugr2qd/yrHxh9UBMvtg+m4OlPxI9PHPNB
         Ojsu24X5K+A0hUmsa1uGsANrytXa5MCQoP8gvwoxUiihnHOdzF7KCy+I80WXXU95a8
         K4Wt3FC6GM4tijG4nLhEQgm8XnMtkDGxkrXTWOsSYwB8OueM2r1ZfXMoxTRQymgZkZ
         Sq/f8uSd6aVsnoeIuThDpi1IfrM4wpujFWnZ1qUhx1WbzENHk9zfN7+ZAxpWqxdb32
         9VWCrZtsNsK/Q==
Subject: Re: [GIT PULL] TTY/Serial driver fix for 5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YMTYzUp9cv+e4U6R@kroah.com>
References: <YMTYzUp9cv+e4U6R@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YMTYzUp9cv+e4U6R@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.13-rc6
X-PR-Tracked-Commit-Id: 7c3e8d9df265bd0bdf6e328174cdfba26eb22f1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c46fe4aa8271e97b520dc72018688e083460127c
Message-Id: <162352666246.18796.11476214346448330279.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 19:37:42 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sat, 12 Jun 2021 17:54:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c46fe4aa8271e97b520dc72018688e083460127c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

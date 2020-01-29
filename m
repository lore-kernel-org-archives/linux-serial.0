Return-Path: <SRS0=su8x=3S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B02C2D0DB
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FD72082E
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324409;
	bh=zdIi9qbq49yLTacNNV0GW8oZspiKmsOdTO0j9aGqCoc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2BaWkjzf1nK5rTHpA8sXBfCrxGxj0gEI5cOLPsmN0bmaaRIXGI9O+Dk9nMZqY8fbk
	 tQX5HN6/Rld65CuVw331Q3MZUlZY4YnANpm17YWhLSYYDXDw+Mis53g+1QV9WS/4nP
	 28oGHLnWIWgybL4+kBguAUKhK3Ju96U3Ha8L5IHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgA2TAJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgA2TAI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Jan 2020 14:00:08 -0500
Subject: Re: [GIT PULL] TTY/Serial driver patches for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324408;
        bh=zdIi9qbq49yLTacNNV0GW8oZspiKmsOdTO0j9aGqCoc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uIQXCt6Dy9+TGQOWQJgImK0ObAeabItJMk8125GSntAHoVBUL9gL3r3OdfXlgawJj
         rZU3pqZEtVmBKOmwnYIJo836+n0bHKBs8gZFD7vg74VyojfsOEyk6328sur6vaB8iD
         L4YP33JacyLjiD07oxh2xWDZSLPOsz3M1FU25TXA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129101420.GA3858344@kroah.com>
References: <20200129101420.GA3858344@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129101420.GA3858344@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc1
X-PR-Tracked-Commit-Id: 85f4c95172d606dd66f7ee1fa50c45a245535ffd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca9b5b6283984f67434cee810f3b08e19630226d
Message-Id: <158032440840.15518.11492001728736110702.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:00:08 +0000
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

The pull request you sent on Wed, 29 Jan 2020 11:14:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca9b5b6283984f67434cee810f3b08e19630226d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E84C433FE
	for <linux-serial@archiver.kernel.org>; Thu,  4 Nov 2021 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0933561216
	for <linux-serial@archiver.kernel.org>; Thu,  4 Nov 2021 17:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhKDRM3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231740AbhKDRM3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Nov 2021 13:12:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 25352611EE;
        Thu,  4 Nov 2021 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636045791;
        bh=745Wy00l5dA1AH3xYnmU1+AknKyAl1Nj11tNyGUjinQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jy3Ca/UNqcaQIvnwtNj7Y7Y7/QVNOrklNPIjLTR1s7v71sL34bxeRIpDYkaFlxk1J
         PAGjApqzdi2dOKF78ra0Knm/MCVtUOxpBKNPmr5el2snDxFPZeGSiTyDw+WyT5A6uR
         qzYLHiFMQ5Fe4ZrQRU9mRD78wfX21qAgqOolGhoS86IZXVmDRSNO/JCHEYBh+d/v1K
         n7RxC35JvwLLbxbZbrd3APSvur3xIDSoAeyT/77fKkF7QM+lDYspGpCy4iHy3fMBYd
         Jk3mZeH6ZLPVlC8uawqs/iVL43XxzTYrHjN2zDDxXKwpDYWQKvuki2pbPFEF7p8+z5
         Tbk45892AFvFA==
Subject: Re: [GIT PULL] TTY/Serial driver updates for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYPc/XfSYP1n5UbV@kroah.com>
References: <YYPc/XfSYP1n5UbV@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYPc/XfSYP1n5UbV@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.16-rc1
X-PR-Tracked-Commit-Id: cc8d7b4aea79df7cb45b74f9bc5b8a8bd2ed4c07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abfecb39092029c42c79bacac3d1c96a133ff231
Message-Id: <163604579112.24234.15610784816359941039.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Nov 2021 17:09:51 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Thu, 4 Nov 2021 14:15:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abfecb39092029c42c79bacac3d1c96a133ff231

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

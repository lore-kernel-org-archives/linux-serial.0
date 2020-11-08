Return-Path: <SRS0=hQyk=EO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F92BC388F9
	for <linux-serial@archiver.kernel.org>; Sun,  8 Nov 2020 19:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336CB20731
	for <linux-serial@archiver.kernel.org>; Sun,  8 Nov 2020 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604864314;
	bh=j6frXFNQdPw1Wd47dfid5BHBVe5rvqIpn3ot7TpKZg0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rkSTegJk+Yt/tfj3b++cHpz5sKyp3gpDWRi617WKhRCfbbClRQ+PlTyuMAQGchzL6
	 eEJm8/qN3rfCAATNmD8u1TEo1T56LtQHLXLhzVcTE93aIDpqTou5ZpnuB/oV94AE9d
	 HEOpQ/xRQRNPNF5o07smBjx0GuAVTjdBox6161/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgKHTid (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 8 Nov 2020 14:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbgKHTid (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Nov 2020 14:38:33 -0500
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604864313;
        bh=j6frXFNQdPw1Wd47dfid5BHBVe5rvqIpn3ot7TpKZg0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mcwFql9I0amaFJH0i333kwgA2XvNA19wugnqDUTkjtUFk9MZ9It1O1ZoYGh2vhCHu
         P6x40SwLcp4zaE5NEyuBnAfJau0dYoFDCdGAo/dFL1YizNy9PrJ0p1kZGnOLedpL8+
         qU+sa3afEhTBcCNdpQnSgV7Zs8GDdi0T1/PDf4xM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201108184614.GA66799@kroah.com>
References: <20201108184614.GA66799@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201108184614.GA66799@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc3
X-PR-Tracked-Commit-Id: 3c4e0dff2095c579b142d5a0693257f1c58b4804
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbc821849eba179e62bbe2adba19a87c7686c27b
Message-Id: <160486431325.12026.11089663500162483025.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Nov 2020 19:38:33 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sun, 8 Nov 2020 19:46:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbc821849eba179e62bbe2adba19a87c7686c27b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

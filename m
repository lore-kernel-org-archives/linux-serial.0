Return-Path: <SRS0=ovE7=EH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A85C4741F
	for <linux-serial@archiver.kernel.org>; Sun,  1 Nov 2020 18:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E91722253
	for <linux-serial@archiver.kernel.org>; Sun,  1 Nov 2020 18:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604254142;
	bh=VdeRuhj90482BTttclCdIHtmbORwLLNHZZ7+uUn78N0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=n/xj1L7Pp5OjyPY7CeC77HqWefoXMBwhxfGh7WXU67q5jsM1Ka6+UbGdlF/kIXSGE
	 vfvFSgPmUmph9kCeE6KvKEhmv82cCI5nl9rN+TC+jAz9kuuzWALZAzF0YIrYmZhieT
	 6IfvblKbiP3wf1kSvZmrEioZH6h0Dj125Bm12oNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgKASJB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 1 Nov 2020 13:09:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbgKASI7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 1 Nov 2020 13:08:59 -0500
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604254139;
        bh=VdeRuhj90482BTttclCdIHtmbORwLLNHZZ7+uUn78N0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z5PZscRdCLtjJHNGMmp5FVkkQedcINYJzAdm1lIopmKzU2/i2RN3U5SCNaHdz/C8D
         Xv8+YxS1/ZUrAsaDH7vHemmnTj/cjcDa95G/IozEffIUgfv1Cflm4Xd9lkgV7El9Sy
         vWwsyDO8nYEhWWLv+WrUnUHqmpDn77k22obk3ahI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201101130854.GA4114977@kroah.com>
References: <20201101130854.GA4114977@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201101130854.GA4114977@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc2
X-PR-Tracked-Commit-Id: d54654790302ccaa72589380dce060d376ef8716
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2754a42e0dccc8db89426901bb54ca6c34969c01
Message-Id: <160425413943.10555.255026369400231422.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Nov 2020 18:08:59 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sun, 1 Nov 2020 14:08:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2754a42e0dccc8db89426901bb54ca6c34969c01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE73C4332D
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5529E20767
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584724542;
	bh=5XG3OFUlmNg8aI4pi041UWHMGMe1DZ86uj8R9VRxuvM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pwmir7TKACMgaOF3RkJO3XiQZReWo8U8iT8N1ZkthtgC3zaODgED2OR3Ii9FB/jFS
	 JB5vTfYQr0F8JhnJ8zgfsPokPf1tqVGUkjWZkendHKVFS833tsdSqOcd5G++w4emI+
	 7D9YAUa163+OooQL/6UbU3JCVCYiIhmPz2wyCvn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCTRPc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbgCTRPJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 13:15:09 -0400
Subject: Re: [GIT PULL] TTY driver fixes for 5.6-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584724508;
        bh=5XG3OFUlmNg8aI4pi041UWHMGMe1DZ86uj8R9VRxuvM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HvqSzTpayRYmJqbkXBR6u/NNYvS0S/VW93QYd+noUDcLJ+NxJC0x+czuJhHQaHyxK
         b3MybXSAQ/P8mZKUo9SiNVCgSdISmJqaTKWagqVgDHFBwCMcZ/dC/gdGXNbPdE3Bvw
         6NhQd6HTX3CWEwzlYrl0YmYwWNL7XEFroZ8frFKg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200320142715.GA760292@kroah.com>
References: <20200320142715.GA760292@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200320142715.GA760292@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc7
X-PR-Tracked-Commit-Id: 6e622cd8bd888c7fa3ee2b7dfb3514ab53b21570
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa91418b72cbf14742f2439439369fcad942b24c
Message-Id: <158472450887.23492.7401016980636426695.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Mar 2020 17:15:08 +0000
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

The pull request you sent on Fri, 20 Mar 2020 15:27:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa91418b72cbf14742f2439439369fcad942b24c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

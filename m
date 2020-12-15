Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F0DC2BB48
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 22:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFDB22D0B
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 22:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgLOWXA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Dec 2020 17:23:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730170AbgLOWWx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Dec 2020 17:22:53 -0500
Subject: Re: [GIT PULL] TTY / Serial changes for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608070933;
        bh=68mXl5wW7uY1rYweQc7TcC9mmYFlTmx1nOhrZv3yIGU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DC5rG/rInyI+lOfQXtnZQ6qAcJFxNJCx66ovcVh7XPoqbTpPMHNdBPylDtB7w9uDW
         kstYDhldqUbhKJk14KDydTYphdIQDTzQrwXwtcTdhgas7q6rSx54+CyYvJZd79qVqu
         PF0fb2bIyWm6yFe0717TKCtMwpMN0jirTFwVDppDNKyb2fkTJeofCw5H/atqyfX8GV
         ehZWli3hcEwQ/7sonF2MzZ7Pv+4dlGygzM3o3i54SremSYXe4Nl7T7rVlXsWKzBaV3
         MTe0IBfntQDFdWcbFbwmgsipDU5J+xhJjF9iTJx0h8Rw0T3GVZNQPKtbPN3x6aqMYb
         lziUMcN1V5QLw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X9iNOFPXMb4IrJDX@kroah.com>
References: <X9iNOFPXMb4IrJDX@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <X9iNOFPXMb4IrJDX@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.11-rc1
X-PR-Tracked-Commit-Id: c3ae3dc896fab5524f9b20f547e72e4b892d8d8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 157f809894f3cf8e62b4011915a00398603215c9
Message-Id: <160807093330.3012.11593147018720186549.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 22:22:13 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 11:17:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/157f809894f3cf8e62b4011915a00398603215c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7982BC00528
	for <linux-serial@archiver.kernel.org>; Sun, 30 Jul 2023 19:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjG3Tnd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 30 Jul 2023 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjG3Tn3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 30 Jul 2023 15:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65281702;
        Sun, 30 Jul 2023 12:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40F0E60D36;
        Sun, 30 Jul 2023 19:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A09B0C43391;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690746206;
        bh=4q4lnzt7Q0DjSYopZav5iFdCPaxRgMxSPvC/6QrRzaA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=loTtookROa1S9UcV3ww+YrTUtUdfe5srH+CSuJr/3llc4yAFvDk3rERLJHtW9Bg96
         f8hJIjwtvjKnjUYG1i6esHPObV7R4nWRlPeR/yPuGt6D4ySCIkWyg0+5c4t0DRlOZn
         ahXWHabzYgUX8Ic7zQS0ZFecRgJik9ZeuopayUH+IcIlvSkdm38KqBF37+QPy05qRS
         EeM5CIiKyr6eHTFDa7yzSBkdaMxkiMlNNccy6DCHGMuC3xbyNpssFMAs3sau2wKZC2
         BcmHGHsLtPPm91+8uK1oGJEByoYDeDTNz+IsqUVVKkAvue9P1M4NUSz7LFSSgvlNeZ
         bIP7q5uUorKAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F2FAC39562;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMZEgcrNeJRvKlY-@kroah.com>
References: <ZMZEgcrNeJRvKlY-@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMZEgcrNeJRvKlY-@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.5-rc4
X-PR-Tracked-Commit-Id: 748c5ea8b8796ae8ee80b8d3a3d940570b588d59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6d34ced01bc3aaad616b9446bbaa96cd04617c4
Message-Id: <169074620658.25913.902732364931866569.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 19:43:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sun, 30 Jul 2023 13:07:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6d34ced01bc3aaad616b9446bbaa96cd04617c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

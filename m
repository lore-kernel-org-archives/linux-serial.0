Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91951C7618A
	for <linux-serial@archiver.kernel.org>; Sun, 19 Mar 2023 17:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCSRPx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Mar 2023 13:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCSRPv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Mar 2023 13:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C561B311;
        Sun, 19 Mar 2023 10:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6450F6114B;
        Sun, 19 Mar 2023 17:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C53F2C433EF;
        Sun, 19 Mar 2023 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679246144;
        bh=MzY6nD+BGhUlZfktlvtXoLRtqXDlXJQo/Czh8JtPCkM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S1AI386/qM3YoPlfvYd5CTNjc8008+/MHP4LaHRwMg0clVQgE2xcWmyPVwsaR4XxU
         R49dG9yHkPt9oP3Ql6JhelZ6tExDzdeVBv6OBQUiaBg1OLvSzZ0kO91Nr0lbH5yuRu
         D0ehFlov8nT7wGl1esZ79/oGfGEmu2PqiJIvj6JkzNI1k3/GGqdb6VUP1QZtrqjvzS
         PIMamIXk4qTRMKVyV0J73JeTGkbX6JQ+JIFlnNryD0t3ZSFTU4Ky/Tu/sG2xIIBx5e
         SjDXHm9EhSwtzNSagdPonYb/rSFt/biDBw0/yrrEi1ZbacAeXI3QqqabKYy+HXTu9z
         ZF5dXel6Dafyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3D76C43161;
        Sun, 19 Mar 2023 17:15:44 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZBci7jg5l9X82rhf@kroah.com>
References: <ZBci7jg5l9X82rhf@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZBci7jg5l9X82rhf@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.3-rc3
X-PR-Tracked-Commit-Id: 18365ebf23f3e713e5dd8e295c9a639295250f3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cdfdd6da3231227611e0c24e005d6ea450bdc75
Message-Id: <167924614472.22094.14229892420286710365.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Mar 2023 17:15:44 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sun, 19 Mar 2023 15:57:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cdfdd6da3231227611e0c24e005d6ea450bdc75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

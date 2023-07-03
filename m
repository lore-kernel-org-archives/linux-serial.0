Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72405C001DD
	for <linux-serial@archiver.kernel.org>; Mon,  3 Jul 2023 20:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjGCUag (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Jul 2023 16:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGCUag (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Jul 2023 16:30:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F4710C7;
        Mon,  3 Jul 2023 13:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99FAD6106F;
        Mon,  3 Jul 2023 20:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 682EAC433CC;
        Mon,  3 Jul 2023 20:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688416221;
        bh=Yu87ABCTOAiCzSI7ggSVNIsaQtGGImKHQ61zl5G4IAw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=le7TsRn9YZDVxfoJZo9xMmkCJ3BLpl8al8TGoGJxuj3hZMX4RKpxIQVNTeVe7VcaY
         0MwJx4YVtQu5yOIfnYlUxrk/kb+wh2Cnyks6DFj4TfS8jHXsDmtksw5vyfh/hKs/wR
         YzO39QnJTHfYpaU/OPba00RStOCVNzQpEjNqS9JFkypIVETQ4CGMEgjtIDGXGNwb4J
         6C3qYYokWnz2HsrOofhXyPkCbvGLl+FdGpzL88/KEprXNcbmM2MlwtlW6rTwIa3vgm
         uwZ9UILE2gN85/+ipzRq82dksoEP85EY8i7uYtFdc9u3XXJYc/MibyUmW6WxjQnV2C
         W+qzOv4U6r98w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56485C4167B;
        Mon,  3 Jul 2023 20:30:21 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKKedy5AEsA58TWd@kroah.com>
References: <ZKKedy5AEsA58TWd@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKKedy5AEsA58TWd@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.5-rc1
X-PR-Tracked-Commit-Id: e534755c9412be07f579acd2947401a9f87a33c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 868a9fd9480785952336e5f119e1f75877c423a8
Message-Id: <168841622134.1331.13026446918767637323.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jul 2023 20:30:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 12:09:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/868a9fd9480785952336e5f119e1f75877c423a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D14EB64DB
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jun 2023 18:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346477AbjFQSo3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Jun 2023 14:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346485AbjFQSo2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Jun 2023 14:44:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE511BC9;
        Sat, 17 Jun 2023 11:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F379C612B3;
        Sat, 17 Jun 2023 18:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 670FCC433C0;
        Sat, 17 Jun 2023 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687027466;
        bh=P0k4knBHGUY/wlxBwP+qX4c+Hx3kOSTKg3D+Dkp5we0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C2YlgCahbEX+L8RX0JuTmPwUPs2FimFZ84PfnmFEMbisD3gNSWlwEarwQhMO7LNs+
         9AeGc0r6HH9FUn2FNHVBxdRvX0hNltUwuUMD2KiVfn5WonAeTjEGhe8IShDjhFDrcN
         uNKDXcymGwT8PFZ46Rv9BZJGw0oiF4pjVJbKwXlU1NY8KMFcBVMSU5JIcm5GsraIwO
         RUPYbTOTNAnivXMpRRaoVUYDQ6DAIBcL6d+b6NMkf4dgFCEUySA8TSfi7lZEL457ra
         /3eon5jaXLd6GfQAFqd7c0Xw//4fDH4GghpZOwYMH9MEGTlKhydnugXL55vaPj8Aq6
         M/XYGTX2VyTLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50CFAC1614E;
        Sat, 17 Jun 2023 18:44:26 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZI25AEWr36a7coy5@kroah.com>
References: <ZI25AEWr36a7coy5@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZI25AEWr36a7coy5@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc7
X-PR-Tracked-Commit-Id: a82c3df955f8c1c726e4976527aa6ae924a67dd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c0eb44233122d076ca5c1ddf57807c82ecfb991
Message-Id: <168702746632.26928.10762846037591565013.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Jun 2023 18:44:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Sat, 17 Jun 2023 15:45:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c0eb44233122d076ca5c1ddf57807c82ecfb991

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

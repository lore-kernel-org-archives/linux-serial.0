Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2869C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 25 Feb 2022 20:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiBYUSR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbiBYUSM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Feb 2022 15:18:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5423252B26;
        Fri, 25 Feb 2022 12:17:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FFEC61852;
        Fri, 25 Feb 2022 20:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0496BC340E7;
        Fri, 25 Feb 2022 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645820258;
        bh=5qvoCDU5S4naYrvMp8RXmlcTtZhhXgIuJdrIdDTW3Yc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K6yTF2Lku+mrk9JfgXpbizOHIW690mXRCIZaJ5JOUetAHZk+9VvBqo+KEwcMaG8ik
         ordr7yn3fpaqsGqgtJbpsVBHi61k6+AoHLTiEmeK/XCFwDto0fsdwnXYgVMMqerKK/
         on96TYfJ23ZWhS+OuuzBHJxUL6ryhcxvwo/o0/U9NJX3M4XheUjz/Hsnq+X7YTjIGk
         rQPhhvXWRf4LezCfTtAeILRNWFmwquTuSPTZqov8AA2MvlKnSl1Og+d2GGilmN6PfJ
         L9BZCHwURg5PuNFiczkRNqsVG47qQ9AjXYyRPLiyXD6+bfZ9zvIBJLEbJiWXbY6xxv
         8nX0qqA51fs7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4630E6D453;
        Fri, 25 Feb 2022 20:17:37 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhjYIOQDvhJBBsIt@kroah.com>
References: <YhjYIOQDvhJBBsIt@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhjYIOQDvhJBBsIt@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.17-rc6
X-PR-Tracked-Commit-Id: eebb0f4e894f1e9577a56b337693d1051dd6ebfd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8fc3bb606d84ddaf26e31231d848600ae0eccec
Message-Id: <164582025793.12222.7780567241585377744.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 20:17:37 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 14:22:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8fc3bb606d84ddaf26e31231d848600ae0eccec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

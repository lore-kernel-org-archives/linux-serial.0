Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBA1C6AA
	for <linux-serial@vger.kernel.org>; Sat,  9 Dec 2023 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIwrUP+7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AD68C433C9;
	Sat,  9 Dec 2023 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702156277;
	bh=o5cnQLbIn7gCoU4KyY5lfptQg3sQ6pDCVQRZ6btaU+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tIwrUP+7k51xJfTbBe5fiEbRbs+eJ6j4owfTdImpnhFYQ4oSr2r5gB+uR8BhCyJtG
	 XvNa2MyiPBONN/3UQWPLMjjdQnuaVf4QMk7Cv7SIrTlykDxnhG2yDSHHMWlQXTkuRh
	 CN3WrWKHEFJEGDtwMpTLrjX9fPnFHwhGmUkCFjK3n33UuHlPb0lBxfbDcjNA61gBOi
	 N83/AOGye6OLKjLwKRvEw4Oi6Grirc62FSQl4o15y6FR/F3V6atzjiEZhOKkjcdzc7
	 GLyKGb/TADBGA9pJiDuQJxZuyw22YlaA+jiDEjegVqvCuv4l+29QA6PE91gs0bddJ+
	 Edc7I3iUO7oCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0412DC595C5;
	Sat,  9 Dec 2023 21:11:17 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.7-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZXRxWubSRJ4lGC1N@kroah.com>
References: <ZXRxWubSRJ4lGC1N@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZXRxWubSRJ4lGC1N@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.7-rc4
X-PR-Tracked-Commit-Id: e92fad024929c79460403acf946bc9c09ce5c3a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b5260904b7d2f55e8c4a6ac9f32e7387dc55a75
Message-Id: <170215627701.20711.2690821596404624329.pr-tracker-bot@kernel.org>
Date: Sat, 09 Dec 2023 21:11:17 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 9 Dec 2023 14:53:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b5260904b7d2f55e8c4a6ac9f32e7387dc55a75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

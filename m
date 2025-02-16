Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E81990D8;
	Sun, 16 Feb 2025 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739739741; cv=none; b=ip2V3qTETjyW5GAdcH+qBZ/XxLbH47GBjmmxduCvxbJ3uQKAANd2eeca1pZxtBThkiVSIistQLVH78JZaecOIQ+yxb+xImdJyCWoEig2cBjUnNMlXjLN6oSLaDapS9XJ183TDc/xAMtpB9eefzruemRd8Si4H5DDC+8Dm06Du44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739739741; c=relaxed/simple;
	bh=6gn10t08niW5du9FkD60G2A6LgOycB6LeR4LY70JFZo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t58Oae8ZVo45NXCRC6kXLL6fmzkjtufBsRGSHGih4vso2j+hS6li3bcaWyXoPZZXcmCk8T4FyA1tPoXZVuCebNehACtXSlVhAHouDu5eta/CFGMtQltLGORrvBqnnugwoBkPD4i6eH4Ox3t+uCPeaC4u7/YNwoghW3bCkH62QAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvEchBtl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvEchBtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE59C4CEDD;
	Sun, 16 Feb 2025 21:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739739741;
	bh=6gn10t08niW5du9FkD60G2A6LgOycB6LeR4LY70JFZo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hvEchBtlWpqUnMdoEM+ylIRjZzviySth9xFl6v86E9S0D2myxXilTWULxMO8APr9e
	 JBXYIBrYQl1pnuQxNqzUst4pCGLg8IinuXPcKq5s8JJELt67k6ioUkZArrItYraZ0p
	 PP0ckZdtiLYxmG9fGzAiwbuCLbuGzawuuw33YqDjW8/nWP3uH1Kq+zbFp/LS3kIYCZ
	 mSonfKowLeIceve/wpwf+JCCkJr+3oEa2/lH+jEEzX2Lar1rnxVpHPQfo+3zI1rkAH
	 mac6dQjyP3M1xDJ79Ivw7B5+kTGX7OR31Hgb0pHxKUisrxtHdVbaM/RmoWh4SyZw7k
	 jW9kUhy6iqXyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342E9380AA7F;
	Sun, 16 Feb 2025 21:02:52 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z7IAaY1o908PmAmC@kroah.com>
References: <Z7IAaY1o908PmAmC@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z7IAaY1o908PmAmC@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.14-rc3
X-PR-Tracked-Commit-Id: 9e512eaaf8f4008c44ede3dfc0fbc9d9c5118583
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56400391b1d312a14f912f36d2f04b0dba0d4a2f
Message-Id: <173973977068.2568330.1861664408233206207.pr-tracker-bot@kernel.org>
Date: Sun, 16 Feb 2025 21:02:50 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Feb 2025 16:12:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56400391b1d312a14f912f36d2f04b0dba0d4a2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

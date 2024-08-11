Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398371537B1;
	Sun, 11 Aug 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723395810; cv=none; b=T1zt1Nw32y4YKrhvSM1PvYcVnFYDuOCcOBo6UxFIQ5cDiNiYPIOhbWNwvSc9/bDSIfFA2R9J2Ke9fRicLVDF8zZe8g4vdoyivAwcDq7fT+AFiXYPodkQP6/mKFb3N+nE1dpoAYYG6hzWyR5zFDPtsezBfrkhKE1rf4lsfFfiaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723395810; c=relaxed/simple;
	bh=vo21wkgnQMImudQ2ab10RafjpPo/sa5PK3ES0w8mtGA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qWskJJmcXMMjx+bkZEengaBB+40zXzBFP6seRNcgt7LBinQivJySpaz2UJOjfg2IVhc0bZkjvl/7CpVnD8kMnAKLTxO7EK8ncNfcJMA2FHbF9WzgR2xz8MV92RK7lbUUNh94aPlLT7+Ua9h4XLHC8IxamsXeptcZ0TQ57E+S5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISnXW9Rk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISnXW9Rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D53C4AF0E;
	Sun, 11 Aug 2024 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723395810;
	bh=vo21wkgnQMImudQ2ab10RafjpPo/sa5PK3ES0w8mtGA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ISnXW9RkOq/8xMZ7su+ARf1HyRb6rLhmQytSm4g2KUuv+9ALcUb/OI2rNEl/mXRVi
	 u5GTemCBphyYWEbvknGBgfSUDNNqnb/6qoVPgSjUDBTVUrSfcXYKSJZl9faKmm09q3
	 yV0cU8ZnGehkgIZd7LrISXeL6IWOdzbonlQjqoO/AHiANotlSprvoiImrC/FbG5U8Q
	 z6KcprstbTol+v/dmr+4mDr1M0F54X7VwpfS3XBxXTmrCx9oGlWJtrwDPIvqG447jC
	 H7PaWkjp/rBA6FfXY6X8T9MLW28uoejkvusTk4o3LRFbO2nOtvrf8N5Cy5x4yR+OXw
	 96zJktuQqEYnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343D63823359;
	Sun, 11 Aug 2024 17:03:30 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zri7cUG-SZsEn2vY@kroah.com>
References: <Zri7cUG-SZsEn2vY@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zri7cUG-SZsEn2vY@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.11-rc3
X-PR-Tracked-Commit-Id: 6e20753da6bc651e02378a0cdb78f16c42098c88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42b34a8de31f1de4bffbf7cc5a2ea699af8dca8a
Message-Id: <172339580893.226577.14230668984977906293.pr-tracker-bot@kernel.org>
Date: Sun, 11 Aug 2024 17:03:28 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Aug 2024 15:24:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42b34a8de31f1de4bffbf7cc5a2ea699af8dca8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

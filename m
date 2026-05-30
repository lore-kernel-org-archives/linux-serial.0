Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D65349AF5;
	Sat, 30 May 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158217; cv=none; b=kFaMNw3hhWnTp6ucwaOpdyocRx4eU8fb/gSQp2XFAPMOp7HkBF0dkMRzTGS0Tw0UaOAhFutp2i+tMVcf6+yjpgq9Pc70BZMSLbuvRq1uQS0In5my9zX4Wf6jnkNLE3hS9DINsq1riWZy6Sj8U88aVTr5oX4zldw0KdiLLX0x8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158217; c=relaxed/simple;
	bh=H80q2/AIV/eYPLv9U/gOALNdM2clgJPFyRgelHd4ktU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gvNRBZeBAiZVI+vUzSHTVgOUvR7nJ4gSFx2A3Qa5ok4TLA9IIMkB4rz9pZVFsOrTO80SuU53EQc00A0ebMxfPR02aSfR3R56TMTZGmgvCYKXMicTIT7GOoKVOWinwExlYLWVScX8gUoLo5oSoFqTSk5BMx64b/vUeuKQgqRDPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNdcNnzI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNdcNnzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F001F00A03;
	Sat, 30 May 2026 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157817;
	bh=Hv88rvomQlCp58XwNToIsUPtPDjFBnqOXSFxwdr98wY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=BNdcNnzIuK9QEwyhvV7FhVxae1cSfq/PcnfkhFZZ7ldEPYqj5kK4OrYX376Tb7l3x
	 D+A95Uo74j+EQaQk+SI5lzhobAWrowRmhyEgiOstYu6ISg6nnK0MdHYulLfQC8BhjQ
	 m489hIrUv4CGKuqwjH9KlOP1CqKrMclvl1svfHr1K4WEKB71wDr7SiDBcOgBzetamJ
	 ZuT1iPyKwmrIM6Hk51jZSeF0TJMWsfTWY7yGI2jWxfXrNc9NznV2KRSSn4PEDgImZH
	 R2q53PC/kux/ud1ViKsl8HQXNODXkMgWne0uL5zY6ScuFfXbEjak/UcYZWGYWjhrKv
	 GXJ7H1szHgMsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569D1393021E;
	Sat, 30 May 2026 16:17:02 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ahrKEkbnYwF5TrRT@kroah.com>
References: <ahrKEkbnYwF5TrRT@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ahrKEkbnYwF5TrRT@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.1-rc6
X-PR-Tracked-Commit-Id: e4240d8845445d58b4b96f7066adfe175a61bd0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 495fb8dd7f1da991c5325f4a0a50d0b042f19523
Message-Id: <178015782092.2653560.2406984582081253789.pr-tracker-bot@kernel.org>
Date: Sat, 30 May 2026 16:17:00 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 May 2026 13:29:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/495fb8dd7f1da991c5325f4a0a50d0b042f19523

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

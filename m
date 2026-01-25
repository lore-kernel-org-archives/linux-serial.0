Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB982866;
	Sun, 25 Jan 2026 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769364361; cv=none; b=MGHbfLSp3fz4V9OTdBQ64prTtRyleLS3MTSmDheFT/y16FXx0tAooGVmpq4pf90obOF8RbhDpspyvFqGSS8O6eIqZ7tM9ZRX8oBxK0uuy5vNVfaEAiYd8wyhs6+FNwam1OysE9BH3PvoBlHtO4PFs6Ik+4MPIBeXzfJ4R/xwuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769364361; c=relaxed/simple;
	bh=M7nmExYBcr0XCgAKN2J5cILlFsVvtDlX7f9IuamaObk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bjeTDzbvw9zId9ixZqorgOodmsGHb1Beim24hcLaOQLGHnPE+t1VUOM9h+ts++XdsIsTy4sce05pFHI3535GgvD2K6kWX/Ue7Wd+HguBG1JITHnjLAajPBn/bl0SqJfEZcY+OEk8jbe1veCHq6xa5M1XSfaQcZwn+QxCYrlhQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXJjHGw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXJjHGw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2EEC4CEF1;
	Sun, 25 Jan 2026 18:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769364361;
	bh=M7nmExYBcr0XCgAKN2J5cILlFsVvtDlX7f9IuamaObk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QXJjHGw3zgRXi1Mn2Yia8VwhR7bucxtaLJHA0mysWll0MZ8QPLuHpaLfxKE5JvoRA
	 yh4cd2ifdy2gfRzqR2ut/Blg9gw08S9CrcOw4fM40jaIUuMa/MZrBJMzqZtv1sr2Ec
	 KYviBPWjyGzNVFNxBk7a/Kdf7dhLuVqpDarWGAZtY/kjjxyWKOW6noHeXrQjDlkn+w
	 KDWhAqJGnerHMwiIm0ZJKJWz/b2UWrGNMpsTIlMaZws+qcG+k08poafdI6HL/wOVZr
	 0+I5S1EqwOzphZGiPatn7H1xevPlXVZVd5GT6srFhGvB09LRmOeZ8ILlmFtM4yNXAh
	 MudCXu1DBlwdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8FDA3809A0D;
	Sun, 25 Jan 2026 18:05:57 +0000 (UTC)
Subject: Re: [GIT PULL] Serial driver fixes for 6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <aXY1f0U7rHgwl4bO@kroah.com>
References: <aXY1f0U7rHgwl4bO@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <aXY1f0U7rHgwl4bO@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.19-rc7
X-PR-Tracked-Commit-Id: 32f37e57583f869140cff445feedeea8a5fea986
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11de40c03cf0f84466f517cc4d58f02ff1ba30be
Message-Id: <176936435645.3553913.5648223834844090148.pr-tracker-bot@kernel.org>
Date: Sun, 25 Jan 2026 18:05:56 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 Jan 2026 16:23:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11de40c03cf0f84466f517cc4d58f02ff1ba30be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

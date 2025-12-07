Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A437275AF0;
	Sun,  7 Dec 2025 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765076610; cv=none; b=KBd/cIIkzD08j6+2dApollp8ubBCXDlDTqobykx+KoV/VHEzg46X1HLD/ZCAL41gr+IPz8QWfbmrXKLcKrwgR7ZxPfAdl10BxfvPXfwHyHSupxB8xByNDW8npjUfW1Ib2+YP4FfCTEdAuEicY8AU1NUNSUaFQ3ZYTixuwo2/mbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765076610; c=relaxed/simple;
	bh=oUFsss6W4O43yhSUWNea8tWf1mUsBXugaVOX1WS1TJw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qyWUuTFQla4o1RZDBOm3fxRapcHC8hvGQpginHxQhC0jnuLEDh54agtVwrXUXsFlLzaXWKjmDG2MFlgv+NanGl4dp7YW2diHbC/xXuBJoYxrSi8Gvq5udtmE0IaNghH/clzzFf6FBKKUK6QBLD+JBrnv3D1LkUKGF2ujkGfhIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+BPVIVB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+BPVIVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7F5C4CEF5;
	Sun,  7 Dec 2025 03:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765076610;
	bh=oUFsss6W4O43yhSUWNea8tWf1mUsBXugaVOX1WS1TJw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=l+BPVIVBUxvbxOepaOpgV/yUeZk42UWep4d3TztSHjXCn3x2SRSmuREKN02nJqYvO
	 8YgmzEIGJhkqicxBGJ2dR2BiRQ5Xd8+ff83nns5mdfdr1rMteDYSzMPkaHhdUBm2/B
	 TkMV6nPRrNl9ehG/iaqh6Ym7QsGtemoq5fWvIHidctaa3yNJBhsAEh+6PqZ1GtDPUe
	 r+0R2o/8DD4zaXfvrO83HP4kKL8eJ3WSpIrOC831eIYbEeO8TJqwhWUdpct7ejuCsq
	 nw+g6rWgIce6AZHw3bMyDMHsCwjwkeHRz7TQ2FmMHtLNE6ostPa9w8vLbeDYz2dArL
	 uA1T5flKXOb6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28EE3808200;
	Sun,  7 Dec 2025 03:00:27 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aTTOTbUu7dkL07S3@kroah.com>
References: <aTTOTbUu7dkL07S3@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aTTOTbUu7dkL07S3@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.19-rc1
X-PR-Tracked-Commit-Id: 75a9f4c54770f062f4b3813a83667452b326dda3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edf602a17b03e6bca31c48f34ac8fc3341503ac1
Message-Id: <176507642644.2278937.17159289305180767943.pr-tracker-bot@kernel.org>
Date: Sun, 07 Dec 2025 03:00:26 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Dec 2025 09:46:05 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edf602a17b03e6bca31c48f34ac8fc3341503ac1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

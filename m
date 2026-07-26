Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AD233937;
	Sun, 26 Jul 2026 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096047; cv=none; b=gB6+ffbvBVFcqXWoAFIvYVudZnHwIY7Ar+3wMqVQ65bTq+inAXOd30gsidjC0bPSLLvuIBiLRywdvRSRAj/4bpCtIDeuUyd6eVzUDhpdhJ/TBOUZAL5SCUY1Iqw9dN/70mPexKifIfPBJArGpB21R9hEstRGaEX/6oM5H5oKAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096047; c=relaxed/simple;
	bh=Mnyjbyob0Ep3fq69JHkJt8R8nKJdy1rwjJSYHVAZE7E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qaDM2+mOKjPrLb2XxNucYa8n8OKTY7hZWVtp4ofXQXQaSAHouMSNgtCMJu9nwn9yFf8bYirLj0GhpquZnylGfVkVGBdnvdRQLn/wo5X8w/gXUykEUYyChJHgYzEuRHEwjRXY12SvOZTi1CgxN+OMji/h4XhcqHnT+GuNFPX+reU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6HSTiT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6HSTiT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A5A1F00A3A;
	Sun, 26 Jul 2026 20:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785096045;
	bh=Uac/+cMuTAN0WGKT8+I9K+9jbjngYb2JFkPJoRu/PX0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=P6HSTiT8C2Cqhnc2HeaQnQamWlmND9mtKNz5D7n7dKbeKkGQbOqGyvXNQw65PR+WQ
	 mlSQv8ujcuvvRSx4ATXHW68iMhr9arT1wIQGxKpe+a2T6qlDsgsQwANMtlj39unxQV
	 bv8U2qlqiX5Sr2tDvK7sz5+9pqLkQoqSqw+R6SdnqTCdhSXwND3Sjrco283zIhY2ks
	 3JzCpBLPOqalliRpKjGoylH95VdYgewoV/nzViGzZN1AVWC1rFkBKflqDkEtQtJDHY
	 uP7NM7CT1qbVLf9+EUtI3FDM6OihEPDSoDF3ICgcXxnSWXi9evNwtFw9HPoCWL3CsV
	 0lND0LSKEE7BA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D094E38119F4;
	Sun, 26 Jul 2026 20:00:12 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <amYFJ1HX82HOiPjx@kroah.com>
References: <amYFJ1HX82HOiPjx@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <amYFJ1HX82HOiPjx@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc5
X-PR-Tracked-Commit-Id: af071d9e07e57cfff239e8d09d2f3b05ebc9c667
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d0a01cad2cdf06511c89d594f96f46a1887959e
Message-Id: <178509601255.3839415.18379940749218465336.pr-tracker-bot@kernel.org>
Date: Sun, 26 Jul 2026 20:00:12 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Jul 2026 15:01:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d0a01cad2cdf06511c89d594f96f46a1887959e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

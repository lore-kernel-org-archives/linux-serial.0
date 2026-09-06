Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269F3B3BE2;
	Sun,  6 Sep 2026 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718350; cv=none; b=rovoV2MYFldGOYBgEJC2SSbjJnnXKWKzlOmzVKru/falZdosCOn57MnyjhO9+4HdUYb7/bBOwv4YILTTgZirm0qP3ZxGGbUVHW/yZJZ7Ep5agvzRHu4EpMozynbjQMgny/8P7/UCRY2vMzAu6xTYGzSp10MizRo84rLmEEY3R6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718350; c=relaxed/simple;
	bh=op39vpbfFM1NxqboAii3eoj53EgElNq4pfWgnTnjBY8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eNg9TdnjFA+iIQ2KqJPtqgdZFh5ZIrsbQyKbrbtjT0YXc2bvgVnQTv6CFY5T8W4LAL6DIJboqCTy9QWAttfVDJcn7mHP1tv9D1HLRJ7K7le4tPmy2ciCmcOsnLjWLXvQ+AIZ4SXNG7BMjE2Q0gEaSZRY3OPbdDHchFrILnocpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA9yFpxz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA9yFpxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEC21F00A3D;
	Sun,  6 Sep 2026 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788718349;
	bh=XaElenom3MZeCTYsCO1t0hhs4GO3sAGEPTVxrhIJrbA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=CA9yFpxzDA63IX8+zQnLERdWW+BThRu0L8ThJPrczYdP1h+Hp0thX7iV3d4RNWD6t
	 kXSyDhkXqtKFTyx/UzrlGBUSwWnMAMUmF+Zh4P14n38I1ER4FtaCB7pmvB2+hsvOZC
	 Ppo6WmUrDMiofXUvuJ5eCbHF+CnI68YWZAhqevlNV2gI/MMgHH8NZwiu5C9jXG1Sa6
	 edT4+DKVyycJw6UBdtF1tikOutQDmvmoJXAUutg6zl5mZX2ddYerNicb0gAKkQV071
	 H2JbCtfGVPF3uhnzGkggzLnw/f4WzXhMwu4n5Kp1UaFiwB0ZLktjM7auims5bBaBoq
	 uzbMNd7Q+dSaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09613926249;
	Sun,  6 Sep 2026 18:11:29 +0000 (UTC)
Subject: Re: [GIT PULL] virtio driver fix for 7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ap00YPFzE_T6B5Dh@kroah.com>
References: <ap00YPFzE_T6B5Dh@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ap00YPFzE_T6B5Dh@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.3-rc2
X-PR-Tracked-Commit-Id: b144dc5a24149ba9a0cb2197001973a74b8c93b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3cbb9af7242873aae6fc2b7e8a991101a322201
Message-Id: <178871828840.1639575.5687831995294218028.pr-tracker-bot@kernel.org>
Date: Sun, 06 Sep 2026 18:11:28 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 6 Sep 2026 11:37:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3cbb9af7242873aae6fc2b7e8a991101a322201

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

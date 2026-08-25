Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48343CEBA7;
	Tue, 25 Aug 2026 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687501; cv=none; b=YeHp1OVekQNDEoVsn6SUM3Ie3+5hIFlvFGpR1hH2i5LrTx8zv64GKpsQnBmYnSRfTZk177LG0XQ7A10WbxD/RIC++CyidTv6SGm9e3QjtfAyVP7LaWD6aIzAPYFviWwbsxcoBQY/ulF0u8JLiorx9cHQY4GxjWHB5lUghuK7Buo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687501; c=relaxed/simple;
	bh=YhLXqcnI0mghAKBy5A2GhF2u5olZ7iNXctTWzdQMaRE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p7xhL47VT+iUlUi53orF4v2b1zg86ZfAnpQ0dbortIQthjk4m0gGR3HM25waNUm7JwTklM8662jbhW42ofQYlfM5F8+y3IsgyZuZkxKafMswOpJflqbRI9/tQkt7zEXmdFhLnj/uXKwQVWuUvRRUf75yvckGw92JzoG8K7FRsWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e31FihrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e31FihrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5321F000E9;
	Tue, 25 Aug 2026 19:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687496;
	bh=32feQu5FawmlCE4SWo5H3zx4s/dZ4itQp9NktKWS8XM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=e31FihrWeaa9msh4rFIVkirqyE2H27bWTuJEjT35rme3J3PEWZvoq5560ANfT6Fxh
	 gfFUOtop/jM8Z5xyQnv8rZdEiPO5BZ9Hx/G3nEpevo11XnmuT+LQj4lxF/vT4nGfZs
	 rfCeMxAu/OcMitDlC6ZoydgffVdXGaOiYr1UdNS1xJyY9PXzO7ulVncC/TtZfsBPrC
	 gWfZR+lS94LK0dF3haOrmqJD8hH8gjVOX38yULg03ll6jMc/VGALifq6sLvzO4Chw+
	 Z4c4JZXsUMyE+SzZ8PUqlbiGKNVFvFaGP7hCpxLXQzcCimtDTbX3iyGk9qqPvl2PHU
	 WKTSgLzDLg7FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398E39253CD;
	Tue, 25 Aug 2026 19:50:44 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver updates for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ao2masQJ22TNPd12@kroah.com>
References: <ao2masQJ22TNPd12@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ao2masQJ22TNPd12@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.3-rc1
X-PR-Tracked-Commit-Id: 8b0b29fdcb47907ae0296b8fe829e918e05e300f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70f5376dbdefa675adec0800e9f21f20a0dc0cbd
Message-Id: <178768744337.4034242.8069319537047542582.pr-tracker-bot@kernel.org>
Date: Tue, 25 Aug 2026 19:50:43 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Aug 2026 16:27:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70f5376dbdefa675adec0800e9f21f20a0dc0cbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

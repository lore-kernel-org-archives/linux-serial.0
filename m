Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC956470;
	Sun, 16 Jun 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562273; cv=none; b=oXDUxkAY+CwEV2seojgWuaaCVfi+aTwLTx0jBsXEG1h5JLxCPxW6WImqT23XcmjdXJ9BvKTTClaERYATegzN707x9MhNwXQqgX87xW4DJ3zyq6kgp76+GlwOFz/SIcS308WiX9CEmR724qYu06ywGn8vQIXA27u8DfMAuRj3cq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562273; c=relaxed/simple;
	bh=938Nst/LztkdP8+hEDSL5cX1ce+xAKdd5lElIY/J++A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cpXJ3zV0Ny6z+3WpdvPMVAPYabmuKMHv1pGsz/0vzYrbUeGWBpTL0pgr/rlRH0PnDKc8NLhpYF4TOeELlr8rwd6WO7KfIs9BEuktjlieVp6Zok5fjwLd2ZhRZgJtt/dKV6BxbfIQWKaM4Wnhyszt05jao3SskMNx5WNLB30u7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6dhLEbF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6dhLEbF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 064E5C4AF4D;
	Sun, 16 Jun 2024 18:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718562273;
	bh=938Nst/LztkdP8+hEDSL5cX1ce+xAKdd5lElIY/J++A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a6dhLEbF2qlLBYqth3CCP1CQSHL3qbp8XUU6fJIYLebkVV86ogU/qq8zWDF1+JEEi
	 OlGwjOrGcKZJCoXXno8cW2vAHguai9dqIxSqrF1EQkgUkErunNXq/dnCbZIBFPXFkW
	 i8TYb2IPDFup14hoMC9ya5ODeqSEeuttnMhBrFRSLeY1defRrLRgVZz5iZGlK9GSPW
	 FiJCaSvw5hCR1XtRQDnQY3GholG1R651sbj1vECnCcmhZ8EVB4LYezsQW/GNtyv3zt
	 62Biymk2gUIsORyZEDaaE16ftlWOeRGDEJtBJRQ7NvNQ13DHwjXU6leYHDr46C5Tdh
	 CVYVopCDtA1RQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0F8BC43612;
	Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zm7Dx7SLTxsUt1u6@kroah.com>
References: <Zm7Dx7SLTxsUt1u6@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zm7Dx7SLTxsUt1u6@kroah.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc4
X-PR-Tracked-Commit-Id: ae01e52da244af5d650378ada1bfd2d946dc1b45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6efc63a843160fe6a1b55ec2312e155555b3060b
Message-Id: <171856227298.1143.9982410036682198830.pr-tracker-bot@kernel.org>
Date: Sun, 16 Jun 2024 18:24:32 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Jun 2024 12:51:51 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6efc63a843160fe6a1b55ec2312e155555b3060b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083F2D97AA;
	Fri, 20 Mar 2026 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033976; cv=none; b=XuAO8DmHBXFb7UFy0gVmSD3URUAF98842l/AXVx42styCVnMh2jP166mgELHzHYPEz3T8OR5ilKmDXTrKAHvWAfEcV0CmEtQaSxNFR/uQkHL2wgcbndzxXZhVnP0e/78ibrutcS5J3YcnIW2JcRDPvioRD1SgeP90EY0caSHbYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033976; c=relaxed/simple;
	bh=aXGXKLri4SdALi/sRu/T3gU2u9I2/oYI6B3MQGmyc7A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jL4EfUfJS3g7c3tOLcnMCw2wd2zE0jjh3seEi40wrvxlChw9+87zjvvp6FiO5zgL1GxS2Ix7/+jywxsHUMHOJkIqj1mFSb76AagqEM2RabBOs7vrSegJsV2MLVeHoWje7ws1VXOecqsyc6AKRijG6WeRL7upCpMYtc88o/e31QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFS7Pn4d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFS7Pn4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BE3C4CEF7;
	Fri, 20 Mar 2026 19:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774033976;
	bh=aXGXKLri4SdALi/sRu/T3gU2u9I2/oYI6B3MQGmyc7A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KFS7Pn4dlx7XoOgFppH7PfJ3CWhZyFmEwPsGs+Uo3NgqVxJ6NQ92iZmFUSC4iRJ/d
	 g030DIUx80xZAGva1MrRrYMNe37VaHC2nz+Xf1TRjbsGruJ4qb81qNuWK/cDja92V/
	 p+6+AT8YFQ4WU+rIMs3Bp/zGlDm3j/cKiyLdhRC12T7GcL9VHVstq4VFnM27ALqSFH
	 nVIXxOaUnRKS3D2sKv7smx+tOeg3+Slsf4lLGorovHmPGjF3tTFyacWXnQ+BlgVXVx
	 Uijo/cFYMia/eXxuNapvk6fydhu1nQXdTQ56wQP2vjxlnpD5+enPE8MdHea6/mIukY
	 02wS9B0ELaZ/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 033793808200;
	Fri, 20 Mar 2026 19:12:48 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ab2DKnELM8LPfew8@kroah.com>
References: <ab2DKnELM8LPfew8@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ab2DKnELM8LPfew8@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.0-rc5
X-PR-Tracked-Commit-Id: 5eb608319bb56464674a71b4a66ea65c6c435d64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d46d5c8383442ae44c3b782f87719990ac67925b
Message-Id: <177403396669.2624637.6924498127292388704.pr-tracker-bot@kernel.org>
Date: Fri, 20 Mar 2026 19:12:46 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Mar 2026 18:26:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d46d5c8383442ae44c3b782f87719990ac67925b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

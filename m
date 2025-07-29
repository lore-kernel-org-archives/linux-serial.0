Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F4A255F53;
	Tue, 29 Jul 2025 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814438; cv=none; b=uGiiPYKIMo0p0hMkBaAIhx8AWWVmbhALDRzxkfE8CoQ/viwAxp1PwxucNgoC+K+f40GDqXTd8hR1rmXvtiq/FL4K3Sc+VWKKGiJlEqU05A/54l680cvH2YWPkG3M1yhE1tXCM9xSF5AafB5fQaYbIHrMDlh+Gh0pcRaphwg2QSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814438; c=relaxed/simple;
	bh=6bAUhSY3Wd2BbujJQDkjqbZr/M/UiO0jcfqeCSdXAko=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AedqacYOGQeTQBFeAEAWpbsgPWk/Smv7VTNUrmdJ/VB61CWWwi9HYMVZOWCGimIwBW+KZ6lQcID6AjFun/UP+ObasHgQkfYfqB3tB23zPUErol4TV9DaDgmdSzVtwB8HO4fS7JwOGBPsNxXQkuh24pSaW4+BQ4GRg1iyNTfSz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITFOR1G8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITFOR1G8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0B7C4CEF6;
	Tue, 29 Jul 2025 18:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814438;
	bh=6bAUhSY3Wd2BbujJQDkjqbZr/M/UiO0jcfqeCSdXAko=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ITFOR1G8LqNkUQ71DXZXpZTsQwzL7QLC/ANGCuHyUhoNwnACzJmgpT8z0zGGwemf4
	 5tR2I8QSSUR2jkKeoM3ssRiE6k2PWOshNc7WnKjB76l2dKCAtFeKoJg/goWiHnYfbl
	 f5nRQlcWqQWyF4XeC64LYsq9WRPgWcMaM6zCFLuh1s65xLjV9l1+jNqNUFvUjh7t13
	 Ix3y/aJZ2cVNAKA7dTEBhWQP1i4jtFwvDvIMLYdVPtQ40q2aHqqSNfPhFgpaCiCeAx
	 PmDwp2pISPcoC+PryFdfcSAr20DUaMEF0vzwOjDe0lZTYKYUnyrsCmDdqus1x1lACU
	 mRMI8KUJOi5RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 336F8383BF61;
	Tue, 29 Jul 2025 18:40:56 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver updates for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIeauLNt3kwvH2TM@kroah.com>
References: <aIeauLNt3kwvH2TM@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIeauLNt3kwvH2TM@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.17-rc1
X-PR-Tracked-Commit-Id: 57b4ca42359c63ad61548431c184a7d63efbd0b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91e60731dd605c5d6bab8b9ccac886da1780d5ca
Message-Id: <175381445490.1585410.4944514762760428615.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 18:40:54 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 17:43:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91e60731dd605c5d6bab8b9ccac886da1780d5ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

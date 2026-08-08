Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03243812E9;
	Sat,  8 Aug 2026 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786232778; cv=none; b=bYoCeWVOOBycu+NzXIdOMLhF2H6sLXdBCHLFJrbB9TRIDC6hSf5/BG18vtURqXu0z0pVTFy9kFl4gPlsPaI07EuWZmZ7SOErZbDnqm+BDyKC2Dhg8Di7Goo6VbFYfM2kUNHwtAvcBxoOWVueGEU7nqD/rIysEicFtXO6rkQQqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786232778; c=relaxed/simple;
	bh=Su9rhJEx2mYs3jRd5JtVLlIkWSJLUeGuzl/ZOhH3Zw8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zhzv/Hoii3xnyHnk12oohbit9K2qcrigkK1vjs44aG97tda6YGlh+pKzvzyykCWX9Mnfdb2kgJLJJmVefLTF2BX++v/Ylchd09faJmiQOpiKJ2aspMf3maqvjkL/nbH7HDzREXAGCGls87lm7XT7F3oVwMv50qfgEey1zPP0v1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijpKALfI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijpKALfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99401F00A3A;
	Sat,  8 Aug 2026 23:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786232776;
	bh=fTeEjdnpZaNCuF/R1m/Ya9bf6UB+X+Z4aSQz2t66Hk8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ijpKALfIeu1UMuSCrSmaHd3xqI942ob+XcKKVWkqTnJ4xmTr6z72ynv4l2mdEQaGE
	 1wLQls+Hi/AlkGd8Duog8LZHZ5xWckT3U3V6JuvdbzFhy3ob66DibsISITlpgLciTY
	 37AhI9uLxmONli0Yk6gcZkYtkegl1qWi2lkiZ62pyQlPld/piA+h1aKeraAd+ZHOAR
	 aYLy7fHun0NcX208H8A5BTx3YwBOWKvhyqQJRZxRMEObztVS8ZSVlPj2mwwK+WbmKM
	 13OnWbvrYHPFMAac6kspWTFGwASJdSsUJ6ML9135Hcnl4EVjSRO0ytzyteLMtwp5i6
	 LX7dt3z5sG6EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AF4380CFFB;
	Sat,  8 Aug 2026 23:45:35 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <andL-wLl02Hoj3BL@kroah.com>
References: <andL-wLl02Hoj3BL@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <andL-wLl02Hoj3BL@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc7
X-PR-Tracked-Commit-Id: 440915499231e9db1c361aa45bb702e8fd3b4a32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4836b67bad62f10e142f8dd71e67473778de518
Message-Id: <178623273468.2786584.7205595137381853425.pr-tracker-bot@kernel.org>
Date: Sat, 08 Aug 2026 23:45:34 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Aug 2026 17:32:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4836b67bad62f10e142f8dd71e67473778de518

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

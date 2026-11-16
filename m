Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849417;
	b=J/2l7oZ164NZFNucKJcNoENDKo1QKxV0KhdeRnyduoHuwDWlPWW5yGAiNu66EQuM3HBh
	 9N9Qr5S15m0TShLGxPA4ZywxY4o58AxAUWyjIVBbOAZ4LcB94osfqFffHktrBd8C448+k
	 8MhIndUHkQzSSVewKMzSrrpYzZZdOI+nZa/DBKhO69gmKJCZMaaubOrEJkuXwp88VGH73
	 g36S4Ms0DBvITcjWGNBk0GT0NIkNK7OfwVrcsI12FF18+4pCOhmFVY0V74dp9aDeT4kfx
	 Kqh6D9YTkgBA4Vm6Nymk2ukTSHPNGCbTkkaeVYm/uehkGKDfHkQQhhSZZO8GPdvY5zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849417;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=hVeEwjcOOj5BC/QfreW3323ZuTtHgj3cknihs7wj+GA=;
	b=TRqOIzoFkr5+Kb8rYr3CvQrx4itkqOxY+Fp0eKv2WIJn1BPoSLY+oH9GaHsV7zaO0fqc
	 nXChYSz3Mgn8s1f4ym+vscQMYnwJ5RQ7Uj6TX1P8D7tExYhPlmddi6HfUkwjqxPu/rfdc
	 qjpEU8ids+necMcZ8JfieRYf21zwMfrO0mtOj+td02CGgCHqZSdUmN2KjpQznYdNRIooN
	 hmmmuoeJidt1tlJVP6yWR1OHnRrkxe+2nbJePC+hpYACExEDmf0bQBawLrfv40BfRaNhI
	 DF7jwxPJG/4IFPjJEiT63CAt6LEtJZe3j687+vv9ccvovIxjpmhtKP5ainqcWOQ4nPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7RzGSGF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C5606A337;
	Mon, 16 Nov 2026 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7RzGSGF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C441F000D3;
	Mon, 16 Nov 2026 17:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849417;
	bh=hVeEwjcOOj5BC/QfreW3323ZuTtHgj3cknihs7wj+GA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=k7RzGSGFnMrAILN27eOAOW8VGm2k6GtErAGSvgp3WmwQbL8Uj+ilZ9768ves+vIXT
	 rGCPiFiy5dYzRlpxJg5D784EAGjdXN8BhfwlVNqb1xznGVpV+gDctT6j/Uwrr1nJ31
	 +3jR2yofXgiavg4sRLzsQgEtD4Dt7CAa3NU5opSJkabHm1zbj03l93Chxm1jY/fRk4
	 7n7nJCRNsHeyA6KpOwyiJ8X7FneKfa5rLWL+QUTgRiA1TqNVthAPoaGeZKyfFjk7ZW
	 O/P+kKA6V48++1amZTcV7SDx8LlbCSAxE+pxNvjqn9vLsq0uuHlYKgQ8d5e0UTjU17
	 jgHc60vjHpiWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7739A391AFAE;
	Mon, 16 Nov 2026 17:16:57 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <avrfbLonPT9vBmMC@kroah.com>
References: <avrfbLonPT9vBmMC@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <avrfbLonPT9vBmMC@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.4-rc4
X-PR-Tracked-Commit-Id: eedf2cf3505c1562a2fb24f8b997056f023d242b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6793a9e2a3c280bb7c6c7d39be271e2f57aa2bb
Message-Id: <179484941615.3777341.6410375985927199383.pr-tracker-bot@kernel.org>
Date: Mon, 16 Nov 2026 17:16:56 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 16 Nov 2026 11:48:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6793a9e2a3c280bb7c6c7d39be271e2f57aa2bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

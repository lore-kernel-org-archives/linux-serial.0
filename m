Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7DD178CC3;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800350; cv=none; b=caz9Bpz6q33mi2eMiZhH4Xya07Gg52q+VRsnGcyZZ+Ily7ZAWTf1LECj2dBj0vuA1OghYFgJeHbtv7Cn+/HG3/u/j3ELIcC7Xk+mKW94zMB25819lNwSJltyyig3sQchK+djckwr8NufR6cCGjXtgXYoUX4yqDB21R39HZjOeNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800350; c=relaxed/simple;
	bh=DIuKMhvoUzcjDYRjoaWwhs8QIMJ6Yag2oR43O8xrLjA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ab65t4S1ki/DNYZSX7BoD5AXlrFk3WGxJFfjSCUtnZZD59hKudBoOyNd0iy2zVElDzKoyUDk32zthLzGv70nvtcbzimpFMK/TEwexVjKWh0WV7zvBjbhQadRAQgtwUgotzYmxAfki95Dma0MQ2kpCBPna33xxBgbCDr8hLXGz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBUcz3k6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBUcz3k6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 218A2C4AF0A;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720800350;
	bh=DIuKMhvoUzcjDYRjoaWwhs8QIMJ6Yag2oR43O8xrLjA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DBUcz3k6DsdzW8XdjldXeeYo+H4D+usq+a/X9uLKcKCUUY0ejlZgTmNlmx0aAhXUA
	 NSHkusRjumuecy3xK2kdqJXh7z2nSUKLAXvpKxLQYvzTaQgpEWw9BQSIL4dOQpgAwo
	 9XHPGpxhvz5WpSV9i0AXQ1MHEtKrHAh8jGPULmRMblu5024umLFEAnALmHdAv/87cO
	 y+w96iGEac/pZxPqJJSIyYH4IGR/1uVuRocJMp0Zy+NKZptssJfpl98nyGqis7AcYK
	 w3I2IQcg1wrKFls1jbWdth2zhbE1nhhG3+Omk2bEEAritL6+BduyCIocEAbzRcHq7j
	 xAp1Nem0J5Vgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19530DAE95C;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 6.10-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpEIPXujV_586zPp@kroah.com>
References: <ZpEIPXujV_586zPp@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpEIPXujV_586zPp@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-final
X-PR-Tracked-Commit-Id: 2ac33975abda6921896e52372aec2be2cf51ab37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1cb67bcc2165c24ad26c5786771cca9c91a1fedf
Message-Id: <172080035009.10368.2070496630330068752.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jul 2024 16:05:50 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 12:41:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1cb67bcc2165c24ad26c5786771cca9c91a1fedf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

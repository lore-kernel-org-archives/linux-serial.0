Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CAD335A5;
	Sat, 20 Jul 2024 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433937; cv=none; b=K68u4k475voevK81RK+JllX1YJnMBr8GETGRgfaqPHvroL4NL+qIXCoWtEwrvvz4qoolfmo1OzQCsxYQN0fKtR0OTE1Zgx6MouQZx5rGNUNVwMwirKnB5SXgejYChxklOWqY9UA+57fEk/85gQV8hHhU3815gxONM5G6tlK7SaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433937; c=relaxed/simple;
	bh=mG1122Azs2QNJgMKAsr4KTLQGSQBv26G9Sl2LfUJ/a0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lB/EpXowR+rsdq7pMVAHm8R9crAbjcJit7swxb8oGsk0WfEgOqBt3qOYRit6spotK3QfBlZ7FtJu1ZhI1+37UieO1bEe5rIjI4R7CCdaO7f7CY6nImG8sMWCbSpCqiKkyoGkkcobLEdc13Fj6z0z1wD6+uN0+eTOnuojEDcIg0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlsVuA/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlsVuA/L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E296C32782;
	Sat, 20 Jul 2024 00:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721433937;
	bh=mG1122Azs2QNJgMKAsr4KTLQGSQBv26G9Sl2LfUJ/a0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VlsVuA/LaQCHx0DcKpqucY6mFabvE4q1qMC5CNJ/VYhuIChv0xCXRgu39NJ2UctQA
	 HNDyqOAsp1Rh/Q79pmNdepqIxHkoyK9jm1ICDejTlF/VFH1PpIvtSqSwIlNQbnoE/H
	 x9ob5trJMYQMli2vuHuR9qdgtclnlnNByb50y8j2E9k/b7Zrn3NxCRE7hHSLRCMJ04
	 /raiYQyPyI6g2pClTzdyqmrqreg2fBzT1XFQaQ318BcrEHTcXMdMM8vmXI+gmEucAA
	 3dByC/FfydXbR0eyt7EKjpnbP3iPSr5f6dBwvxo0shi3h8d6dM+KdiSMywVQHP4fII
	 eovT9ILUSUaTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8476DC4332E;
	Sat, 20 Jul 2024 00:05:37 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZppbNwwYDV4y0Leg@kroah.com>
References: <ZppbNwwYDV4y0Leg@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZppbNwwYDV4y0Leg@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.11-rc1
X-PR-Tracked-Commit-Id: 17199dfccd4b7f7e0c059ef43bef6e0078423476
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aba9753c0677e860f982edff98c7fe5a2b97758c
Message-Id: <172143393753.25682.16623743476049229842.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jul 2024 00:05:37 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 14:25:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aba9753c0677e860f982edff98c7fe5a2b97758c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

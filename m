Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2983198A02;
	Sun, 20 Oct 2024 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729455382; cv=none; b=fJB9Li4qnxQERM7QTAJiFFxEQkHEHD4q57nihsBZzMkiJKLQW0+LnmY/gjWz/h26QBjCE36hdukqWNT54idAV/U9Xw0fmDaGMHZKSoU72xXhWR8HepytA7rJRBkJilkd43Gbjidfd8/sYPAaXJYq6kyICC0szVHntW+9QubgEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729455382; c=relaxed/simple;
	bh=y7Y008NpstHaa0kD3FgiR84VYfOFAAd5r9zovRRwofY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=StIWHs75KNCGRdphZ57IVlAd/KbXNrkKBkKnffq+Y3RzGCa30f0Wq2srcHVuP9byy6+vdD9f1aanqCzNvZ1OGxbwxnuSYr5B9JKqpdbUgahk0/s2a1DQxx9mEmTruIxpG/W5oK8C3EK2B+QfxcBqlCmB02SBZO+jiYbt1FdGGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca9VSl9t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca9VSl9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFB1C4CECD;
	Sun, 20 Oct 2024 20:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729455381;
	bh=y7Y008NpstHaa0kD3FgiR84VYfOFAAd5r9zovRRwofY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ca9VSl9tFu9qiPTLcS8GOQmHF2bnsQ3t53IkxMAMfCfcV4jvr6XK0+47Ee50JNO4x
	 LpUMyKduUgX6aJdRDesunyKrL8yxSN+i/cyUywRmqSPoJIEK0P1UaMZVOD2/IV7sPd
	 sSSGM4VWY9bIvOB7mFKoNZyhwmQuzOK0Gj9YdjKiqk7yfepz2/nkFsSXTNLxGpyTbi
	 Bo+9B5ZxjTZ+C8YlUPvKHV+UMMJdjP40MBpIO6QL0sBNepFbptkxKUZM7czJ7lbY05
	 pGgh2JGzrf5/JboQP8GsAgoU9HT8UHbQiUv4cvORdGufq4TuI2YqsnI0uLBGObYeka
	 xkhapE7T5afHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB64B3805CC0;
	Sun, 20 Oct 2024 20:16:28 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZxUHkmIo91tAeyFl@kroah.com>
References: <ZxUHkmIo91tAeyFl@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZxUHkmIo91tAeyFl@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.12-rc4
X-PR-Tracked-Commit-Id: be847a3a8d4ec4bf270c2455376d11f2de61bfb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c01ac4b9440aa85374536075b1d61af961c3e567
Message-Id: <172945538761.3637315.6100337844265064267.pr-tracker-bot@kernel.org>
Date: Sun, 20 Oct 2024 20:16:27 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Oct 2024 15:37:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c01ac4b9440aa85374536075b1d61af961c3e567

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

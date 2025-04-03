Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1261448E0;
	Thu,  3 Apr 2025 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743643724; cv=none; b=bHvjlzfP3n6YfWht8cGmxSfqm1Ue0i7zT6FqMW4t9EaZB3M2nBI9nEuCrMvXfHqr8St4oOUOdEOpRrB4gUCP8ufCO02kaFzjjtRznM05ZsdDMoGDmVGz/AtuPAsxhSluFcbWjw/6/jc/WAzu01I1OpVVmijCOjwqW7DDmItXtrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743643724; c=relaxed/simple;
	bh=oLqC5fath1ZrEqaF0LjhE3KORxBA6Cvvb72vvPsS9uo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W3O0P2y07zCy+0AmMuI3uPPvVd0jRhPU+6CF9aa9IGUiAr2Aupq/mvrOcSAhB6VVt2nRtMQ/06gBv19jz/Yv9QffP93Izzsn1p13bsN6AJv9qeE1QURJkttLszbEY7k8zL7MU4RJx6bNO/MsV+l20xdZehNJUkOkKTKbc5w/Wxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIZoVMmg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIZoVMmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4966CC4CEDD;
	Thu,  3 Apr 2025 01:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743643724;
	bh=oLqC5fath1ZrEqaF0LjhE3KORxBA6Cvvb72vvPsS9uo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mIZoVMmgfjZV/p/K+l/e/qBbghQgkoWe1lQBmdBmBbGSOz3oj9FxZ2XqBioyRCAuR
	 BmJ2rd9l4/4cCFSCcI+r6ro1R+4bIYc7ApV1aXWlYxamua6R/n0YyZdCEMA8bO8AXM
	 DmO5Gc83SbXT6YkqmC6itDZiXXE4MFg0lMCEme8YdTyuCPC2bc78ukEePDyHneCD5z
	 JfD/+W2UfTaiEnUBJWzzEAzowWeHG88nktmr9oemIR7MWbTjyHgx7L/RzQI05gFikw
	 KDhxC+4JMRzUj0g2UelFFc88kNtTxPBp3FaL43KctpM9YN5a0mY6jMI2ZgY4KYR7Dl
	 VLt3Ogxxh5O+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC4380CEF1;
	Thu,  3 Apr 2025 01:29:22 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver updates for 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z-2YhB7c0rxT5ldr@kroah.com>
References: <Z-2YhB7c0rxT5ldr@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z-2YhB7c0rxT5ldr@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.15-rc1
X-PR-Tracked-Commit-Id: 9f8fe348ac9544f6855f82565e754bf085d81f88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddd0172f182e3e869a3a960e433578aeedcb37c9
Message-Id: <174364376110.1744561.8618250493326881643.pr-tracker-bot@kernel.org>
Date: Thu, 03 Apr 2025 01:29:21 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 2 Apr 2025 21:05:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddd0172f182e3e869a3a960e433578aeedcb37c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

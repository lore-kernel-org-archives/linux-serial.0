Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD15193425;
	Sat, 14 Dec 2024 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197951; cv=none; b=lH1aGpfuIaZpVMG1zmlwkNWoYbcS/fKaNQtTjqMdXLWGmlLgQHAxB8zTX3SwmV1H8z1YJlCMPNG8MxNMDR/3YnoQRumbg6dRNlQzFnhbxEO0VUIWNnLXWa04ZCDpylcc4tUzkMVshYUWdlNLReRMQ+IEYyeyFd9m2oO29ID934o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197951; c=relaxed/simple;
	bh=Cr4Rwm+dg1QTfsUXryytoljA5XpgthR/cGs6MHMWiGw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VmGL4r4lYFjU7YU/E4BT9HFPdKuU2yqWog1g2gmfnwax4lRTn7qjG4zSV6VsvSe05TchnR7KvjcmJEbeY3X1awDqzIEg9qulF3emZ+R10hsWNxT3Qxd47SeJPsBCWIZJTDEjvP0qn0WUlMtKWRrnoT1nZnvGa0fb6BdsHx8U9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baaP0Wz1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baaP0Wz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDEDC4CED1;
	Sat, 14 Dec 2024 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734197951;
	bh=Cr4Rwm+dg1QTfsUXryytoljA5XpgthR/cGs6MHMWiGw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=baaP0Wz1GVaRhLp0fqy+kB1cSx/D2JB6P3y4rWl0f/rxWQyACTyLoMp+qXDv4tvrC
	 htCc2rMg7CSAlU6f71NFIl94eKdwYdH8V8+fomlrWSp8YqWNnLKmpxA2DmMFtQEAd8
	 Q8ijs2EBt2CzKvqH/v1sKeVLtGxrh1sfa5vaTGDkGmNbIDE85ubvnnkh6A4/ZS3Kuf
	 2EfAPWIISu/gmb/oBgaztKJmTber4gQ0BiKrLDraONkpbOymjYjYEfnDfjaOaSVK1j
	 D/RlFX1xJeXiKa4bHb1NRH5thWQOalo0qwl3YKKlanvIOontd2xIW5dPCivGNhYBKI
	 +AMs4nZTOtTOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71006380A959;
	Sat, 14 Dec 2024 17:39:29 +0000 (UTC)
Subject: Re: [GIT PULL] Serial driver fixes for 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z12XxW821DZlGNfD@kroah.com>
References: <Z12XxW821DZlGNfD@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z12XxW821DZlGNfD@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc3
X-PR-Tracked-Commit-Id: 4e450dfd0f968b79204637bf13280892dff287b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 636110be626b1e039b82d6eba4192d3cb82e5c92
Message-Id: <173419796796.3365831.3907095723312484689.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 17:39:27 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Dec 2024 15:35:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/636110be626b1e039b82d6eba4192d3cb82e5c92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

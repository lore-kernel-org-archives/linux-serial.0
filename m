Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844A219A9E;
	Fri,  6 Jun 2025 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240613; cv=none; b=rRjsyMmSIXfxGA5kMh4Rg8ppWlIIawuEXcvFokgX3R3IQi7GXhr+kLzsSsKqCgyLFuC0lPACXAiX8/LU8gccZ/0K8ADw0lHsfphYqPpBE1R8Xe5dC2kFagkJfzRzhRWCi9S9uizN7L/muBRYGoG8lJaxvtR2qZkANu5ewhNZTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240613; c=relaxed/simple;
	bh=qawWwxfEwC/qkrptcEhp/d1Kh+FLZVhUfykbZupv+yI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mu50zWhGjaP0ifX6HLkhdG8BimgHN5FlMt8iO7vEoGqWtKlCVkIBEYk2LmnbAzYLexYfP7xiV5rYUazQK8B9x09+BJ2Mu9amM8JGJCU676GeftjTLIn8mKM3JhPUFTPvDLptKEUS57LIoj2/0QSWymDavRqeywa/Ae/gqKxhb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUzyhnIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUzyhnIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8221C4CEEE;
	Fri,  6 Jun 2025 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749240613;
	bh=qawWwxfEwC/qkrptcEhp/d1Kh+FLZVhUfykbZupv+yI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iUzyhnIkDRdIy5u8uu6z9Ce/fRd5iLEi8r52zpXvGBE1AAl/8zJuMg3dobXpnElPE
	 Vd7O+xMSrFN64Nhr8mgvtUC78kydAhGvP8NOrSgPs07GPzpt7lljWTaBtBAYKFvfdu
	 d691jg/sfOvPWZei5IpRvnyXREYavsl7lvUG2I7s3GlvdQRPuHmCJ36kmg4lkjgyiE
	 kQS3LJbD14sj9WkyDLbsN75GMIeOdK1dkTi/gnsku0Wk5AfwLI/Xdjma84cYRSQuPo
	 xXQkOr0AK1oTEC6LmBn3FjZRp1EaO/lXhNuHtWecKENunq3wbdkxnHve0yeohAZD/w
	 l42JbkYPdSWbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7A7F539F1DF9;
	Fri,  6 Jun 2025 20:10:46 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aEKpKk71YuLPPMZC@kroah.com>
References: <aEKpKk71YuLPPMZC@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <aEKpKk71YuLPPMZC@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc1
X-PR-Tracked-Commit-Id: b495021a973e2468497689bd3e29b736747b896f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 378ec25aec5a8444879f8696d580c94950a1f1df
Message-Id: <174924064538.3964077.15606867484600379824.pr-tracker-bot@kernel.org>
Date: Fri, 06 Jun 2025 20:10:45 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Jun 2025 10:39:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/378ec25aec5a8444879f8696d580c94950a1f1df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

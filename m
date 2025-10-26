Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE472605;
	Sun, 26 Oct 2025 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500272; cv=none; b=vBg5QNx9KqkkRf4j1AcL6Mcnx6nmPmTC+cNE65Va/SQM2WtCaW51swCKOJZCL0uGDPZKlitUjVAKgdboSvoIXw8bcxgTyyqZOCZ0+dSztSBorW1Rs4wp2VUjc4HsvxusMEaeBmz7ZgYMU0F/mJzwu+RQ6Ug2zuQWTLcvOtf6noM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500272; c=relaxed/simple;
	bh=AdFT4vUYXhfaVdg+4fnL1JLyXrTESgYOv4hbru18pWU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fa5nPAL46W8Khd9nsU5DBB7DnoULPbXqcVVqVtkO4JH9ubuvtfo038gm3GuiwJhmcXh2OFG/cpVKw3Ajz7/gH2RzQMjRbz4AHUFk6GPjJkhgdNewM5LmisU3JSzZmkIFcZkQmKENa/Kupn0tFilDCxu5TON18VEHMaEAY3d6tAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRnzZInr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRnzZInr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFB7C4CEE7;
	Sun, 26 Oct 2025 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761500271;
	bh=AdFT4vUYXhfaVdg+4fnL1JLyXrTESgYOv4hbru18pWU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NRnzZInrg1097fP6XyTrQR9nohi+Xq3mkn9rY/dKYfvHR0jTqfy1+8XVSC44ynrQT
	 FPKHrjUxUsV0sjRO+VrlJJu2dg5u4IflEy7eO9zhIV2kU51oHPk5UQRxEd084UPzeN
	 BCKmO9AeDL99RqZAULRyk26VT9cqUbHpX2Kdush2izUSTUcs7V4wLgD9ntrT+we+4d
	 LvwmkwdxyqNIM6Z1DXGKUFM7F0ejxlqk+jBYnHwpsd9U7KBvCnBtEUGAFoOspF6+ER
	 YD7S9KeATCkBhE4wyEftr1c1TX+6H5GAI1VG8St79s50fsAUKD3q/Z2XqF/X0c25ZZ
	 GPBDLgwb86i2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71052380AA7F;
	Sun, 26 Oct 2025 17:37:31 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aP4pS45wz11Lcggf@kroah.com>
References: <aP4pS45wz11Lcggf@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <aP4pS45wz11Lcggf@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc3
X-PR-Tracked-Commit-Id: d518314a1fa4e980a227d1b2bda1badf433cb932
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa6085a06716dbfa9b01c0235cc36f1e9b3e1e3e
Message-Id: <176150024990.300159.13559449878668727101.pr-tracker-bot@kernel.org>
Date: Sun, 26 Oct 2025 17:37:29 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Oct 2025 14:59:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa6085a06716dbfa9b01c0235cc36f1e9b3e1e3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

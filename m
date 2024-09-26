Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1F136337;
	Thu, 26 Sep 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371535; cv=none; b=pdNufaEdzWJtzpnAbDq7sYqoo2TeqmM3lXlbKd+eoJuF/pxBoHCtypA0fK2zMxSR2ggPooytcdszpLdNc6pN057HHsa62dUFvOvGXbncSjdWUkuPaa9aypV98o1aKGVCYgpz1UgX8JqH+V6+JHXEdBPofDhuU1JzPXoTdOR5fXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371535; c=relaxed/simple;
	bh=20JZYp6TAOzDfmSA8xGtIthA4f5q02l9nwfKYFhgMHg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qDkSFK+UQ0yjq8CZmVGjLtBb5SBHZTxaijrKuwSFh0D71y8LAx5Ey/9aVBICjYaJi8CJqaGgpyQSneWUlAj3vIV7ZxIpgiblqYS8P0NY42zmbLv6Qacb3GtuSISFb6aIYn0WY4NGuAlN3dxUks1E7/kvHnOsxmtyDvGd3R1Q4a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYW7CFBx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYW7CFBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DFEC4CEC5;
	Thu, 26 Sep 2024 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727371534;
	bh=20JZYp6TAOzDfmSA8xGtIthA4f5q02l9nwfKYFhgMHg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CYW7CFBxAGEWpeg5jFd7UrMDw1ZUD76/AUDOegQpfpwfhFwNJLJkauMOsJZ47uOzE
	 xxWy+5K7D7SEchDx0awlY+tuKJAzIGm4IIzGBAYjG6BabVljn2qoXUMtPITUg+IeFA
	 anDvZxFbNllzY0eHyiNnBRAvQkjT5VZVlKNiuFpme7KQKA8OShlFFPGv4UeaIgAnpO
	 ku6TicH3ZB+E2Qs5guCPrA7Ew07RVs02zdo+aPofIhkjErsn6jRK4k1yytZhMG3rUn
	 sHEYEJQ8AqgdvGbaX0ij3DWdDM87cHT2AP5yrVO8Ao1vGBw9II07mvR8I+pJumJTie
	 qkT+Z1Yu0mpAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2E3809A8F;
	Thu, 26 Sep 2024 17:25:38 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver updates for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvU19s7TVsFsLgas@kroah.com>
References: <ZvU19s7TVsFsLgas@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvU19s7TVsFsLgas@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.12-rc1
X-PR-Tracked-Commit-Id: 5ed771f174726ae879945d4f148a9005ac909cb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 356a0319456810f3a5618353f6ca3b0ef9965479
Message-Id: <172737153718.1334950.9571425940561035278.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 17:25:37 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Sep 2024 12:22:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/356a0319456810f3a5618353f6ca3b0ef9965479

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

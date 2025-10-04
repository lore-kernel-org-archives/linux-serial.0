Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28C260592;
	Sat,  4 Oct 2025 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621346; cv=none; b=X7kvdEEbMO9/X20PipE9eiq6dMqjFJpEog5W9Tk47ZkL5aBU0N4TQ9i7C/duYvnqYar1bL3cEdboWZQmHtc/o+4OZC5saCWTJVxDKL0dqXyw2cUiGLtw5ovEhjWXV3A4ZKrzJ6jSm89fmyHWX9kJ7DTjOtGaqo/aND5Fixx7OFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621346; c=relaxed/simple;
	bh=DH9uYWANC1aFuO2P7AT84Yx81kKtZMAHQs6Jnfi9K18=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lLVqieQk4gwdDUJXz3FZuNThv+bQ4PPKhpVzN0WHRsgILnUv1LreE9Kuhx0VWuTqDr6P9zD7Il6ttz9a1MIMaEbnau5VMnreCLbr7FGOPcOVK1y2Tz0vUrY8rTmBG9TbXPn+LgthJZKwj0LbNaZuSqWaJ/7eEwDbE72q6Ju9Eo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEALVdhd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEALVdhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11E5C4CEF9;
	Sat,  4 Oct 2025 23:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759621345;
	bh=DH9uYWANC1aFuO2P7AT84Yx81kKtZMAHQs6Jnfi9K18=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jEALVdhdLkN68D8eQWbM0ofEzBWP0MZjvs4rpvYGRJJwbagI7gayRGX0y0HYj8OQS
	 wG9K0qZdtuyh2mqgWOC5WlWe7OBuUZQIe5yVugA54yLVf7fBrhsCTmJxpHVpx6slCU
	 p1fOA2IBstlOoDlemPETjryn8ChuvVafI1nnHhSFrR0nrkI7ddOoQsLk1AsBDskym8
	 aS4xByRyqQc87tNF+kXaWUX8WuX+yyadGh6+ZHfz76LiBczd8/g1sHNWNJG/cTlta3
	 mtgIMbbliFSTNZGi1s8xYOPk0uJqQix3ZUVy3+juj1ApsLF6eF9NnyvONh0kVaKqtP
	 IAOYtBbilwCig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBF639D0C1B;
	Sat,  4 Oct 2025 23:42:17 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOEpKp9lSCgoCiId@kroah.com>
References: <aOEpKp9lSCgoCiId@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOEpKp9lSCgoCiId@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc1
X-PR-Tracked-Commit-Id: f4abab350840d58d69814c6993736f03ac27df83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d2f4730bb7550d64c87785f1035d0e641dbc979
Message-Id: <175962133645.472872.15020364018026948476.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 23:42:16 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 4 Oct 2025 16:03:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d2f4730bb7550d64c87785f1035d0e641dbc979

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

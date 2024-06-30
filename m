Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A25B1E0;
	Sun, 30 Jun 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719764886; cv=none; b=kPAKzfM4OG3HFhiHY1SJ5/gJ1pDz7bDePZOf2Jtp6udJqCjGsR5+bbNHowABY0u/oRMtnHecTnflzK1WbFDGp/Edr1i7Hz+T4gQ7rbdZ6z6k7rWwRQAQ/oeH3J0+Y9O0NEpH1+TttXB3f/OjZPbuS7TbeUiJ2P4lssEQvB7kePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719764886; c=relaxed/simple;
	bh=dUSY9WlVjpaC0jibaT6PWQbRPziL6WMnbcskSU/tty8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nWxqlycWDOedj1nuUcg2JekMTlE4VdkIu4NT+AEd1JJFSYIVRnB/ODWjbE9gJsVHLlysD+YQQmSs/7dDK7DQlRz4XvnGmyP0Ht0U0R1PXtnQoHgHCAudszeezaFgy57iPrE/p1TjWGFtoLc7EYj5QmYqSqGTfLs/IwxENo1gqe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDsg4qJc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDsg4qJc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0715C2BD10;
	Sun, 30 Jun 2024 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719764886;
	bh=dUSY9WlVjpaC0jibaT6PWQbRPziL6WMnbcskSU/tty8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XDsg4qJc4g0Kf/WJs+dKn2xM4TRVTMz9LPV+m3yCr67ZRUnOafqPATXkWxqi+acIM
	 6hV4PJz1olhmRMXkW6Sz0eIparoVKzaWprMXF0KbGJ/b+GcL8PsNfDCzQ/JEyfEXgL
	 b8Og9zv80b7+dkpQnvVsgJHQralqBKHcgfoihBj/oRQstCUu8AaxEhQM/ZLl4k9YbD
	 aED/xaiyJ38NvMHdHjWaU+1XBJ7BUvfzTHBxBLraJ9uk5IQYeVzl1uiOWDS1ynujrH
	 IT0bwprbBjd1TawDz7w3zVVjeYnqi+E371GbKsv8IPqtLx6sH0pN8MeFNxr5P87aQn
	 C9XNRcQLUGuPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A65F3C433E9;
	Sun, 30 Jun 2024 16:28:06 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZoFnsuNJy_Fz8_qE@kroah.com>
References: <ZoFnsuNJy_Fz8_qE@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZoFnsuNJy_Fz8_qE@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc6
X-PR-Tracked-Commit-Id: cc8d5a2f09a54405321769abfd6ec3395482336a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e334486ec5cc6e79e7b0c4f58757fe8e05fbe5a
Message-Id: <171976488667.24413.1678305741571152562.pr-tracker-bot@kernel.org>
Date: Sun, 30 Jun 2024 16:28:06 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 30 Jun 2024 16:12:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e334486ec5cc6e79e7b0c4f58757fe8e05fbe5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

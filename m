Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E234F270;
	Sun, 12 Jul 2026 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891064; cv=none; b=C9PKzI8EPrJiXfqXkXbCOz5MlqjareRIhseX87iaBTtBT6TXEg57saXUFHr1B5JGmVj9+42izJfo8yJ7sT9LtXiTF+vMLjjFmcR6bbLOKETc6EWKBItj58qkPesfpEdC8cqTY8QSv9ziju2LRP7jk12mhUNyRHoGWDxPTH42O/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891064; c=relaxed/simple;
	bh=TAN8uqcXQaWpMu46V89+7rmBB0GHxnBNoDJ0iSaUJ0E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K/KZi6Ic7D790E2YTiBAsHGf5CFlutiVmwgtSSYE+WHxBO4HSKEXlYlpgAzumCujfQs5hs11OwFRWfSf9YAjtrUCzrYgsS20Ya921Ht8Cd+LuM8ceiwkmcxswt5srko6Z8KmPB1kwX8CNLkeqSp3UqPJQUGLqpMoiWN5e4Yt290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkC76YB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkC76YB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7041F00A3E;
	Sun, 12 Jul 2026 21:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891059;
	bh=BDdEyOx+OG/us7Sm7PENRBotnlk9VnO5k47Pd4YNgQA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ZkC76YB+LJnKymuC5lBNUhb5oYA4L/GKZz6CGMztgQMV3K/L1ND+oOlmkzqMk5kTe
	 b+zkyOUe3EztlKXMGmYmS3SozZMUqHuqCn1oK+e3wpxjJfQw+U3QBhnZzUxeNgvdZY
	 pjX8e1huHNBh5uTT1dZwSL8pCV5noKxB2uFDM5+M2+T+tBICCKlgTmlzV+uIOy4I8b
	 V4FFe3eQq28wV5/I0ajG6nMNnNTDq6gKOD5Rc/T/BVOhrv2H8w8xrsiWYTVTY7zAqs
	 gxTpccu9dadqyDpo4cD30dZkzsVzdyA/7BnwUOmGjesSlWgsECNy/suFRwmChM3FYt
	 pCCY/IX4fusuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1967439244C3;
	Sun, 12 Jul 2026 21:17:17 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 7.2-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <alNTUs9uo0TesjLv@kroah.com>
References: <alNTUs9uo0TesjLv@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <alNTUs9uo0TesjLv@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc3
X-PR-Tracked-Commit-Id: 302fbbb4fcbdeac2dc8c63a56c1c4e38c4781958
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a65af0e39da4f8bfb594c331450bdba8db04add
Message-Id: <178389103581.1485009.9104051772100609027.pr-tracker-bot@kernel.org>
Date: Sun, 12 Jul 2026 21:17:15 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 Jul 2026 10:41:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a65af0e39da4f8bfb594c331450bdba8db04add

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BE1EA91;
	Wed, 22 May 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406693; cv=none; b=pieHKGxJuh2ltNeH28JYrkgk2BvEzTqF05ZoRWxdW3h3Mheew3wsYWIUol1jKQr17ZLQDu08eb/uauIQjdKrBGThmLrChETxXjDfdVJXGc30KqJpDR3e2PYvVGFe+fg9tBlO2F6uc+ehV+u2CwA7B6jL0yb3IUq65hhLvWUluzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406693; c=relaxed/simple;
	bh=MX5OSB+dy62ExBlTqY8rF2NlYcX4hfoDzivGnHuIS48=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KLVohtyRrptDzNbdjJkbF/Abei9E7moRM4InNjcVYyfKzTqoHJ8zFnmgtTP0fUg1eAyBiptyLwR6UEc1eOZiYpXqKMGn+mJot+JSIrjs2vGjoPc1wMq3zOXo+RQeQH0zvOAt8DWRStMzPFZDJPvtztKji26SKXi/dIGgbrum4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjrsBaGj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjrsBaGj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6369FC2BBFC;
	Wed, 22 May 2024 19:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716406693;
	bh=MX5OSB+dy62ExBlTqY8rF2NlYcX4hfoDzivGnHuIS48=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JjrsBaGjYuw8b9r8EpcdKdzFS07tcGZ85hJCjsYCUbOUggW/6YFMxqChDYHgg8J+P
	 rRv4nOxTDTDDX/YxYFL+wKhxYLJ2ajRB+4MIPRI5DGTMC4CefUE4WEG2YzxU+44lzd
	 CHqAQdl23QRv642fOrSYj1CXs0+oJBUvx6VpGglYp0Za5knOxzyLu1DBOmmZfARgmI
	 OWKobQvdnXplfAYCyrpMUIFv1FgCxOyrvA3sraZ+9U9z4rM7szd/B/aRZjqOFHMLyI
	 ht23X8fRtlsoR7oufxx8auney04FtUVF8AZDKXPGevPZZ+zSfpSDD4NX0oWbTAdUOA
	 3gmKsmPygX8hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CC31C43619;
	Wed, 22 May 2024 19:38:13 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zk4GJDYPNVCsz7AE@kroah.com>
References: <Zk4GJDYPNVCsz7AE@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zk4GJDYPNVCsz7AE@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc1
X-PR-Tracked-Commit-Id: e21de1455a721a0cb4217b18589ede846f5b0686
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6b8e86b7a65495d3947a1d1fc22183c52f786f6
Message-Id: <171640669337.20241.6864258702618088248.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 19:38:13 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 16:50:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6b8e86b7a65495d3947a1d1fc22183c52f786f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

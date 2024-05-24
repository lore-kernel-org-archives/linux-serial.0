Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0712E1F2;
	Fri, 24 May 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569126; cv=none; b=MOolIE3UJF3xRD5Jdk7NvwuPZBba5Q0UxNLwKRbzEEOmx+A99vkOqq9dvZI+ukYk1KeimRNe4FGo7d47qZwUbr53cG2VO5dwKau4Ra7RJHVJHqBgLk1dWUubCo+fVgd9NkBC5PlndnZQrthGVkZKIiMPvg1sNKorgl/1HTbuC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569126; c=relaxed/simple;
	bh=3FYaKm3GfBHvEx9jHSZDQ+GIJ/9RIWsmWgyVXHeeyxY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eFT++NRoNTEop4L238jt+52GxkD1X3/ohKN4RDdk24uNXnrJn6RDIowT41YP9T7D/YI8y4VVtd1DXlARPiN2gxJUHFRXn+ipgAZymEf7rHz2yc18g60RE0/2qe4dIqHTa4xmVWrw6Zw+T08MLr1NRxrAkOfkGbYJ3ZXvuaIoVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2t/vD2D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2t/vD2D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 793C3C4AF09;
	Fri, 24 May 2024 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716569126;
	bh=3FYaKm3GfBHvEx9jHSZDQ+GIJ/9RIWsmWgyVXHeeyxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X2t/vD2DkBaswwzt7jjLsy+7ryyHpZTp9J4mDO2LAQB/gdikWIUTL7ITU/caIX/LR
	 UcVWazNzZcyJGj1SmAfGEhseg8lsAq+675Jh3PuqLcZxT8oNPHXQ+BMuO+ij6QyUoq
	 DcaV7UuFV8p/pdqqaaARs9bvGPQxpdCCh9ki2JVrnYgvW0jm4XNy2Rj8bgKYQhTZ8V
	 I7EzSILovtNDJdGWrTGGJ4kSSj/zqNSDwBkIIWhm9poAlRs2Pd4OA0Ltzvfy96CBdP
	 5KpqQFCa62jQ/4C6/tlKR1gZhzTPBUIclwsm1/CfwFTzOPCJKfRE69CA3K4n9UYKNx
	 wZ0o416Hkk+SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F30FC4332E;
	Fri, 24 May 2024 16:45:26 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZlBGWwX-98c6wnGW@kroah.com>
References: <ZlBGWwX-98c6wnGW@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZlBGWwX-98c6wnGW@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc1-fixes
X-PR-Tracked-Commit-Id: 8492bd91aa055907c67ef04f2b56f6dadd1f44bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6d199c774241e65b7078d89df56b97c79cf5f66
Message-Id: <171656912638.29701.9038585414242051556.pr-tracker-bot@kernel.org>
Date: Fri, 24 May 2024 16:45:26 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 May 2024 09:48:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6d199c774241e65b7078d89df56b97c79cf5f66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

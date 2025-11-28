Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE02C15B1;
	Fri, 28 Nov 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352678; cv=none; b=jM6Hvhmglva8Kcs/2aHeNLmwreahcHALBxQsSYZvJUld5fHZr+c+Nfh/XP5OEqnCFaHN8mv7bR0dXZTQicLEv5BkjuVuOtdy9THkDKLGu4+xDo4gjTwM67WYecTYUVFbEwzu6xnL4/PKwuvVn+aaTFdQiwNS79JhEybv7O0D0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352678; c=relaxed/simple;
	bh=SiOtVehZGM4MttO5C8nNkyhgnuve8Cu4BzyqIu1ixBY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z7n7IzbMmpqWJ0ZHFnhInBFPZNdJrx0grjvZM7sVdMZeBigK73/vtFI20LxrNV0FDsUZq5bFUnzvIEhrWX8jCIXsB4jLKTR7ErOBLVJoyP5qlDgDDKAUKgtgsZFhJW5v4mo1hHnxO2VCHXGWgsfs1Hmubx+DnoPbnqaPQ6tyBqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0gyhIVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0gyhIVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC18C4CEFB;
	Fri, 28 Nov 2025 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764352678;
	bh=SiOtVehZGM4MttO5C8nNkyhgnuve8Cu4BzyqIu1ixBY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S0gyhIVGD3A6YdMfRZDpnbkzZwHXrk26sIJFdHQZvkh1JRBvACnz0UN5Hc1KHmouL
	 6qfJBWs7eu0JMYKELcgzASK/vEv8BNOVPxjzLc6vUjb26KivUynq9Gwpq08HKMNvGH
	 +FblhXTanOsBSRic+zcwmIwl7LsKXjXs/Afx7awG8mmpt7JjgVEqZXJebIeBPeyxbM
	 14bFYfclljpHQfUtMDtlyGd6qnf4Rv63WOC5HNfYDk3qN6nIzYqUvykkVLK0clz1zv
	 fZ1H7OHfOhuYeHhiLCkAjzdTdk0Dscu8KVcwbXKmHcjoFHdKpNEpol+Uom1LIRchod
	 uXWDcjtYSMVeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5BA53806929;
	Fri, 28 Nov 2025 17:55:01 +0000 (UTC)
Subject: Re: [GIT PULL] Serial driver fixes for 6.18-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <aSnPDe3bUlz_Xl7e@kroah.com>
References: <aSnPDe3bUlz_Xl7e@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aSnPDe3bUlz_Xl7e@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc8
X-PR-Tracked-Commit-Id: 2bf95a9bcb50002ca9d47403d60aedaeb2e19abe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dabf127d641e43d5fbb72a1f48209818349db7ef
Message-Id: <176435250041.746710.17253256111135314323.pr-tracker-bot@kernel.org>
Date: Fri, 28 Nov 2025 17:55:00 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:34:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.18-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dabf127d641e43d5fbb72a1f48209818349db7ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

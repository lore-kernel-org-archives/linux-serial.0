Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8871534E9;
	Sat,  1 Jun 2024 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717259900; cv=none; b=VdfMsYsJzAxIy+STuEobXUkEB7TJ5YXExnjzf01WCZ0wqtkK9bSyxthoc3gQ5RRcMu8855XCCpbGILBjCSljQBjjO6mLueUWHeOQctRG2NE9j1MRN+ZeZikqmpUJX+cC7lA0vurPrvlCyS7H8A6CFUHstbCGCGR594vnFxjNs74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717259900; c=relaxed/simple;
	bh=3O8mmZE+SXXr0aoUDa+V3wrSWWWIgOSRt5BHD6dvkE8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W4ugDJcuLJL2A40AVSMMqNA4l3mtQETEv9Kw9o1sBeY3j4NXLM6+B0/BS85v17y/R6vx/MdTc8RmgOTlb3VebvhA8M7K7wK3vLT2+YLYbWmpg1PsJUYXvumzLoXeMbcS3e6zgxP7k7wIeFs9OPa8nAfAvTSng6nzbSj8zIwd5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaPbWSxg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaPbWSxg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 281EDC116B1;
	Sat,  1 Jun 2024 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717259900;
	bh=3O8mmZE+SXXr0aoUDa+V3wrSWWWIgOSRt5BHD6dvkE8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iaPbWSxgYEguTMmWcVcf24XJcAiATXvw7S5QO0+rO53rNwPOxbnkkxDL9R/J6if2H
	 okwssZdX2kQHK099DCuIdMtxiCESqyQ+TfhhowMe5tojJQAfTkrje3iLC9Ld594E3n
	 EiN7/GaO0X+fCE+nVL+aUfx5az0oUSSVLqCq9D4mswZ/2S5KVGtCHAnhqA7LOzsx3J
	 Ze35gdtg3szDs1hSehIFzawoT6fuVHt63AeVufSQIO2FXHH6chtJKK0PUabkqSPF53
	 0pMtyah25PEbLqIwRJLxWcKHRqiV7bsy/38qeL+O9mGXgi57D2h2rlFmJvtPI5fAq/
	 qS8VmVvpJ+WHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E77CDEA711;
	Sat,  1 Jun 2024 16:38:20 +0000 (UTC)
Subject: Re: [GIT PULL] TTY driver fix for 6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zlq8yMiUBTOisuWp@kroah.com>
References: <Zlq8yMiUBTOisuWp@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zlq8yMiUBTOisuWp@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc2
X-PR-Tracked-Commit-Id: 7bc4244c882a7d7d79f4afefc50893244eb11d07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f26ee67a0f94b8ec79b08c046c2a47568517d772
Message-Id: <171725990012.19745.9399491621442266028.pr-tracker-bot@kernel.org>
Date: Sat, 01 Jun 2024 16:38:20 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 1 Jun 2024 08:16:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f26ee67a0f94b8ec79b08c046c2a47568517d772

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

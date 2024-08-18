Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F114EC5B;
	Sun, 18 Aug 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724001809; cv=none; b=gbSM1TvjZKI+ZQZvH5ALfeyOQhaFh06Mzj27mwgjrHwMKBXK71FKn+dI5BomcLKz6CqQSASDCZK8qANgq09gEJX3lraA0ZUP7QZ0a/trbQykO4rpYPNY29uAIfSuGAa7Din1ut9Ayfl97bQyhcXua2HNMQAfea+WKpzEgpFolao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724001809; c=relaxed/simple;
	bh=DNBeeEuPpDGYrSQBi7BO1V5gENZVaIsvtbbsAsMnTWU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=otZ/TXWVx4QkKYyDzyzlT+mTtOhb/TDheb+Nsentnj05aJaiPCHCmyWGVonKE/j3hvanNsTzb1Mcf9vs/Nf9qC032yhXPF/fXlRU9T3+3VzESiKoXVoEZNStNqFjqOR2r9ZtricJuS4+/UAPRE4NrHgZmcsgO03hhoOSW+S+NYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is14sWhW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is14sWhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057E7C32786;
	Sun, 18 Aug 2024 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724001809;
	bh=DNBeeEuPpDGYrSQBi7BO1V5gENZVaIsvtbbsAsMnTWU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Is14sWhWfNChs5937JlgfM1dMEsCZWmAdxmzsaUmMVYuQthlizviBcgrlJILfuhU/
	 cZT5bNwYnIftNTLRw1gGC8exAQZf8C359R0gTouBIHUns/5ZdNGVEGyHRBMzlvAQ1F
	 rbi0DFgukHEigCErfkBrCEqAZfXbErvMcz1VSKexHfKLKZp2yTkrL58rwy23cQ5SNv
	 ycxe8KnvkR4IRgbz3zcmLOPj9NIK+thpcgGl0SXgngGRGMiWQuEpAU7F8GxrSHqI7y
	 NUohjwEqOWUMEnl/QbjiHY4L/HybICmUCIAFEN5nvy3j0WEeoNTI05QZZHNw92zOYF
	 T5CA/Wd9Bjayg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBD438231F8;
	Sun, 18 Aug 2024 17:23:29 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZsIVlRGstB9mxtQU@kroah.com>
References: <ZsIVlRGstB9mxtQU@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZsIVlRGstB9mxtQU@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.11-rc4
X-PR-Tracked-Commit-Id: 0863bffda1131fd2fa9c05b653ad9ee3d8db127e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 394f33f9b3f40dcdd0304f17186d28a0342e8763
Message-Id: <172400180840.3949564.16463127226710187378.pr-tracker-bot@kernel.org>
Date: Sun, 18 Aug 2024 17:23:28 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Aug 2024 17:39:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/394f33f9b3f40dcdd0304f17186d28a0342e8763

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

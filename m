Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF02328B7B;
	Sat,  3 Oct 2026 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791044689; cv=none; b=mg1nj/46qFGXN6JJ4Nz8S6l3rlmd8xzji92EgFSbMTAqS6losGgnslDHiGCSaxdoUAsFFPqnm4LSQA/nqUuOCaGkPlVCnqgUtBngkFq4qmPhPySkeLImgS3D6Df2stHrDf38exIiyK+cf4rpot59SExPYmgOxIyGgmHreXdLXvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791044689; c=relaxed/simple;
	bh=7II8O2CcIc0MNZBpu/w/sTk5mU7VZ7MWejWiq8tKSSg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WDWgZAqE87fNtO0sZrnSGTR5M4vB50Mydg7hTQQXQxu1RlFnzRvmFUKU7EpztBc0aiWNDcTt8oAEJw9x/M7yBBzVxHe9H4aAq8+VsoA8OtPJ3VC9S4dLzfbiAvWVx5JXLwizsuLwhT/3WzTOaK2yas8SDc869ozQvTvEJL881WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh69FvxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh69FvxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435B81F0089B;
	Sat,  3 Oct 2026 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791044685;
	bh=eAdI9H6/gtaBsaX7I0xQDDP4LppZVVNn+8SobN3+a/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Jh69FvxQalGMkO77YmWtC9E3tCwvu7l/PHigQnCPHDpl3wjzcKc+zjBeqWepzJQDN
	 cWOsBHkRMGQIGKRVsFw4284brLFhwbj7uNxb95rg+E1PE1QXXQrRElYZKdy9YTGDPp
	 w9T1yCDsjXEL3WBdqcqqkNFAOrXAyaRK0z/tZjBWkZK0kYVaUzybaCop9dfTf0RQV6
	 6jou9ilGV4+Ch5HzGXv1LRWQpIQsocOcPOTD/6rEsjyALf24aGGzRRc1iek7X13rvP
	 DVxZKw53KrNQj1qLpYbCBqj/IrHpxk2DcmKoDqV2UbkmFzZROOGmHA62VhS33ChLKm
	 13Ps/8vsPvClg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A57F3924475;
	Sat,  3 Oct 2026 16:24:45 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver updates for 7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <asDpLAJTXzOrUdCX@kroah.com>
References: <asDpLAJTXzOrUdCX@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <asDpLAJTXzOrUdCX@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.3-rc6
X-PR-Tracked-Commit-Id: 6c95ca52f27855dd2fb74131c8d4e8325d2af7de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a32e0754d637c1d386a533ae36e41c8f4be8b10
Message-Id: <179104468392.131116.8902563754987344208.pr-tracker-bot@kernel.org>
Date: Sat, 03 Oct 2026 16:24:43 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 3 Oct 2026 13:38:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a32e0754d637c1d386a533ae36e41c8f4be8b10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

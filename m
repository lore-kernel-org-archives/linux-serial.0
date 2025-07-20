Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C96222127C;
	Sun, 20 Jul 2025 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029052; cv=none; b=MtZ7VCRXPFLhKcDjQqu5hh5eebqaiyhtt/VdGylRyONT4Xnl7YGGEUERcghIPOdoS3lbzA6Vzz0RN3o3AILLSprVTk8g3tGvR2eUeG+oouvAE9fbu6+CQqot0ZxIy+raj1Iw0e5hIpTYfXV9KP8241Tk21V9iYMw/oZKKwGtUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029052; c=relaxed/simple;
	bh=p4PbCS6cMZYHLOCV+A63qjm4CDBVy6bshoMjcL7HwzE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o/8NZOlkuqXhKVb6/MdI/yI08ODXyyRoyl4PynNHGEtQ3Poj0QRqXgP2sMcJkoDP3VZSpUBVNvxhSiJCRGaP+MXiUMP6SBXJgLJRJGO+Ljw7Ro5OnT1MJuRdKpek70XmjZ13C1MgdxAM81LOxo9AOcMDbflkzfp/uAjsS0u3L0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za2IExyb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za2IExyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C33CC4CEE7;
	Sun, 20 Jul 2025 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753029052;
	bh=p4PbCS6cMZYHLOCV+A63qjm4CDBVy6bshoMjcL7HwzE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Za2IExyb/ZZfXrPib165RXMTn+hKMZSb2In6lkNC9MsiDkQe8hUYtkmEj6NHJiTWa
	 LTg2M9UDz+xUDNQfq0WAI8y+Q1hoapyEMvVv0vP6ZRR2hcHEZXSgY6A404Hds2kuGy
	 PX1zPOpt5KygU9cLBXxou35qytpbFaTu8qmZH/dYcFjvnZnG03KPX7UMIYiRcla8sB
	 4zS1yq3E6ATuJklaWf3RkCEwWwv9CO1m0rLTQujrP5rMGTfPLlq/5mmeFWK0v/dZS4
	 5Cv0TA3zU3/Bmq3+dLcxsNR5kKshYOHGzVH7KH8Zd0i/N1EnJ70TohKW1eETw57X1Z
	 FdAefEd2jxc0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBE383BF51;
	Sun, 20 Jul 2025 16:31:12 +0000 (UTC)
Subject: Re: [GIT PULL] Serial driver fixes for 6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHzJDbazSNDl7kv4@kroah.com>
References: <aHzJDbazSNDl7kv4@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <aHzJDbazSNDl7kv4@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc6
X-PR-Tracked-Commit-Id: 6c0e9f05c9d7875995b0e92ace71be947f280bbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 673cf893b66a7dd76c9378f4506b3d4a870c80b2
Message-Id: <175302907106.3241589.8779347621961198605.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jul 2025 16:31:11 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 12:46:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/673cf893b66a7dd76c9378f4506b3d4a870c80b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

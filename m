Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD9128819;
	Sun, 29 Jun 2025 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751215188; cv=none; b=XaYeg0Es7LKiKJmxau0NySzzetbqXSCofwAlL/zk8c+ofHbPCfORVI5ckFz6Xx1BgP7qJ5jtgSDhuAbX1btO8dJgHce/+1FXMOsesyww8AQpqVMjR65+bwiY5+DGwSrIpe9L+4IkTaaFX/WHJ3J4GMN0YqXux+a87y+gOOzAIII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751215188; c=relaxed/simple;
	bh=vnsHTn2uZ7mVOwXpqf438laxLK2ajheZY0YLjxs9e90=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ua90WhX4ENDq/Z04vDuwkImM/3lDChBANN/IfxpCDXWUmJqkdHL/ZpgsOjv5pnotORbJQEXzrbczpqMng/wxdK/hcjAufO8GO32fkp9XE2K2XSZdE52UjRbiBPp0Mf8oQhF7ts9TKE898BZ/hduk2lb1KQY3Zx7ufkcfogdTHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCF4gioM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCF4gioM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B681CC4CEEB;
	Sun, 29 Jun 2025 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751215187;
	bh=vnsHTn2uZ7mVOwXpqf438laxLK2ajheZY0YLjxs9e90=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bCF4gioMq6VtakP6tLEjH6w+oAaoPvUSZXLqaimFE/fTbg+9SRKol0P8JQ5Bt70Jz
	 ax0g4+kuh+eEPAZELRkyAJiD64CRKdP9Kb5yAspwcJbTlKyYnM1/nfXzX6QAO+AZds
	 u/Yjkae0vRcm3ulVPKHClkpEcTSWKvdNts9EDmOVcMrFH5VevCzEQXJxWtWqmaQM52
	 bqS9bpc/PZFy9g1kNjb6MbBze1wzhVvImJGkM50KcRfZ8oTwgji+zQC8brTDRuF7MH
	 dbhaJXpOrjN8D0GIO1vCagUOGYQ8CPEnTHmimt9kM9/15dYqkUS2MdASYTRI4ZmhEG
	 pJEx+l4tDOO+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA838111CE;
	Sun, 29 Jun 2025 16:40:14 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <aGExtgnENnLLFsET@kroah.com>
References: <aGExtgnENnLLFsET@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <aGExtgnENnLLFsET@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc4
X-PR-Tracked-Commit-Id: 09812134071b3941fb81def30b61ed36d3a5dfb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 798804b69fb6c5b5a4a5d38cd6054e42fc4a174e
Message-Id: <175121521297.2431506.9754252872980648111.pr-tracker-bot@kernel.org>
Date: Sun, 29 Jun 2025 16:40:12 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 29 Jun 2025 14:29:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/798804b69fb6c5b5a4a5d38cd6054e42fc4a174e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

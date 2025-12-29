Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16E259C80;
	Mon, 29 Dec 2025 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766975865; cv=none; b=UrFPZWOLpuM89NfT8MyKOv0Vu3pWARerAMYgk32u+91Y7zT1SXMqTlLqWYH8Ogk29or22ozJfp0SCdrTaZ32TPG9Rc5Wbn2WdrEcrZxn5xLGVMMWxrciq3j3n67DMjg+ynYyiY4HmxdoRLbQo5q3VS3sKetJPnhXJeOiiksDPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766975865; c=relaxed/simple;
	bh=tW6cyUsK+Q0EqgqV67F2XJQMqTpmh1mU8MmvosfAelk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=caks1pdiKHkPkmMGElNBxVxSLZ4iidqjwQ9PmGAclYGUWWpIw7gmwktPJ+1NkSb4wfta+TwOYK2d0YAl6J1S6B/aXk0BHekHoUZkOrGlL2FLYZHzBB+7vo+susuVanQIYFxIC/g1TeAa1EtZCPBquLghES6eY+X1iiZ0R8McMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/dZCdLg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/dZCdLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D630BC4CEFB;
	Mon, 29 Dec 2025 02:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766975864;
	bh=tW6cyUsK+Q0EqgqV67F2XJQMqTpmh1mU8MmvosfAelk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h/dZCdLgdHwDokXWEDMZ8570cs9jQ1pGjiX7fA+GuVkl7XwlzqdcBdotYN3xVVi8/
	 qLW2sgHrkt7ztCEJGusUW20pX56e9S58wsxzkiQF7u6Ve2VDxrNOneybny5R57KNGM
	 k/8dGOzZ67SdMtN9ptoGvj/WxrO2Kxhao1nwJ7HsNpToXsEE1dKAFmyERMTVqmSGic
	 U2pQWTskzGX4+t1iKuQZGB9Oq6ap1uU/IFrtr+eHXwSefj/n6IYnLI1xjy8VyK4s41
	 QJtDX/7BCSy3oDPoQH9XQF0eTGgTjB2B+z9KZckGY5ocB2EM9y7Brgc1SiUuAMF6gd
	 AEzr38nfchqeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2F543808200;
	Mon, 29 Dec 2025 02:34:28 +0000 (UTC)
Subject: Re: [GIT PULL] Serial driver fixes for 6.19-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aVEmGSlYL_sUQhXa@kroah.com>
References: <aVEmGSlYL_sUQhXa@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <aVEmGSlYL_sUQhXa@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.19-rc3
X-PR-Tracked-Commit-Id: 267ee93c417e685d9f8e079e41c70ba6ee4df5a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15225b910cb8050636c11b4a607559169a7905ad
Message-Id: <176697566755.2394465.5640366715022617975.pr-tracker-bot@kernel.org>
Date: Mon, 29 Dec 2025 02:34:27 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Dec 2025 13:44:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15225b910cb8050636c11b4a607559169a7905ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

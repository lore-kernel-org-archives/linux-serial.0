Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA943264F3;
	Sun,  5 Apr 2026 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775409246; cv=none; b=ioWsxafgRhEIYPSKhUp3yJxFJLBuo67TU7dTBcsmIHrlTDT3p6USVu3bjS1Qwd2bJfCKCP4WDr6UpDZgIFAjHfEwkdyQ0Svay/pAMaAnmfg60tsDntQ7TUixVImbqKDkdSiK/b8zWH48pihAdzlT1dp1Z7VUk+elPxvgn1r9kbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775409246; c=relaxed/simple;
	bh=tynozaNxpqh0bM9BN3Xjj667A1Jh08s1atZLTmqfScc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HOnA8h328mcnuJpw/KhWjbSQ9fMpd0mr0aFIaST2AyQ4zh/o2vCWAanzt0rLmIf7A9N8QYnQUfjtLB1Ef/OL9arP2hhde/GGT4kEUdLsdUhWkpkiibmktsUoZOIep1bDhITLfl77gORh5iM8kPkhf5XO+EdtfmMpfyUWq6Vg8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wotd/FFU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wotd/FFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7C9C116C6;
	Sun,  5 Apr 2026 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775409246;
	bh=tynozaNxpqh0bM9BN3Xjj667A1Jh08s1atZLTmqfScc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wotd/FFUNjnvZDM2Seb1B5B/pDFku61lnVoJBgXtWW3iVrXVEYd+9w8WP6vvPJk32
	 OT+xPIySWYX2RgYvyAYxmQRgd18sEELBzYYOqv9DZIn2WbM0Nz7GwUdWgbDlbu77cv
	 GtbTEcWdaaFel6dWCprvU4PegRIhXikK3QywgDncLJQvOd6r4hWI9ZRZ7RQjgmSAkf
	 Stb7qCcBtp/m0w9yvzrLHszc5ctKqzy7p3tXt/XqRTJWlmyft3xC1f9ViT0YcNXESS
	 gRH0M6NhP/1zRSgm5OuYQ7BlsGVbjG371JyFHBDkpJ2YVyz0hX/xbLMSGV5/9xSGgw
	 wOTpV/IEima0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC803809A22;
	Sun,  5 Apr 2026 17:13:47 +0000 (UTC)
Subject: Re: [GIT PULL] TTY driver fixes for 7.0-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <adId31g54PFsRJ_s@kroah.com>
References: <adId31g54PFsRJ_s@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <adId31g54PFsRJ_s@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.0-rc7
X-PR-Tracked-Commit-Id: 3ddbea7542ae529c1a88ef9a8b1ce169126211f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a60c79bd0547adba3cefde40ced4a1f376305be
Message-Id: <177540922588.1998626.13511356825434672222.pr-tracker-bot@kernel.org>
Date: Sun, 05 Apr 2026 17:13:45 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 5 Apr 2026 10:31:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a60c79bd0547adba3cefde40ced4a1f376305be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

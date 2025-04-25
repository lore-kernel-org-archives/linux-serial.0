Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D284437C;
	Fri, 25 Apr 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604081; cv=none; b=sD28Bv9qOj56h7n2Sckoey2maoGGQjPMnid/9+I7GsiVsYgoIcR/1bKNdI9IuyMhIDDyYCwGAaq46cU9E5xICmj83yDI0bxoQr8FX+F72n4CYENz4UF8MqG9aHtrhXN4dgOrGK6kw4+bgT+h0dA6zRNzcco7bPRUt04QxfiQv7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604081; c=relaxed/simple;
	bh=BtCpv+SFXBMzqzF9HiQ9FacCyEHmigzwLnkdt11tptg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Nx0j3SuWt3jQECqZ6kk4Ra638iHTAJl4n0f/a4Xym7KZo/ZtwTMSDSi0dQeUIcZd1RY65a+XsSe6eJ/pGb3K5FoCQYFDjAKdYQIBoqOPFvPkDFmiL4s/JKYf6B8LJEPYqRLYPDx63Q0ZcYaYjX1y1pqJLoutGKRaLrE56eCo5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0tcOzba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0tcOzba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05043C4CEE9;
	Fri, 25 Apr 2025 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745604081;
	bh=BtCpv+SFXBMzqzF9HiQ9FacCyEHmigzwLnkdt11tptg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o0tcOzbaBUdZ+Zgy3w62MuACdIG+BsAgDVMG3UVTEmIncP5DWQYI15eQQ/5FT+Ed3
	 dyX2mWl2vtcLyPwXkVeriVwOss69wKkNk7aHQpeFLHQyAXYfJeSgkFCKh4aYlXKTZX
	 WG/91cjKF4sihi8MZ1CCON2lMRP4OwaJWei26DZuQ0qwfN7Aq5LeVLOChxMxNNjgb4
	 PcceaQxFfhx2VvOoNeusl9kCYZm2GOi24Gd067tYeltRZj8orcl/kwIJsyIe6WGtcg
	 +guy1iTLQcCqJXthWKTFXKu24VxRKUgoUvNXLtOyk2cP9/Uz60kI+rS9o5dPuDieTb
	 AczTDFYuMkdtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADED380CFD7;
	Fri, 25 Apr 2025 18:02:00 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 6.15-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <aAuSwdh2viW2ohGH@kroah.com>
References: <aAuSwdh2viW2ohGH@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aAuSwdh2viW2ohGH@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.15-rc4
X-PR-Tracked-Commit-Id: e1ca3ff28ab1e2c1e70713ef3fa7943c725742c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3648af4bbb7f44d306ac6a6c2686ce283d08635c
Message-Id: <174560411955.3790119.7735641869930041464.pr-tracker-bot@kernel.org>
Date: Fri, 25 Apr 2025 18:01:59 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Apr 2025 15:48:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3648af4bbb7f44d306ac6a6c2686ce283d08635c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

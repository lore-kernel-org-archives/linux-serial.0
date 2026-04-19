Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828840DFC6;
	Sun, 19 Apr 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614113; cv=none; b=X4cf/b4X7bKqdYrwpGVb/li1ZHKGmrcWWjZ0un2DPsWCGx/qpQH5DG+vNSaJUQTQT5rmZp/QNDpkv9ZOyGnRl0jjJs3H7OSYenqXIxOf8/jzZ4zFIpkjBpxM1DZFudiesqgPzHEauALxkKx0SIaKLSd+QD2VvbUk4Zo8NdxSFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614113; c=relaxed/simple;
	bh=uneKhuHlg+JeWesPPSo5e+Fwx9tkR03UBrBjlSPq9u4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CM3Q0DcYeTm/cszOgV/3yhoTBeJt8iYKKb641F+jpLttduRP2HFzDlfek26lKH15ND/AxYPcF6Hcnc2UVI0Wz9ozrulpivc1szpJMptCleg7vLKuWR0sX1VW6X1V7AV+YXRbGHvxJq8+UbSp9WybPGu4IOFrdxw7w6pCCEfK0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iik4wMUz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iik4wMUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257CCC2BCAF;
	Sun, 19 Apr 2026 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776614113;
	bh=uneKhuHlg+JeWesPPSo5e+Fwx9tkR03UBrBjlSPq9u4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iik4wMUzr7UnyQFUGlM/JohU8f4noFZ00RnamoXZWo1Gj1EJvOV0fBJunsOvRban4
	 GWzkPXxI6/TqhyVpxWzYdVDwELvE4823GHjYUF6092u7eWVMV0udVJas7beHBGRkl5
	 zFMIHSkZrw1d7j2tCS/zEvRMsXqrqBfcPDLEftvUvQue3Qe3a6Fr/t8VbY/ScZpQ9s
	 uCdH+1OzrRYFTjXbJw73JUj2/8Le1SU1mdd9iir0txJZJyY3geiofO9EkayLmaHghB
	 qsYgp4+Y4RkP7iQvO2UFYpRgf3Uj4K/y5ChUmb/47+SDMBXQtOl7gIoLo/VTL56uJk
	 uP9fQwHxSqUxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E08380CEF9;
	Sun, 19 Apr 2026 15:54:40 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aeTena-xiaqaffDG@kroah.com>
References: <aeTena-xiaqaffDG@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <aeTena-xiaqaffDG@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.1-rc1
X-PR-Tracked-Commit-Id: a1a81aef99e853dec84241d701fbf587d713eb5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73398c2772d04ee656a654c63db85851381cd147
Message-Id: <177661407864.808114.14628290952020131058.pr-tracker-bot@kernel.org>
Date: Sun, 19 Apr 2026 15:54:38 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 19 Apr 2026 15:54:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73398c2772d04ee656a654c63db85851381cd147

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

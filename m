Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F9192D6E;
	Sat, 30 Nov 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732990097; cv=none; b=IKyh/D3+zOi95wRe0qQkNweKcXrL0gmK+DC5ej6cCVYw8MUywY5pAyujfk5oES9EQt6/2w43UAAV1ayCFONezExa1K1cRCv1ute3C6Njx37tj+9AP/HK7Ehyd+Uq4va/YcS6kajuC6nNU2JV/V0XQRXWPQmAoZtNDKP3ROzg/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732990097; c=relaxed/simple;
	bh=Qau+AFXSd9vD4oiWpRHO+CA2hUi5q0a3TV5aPJWtQLY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OAjLTW2jWey/cbNEBsbsxbSwiAB3F5DBcT1pDbxHsu8aXGbMcWywTOK6tuxpVJaafASuhO3O+sG15HN4ms5fqNFRNxC2xFzaAwBL2kq0Hjqh5RY8K5JM75BhhR5tA6UuvOmXszl4XZ4B3vdazQmmLp4DqGhph3TcdXxtE9rLy7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QURUlMyH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QURUlMyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8961CC4CECC;
	Sat, 30 Nov 2024 18:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732990097;
	bh=Qau+AFXSd9vD4oiWpRHO+CA2hUi5q0a3TV5aPJWtQLY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QURUlMyHvA1KmIP3kWPJwfFzzIo7syNVNvCPNKXpgBzrnJhHS3k9WSeIQRh33Srtv
	 TVcTS0Hmfs7vtK7geu697gBTMCtS3tsNKDclhoXLUpUc+ccunoK81IfOcil2Ee5MD7
	 Bqmj0Fi+tGyR2A54vNyCIbrZrjHXbx5WTMg+SIqxqoOc+XunYWM3DffighCjQWo4wC
	 Lb8i7PoFZlTDsGESW8RCpMZP4hABIkERTVZ4vRczgWVnG8zCj7/mXLFKr4pTJz1Nx+
	 kurlvlaVcq9lCY67P3mi7nBN0dciZCTKiTtk2X0v8ICKjXyDmaNYLeiq98ILQBw0XH
	 CPMjg4ztu3zww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717AA380A944;
	Sat, 30 Nov 2024 18:08:32 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0lCihhE75lE9Zjd@kroah.com>
References: <Z0lCihhE75lE9Zjd@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0lCihhE75lE9Zjd@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc1
X-PR-Tracked-Commit-Id: b5a23a60e8ab5711f4952912424347bf3864ce8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 718632467d88e98816fa01ab12681ef1c2aa56f8
Message-Id: <173299011090.2443317.8330340376359997623.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 18:08:30 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 05:26:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/718632467d88e98816fa01ab12681ef1c2aa56f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

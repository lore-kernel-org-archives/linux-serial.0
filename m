Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31331F4294;
	Tue, 28 Jan 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738089000; cv=none; b=rYu9vdKejm1bq5JSdrqsiy0moZsvtSxMNt0V+HxWtdKAhyvpLgWhZaX2ifhsgrdFIjC7cTU0CkkLnBtycCoTwL0LmaTXMHH8Pni0xWnpNB73n12MS5DZsX4xHHGDXAbYBSmPeOBCa6B30EL2wmyJ6YoXFt3xsHQxq6K2FN1AtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738089000; c=relaxed/simple;
	bh=g/pwlM5MQtBiWp+L8knYQYXyZAVdVb3pV+yJXNPKDeQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nY6VQ4eMkIBs3cF36mWz6o+530YHFm7+RS+T64o8kaIyIal7rQuFAnvmo4vtbx4WDUtPkQTJhvSWoA0VuMFEv5EtRV6eNr0BKp81gtne2gUK6/znNMYyhQpsb2ghLKmrKLECxfeQrl1xKeS0UdxVouksRzpkytEIlmlL7ji+048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbXxL6ie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbXxL6ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8BCC4CED3;
	Tue, 28 Jan 2025 18:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738088999;
	bh=g/pwlM5MQtBiWp+L8knYQYXyZAVdVb3pV+yJXNPKDeQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kbXxL6ieAO5JMa7eVQ3Z7thnR03dvb+98b/Do1uPsJkWlbBzLgnnnTcbmbAd1KZi6
	 AD6TIH8xDvSzMYomds30EJrkgR1a+Q59OvdZoKzi/8dQDau9L1ElxNpjGYI03v7IRw
	 cl586z0O8Vr3DACBJ7JIL3CfzSEdr3stl5anUol8OlfRjIuv/fSCbWfhfRXLD+VwP5
	 Q8N22fef2M3WJ5HNvmGr0McX2GSvH/5Sm5JqmpVTYcGky72mlfiPNW1IYrI0+v0o4h
	 9KStnCUFmJHhT7KvvlfiwanDRzKzeEiCuKmbanflCSJsMgnQ+OEmdG7FXQ7Q1nQgiC
	 9eVTKUMOFhyhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 737D7380AA66;
	Tue, 28 Jan 2025 18:30:26 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver updates for 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z5jn5M5bdV5u21GB@kroah.com>
References: <Z5jn5M5bdV5u21GB@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z5jn5M5bdV5u21GB@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.14-rc1
X-PR-Tracked-Commit-Id: f79b163c42314a1f46f4bcc40a19c8a75cf1e7a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58f504efcda54a9079a38203acc088c3354aaa60
Message-Id: <173808902497.3882504.7197689889341138890.pr-tracker-bot@kernel.org>
Date: Tue, 28 Jan 2025 18:30:24 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 28 Jan 2025 15:21:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58f504efcda54a9079a38203acc088c3354aaa60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

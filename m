Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7FE2AD11;
	Sun, 14 Sep 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757872883; cv=none; b=am3t3RwXQd5cHEAkCt1nRSHst5g5gkBl901uFmpaOqAjaUrspy9hjOh/9cd8BSjZgh+az/xsD7IjM2xww/QsWWoU3YyCxqHxE0NTW5xsFfw8VC37Hf0yWs95x+7Sc1xJtiRZtx/uGgvj8DLcNOErW/Q284roB6aF5H7rLCisiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757872883; c=relaxed/simple;
	bh=C0U68A8VhNypMaOyVTm2T4TR/MVW4GCpkcKiMzYXhmM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mGst34sv1witPIduVBzwL4Atoc0Z0MiuhtW1yMeSCihx/jd8Uw9wB45eQWD/Tm/wqfWPe6qmWbBHehaQHLS5MkrI1ehTR2+Zb2iz9ahQ0/aaxzaCMsziZgqyCGw6qNGD44fCSGKKHtkGgqeUWI9Duwq5W3JABJ4TsmpdsRcMjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+z8V99L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+z8V99L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF23DC4CEF0;
	Sun, 14 Sep 2025 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757872882;
	bh=C0U68A8VhNypMaOyVTm2T4TR/MVW4GCpkcKiMzYXhmM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s+z8V99LHCsIPDn6z0CrCIv3qfykD5vwHNrhGsrADmkLXwPV/29ecIYsn2QHxpVVI
	 0JEfzEH0QK5zRoDHwkPjwAxQwlhOb27kjzV4HU1mghyEEXdjICWKaVbZplI59f0SRY
	 tvksMk+QgvI47w4eYAzdmY23vNGOt1dXSnDl29Ef7bkxJzvyrPgB/ELkdkxLLrBmGa
	 3bUDSkXRwzbZS1OKtuYym3oTgjuuJOdj8SZnAX6gbjI7JQ8bvcyGFdUGyUR5fmFEdh
	 pgp3pWv3UsSjW6NqL7P4N7OeMEyeYIiUIQj7SPv1ffPexZmBAjtNUtxhrSvOi1pQ8P
	 eiocKmMmnTQAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE17339B167D;
	Sun, 14 Sep 2025 18:01:25 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fixes for 6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aMatIn1m6zRXmzC-@kroah.com>
References: <aMatIn1m6zRXmzC-@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <aMatIn1m6zRXmzC-@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.17-rc6
X-PR-Tracked-Commit-Id: b5e3277c0f1c3439dd02b58997c06201d0ee8dbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1519fc7cd3e129f6a95143cdc92f01ba21a3c266
Message-Id: <175787288417.3518752.5002890004085024753.pr-tracker-bot@kernel.org>
Date: Sun, 14 Sep 2025 18:01:24 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Sep 2025 13:55:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1519fc7cd3e129f6a95143cdc92f01ba21a3c266

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

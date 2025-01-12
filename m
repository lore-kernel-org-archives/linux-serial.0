Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8881A8F9B;
	Sun, 12 Jan 2025 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736721378; cv=none; b=jmj77WTheK/KcG45TvVa+iOq4DxhEH5LrCHf1oEfTs3CUDjkVqb3o9Ae8GRxUWyuhCuqPOFgUtWAaKDnGDqYvh2BiaNazsfv6Q1oXdQ17tXwykChtowGvDgO/e2JeLdYZ1UGTvCvl9cg3JygP7m+LQyl8VnUzFtwK6sd1D5OYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736721378; c=relaxed/simple;
	bh=+fzAoxlY7MMP8oFXw0ulcPppHspy0ch2GMeo119qtD8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F7tRtvDVMRYq5U4SzwGOh6IcbLR3M4ju4ZMRYLZ8beMMpgkvOg6S0Dg04bZY/vdgI7bCLiZ8DmU/dGY5QgnAG0Z+kzC4ykPPxuwfqqWe61XWz6doX6UFTmKBoj+vv8+dMq0u8bzVPjrdovBi7Wk3ARdITii803pv8aYWaRrhpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTCgcZ3L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTCgcZ3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B46CC4CEDF;
	Sun, 12 Jan 2025 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736721378;
	bh=+fzAoxlY7MMP8oFXw0ulcPppHspy0ch2GMeo119qtD8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZTCgcZ3Lr+BWo+XUKlvMmGD4CVCxJwyawrDUcG+85qP86nV+IUXkwGepTDFXtX2xs
	 tUQbzsoCZsChg6Do+VcuVSBaOfvxOdRgqMnJ370n3WYVC0EzwjncyU4FxTmxOuCN3g
	 aJfoAVDhxPkNY7tbb8wpIYmHYvSj/as9GRh6oJGnM7tCjoatchJxSndUu6ODAaCIpU
	 GXXeo5jVq19wRa57nb/n0bGwKnBs5//OYi1isxBV68DfTjQpJPsd/CcxeeY5WNilmH
	 ryVVhFmmT2yqic2jwch6gBs8P9v9wPGceGZ4ZQn3WVANW6MlanHbYIDcyR4CZfE0BL
	 BGYi8ZmlzF2XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1C4380AA5C;
	Sun, 12 Jan 2025 22:36:41 +0000 (UTC)
Subject: Re: [GIT PULL] Serial driver fixes for 6.13-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z4PMKaKtcsI_zmU4@kroah.com>
References: <Z4PMKaKtcsI_zmU4@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z4PMKaKtcsI_zmU4@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc7
X-PR-Tracked-Commit-Id: 0cfc36ea51684b5932cd3951ded523777d807af2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bd9e3b4c514781ac96276fbb96985066d4dff2f
Message-Id: <173672140058.2663698.10453657658542018309.pr-tracker-bot@kernel.org>
Date: Sun, 12 Jan 2025 22:36:40 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 Jan 2025 15:05:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bd9e3b4c514781ac96276fbb96985066d4dff2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

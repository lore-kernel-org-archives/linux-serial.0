Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49D378D92;
	Sun, 26 Jul 2026 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096047; cv=none; b=TVXIcpPvVvBl2Mz1eXFXLHi2KYALMm9zo+yOQNIILVMmqOAL5wWYT3kaT5V/mM6IH34QVw1sfvtUs8hmZqwGnEaMgpUcodGojDlxZfC/ZYZ6Id69oKgIPqyZx6IOaRcfTzLZ93/d8sFvU/a+pLn0Ik5AZaCg/sBQclQ1M4kyln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096047; c=relaxed/simple;
	bh=Mnyjbyob0Ep3fq69JHkJt8R8nKJdy1rwjJSYHVAZE7E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s7DhQ722iR5a6OWSFKq6zJWLAks2oJR8v6mU39CBWfOuHAmZ2MFd10Z71qZxiZSIGMbribd8FzLBb963lwSNTlOhSfNb5NZOlh1ym/F/cCWct/5R7jNKOidH/DIAM4pLeQra0Y1XhQJNAW/mxWZQJ/PbRBf50vviqXFQECu3YHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHPqRvQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHPqRvQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48501F000E9;
	Sun, 26 Jul 2026 20:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785096045;
	bh=Uac/+cMuTAN0WGKT8+I9K+9jbjngYb2JFkPJoRu/PX0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=QHPqRvQ5l/gRPXTAOZ/bXSq8htNBYaewK5+9drLsF/hqb85YwUWgBliSf3uyeYeSy
	 wRD8KvilewBTkoMNU/B4cxVL2Q4YxJ/Ttxu04KFzHdEVXyKswKxGm3e7JUnC1kfkaH
	 J3GG1VDTNqaJsyk3NYAkTU+FJ+rJMg4AsuWgd8ze46qWQT74MauYsUDg6N933mfJZi
	 9W3pytkz+GsCs3Zp78FstsREyQ7wJYPX5aVmffVfz88hHOPbR3PCQR//uzbgkZEVcR
	 +xgAwvf5S4DKa/MODWy2IQ9SWnsFi4usu/fgpHocuVewjhvkiDEVTx/aJYRPjiC096
	 UpSP/olUGKRYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D138119F5;
	Sun, 26 Jul 2026 20:00:12 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <amYFJ1HX82HOiPjx@kroah.com>
References: <amYFJ1HX82HOiPjx@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <amYFJ1HX82HOiPjx@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc5
X-PR-Tracked-Commit-Id: af071d9e07e57cfff239e8d09d2f3b05ebc9c667
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d0a01cad2cdf06511c89d594f96f46a1887959e
Message-Id: <178509601149.3839324.15860364462078020606.pr-tracker-bot@kernel.org>
Date: Sun, 26 Jul 2026 20:00:11 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Jul 2026 15:01:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d0a01cad2cdf06511c89d594f96f46a1887959e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

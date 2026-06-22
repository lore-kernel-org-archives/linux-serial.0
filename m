Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7721B191;
	Mon, 22 Jun 2026 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158353; cv=none; b=hGdkflzgYwoMhDOsdSFnSFuaTMJWyuKP+OfzhWNgsWns6K47o8SU4BT4FSf4VUNpD/MfLttYasoasGnjd+n0ON2EGQU0OFAWURxi/Jh71gFiJqWuk688dY0oJSdUaWWZmm30H/iahOsXWVP43mMB+Lm7K8HN0Z8oOceyAX0fw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158353; c=relaxed/simple;
	bh=3AcQKypWTQGGUMcpVBY1Wloqmq9Xa303CaU0da7me6k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T0Ufekdd2dpwS7wbnyL+uXtE7Cn5Go67rjehG2AvWwnvtqtey5L/vNIzM2+StrVrP5oiLkta3bOYW6i97fKfvXExr7ZWZM+wX6I1N6nBVAzJmjhAcVkke337ubHvWSwdLn8NIbHa5AoDcyHdmxqjxeuwmlEYWiHVde2CCsrrkZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aan/5Ycw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aan/5Ycw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB36D1F000E9;
	Mon, 22 Jun 2026 19:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782158352;
	bh=0xYIXJU0oepUiiCfrAJgc0osiFBBtAqws17/bDdUO+s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Aan/5YcwJ0R8WrCmwC7LNTQSatRAIURU2ixC1s8iubsGn0r8kMLpVgLgQMhkKepnj
	 84QgdGx1IxT+Gx1XqRXPGCFpK1CS20qJUfeB2T9LotUkNqwdhRPT/vNaMmZzsAwibX
	 XcApnQorjQUHiwrYs6y1Yo4qM4AhFEhf2ni/7LX5zMd6WalLKUpDy6NOPxxE+6zg5X
	 f/z0WaIjAjS69dYnOir78dPJK1VPBu65o5oV0ff4HI0YKlDE7mgzKACpf17nrwkZBY
	 1sCUBO/1cuPqaMbA3mZjFh4aOTpTKQia0N4VYsx/05niA7fe/PgtQCMoMBgauiyisS
	 eQX9baKYmkOwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 572733930922;
	Mon, 22 Jun 2026 19:59:04 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajk5yWaG2fa05hcZ@kroah.com>
References: <ajk5yWaG2fa05hcZ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ajk5yWaG2fa05hcZ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc1
X-PR-Tracked-Commit-Id: 426e83cab1f5d53069ac7030cb03e2d7c6367ef1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a500fd09385a13ba598cda651f2e4ac40bfa578
Message-Id: <178215834306.1395317.17534278194168551719.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jun 2026 19:59:03 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jun 2026 15:34:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a500fd09385a13ba598cda651f2e4ac40bfa578

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

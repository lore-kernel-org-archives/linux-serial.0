Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792893110;
	b=Nu2hs4yxtWZkW4aVmMvM5+GOn0XiFKOFFpLV99Dmn6h1Cui+puwg5/6njvSqZubcfpoX
	 XiLngY/N3QGRUqJBxdBlp2JpEKLC8LQDPmyTtEsHc7DE+D25DwiPgqUSI+3oev8SrZaeY
	 O3u6ukVnMLinwy9/wVSN6r9CeW/gM5nlJ9VpoHzaTnPrciEvNG+pmJlwcNmvplT1dbZGV
	 q0HvzakUJzYrdv6opUGhfoVSG8IUmpyfB/SvoGhEAs0y0433H6s0/uSBg8zaeLQlr6nxs
	 zR8l4cH9Qc8hpimkXz7DK7c65sej+2tvYCzJ+Mx/UOhctr06Um6wW/Hzj2f7UXwx2qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792893110;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=ZlsraUFXrob+yhhIA9RI7pYk/VYqU0F7SX0vpqkg6RQ=;
	b=ABShfo1qi6hrjuKUyzxcvZxbWWJb4vWJYHiKQVbDTraEmttLLjtZrvwb4v5rEMUnNDQE
	 2zuV2+mfKrNVFj9zcjRC+hAEJgrNTycNKcKmOy9ogHcAA3e/Us1WXjMztYymhPKheKL6W
	 KeL8AN1EOxl8JFB3jN6XrdAR8/EIIEv3TEhfH0gcLEaFc0JrW49i0So4Wy+FKSEIC2J/j
	 OoO2/EqqFBbjB4+vcjtqpDkvNwnovtRexUiJI0qxa8VlxvbtW/djGTlqgqDQiB5O3Gk7T
	 EF/LLVAMarm2ArO0NgX5REuFBuYJ1s+blc6yl7IoGSI6ONi4ya2xXKoCYYFUzMfLW+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqXiBYUh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71B606A33C;
	Sun, 25 Oct 2026 01:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqXiBYUh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441BB1F01828;
	Sun, 25 Oct 2026 01:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792893110;
	bh=ZlsraUFXrob+yhhIA9RI7pYk/VYqU0F7SX0vpqkg6RQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bqXiBYUhYgG/MO8iU5CEBzlhFLwrAOoCoSVznSgcgN9KTbffg32iDvexI3j715qCH
	 7QDV/nbnQpavIU5XLRY7HsUXS3umwoqEpx49Sd/QjoPE/2fb1O3UnACl8jwAOpCwtX
	 neuk0WTRyt33wnr8iJR05sWCo3iM9HDEDTLX0a0ZxELEDKqb4tN1wixwFOxAP/ABHY
	 +kbZHwHaKE228EHauxw9+jNNiGuarjjeNUzBtcKoX4hutvMLpd2ZZPZBytkf/JUu1p
	 SdHFsXm0tmbKymFuomYRlWSl4QfnpY1EaDL4fFderqeLWFBRerY7WBhtxWqqXrC/DZ
	 G780B1GiRKuAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C8B0391B1B6;
	Sun, 25 Oct 2026 01:51:50 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver updates for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <atoUj_wOHwHCqwdS@kroah.com>
References: <atoUj_wOHwHCqwdS@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <atoUj_wOHwHCqwdS@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.4-rc1
X-PR-Tracked-Commit-Id: 1184f87e2790e8af9be3116f608d2e86b4792d7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb8fef4b07f71da01843457b66e579ad248a625e
Message-Id: <179289310881.1865536.2112926358130193084.pr-tracker-bot@kernel.org>
Date: Sun, 25 Oct 2026 01:51:48 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 22 Oct 2026 15:50:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb8fef4b07f71da01843457b66e579ad248a625e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

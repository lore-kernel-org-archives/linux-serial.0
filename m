Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E2192D6E;
	Sat, 30 Nov 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732990104; cv=none; b=pI36xEYJ7n7gLFBJGd2QwBNNQxzrKRNtTpJRXV97HsmPnz+/L6FEzPAgl4sRh1/is96mZueONXP9cP1B3Qf4NQgWna3Q6JC0R97NoKtN7+g5SamXMnupgPDhHIHc4o9k/q5OS3cSngvuSRoynKm9fM3GB07kcVfePxvJie0usnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732990104; c=relaxed/simple;
	bh=pxW5KZ2HiyJ5JV7zbe+8ojW0+7D0ht2CRmI2uHlrRCQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=POv8NbtRjHQLlAqc7alPpk1pIQB2qaGYyaWyN2j9ej3a6KZ3WiObUdjdhdlUgnKbp+HTdKZM3F8xpbw6854y8iToGEZ4YxieON2Jaq2+aAzgKM8LWucOPxNN9944WIVW7RXry3ZzFUMS5amXcNfyTrTECsBGQ5GdZVIsG2uWy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWpK97jc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWpK97jc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89444C4CECC;
	Sat, 30 Nov 2024 18:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732990104;
	bh=pxW5KZ2HiyJ5JV7zbe+8ojW0+7D0ht2CRmI2uHlrRCQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RWpK97jc3aTugmaWPMG1iPW1KlgG8OaE6D6NJfELTbOf8arxfI4AuagdBeK2DsJl2
	 dQwwT1V5W5ulOaZoYM3qLKkk3X30byYzerAOwpbL2FGHym0v43zNOikiQk3CNGvz8V
	 i8wiHlZamHwMjWGTsMGxAMSa8TXpk5IcRShV83QomUOreblIr9FlThwBJvrsH8zcet
	 RfCTcPez9cc9lXrI9Z6BowuvJwj7SMy3UHND+qDTzL+Ls3KxNwbRJCCxrKrQazq9u9
	 jdiQoiExMa2VZC5llGA64mOyhT3VAaUdM+m8oEYMAH0knb9IXmqon7DKkDU3vXP22a
	 Ce/ruzxpC5eCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B23380A944;
	Sat, 30 Nov 2024 18:08:39 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.13-rc1 - try 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0s3vuiUb9dpR-C0@kroah.com>
References: <Z0s3vuiUb9dpR-C0@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0s3vuiUb9dpR-C0@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc1
X-PR-Tracked-Commit-Id: 718632467d88e98816fa01ab12681ef1c2aa56f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8b78066f4c9c8ec898bd4246fc4db31d476dd88
Message-Id: <173299011797.2443317.5715448145724532030.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 18:08:37 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Nov 2024 17:05:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8b78066f4c9c8ec898bd4246fc4db31d476dd88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

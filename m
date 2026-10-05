Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C639948550E
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206868; cv=none; b=UJX23O4VfaCBjSASSx5SXbAgbhgJ0hWCupm5GqQieivs7JLfDEGndDUnipMzazj/b1GtcJXnN5L4QkGJbIT3rXyv4PaIVHysozACODrU2otDKN8z4WWuITurz5J49HH679XjGz5pngDP8wadchNbEynuTtcsH+nZzx4icof7FBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206868; c=relaxed/simple;
	bh=mG/vu5IGhDY/NX5x1XhJVx3p/RK/ahcPGUkyLMui0zc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r3QPKki2vC+E7lMDrGgXcwHOX9+DcLp1fnpxwnVl9dIqRcG/KRbAPj6o8QAd8AA9KJgT/yV8L0JXHISPtxvGm1BybDPykmc0wbXFExm2oUbKQVpbSiIDPO267PsGspGvu91wwCRYPXIisbwhE8S+mzBkluy/H0qvHR1KI8KuGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMiyl3gZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMiyl3gZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BF61F000FF;
	Mon,  5 Oct 2026 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791206848;
	bh=mG/vu5IGhDY/NX5x1XhJVx3p/RK/ahcPGUkyLMui0zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BMiyl3gZck/YvBHt+He+lmWuvfLYPjxzwwItubXLeNNBjNkLLx+IAsB3A220s6WHC
	 CsoZOjq1YGECNAF0fNty7eXT3CSO4k0Z6IuxEYKVWlVXZo4WAbOM9X2lgw5KdSWV6M
	 6FG4ShPfUR1jPstT0S63EXB6d9vBI1i8yIIDxy50xEqPmo1PElP/jFwJEwpUJNk5RQ
	 72XDlBkekfq0eIabLN7ZfE2nytAqMHqOR7yHl5w0ufoucntD+eKVJquI7jGe47emX0
	 ujJFXpSfFHjv/pppBGwHI13n0g9Q2nXtWNrRLx9ZAPAD4tHsQfpviCX9cgXLGiA6xe
	 0mZhenu04SbYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/9] serial: max310x: don't clobber the TX break bit
 in set_termios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-1-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
 <20261005-max310x-rs485-sw-delay-v7-1-6ae392eca08c@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:27:27 +0000
Message-Id: <20261005132728.44BF61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> max310x_set_termios() overwrites the whole LCR register, but LCR
> also carries the TX break bit that max310x_break_ctl() drives. A break
> is a state, not an event: TIOCSBRK sets the bit and it must stay set
> until TIOCCBRK. Any termios change in between - no concurrency
> required - rewrites LCR from the termios bits alone and silently ends
> the break early.
>=20
> Update only the LCR bits that are derived from termios and leave the
> TX break and RTS pin control bits untouched. Since nothing clears a
> break when a port is closed with the break still asserted - the tty
> core sends no break-off on release, and the unconditional write here
> was the accidental recovery - clear TXBREAK in startup(), the same way
> 8250 does.
>=20
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-max310x-rs=
485-sw-delay-v7-0-6ae392eca08c@vaisala.com?part=3D1


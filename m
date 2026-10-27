Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099545;
	b=aSoAILaQeBbNuq9wlY1NUeNtBcl0ke7ToHD6sxsUH9bFmmobBipEGwPSQuwoNh2bj72S
	 Qj7NznRmRg12TpDAfPNu5tvbHpAXosBd7gbJl9h3XHyzKdEM4RjrcquKFA+r/egND8ndh
	 NaHKj5+b0n5C3dZo9iF/gfB8YD2hXvpiUgKcjKiI20ktVV1cMQpwDjCWpY/LrCyXPXaIC
	 vNAjlMwwF+HCocczqaRdpUktuilk0/vEpVYLw3HYRtv29Mw9bWp1KI4u18ABHUwV0jzUG
	 xITf6edUNQCOolgAsa8yWhFkAS7XWLQL60VZ0SYPxRBnpwd9QHeVUGXYJW5lG1hL5BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099545;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CQKoOlul/b6mnGOb/W7X5BdvCwzSDzDIJxTVOQHy3A4=;
	b=sHrROWsP1GyAmXbvvCsWZ5eHv5YLWzBMtrMbUbTu1nURfhak/Pwv9CXVlwuEAQe/xC50
	 sqVax4i/yk5R3jdeP6Te0DoRsQMpWtjoFomKAG+aAbT6RQNf5Fv3QwtzV4W8BwNSg7biy
	 XvbOo7r0BsN4+T8HpmkhzD7EdnNDmM2jQg5iX/lrN/jd+LsIfDECxIRtd47F/E9VbcPtj
	 Ob1cY8j5/HThM3uBPHwW+i+F51gIWOqPBBG8QB2/vKDHYQE6eJYqv4TjZjBWWaehGTXSp
	 weWPgAZsnQGYC5jzVQuy83ZweuxlgrOjYONI+OXg2mYRdRgBvUGQYljND6ORPG+bB+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flD8PqbH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5B606A31D
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flD8PqbH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12891F01825;
	Tue, 27 Oct 2026 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099544;
	bh=CQKoOlul/b6mnGOb/W7X5BdvCwzSDzDIJxTVOQHy3A4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=flD8PqbHwlWMFIDJUojJ9aDp+M8UCAOXK7vumjcQXy1XhtMmLVPBefyyh+0v2yDhh
	 lgNyb4X+iPDSCpusFB3pErHrexdBmpv9XS7r8kb4LbX+kREyMv+FLXVUid5+SRHYCO
	 40B54Rn4EP6PD9jRkwMLWSVCYvancVQ94dTLL74I7dbA6EiLJm40zMbZNEGalawi64
	 /YOFortFT2lDg3+lepkO3tiZoYDJQmsv2kuBrEp3PqdjLaOOAEBiNEwuf6kG1P3I4E
	 PC1WQEatlPrMtpW0zWezGrSVMsUGWhLdP17spRMyksm9am2yaM1BAnNE4ERf2h2VlE
	 Po0Ou9ma/iyJg==
Message-ID: <sashiko-outbox-186418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/24] serial: imx: fix the tty reference of the wakeup
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-19-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-19-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:12:24 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> To report a wakeup event, imx_uart_enable_wakeup() gets the tty with
> tty_port_tty_get() and never puts it: each wakeup by the UART leaks a
> reference, and the tty is not freed when it is closed.
>=20
> Fixes: 0cfadf4bcd28 ("tty: serial: imx: Add missing wakeup event reportin=
g")
> Cc: stable <stable@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Robin Gong <yibin.gong@nxp.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Pan Chuang <panchuang@vivo.com>
> Cc: Karl Mehltretter <kmehltretter@gmail.com>
> Cc: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D19


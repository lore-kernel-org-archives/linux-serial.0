Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099561;
	b=SSXYame3pGq89lqaqtYnYV72oFER4m0aWSacGp4AAv5511jJ8q66KdxFtrPBCS4arU3v
	 wtSia+57FPEBq842/nkpyvwFjj0SjPqpquh5e0ck6GavGMF5whqVc3jJetYrd3v6vngD4
	 H5Bo0abdW8aU4A8dsef4C4Sl+jpdnjEhtRYOFSaZARQnpRWuj+tqM4GI7RQbwDX2WrWDP
	 h4/avtzT1K8r/TY1NX+rB6BK5gHtmlAG85h8YLe4YAsxf2wSUztdoPS1qPBhNQMlyp8kT
	 oKulk+IzIOKfEMdVWFKexJHBY4TMfRnY7WEWMKAc+AluLxfftw6+9ydklVWOkl5l6RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099561;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5lslX7fRwI/H1Ma0xDc34koIskluvoeTQBOcew7ZDKs=;
	b=FfbK+Q4t/HypcOZdUBekvBjltXVOO92W1g8f+cLD8Gpcyrzt49g1YKmY3ZcTkgCN76lC
	 Jz42YwfksOr9S4f5oiJ8z2mDA/c2wAelztjg060u5qhENpJQipcBQAdfl5Aq44CmV6tJh
	 x1W9dtwVXYzix6abw1ijPx5MvnowWHX6sogF9EenhUwWq4WLxpuLsnaiATA0wtz23qr4W
	 TBdU9avwqNDLpGgAoPz8yk+HLxCymCX0o8opXA2NhmsPYtRxf7uwL0CCg6MYsRwAwl0SH
	 9VHnzBaEGjoMtENNL0TojGlbePaqmZp4i+4W71WIwwGQWZHHIgKoFXtcN7zwFUeDCJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1opy0kE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E802606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1opy0kE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DBE1F01829;
	Tue, 27 Oct 2026 11:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099561;
	bh=5lslX7fRwI/H1Ma0xDc34koIskluvoeTQBOcew7ZDKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j1opy0kEtkYIVudXgYPpYnuLFRdICff/yeX0p3r0n+ruimjWBxFo65pLsr91CSMS+
	 AzZFGjgkVM9LmF0fZJ7tRpOEvbEvK8KzXasriXPvoBcefAgj11qMgM2TeF+1Bvd2m4
	 fqLX9RRjrsiHAq1s4sv0l2FyPUG8szgfEn36pGzqfRrnxiibDEQWNKByRVSCIFDA8l
	 B3S+mO+2E9bsDfx+EmIe4/oLNUn6wqBHEdYysoGMJ+ra5Wo9nPNnSG8eoND8gBuaXA
	 NTMhdWv+r11T+c90paWEsFO/TRGfgtNqauUwDNSMeAygcPpPk/dVd8Lf9px37Ebw2q
	 K1C9T4soJMkqw==
Message-ID: <sashiko-outbox-186420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/24] serial: st-asc: don't report a wakeup to a closed
 tty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-23-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-23-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:12:40 +0000
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
> If its interrupt is a wakeup source, asc_receive_chars() reports the
> characters which arrive as a wakeup event of tport->tty->dev.  That
> pointer is only set while the port is open.  The port of a console is
> not shut down by the last close, so its interrupt handler goes on
> running without a tty.  If the system is then woken up by a character on
> the console, the handler dereferences a NULL pointer.
>=20
> Take a reference to the tty, and leave the event out if there is none.
>=20
> Fixes: c4b058560762 ("serial:st-asc: Add ST ASC driver.")
> Cc: stable <stable@kernel.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Srinivas Kandagatla <srini@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D23


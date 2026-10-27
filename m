Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099924;
	b=PvgaACwl9sNX5SNDtVta8fISJcp6vZStZ773uDbJ1GMNPasSccVAF3yi9YiuOKHutn/d
	 5tikjdWJY7NSBX9dK3ucmBbK8cLqvccb2VapJKegBrElj3u4C3peIgviGIfq+uUEj1EEj
	 0nWAfjnctAjV5HehrLlcF0NUTAjsDVRiozvFWhDUSEwwI8qKBxujhju0LMpk+4k/V8o6s
	 RgK9qLv6gmtS4OWa6bVxolAndA/qj1AVuzPhJDZcrMKrS8DldZ2vHyWTIJD1UWzB08gWV
	 o5qZAwbS5JD/S2XOxKFaPGH+fIPvVdp3MSByJfkOU284pM43IvirDWaiDVVjyVZy4fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099924;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yEjEqaYwrK2Ud9tJD1KolehApwvEqJOUpjgkmRBg0QM=;
	b=DWxgfpUe2aKENvjdLsecbjJKIT7KjXHlMVtVXjudmpOMm7ZQoLmBHSELmb+yhNafzs83
	 StEGMSLP/YyVvLAUA71ln6jCAHbvTeZffY8Ift/mQLOI4U/Qu529PAwZld4ChjYMz6sGn
	 omL9fUF/sNhOEVRj0Eem0clSMvrAxRjFZEn7/jxialBcMEgYMePoehqnVF4cBtd1FTJ6A
	 o+4Q67VNn2kTRyaaMDu1PqXROipuZ/doReDpoX/9uJ3cTYt/mpNuGOUp/vB2K/Vormv6F
	 8vcErrkodWUEFki2lJW2CP2xPSotcfqsoqPB4e1795ZSUp2rK6uRqotJTwkNdIz2Rpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fm0TS6Fq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93238606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fm0TS6Fq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F181F031E1;
	Tue, 27 Oct 2026 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099924;
	bh=yEjEqaYwrK2Ud9tJD1KolehApwvEqJOUpjgkmRBg0QM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fm0TS6FqZRG0N4FeBmkCZcYnadKb7m2wC+F718N62cRMs5iGb6G7UoAn3jDMza9Rt
	 JtabSrHkg+qtqr4VqSxeCLD1j3azTeYPKzX9//Dgf0nghx8HVs1TQqw/MrnL6HMeCR
	 0O4a3yieWcf7eQiHH032vBUtcBktDKSseMjLbRvOfN1vT8A05hf81HYAncWCnnnQnH
	 n7oHAKkfLdLlck8zneK5pikZ4c0MpTXmfKJNvLxRCKBiJ4Ltv7x4hzewMkEgF4FMTx
	 3Xxv4o+uTCD0xB3h0zcES2WBqKdx4lXV/Nn++lymM5lMGdx9otgf/VrOeUd03Oorw5
	 LFK8IyW1qKc0A==
Message-ID: <sashiko-outbox-186435@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/24] serial: 8250_lpss: don't divide by 0 above 6.25
 Mbaud
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-16-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-16-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:18:43 +0000
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
> byt_set_termios() derives the clock of the UART from the baud rate in
> the termios, which nobody has looked at yet:
>=20
> 	fuart =3D baud * 16;
> 	...
> 	fuart *=3D rounddown_pow_of_two(fref / fuart);
> 	...
> 	p->uartclk =3D fuart;
>=20
> fref is 100 MHz. For a baud rate above 6250000, which BOTHER allows,
> fref / fuart is 0, and rounddown_pow_of_two(0) shifts 1UL by -1. On x86
> that is 1UL << 63, the product with a multiple of 16 is 0, and so is
> uartclk. serial8250_get_baud_rate() then passes 0 for both limits,
> [ ... ]
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D16


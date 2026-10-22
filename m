Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792639092;
	b=vAtWcT4rjzwz4y5lsOCu5HQLA9x9UBUczFMrGRPRHD4ZqiUMhVjxtnddHIErWhZFrABR
	 hm+WGV4wYIBDtXBFK/Pajz+C6dtMdZSFdcR4U7CbvXJOmGpSTLc8+cp8VHV0IJ6/hXAbH
	 BeSahVNhCUJrDjk9UJd3epo0uGFi0fj5gRDkmuxlfDrdG7F9NSzir/79h8buaNgShkXHt
	 tb3NkCvFgjIwx6Je09u6c04RvRyAOSZDZuVb91rxrDLl5GQtUePPVGKND4vJAadDxCddo
	 ST6AhVBNkWzEOucKh4MP70plw/YbE/avWu+HorXUZLi0Z11X0eiOU2VT9vm4ZDeBNpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639092;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oZVXMNVOkciS58mAG+Cj8NUgdg2hhDicWtuF2JjUrAg=;
	b=iRJQBymIhQlU11Dspq6WMBHOkKOA/U3QGoEQV/TqPKnoQaUHuJNfyAiNIsadVYw9b4d6
	 9+8RMOwAmYLlNLu2U5f8284747QO+LDxWIr4MOTN0Tag23yBsrjRetp/ZooYRnYdUQb/3
	 XIELoXzvwjsI39WIcFUD3JH9HPn6CgU0piBBRV8gk/QBpqQzXXhI9S4VTgocAIvMor6Hq
	 4ddjlurlFJGGuqdATrvq/5BgyraVmZYHS4Z2t2kRsjkTzlffUlhueFjEt+OIvsZNAAYL9
	 9LiW9nQDFl5zrKtX4TgBZE0r/+HINqjyHqFq0yg/XsRVls9Q+7bTWRFYnKCeiM3HKXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIfhaUL9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765EB60A260C
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIfhaUL9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA981F000C1;
	Thu, 22 Oct 2026 03:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792639092;
	bh=oZVXMNVOkciS58mAG+Cj8NUgdg2hhDicWtuF2JjUrAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MIfhaUL9whkB3isK/tQP5ankKNk8NQsNE3Zfo+F6LXcfD0ifNzh9prpIQjrtSgarV
	 0eBoeWPE9zUyBR2XhVjdKhp6y+7QUe0fJZ6WNeyzPnYgvzbzo1wQvSiz7nkmXBUnC+
	 VBxdbk/CMpQvI//G5FnIqKz2YScyJ17/sSVYDXb3/gSpnWU0QwB+8N2iEBQRlcU1rI
	 UCMQhCGuRzyzg4/gNaw5UCYMB0xFdZWhCx1yaYfGCvsQne8St25M3lpOTHGiuCjQHj
	 SAsTocKx3zf9iSNex4IV191vQSsjb3GQZ32D5DjLanLCMa9XM499VeHqq9Gnh3F1Ks
	 g32uYiwoMQyMw==
Message-ID: <sashiko-outbox-180943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tty: serial: lpuart: deassert RTS while
 reconfiguring in set_termios()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-b4-lpuart_rts_fix-v1-1-207f91580dee@nxp.com>
References: <20261022-b4-lpuart_rts_fix-v1-0-207f91580dee@nxp.com>
 <20261022-b4-lpuart_rts_fix-v1-1-207f91580dee@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 03:18:11 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> Commit e98ab45ec518 ("tty: serial: lpuart: only disable CTS instead of
> overwriting the whole UARTMODIR register") replaced the write of 0 to
> UARTMODIR before waiting for the transmission complete flag with a
> write that only masks TXCTSE. As a side effect RXRTSE is no longer
> cleared there, and when CRTSCTS is requested that write even sets it
> while the receiver is still enabled.
>=20
> RTS therefore keeps following the receiver FIFO level during the whole
> reconfiguration, so the remote side may keep sending, or start sending,
> right before set_termios() disables the receiver and reprograms the
> baud rate. The characters in flight are then lost or corrupted, and a
> short RTS pulse can be observed on the line.
>=20
> Mask RXRTSE in that first write as well, so that RTS is deasserted and
> the remote side is asked to stop sending before the receiver is
> disabled. The final write of the modem value restores both RXRTSE and
> TXCTSE as requested by termios, and the other UARTMODIR fields are still
> preserved.
>=20
> Fixes: e98ab45ec518 ("tty: serial: lpuart: only disable CTS instead of ov=
erwriting the whole UARTMODIR register")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-lpuart_=
rts_fix-v1-0-207f91580dee@nxp.com?part=3D1


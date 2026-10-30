Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793337487;
	b=4X6HBJsZbhxNu1059BFQFZC8gUcG2SLuMSEYvjbDXuP+t9ciDWAvGnWgFDTKifmZ0LmC
	 aqVo2P3XZYHDQ80V+HAnJLtv4eC/Ougd1sTbb5ryMRmCG5UjQPCZ51esqABDsu1mUDXYd
	 rbgDtkSx7G4piIBOahRUk/Kr0KfmDa3tTJNYw0K8PfQYVOoDHSGGXcaRU3lBJtICXAttv
	 ajbjv98HSx/CCtAkecS0PFPNQky4cP3OkRyDIvAuI01D75ledf6haeLU9OK3mXxTlBGMZ
	 5jAYN2G5v/dnycaDcPQH/8C7DB4qqEOcCCtkhQqqczWXnRaAtmD4xr08ybladAccrUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793337487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wNbR8dBmLHC0zVt8HhfjqW5fna7Tswbuupsio86mefk=;
	b=3tnn4oy0F7tjZy95LpNrWyhg2v5xG6Kwg1MXugcL69CnumY+/LcDtNPYXr0YHWRcagOR
	 tbf/DMuYlUi2/TDFRsWr4I4dx9dWbKlTe4t5JlGbWOzbV674zpfPsv1Y7QeRDPZsHA+Bo
	 G7nX15lyPDk+YQZqih0Xxpneg6JrxbOIRPnT7OBCBWj6PLizhYSrzIUJ9dgCJ2H5y3Nnd
	 gOGMyJxOhxZ7SHFmSpCI4ye/wy/RmUeerjDU++Ab+jj2YlFXQGQyKC+SSUS41Nc6koZkk
	 6v5XKj0pTPhmS7uoHfDQVH77TofJyVDZnXXvhgNlWmuyagKU10sCnb1+909BzSHRxfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaE0Egxw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9B606A31A
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaE0Egxw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DBA1F000C1;
	Fri, 30 Oct 2026 05:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793337487;
	bh=wNbR8dBmLHC0zVt8HhfjqW5fna7Tswbuupsio86mefk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YaE0EgxwDVOgIimXG1X8r7baEkKRkTgT/wot8IV54uLEhKQGGfhSlwJw/ECKvW1Fa
	 HqsC4cYYsjPrzmaoaqV4IL7J2DyA87ocDVqzuIcn1rG6691MrvBvxdzQpDJ7ZH1ija
	 Y3SDY2MIpNImZCmMlTVkfEbSEWPNcg2I2rKeXpuyLhppy0V78brCYSsDhVgAP5ID4P
	 b9t0bHIOPWauL722DthuIq7xmd92J/E2g8S0h1B/QKIZh+MClTRLH1F4dA99F7HylC
	 687rLZ5ZFqAhZod7gpaWJuTuiybPwthDdurD9UbYa04hbvGQJg2GzZtRUuyCDTwN7i
	 wCsGd/xxoYxbg==
Message-ID: <sashiko-outbox-190552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] tty: sysrq: reset the per-device key state when
 reparsing reset_seq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhan Xusheng" <zhanxusheng1024@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261030045854.153556-3-zhanxusheng1024@gmail.com>
References: <20261030045854.153556-1-zhanxusheng1024@gmail.com>
 <20261030045854.153556-3-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:18:06 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
>=20
> sysrq_parse_reset_sequence() clears reset_seq_cnt, but reset_keybit is
> only ever __set_bit() and reset_seq_len only ever incremented.  struct
> sysrq_state is allocated once per input device in sysrq_connect() and
> lives until the device goes away, so both accumulate every time the
> sequence is reparsed, which happens whenever the mode 0644 reset_seq
> parameter is written.
>=20
> After writing 56,29,111 and then 59,60 a device keeps all five keys in
> reset_keybit with reset_seq_len 5, so the effective combination is the
> union of the old and the new sequence: holding just 59 and 60 counts two
> of five and does nothing.  Releasing one of the three stale keys takes the
> key-release path, because the key still tests positive in reset_keybit, so
> reset_seq_cnt is decremented for a key that was never counted and goes
> [ ... ]
> single-keypress reboot described there would reach every device rather
> than only those that have never parsed a sequence.
>=20
> Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset seq=
uence")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030045854.1535=
56-2-zhanxusheng1024@gmail.com?part=3D2


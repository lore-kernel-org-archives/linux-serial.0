Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959332;
	b=DsLbP0KVeEbW+UAoUGLeqcw31iihqFGxvnq3IcECU1DCJLKkk12Te2i2AeVtaPWyy02S
	 U4BYTS8/ORdXzW0g6A6rIoadRIpHRTkpU7LtB5Zyf8myzFaaIGDDB6t9n4GXlqwq6h+es
	 TXjUfxgfpj81wXFhjNFNmNxEdKyuwREx81UFh21nEzdFauAg/yNHG12UaychcAmE1m6y7
	 T+uXKT+H0w79cwmutlNE6mzVmOen1hMb0yUp/sMB3l4dUq68O/7VN7Jh2KVjsESdBDiSO
	 BsrOfJcHNapmjkmePU4/bbnBLD0ENXfVHicE+oTR2c6Ev69Ck6Yo9+6QYwcEnl3+l0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oSgU0sEjkq+tigHF1ZpOyvXB1gPqYLS5br4E0JYoSMw=;
	b=Rbal+pirS/DXnsYSr0pGxqRdkQLEEqA2/+toHabucrtwNQiggoLoB5NGZXUrv52/DY3p
	 jmJ7JCTt1IUol//ExPo1lhsTYmADp9XBOdbXQVdUlgq6TRqkUVtW8wHA18Oj9DSa4WVlA
	 HYlJnfaOkRujEtG+ra+JNGE/YdxM1950nW6S+nwUXp+ua51poGLKXiaocJW/a+AHTtbex
	 tPHf7/01sUi0bofPZK7yp1UxDXSbcQUc/R6ubDx8dQPtlY0A/D8Vd3Xyudihid5xyDYjX
	 1erGyj4+TVuyPwf+olY9lxX8dRoXwIekVWtCpgstOMoYMbSbe2GfO0S6RQnuvnXWDmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLH+fFc2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616A6606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLH+fFc2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7471F000C4;
	Tue, 17 Nov 2026 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794959332;
	bh=oSgU0sEjkq+tigHF1ZpOyvXB1gPqYLS5br4E0JYoSMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bLH+fFc2Ou3jjKZlaTzRrwFoRNRNcjWO2vIoLDYrO0EORvXjSm+0nX8le1d9zqD/4
	 TSWiiFzKT4i2y75jvY/G6r8W3d2g1d5rL41hWxrrQHrm78gMnXopolE0WIQ+P/5n6v
	 ZeJW3C3/9a102UCA6lDquECY2pHLrlzDwqdab3SoCw1j+uuZM5W5F+NLGTE1OHBHvM
	 vnd0euWGGfLJ3nDoz0Tsfpg3Bv9qDKeGQDrgqW1/kwUmRcoshl/sh1xgThPpF6bHip
	 nMWl2AVY9CL5KFrzMM8615/11/AFf4oOvVdtBlISIbi2HXp21zTKOzeoMTwXHRHVIA
	 CtdBP3UTBW44g==
Message-ID: <sashiko-outbox-219812@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/7] serial: sh-sci: Toggle TE when restoring SCSCR
 in console write on SCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-g2ul_sci-v5-6-30b58ea18923@renesas.com>
References: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
 <20261117-g2ul_sci-v5-6-30b58ea18923@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:48:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Au Dang <au.dang.jx@renesas.com>
>=20
> When SCI0 (PORT_SCI) is the system console on RZ/G2UL, the board can
> hang at the serial console output stage during boot.
>=20
> ftrace shows the following sequence:
>=20
> 1. sci_transmit_chars() is draining the TX kfifo through TXI
>    interrupts with SCSCR=3D0xf0 (TE=3D1, TIE=3D1, RE=3D1, RIE=3D1).
>=20
> 2. serial_console_write() runs in the middle of that drain. It saves
>    SCSCR=3D0xf0, switches to polling by writing SCSCR=3D0x30 (TE=3D1, TIE=
=3D0)
>    and outputs the characters with sci_poll_put_char().
>=20
> 3. It then restores SCSCR=3D0xf0 in a single write. TE is 1 both before
> [ ... ]
> resumes.
>=20
> Signed-off-by: Au Dang <au.dang.jx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-g2ul_sci-v=
5-0-30b58ea18923@renesas.com?part=3D6


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588760;
	b=mcyBxj1Cb++Gb8yX2vL+6NpTc7/+fTtGXMB8QK3mdF985ETRTgbWdoGuiLijmmiVkaRX
	 NZTvo2Vci4T2nw2p9KeByjo5f5aF5/WAruUKbzqN+LMeVOT++XricdYil1BgNhq2F/0tb
	 PqUev5kn62QA3Sgk/Jen+ZWpsuDiNp2zBCOrbkNqb72r0lMOLEfZnVGL2xcSSYgVpeUg4
	 u6hhOtxZ88hs7anqk2KjS6Rl+UeegL1hxLa/m2N44vu42eMmQXCKk385qJsXHp0gP7EQ5
	 J1DTFP8ys6AxO1ic29MTmHvMF36UcaNp87HC14WvyvYmhf+FknHVCWeP0rlsHOkE3fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588760;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wX+ypAi0Bd7InDAjZ8AwCPFwT9uOr5hA5C2EE6mjTJs=;
	b=sR+qF5VlaKRkO6kIzzIuVOLgS/jMHrgZiQCYixPcjyMt8BF2b7JzHRMH428s/Tdj0gr7
	 qnNQM9YRls8owYGpLIyimwGCEXjDyLF1vkXKuhUASIrCLTHZ4WCJqKoRJLNCZlABSnhqa
	 Crgl9+yd9ZSOw5oFzMWnGyNIe3JDe6Tq502zAY9S7YUFuXXIvXOUT62b66z4UrrZ5hUNB
	 Uu1YsP9SYQntWyjL13ZbTqexL9qPHSj8+eXCgEDJZpKXQ22zgfx6VL/g94mUrVtoJxQ/N
	 w6n+bDJppzIV30FDZR1QVXBain4X/mstirH4pcW6w9Nvw008MqDn49GzCWRYOPyyTbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dw+bkzz8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB29606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dw+bkzz8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A0B1F000C5;
	Wed, 21 Oct 2026 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588759;
	bh=wX+ypAi0Bd7InDAjZ8AwCPFwT9uOr5hA5C2EE6mjTJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dw+bkzz8iVaynFzstK6fgJ6DMfiL5vp+NOYaiFjAixh+cM5OtvFnLixrg1R15OTt8
	 9dD5oVZKuGDP5ZDcPArc30JhAhdIp029LrbK+IWFidZpydbzgrxuPRGiMjBZC7O20o
	 Va/JIsXapv0Wh0GkNR0/B/LgLE6JxHelwJNkVWbqxt29mBuCL0vv71BQcQrB1fLVRf
	 +qjUsOhzBJby409Su2q76EP0zN+1arz2bKDFWc3p87EfKjFHCc26mUTzuaoaSerwv/
	 XwXmkAQCDD7jq7DbhxqresGvr6UYbPH1NyO8mVckcwy8OfEH4V92c30k2MV/lH+mXZ
	 sEZZoekkjkvxQ==
Message-ID: <sashiko-outbox-180294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] serial: sh-sci: Toggle TE when restoring SCSCR
 in console write on SCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Biju Das" <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-g2ul_sci-v2-4-b4e038220018@bp.renesas.com>
References: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
 <20261021-g2ul_sci-v2-4-b4e038220018@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:19:18 +0000
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
> TIE is being re-enabled, so TXI fires and the interrupted drain
> resumes.
>=20
> Signed-off-by: Au Dang <au.dang.jx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-g2ul_sci-v=
2-0-b4e038220018@bp.renesas.com?part=3D4


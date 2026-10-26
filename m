Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015629;
	b=yXcc14rp+NlXwMhSC1wl2SMQOAobojLCQ7vOax20mx70lUcGcMlzA9Zz6lw3H4VFwnpg
	 V1BGIY6kDnl82gJMYI/Xj953y0sRCH4B8oPlOaSMff10V7b7zNBS58+OXXcCCDXsgd7px
	 0VTXhbBncqBte7atbPoel2jIkR/xuUghJqEyIQ55F2vpYSC2dUo265jX/7SMzx4QHUlPU
	 TPAGT/S6tkzgkQXh8C5B1TGlgxqleWvS44kVgM/x6QDRSun5icmmL2zsxQSAWo1byLQiv
	 FTqhW5iDN+jXZCrMGjDlKQgRIkQL5dgoT/QC7Wcqzrn4kwuW+J81uDF40f4WjMizSQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015629;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ooCRqOsF0c8iJ0royztuCDgtFYoYVxoVtqdZ8DfSppE=;
	b=LFKNNU+r0s/eB4MrPrnUOjcErnsECuxCnI3SpCLgWRZYc9I61TDu0WpShN6BgFZmaRR1
	 G0bP/lER3ZGAdWk44tm0t6YI/TX9uLKX3fk1KsEkl2nEY6ZT50L8Ky3Y/2qE0cHU/N3+g
	 KsogVLBRdpU0LEMB2qjyA3pxWtrVhBk2kl8dW7KqA2rQFbLnavaKzVaiwusEgZCtsTv0P
	 j+BModp7HEslXm5MRXg04M/h7sadNJxFAi7JVo5C8qnvJ0jjSCKMieZg07buM7xuHrlZb
	 zcDoLugagRlo4P3N8Y6rbUszpFd94HXTBswIaL0PCEihjN0S6epdsIrcMDf3d5Z3l8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dQELSBK/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248D3606A323
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQELSBK/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912CF1F01825;
	Mon, 26 Oct 2026 11:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015628;
	bh=ooCRqOsF0c8iJ0royztuCDgtFYoYVxoVtqdZ8DfSppE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dQELSBK/EFwWkMDq4drlwSW6Rb0hwfb94QA1oFBlEoxxKzFmAT959u6cGWnvjvyG1
	 w6QKnVgMZQjv82YSl/SW/7v0VgUGwPh8a7aUGleMpbqeETYyP2KuSp9OvQE8A/I8qO
	 +KYzM3sju4ggISZrORPejtq5C2zBrOpMsEvBkinRahNBITPtAmu+Ns6vrzRWh8RX8C
	 fPLG00tkMg6dQx/ltfezqcb0vvUQ1ojDAhfxwXMJEqSBal+GRM92b5YfZp+4ptIMG0
	 VTNB8b9+FEvc5iO9vLCwS6bQmdIwCY4fZme8TtdCgXOxYExtNGFbsc6F/JasDlmWqZ
	 VX9ABOvpMUdAQ==
Message-ID: <sashiko-outbox-185130@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] serial: sh-sci: Drop TE disable at end of
 transmission on SCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Biju Das" <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261026-g2ul_sci-v3-1-b3097163edd5@bp.renesas.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261026-g2ul_sci-v3-1-b3097163edd5@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:53:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Commit f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on
> SCI") made sci_transmit_chars() clear SCSCR.TE and return early on
> PORT_SCI once the transmit FIFO is empty.
>=20
> The hardware manual does not describe disabling the transmitter to end
> a transmission, so this special case has no basis in the documented
> programming sequence. Remove it and let SCI follow the same path as the
> other port types. A plain revert no longer applies because the driver
> now uses a kfifo, so the code is removed by hand.
>=20
> Fixes: f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on SCI=
")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-g2ul_sci-v=
3-0-b3097163edd5@bp.renesas.com?part=3D1


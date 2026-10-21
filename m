Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588699;
	b=b/1P8oDmddZOyFsOGoOYsllt9zvasml20qX5fIal8wYhnpqcpJIl9cqx8+yrH/MjYEaB
	 yxDxa4urcRsQFhwo5mPN5edczoQb60O99q2n2X19w59MpU6RPq7P07dc8zpz8hUQQYaOh
	 NcECdCFehGohhG/i+6h1Oav6rCR4j8nUUFMDM4vLIwah3OJ0mL6lVdrwOH/IF6MYjXKIs
	 igvQ3Db3YN0FhLaM8trfBIPZ2/fmBLNn0znq86EF4593T5SN+JQmzufE74Vzjo0nQItI6
	 Puuw6e2A0LvCKjrAV8c7FOewZaAEN9TvvKYluzx3VwfoZ2mmxnkNeKxdC05zAkOy8Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588699;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PugYnZTmn80FrPKTSxyd8f2ns4fqO15VO9O+isdGJiY=;
	b=0lyxrGB/DfmSg5HqTwZEICM9AzQgYVYAvbPdGZym6p4Y8o9Lw2uzNkU+oAuGGHGaAAF9
	 DzhrwleKKNLYtGQ7ryloAlKmZ2GIbulOWsncKXOJy7f/uzIYy1Z7jqqvIWpjiRRQ/bnRt
	 /7nmpb8U8enULp7kkCsua6dxORqRkH9gNwtFaCAMNxuMVsu5sAqkB8Tc1V0J+EKt0QbFI
	 6tNy93hLBkP5O7hJiJc+1b9cQtNzZyod4X90eqcNtGZGGz/c0lz9OHlH/2ul/sPyXgjnH
	 Y2nOvsGakaL2AmnY93t9zA9G6+XTWAM/YzgsxCykMTcAdgbo60J8LUjCsAwu2rsYLgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIDohCss;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3631A606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIDohCss
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9881F000C4;
	Wed, 21 Oct 2026 13:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588698;
	bh=PugYnZTmn80FrPKTSxyd8f2ns4fqO15VO9O+isdGJiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NIDohCssfO2w3f0PDC7/fRqms5TaPwvMno1xn8cM9Ju6IcvccNbR5nOzbtgEkjL5J
	 gf8NaEVXGSES/4cF+g12OtfRn1/5LfNjB+m3woeaekvXK+e/ULf4sMw0HFDnMNe9Bm
	 6PeUl6iLd7bc3Em1pgGtVh/RiUXbFhcu7f9t2jNkZxJeHzCXK14MKMBOJTInjXVEZ1
	 WL3kknvWvCa4EXlltPZWNkozyVnUoGYcKUvrYpZ+JAI0t2z3x/2URJkhprr7UAYlPD
	 dEwgzWqOLIcPS2CyoLU4lw8TrrXum8BugOOxuFCL0eJroc/Vuufn6v71ohVxVLbrea
	 hKq03nYL1Oq9A==
Message-ID: <sashiko-outbox-180293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] serial: sh-sci: Drop TE disable at end of
 transmission on SCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Biju Das" <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-g2ul_sci-v2-1-b4e038220018@bp.renesas.com>
References: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
 <20261021-g2ul_sci-v2-1-b4e038220018@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:18:18 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-g2ul_sci-v=
2-0-b4e038220018@bp.renesas.com?part=3D1


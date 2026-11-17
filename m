Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959354;
	b=ogP0cF0n/2k/+/4whWyK+UiQ4pCnjqwKAQCSVYEcO1156HzaF/B92XQQWeVb9Zq/HWYc
	 LUzRdZ4+jYlCdCpcST86/gsgckqA7N2vZUbezdAch9W9hYMbHuurEbD3RQGtl3XoflSRw
	 U6HdPnjXdK0+0sp8XfkuuliUeBqlQ70Yyg2j1eOs6XGimJGXUQgXBGXBMdNWW+U1fGKom
	 deuyr4as7j6bjWeR7SnSJ0gLVG8TqkxbLUqEHx+JBSn8ryc5XRSSwGpt1kOibvrsLUA6p
	 Fv5dg3zQ2IJ6KJMuA+3R4upZmzXAAxYV5seVMbjxULL6/I+c92RGgBUdc1xWfxJHVcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959354;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=50h/PY7xhI51tAk7Sc2w2n+JXmDbGhy41gpC1v0sQbs=;
	b=wWsEDoHX9+LmkvJ1vJwK0TlnSzAgjZ530WxNAGVsvyhFOHMqXTFP7EcjqUpb67/hjeXP
	 jnvloWyeoKw7KIAMz+QMLFDFwOHq1NvfSsbXeHNWxYO+1HUGumyAWGCItxcyQJVC9xLSt
	 04RaESaq3fGY/dCSxTjTupM966Zh9aqCEG+JG5uLutyZ1YLRte5sHSTOdl2ITAr744nJt
	 SpA1V68rcPkbSH+7WP+l/jNib7CsJSqjzIQPYPNwqK+axlRt1Lon1N+tSt+U4wAMlL/0G
	 jmHuhrXipvW97j0XsZTQ2FA9Nj1/V0VuVrAPkdlvM/T6RszBlnPMSPm3hRynRibsMRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1IpgcFm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84F2606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1IpgcFm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088161F000C4;
	Tue, 17 Nov 2026 23:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794959354;
	bh=50h/PY7xhI51tAk7Sc2w2n+JXmDbGhy41gpC1v0sQbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1IpgcFmUs73+8BlO7+SvXTXXbSLfZ0ld6y/vadJfRe0uuu7y5J3xPSbMfd/9Htlb
	 S4MSTFwyrtkXCsYckOJ8dxYJbul3HTwNHucbidEULOgrd6CQcgPg1HRnxtg000bs9/
	 Md8Kb0YqNXe8dDGxUMQizJCPJjlbQCA825CknQkvbyTm1iNhKkAaXqXjrmORNH5R2e
	 oUHpcGXhZtEbCqn6lpUvzKAs0uQoMHDQtfVTudc3jF9DVJERnRNeMb4bdJ+mvH5NE4
	 1EHQryaBCXNPZ/IgqbJkfoPlbsYjQxAVdXKVwRRlVfRlYnSnFTKPiZ0A2JU7P48fWU
	 fnMSjNM0MWnKA==
Message-ID: <sashiko-outbox-219815@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/7] serial: rsci: Simplify rsci_transmit_chars()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-g2ul_sci-v5-7-30b58ea18923@renesas.com>
References: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
 <20261117-g2ul_sci-v5-7-30b58ea18923@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:49:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Now that sci_er_interrupt() no longer calls sci_tx_interrupt() on RSCI
> ports, rsci_transmit_chars() is only invoked when CSR.TDRE and CCR0.TE
> are set.
>=20
> Drop the redundant CCR0.TIE manipulation in the !CSR_TDRE guard and
> call rsci_stop_tx() instead of open-coding the CCR0.TIE/CCR0.TEIE
> update when transmission stops.
>=20
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-g2ul_sci-v=
5-0-30b58ea18923@renesas.com?part=3D7


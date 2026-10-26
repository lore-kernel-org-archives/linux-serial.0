Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015530;
	b=2hOBz1MOhdI059iVXZ+vwOVUZWfoBnIPuzojnzaw6Z1d/7WyoP5v3EkNMzjbDTu32kF2
	 K9qkYi2Tiv8I7quIgRSVtao2oGY2Q1jw/k5pfnGZNjY8GX8QhBRYYIiP8H7LWHnRDDDlP
	 cZeLpa0JjI6UR7IS9vBfooHQJe0H+RxslTDqL5/vGMG/4RTeVgqgRlxo62HU8VFgmmCIF
	 udhvb8nb6SEtAM3uTq+fSmPnrr4MAq6OZA3cV/w3ffy+ZGXTjorzDK1YgvK2gU5owR27e
	 VN4JgRH/x6wF0rK0lODlkUeiw2AyfWgdzgfb3UE9Ugm7TRhmz6Poz4LoW2yqeVRGQQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015530;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=++akW+Y+UN4VHZhNnaqivkOJze5FF84pAlDiKpmn0mo=;
	b=4wiFemiANVEIdIcndJNjhvjDEsh2jTu0S4XAOJbaimx80DnV5W+UtjeMBqA571+NQ56b
	 Qdv7ZprByBKlc+TmGUM+MLGteh3TKpJO6qrs9CQViy1RWnSk3Is+AVa4m+e6q3mnjtF9j
	 5GdfhdiZA06cpvmipP5kS3OXuqZcZQcYAy/D8OGXNqVOVcta99H2rAZbE+aNPylfMf4EQ
	 veM57OH0460KWSE8NKPGuE2IuNnSvTBfEI29TQeg4LJi4s4NkTM5ojzI5zNBe2aQns4lZ
	 uTPWfEq/jmZM9S1+4jDkSEjb5Jkdpofg51RoUvpbMhDda1ipEwpBwIsEwzM1tTj9RHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cG0kM9L/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31477606A33D
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cG0kM9L/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877D61F01828;
	Mon, 26 Oct 2026 11:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015529;
	bh=++akW+Y+UN4VHZhNnaqivkOJze5FF84pAlDiKpmn0mo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cG0kM9L/jEFzypGYu9nEjjjsRk+f5YeACYc/0d9vqdlKJFgbLT2NSNcDhWmReVSz3
	 Sh8vX/x4+mCw8mvRcpQ80/u5WPh9hPIjS+S10NPaCQTWyWq7BgaZVg6YRfa1Sur9CB
	 IdKRy4yS6vdYaVOLB1O+86ddVA8WfMz0I7G9mRGkYYezH8lP5bsGVicMhGEmOGpCgq
	 SdmairXloKLM1Ibm7G1lodL4MM0KyAzIxHIoXMVjSpYHE37zApGbcly3dXFZZ028nu
	 k4KgUmmUcnIrGqpfi4kiz1behWcoEFvAHZlmySBTiRCzz2r/FDeFSCwra65tbzT0Z1
	 KKkkwuIGOWCzg==
Message-ID: <sashiko-outbox-185121@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] serial: sh-sci: Skip TDxE clear when hardware
 clears it automatically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Biju Das" <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261026-g2ul_sci-v3-3-b3097163edd5@bp.renesas.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261026-g2ul_sci-v3-3-b3097163edd5@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:52:09 +0000
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
> On some SCI variants, the TDxE (Transmit Data Empty) flag in SCxSR is
> cleared by hardware when data is written to TDR. Clearing it again from
> software via clear_SCxSR() generates a spurious TXI interrupt, causing
> the last character to be transmitted twice.
>=20
> Add a tdxe_auto_clear flag to struct sci_of_data, propagate it to struct
> sci_port as has_tdxe_auto_clear, and skip the clear_SCxSR() call in
> sci_transmit_chars() and sci_poll_put_char() when it is set. Enable the
> flag for the PORT_SCI (of_sci_sci) variant.
>=20
> Signed-off-by: Au Dang <au.dang.jx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-g2ul_sci-v=
3-0-b3097163edd5@bp.renesas.com?part=3D3


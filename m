Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727889;
	b=kT4UrzeRY6UiF1J7rq0NWqBLVgpqr0QYM2usyRvd+kyDoT1SxjoH86s9fKJ/Z5pbRpUB
	 EntDf5yI1yKsI31hJxQkxkAXGd4Ri8fG/Do//CxNVvLITITz90Yczqak9IEQSHdi53YkZ
	 3UyfhsX0d4kAROVIwHacSm7ydkXHUW+Zw6MPLJ38XUVfB4iz1QHRvIAXoEZh9EYR/aEFu
	 R5Un8fNNwn2DQ5G3ROi/FMT+d6GTEBobaa0wwXxB0C9aud1Wenzkr5gc/ki72AsdkVamE
	 WwyGTy4h+40fnElv419sQrmP6MUFN7YOV8k/n8w12fpuEl1o5jIEBCORxbNo2w2iCfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IzFKSxuu4m41LZMj2VLvpbK2gHDdjGYHMPxWvUwctfc=;
	b=eirn9nKeCKFJyJlpzopldjjIALDN9pZULMKE0uTkwh87w/M/hehz5Da92RhRCe2/Mseu
	 SBjqcb2cpIHW+2zz23JsHJsV9LvEX7mWKgIz55EjmxKeWrWs2IszPdDRRVi+Cf7uahEcd
	 +d7DucjBhSEJcZjyGWMovZArclrYwGUEsxFZULLkH8YK1R+dqYkygRd7pSCl34JmKlD3g
	 rxhDYujKAlbqSn4eaR2VNn7TjYKAClLx1eC40NAIttK2cK4Flg4ftj0vTHRp8JkqEka3A
	 kJvxAoHvAGkqMLA5uH1QMSpcVivgvHLpxgI2E/36Zjssq0GHHgH6duWdajFvkf93veA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MA9+mU/q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91F606A31A;
	Sun, 15 Nov 2026 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MA9+mU/q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F091F1F000C4;
	Sun, 15 Nov 2026 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727889;
	bh=IzFKSxuu4m41LZMj2VLvpbK2gHDdjGYHMPxWvUwctfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MA9+mU/qqPpdx9KjDqWocTtpcnAvh2YkXBaD2PfKgHeduhWrgxlPiXcJmuVcf3yUy
	 g5mkgiW7Hq+Fcw2ZtiDP55w928oCYrPRATJ8bubblQvBUk18T4/gYP35j51MgPMTGk
	 QXWKwMl9ndBcSPkr3xc6NHYMtU8N5qygQCfUFzE7ZIGQ2SruR6G1mdopM/s1YH09Dm
	 TNurhNhxObtT4AuESeUZODM/vvoQTI2u73LA6b+djefSK0MEsR7lrMygFm4nfDrc59
	 CCRdFgXp+BHXCDLmTjM0kI59aroMYu1dTdzRUMOv0xFeDgLAx1Jgm3rWdEvN6hQZ34
	 N9Z0aYb3zxo2A==
Message-ID: <sashiko-outbox-215262@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] dmaengine: dw: calculate residue in the status
 getter
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-5-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
 <20261115-submit-dw-dma-synchronize-v1-v7-5-8d58f3d49e4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:31:28 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dmaengine: dw: inaccurate Fixes tag in
  dwc_get_residue_and_status() fix
--

commit b5c22abc9b7baff822cfeb84f5f8ea11d403b05b
Author: Serge Semin <fancer.lancer@gmail.com>

> dmaengine: dw: calculate residue in the status getter
>
> Calculate hardware-LLP residue while looking up the requested cookie under
> the channel lock. The scanner and the status getter currently take that
> lock separately, allowing a descriptor to start between the scanner's
> residue update and the status query.
>
> Have dwc_get_hard_llp_desc_residue() return a local residue value from a
> fresh LLP snapshot. Keep the persistent residue field for software-LLP
> block accounting, subtracting the current block's progress when reporting
> status. The descriptor scanner continues to advance software-LLP blocks
> and complete cookies from RAW.XFER, including for polled transfers.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: retain polled completion and software-LLP progress]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

[Severity: Low]
Commit 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA
controller") did not implement residue calculation or dwc_get_residue().
Calculating hardware-LLP residue in dwc_scan_descriptors() and reading it
under a separate dwc->lock acquisition in dwc_get_residue() was introduced
by commit 4702d5244ca9 ("dw_dmac: return proper residue value"), and
per-descriptor desc->residue lookup via dwc_find_desc() was introduced by
commit b68fd0976286 ("dmaengine: dw: move residue to a descriptor").

Should the Fixes tag instead be:

  Fixes: 4702d5244ca9 ("dw_dmac: return proper residue value")
  Fixes: b68fd0976286 ("dmaengine: dw: move residue to a descriptor")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-submit-dw-=
dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com?part=3D5

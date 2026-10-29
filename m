Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302042;
	b=Qhg977k2mEqh0sCDFtmukUrtvCEha74Bn+fUYF9Q0PxAY9TEUJWbClJHOAK8dAsFUXTs
	 ymNsLRQAbjwEf52MTh/iXiYtszjiFsrvAGUn+/4PyHXsmoJ4J9iINl9WjSvuJ7HJr7JnI
	 TULN7OZr/PHivnK1jsubYpfxtdajitP3MbmtGhlNs7ZVvjQ6rHyqzropZx2R54LGjYxrl
	 TEIvywmMSnEDQlGdTasDyzjT37m+mIMrKomVtxUTvVYStrAcmy6dztwYcourXJeBrPXyj
	 BGztFkQkRHgF5dSRwIPSeN6lvEUdHYoCJSjRMk/d64HlqfxXwV0ziuKHChWOEx70ScQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302042;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SFj86VXEA3qtxfMK9+NqvEgV8zRf7vGYd3HSSXLyyiQ=;
	b=WYXnHPaj/W9lNbME5YStgzkgc8boBP361I+Fv33mQ7/W3PsOGKURLisjBSkg6tRttcPG
	 aj0a/tkzjjNJ2AGbJ2x5pGxdP46I166dyRJ5Iww6mqjw6LvajS+wP/S/bIiLubx5ymUvT
	 Pu9sOuhRJCqRIH0Mtghsq4l50fQwfUh2zEeiZK/i7ugzM7D85GJp0Mz1WOu3lU0eVFzHW
	 aNdwtBqqKE2qs4uPsCyJQoeEaDpIS6glEGEwuf43jMmRVkAoJ4ZWpcmKMk28538bOTpB3
	 zuCyEogv1B1mvJ9Yk5paURO7+t2o2QFpAxaOd8m7vVc4rb66elXsDDH3TsUd1OPAirg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HervOFEz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A0D606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HervOFEz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282701F01816;
	Thu, 29 Oct 2026 19:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793302041;
	bh=SFj86VXEA3qtxfMK9+NqvEgV8zRf7vGYd3HSSXLyyiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HervOFEzZk6yznP6XRBw+7ZaJSGPsm8z/shvvFIViSTTgq1IKjWUeITcFct45rNwy
	 RTrkq6QNH7PG7KYiHQ9oxlpeq2RRoecEIBh1I0gYteXCzGyKkaCJcqQaGArnLLETJm
	 ffZSLGEiIJ9/pRkpAEMt4SKl5sTUjoQLpLDJF7gYtRN1yfa7SuuSvLOQqKkfszWx6H
	 P3XwDJI4flOC+PAxnNjA9Hn7nPJEuJFAUy57pzxx8ZGuxgDopkZ7Nk+atDTBvXkfxA
	 bmzMXt5sClbyzB8+YzQFyvDKMpBIoXIHce49hzL0O+QQWVCqAmzQ5Y7DuozOLxXA9x
	 WHFpBZvzTWtSg==
Message-ID: <sashiko-outbox-189879@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/8] arm64: dts: allwinner: a523: describe the UART
 integration
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-8-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
 <20261029-submit-h616-uart-fifo-v1-v5-8-53b433aebbf8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:27:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Identify the Allwinner UART integration on all eight CPUX controllers.
> The specific compatible selects FIFO-depth discovery through FCC and the
> Allwinner receive-trigger mapping. Each controller supplies its own depth,
> so the same compatible covers the different FIFO capacities.
>=20
> Retain snps,dw-apb-uart as a fallback. The common SoC description supplies
> these UART nodes to the A527 and T527 boards as well.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-h61=
6-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com?part=3D8


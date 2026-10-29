Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301740;
	b=rW3EBoM6BtelxY7cXuLvQVVOrKvBugAWDPyFBUvp8MLBBgc4BkakJ6vAlTjMS5AAWZOJ
	 c7v6hZcVv3aBCJ2KOJgkP60tuT74g4zHR+o6ZU1ZULVD9tDTCgmnVSCrrzM/i5+OLDe/4
	 whnjK52QMSNwsham90UoZ644Ufp8hAmNK5nSj/+Ro0oQRNyvAggRfvxvMWVXGNe7rAH5K
	 Z0iWNlVgyTOtxns0MgRLSFmWsraI1NkiZGY5DraeCFOGAXHO5m9zBG0xSfwLyPqU0J8gV
	 frMKCDMfWGDdgAntDBxuIdfNDUkigf4jDsw4N7TMv/pb1tcNfwKdGdKCe0TWHw0jv2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301740;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=erdn56FlWdw5dHZbEBIhxWfrYwYRtU14HbfYZwG9QKQ=;
	b=or2GB93k9DFUMe5O7mRJjcyAeFh+rt9BhEIOsszMjKovmZPXapqBL5OTtbSxJedzV8Ie
	 VLrhF0aLXCR63acRBMLh7lUSMKx+JpPhkO5atoA4lU5k+i88NyMkUQDP0T53TCkmDkukP
	 VyWleYNj/5JCRhwRubUpZ3HL0DMucg/6XcKnWB/v5wSB5ZxBCGUmwKO5NJcM/3va7rBfm
	 ryoMTIzf+h7Wv8ltLL4g/IJ+bfCmWa76x7qfw1d7xBdp39Lq7pPQcIoICGT0OKSrc/YxX
	 jhUTHA6al0QFDI0i2EXZ8pr8e7p7xmb9Eomr8DmV1B9XUnFxjKT/bBMDiJ8X6nex05w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duL65NIr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F60D606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duL65NIr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BE71F01816;
	Thu, 29 Oct 2026 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301739;
	bh=erdn56FlWdw5dHZbEBIhxWfrYwYRtU14HbfYZwG9QKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=duL65NIre21jRCYU2Nut+03J0ebAsf6Bb6SVtV3WAO7bP8GP4CK9sb3rE+DVCvdIH
	 UAvUowGNBy5vRRUgbMANzmBaW5UY7MpxsyNb3857hth+KPkEOiYkzbNPOuK9mkK9cy
	 xVZtyCwkHzORa7r7cBHq6qz2YlcLLHO99MvvSRvq+7oiQEWeiiFRMJxi96A3BrPK/+
	 bASVqgvTHqnFuF7r4ffZeWsvDX5Qc6RypBA+0wPwgcPfg2AwyPPqETT6KX5JQdY63M
	 x0NcgijaxxdEzs36ht4+NvETWI7YkAXPTl1o1yCZyumPbPL+wP9AGrmi6cO17eYSaD
	 7sQGPcq29OaPw==
Message-ID: <sashiko-outbox-189868@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner A523
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-6-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
 <20261029-submit-h616-uart-fifo-v1-v5-6-53b433aebbf8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:22:19 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The A523 UART integration has different FIFO depths across its controllers
> and reports each controller's depth in the FIFO Clock Control register.
> Its receive thresholds are fractions of that depth, and its optional
> register layout differs from the generic DesignWare integration.
>=20
> Add a compatible for this integration, also used by A527 and T527, with
> snps,dw-apb-uart as a fallback.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-h61=
6-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com?part=3D6


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DF4E4C3A
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780774; cv=none; b=hVmHq6tqVLAJan9VJcn0JTDCSyqw7+7wXoupDQoWM3dZkDsng2pTeoB9ScHMK/eJP7ItqgAp1P0/93ra1ESjyQMd7WYNsN5kexVmKT3n6nCxjsin4UjJTo8IuhZvjM2SOzA1TmUSFaoMFNFmB3F0wCAnxW2xyAOBmD8IFAdkd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780774; c=relaxed/simple;
	bh=nUdhlsA5lrlJDZGzH1VDlWQNRLJ3CXZrhBbiI0N3K6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HiRey0eclMJ0zUf2t+oHhpudAd1sjrQJc3jQ/JQ+SNEyC72sdj4IyU+hAh35J2v29GoGp7fVKZ5KQAkvcOumQNWXF4BvqeRtmDF/y7kyqtiPrC2auyr0hV1fgNFK+k5MudzPxfFCpt3N0zjsAoLP6l9rXlHv4KFoZpTTDN/kRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVWLl51p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVWLl51p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAE11F00893;
	Wed, 30 Sep 2026 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780767;
	bh=nUdhlsA5lrlJDZGzH1VDlWQNRLJ3CXZrhBbiI0N3K6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nVWLl51p44hANOTrXe/G4/27msChIZ5pgB7qqZsk06mFcJLiJ2V6CUYquO72ncGwe
	 u/TLpy/YFB+ezgXABpRpjyopbpQ/b0EiCxewRWmXXy0TjuolgkZV3b4ipmB4Hfn8AX
	 sSYWRZXdaPQyKxb1C8X8CYOyJBqki+VRjr/Z42e0HO0icXmAVRacadLGlMbWAud2Q5
	 KuBeXwIOz+U/CRwVcYSMOtT1UF5yyv8jkRqmtjTlnDrpRYbKAwIxuv3plFmaik5HF2
	 2NZH/zvcYGMnFTmA5e5m4Qgsk4DNyx1IU0Qk0SMnB988f1pYgAOhcvSTbA+ZS6Tndj
	 a6v+Vtmzol/SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 RESEND 2/2] serial: sc16is7xx: reduce TX refill rate
 with half-FIFO trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Mbewe" <paultyson.mbewe@ziehl-abegg.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260930145628.566535-3-paultyson.mbewe@ziehl-abegg.de>
References: <20260930145628.566535-1-paultyson.mbewe@ziehl-abegg.de>
 <20260930145628.566535-3-paultyson.mbewe@ziehl-abegg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:06:06 +0000
Message-Id: <20260930150607.2BAE11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> With the TX trigger set to 8 free spaces, THRI is generated roughly once
> per 8 transmitted bytes. At 115200 baud 8N1, this corresponds to
> approximately 0.7 ms between TX refill events.
>=20
> Set the TX trigger to 32 free spaces via TLR[3:0]. This makes each refill
> larger and reduces the refill rate by about 4x. At 115200 baud 8N1, the
> refill cadence becomes approximately 2.8 ms.
>=20
> The trade-off is that the time-to-empty after THRI asserts is reduced
> from 56 to 32 byte times. The fresh-TXLVL refill loop fills the hardware
> TX FIFO strictly below whichever trigger is selected. This patch changes
> only the refill frequency and the associated latency trade-off.
>=20
> With the two TX gap fixes applied in both configurations, changing the
> trigger from 8 to 32 free spaces produced the following median values
> [ ... ]
> the TCR setup immediately preceding the TLR write.
>=20
> Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
> Link: https://lore.kernel.org/linux-serial/20260623112225.82386-3-paultys=
on.mbewe@ziehl-abegg.de/
> Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930145628.5665=
35-1-paultyson.mbewe@ziehl-abegg.de?part=3D2


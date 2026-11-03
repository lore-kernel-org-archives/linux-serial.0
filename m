Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745066;
	b=k/r+fOqRHuNdhgLBvW3bNPSSAtMAPZMbLuG/EPpjFwq/xifB2UJJ7ExMkMD2OTMu3V0Q
	 ai7HiPqtT+XH6EwPHQi7Dmey8LW/U5M/zyD0ttdi0goNYZaOWKvm9M4DPEnsmxHSliWCB
	 J8IRu4oLLAGk/qfVGemmc7ZuWIxohhC00gfNZfqmboz8EA/02LDYDusFu36EeCVsQ1NFT
	 1l+tgGHGt62OSeRM1AZE5LFFYGNEEus+NOnemKXLWKpFFWQPVsno7Yx9arYmfVAj9PFrt
	 tdzmnpDNVr9iIPTqRgpXmzLG4EqXDLdfDL+0JDB0Z7gF2uSg0ZYlS2ufS5pegBokQkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745066;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n/Jd/reBIsjxZ3Jeao5Y/KzUtShmRzKLw/75XUAaA6U=;
	b=lsRUSNnerTcsHhJMLjhwSyugUVJ80z2cu2VeEwhU1/fs2mwXsLKLvIcynNTe7Ju5FOd3
	 RNnWR1aRusYexGMWL+9EMdzAOqwq5vbYtHoQkpGtBmTk9YKnervht/aMenJL+6n3mKP3x
	 36nXhL4jU+YV5OW+UfvVM7d+uuzROjubOklQW6lo0g9gTzztZBcR+h7IWURSuG2ASUC6s
	 HBBbgLfEn8tH2nhJ2vgn1qysnhptcKEMyblXP7s3UfU6HRWOwYO5Rk6tWVotquFAqKCia
	 622qrBkGz2Hbzn8vBouWC/XvB4e5lO36WeYriAcUxpEmebZz7yL89D4h+UnSzmOA1bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJEuNSKE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D830606A326
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJEuNSKE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102FB1F00A02;
	Tue,  3 Nov 2026 22:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745066;
	bh=n/Jd/reBIsjxZ3Jeao5Y/KzUtShmRzKLw/75XUAaA6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PJEuNSKEdomNsymbyISOggveO5P9tP0Q8POugz8kzToA4BZrbN0EvT7Nz3wGK4OVQ
	 gBOrRLqIIgP1asdsz6jruInuPq3xQJj8z+YO7l6dIWQuntR/BI9mC1N6t5B+0Z4qI7
	 DL0krF1KvqS12/kVsbw81X+zbLrlVYkLVC3PYWWO7Hpm4JOwtdnoy7SzPr0c4BNxDo
	 l1inExD7FRz83CY3tcNkuuq+/a5+a1hLPbL08zdhNqed2ma4F5eKNMUgbZABjDALk8
	 YP1UeTO6ekSZo6gCPahf9FCC0gq67cCpbb2wQrc8WHx/I7mr7scJWyC2I1rwWz9ziV
	 eaBRcBCxPNY4A==
Message-ID: <sashiko-outbox-196117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/10] dmaengine: dw: report residue for queued
 transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-7-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-7-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:31:05 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A submitted transfer may still be queued behind the active transaction.
> dwc_find_desc() only searches the active list, so a status query reports
> zero residue for the queued cookie even though none of its data has been
> transferred.
>=20
> Search the queue as well. The status getter already reports total_len for
> a descriptor that is not the active transaction, giving queued transfers
> their full remaining length.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-dw-=
dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com?part=3D7


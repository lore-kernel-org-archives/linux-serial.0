Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826862;
	b=ij/BIqyJ5Oxe+b3erjrxFVasowT2BhQkQe8OcC5ipNLRZ+7IGwa3rmmiqvvTtJIpzJE9
	 Sblr2Ai0aS78MYTzC+8TJ+1jdycNdP+upbIbd6dacym1Gcek0JzHByXV2gaTgeSuk1x8L
	 11aWvxXaVVq5IspcMeNbfOLtQ1gBva89H3SRaTiwMA/b0odTKHYPeZ8NZYnA5g9JzWaWP
	 dM15vvIc65tjjZlDIvH965/Ew8FRbIPXZy3xw7LleD2CDDg/R9dYr9NH8ZID4SK3Ad9rd
	 wJnAP8R5XlY7gN/LnwPJm+qDbtcnHoUJPZOc5P1g6DsvE/gP6Ym4uKrhE7mC+Xh7Lug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826862;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2E1f9zYAb7VzwDZTMLhP6/Mg/p70jD1qaYSgbE6+kfk=;
	b=x7xjrZZrv5HQ2DQuk3Qp3kQOSugako0Vu0WvCM/poYSibJTickVbPKKCOqgc9bNABe4F
	 G3yMWMjEVy9iiV+H0FzaV6X7ipeLUlmbtB8tBKvJ46GRf5xHVUgo25B+hMrz6nzYa7qiO
	 R9mujj1z1He50aIaB/q2PI/JA6imSVnHI6UE0SydHbcSrniWxEICVs1mwtWzdTbL4pLDj
	 CfSHyHQssjWXVIEIPVDL5EOG4jpkDRcaV0YW1gRZ5DEOdbvlLPkPs0leH6qmO7Vcanycd
	 fGFYPhWQX46eBLk6fUHWZqnKfKfNOPg7zJ60Osi9XFNFVCY7oeaexMcUmYYLc3CBqfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQZNjLa4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF768606A31C
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQZNjLa4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB891F000C4;
	Mon, 16 Nov 2026 11:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826862;
	bh=2E1f9zYAb7VzwDZTMLhP6/Mg/p70jD1qaYSgbE6+kfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQZNjLa4hf5R7mFsxh9pYEIPcwfFg640UsVdmgbcATfNXtMI2CKjweFeYCZMnWTM9
	 1VUleOnI9K/t6IpEqXbtra77ar9TadeTxcV1ZZG9zZ4S/p3nrQ45alyftqeMCxJyOc
	 AUNoM4utTn6HVx2I1KGO4DGWTTts0aDpGS6jy8jjNZtFys2CiEKuucve9eewN0bVYA
	 M9/+7ECpqbkQNuBQVH+h4mKNFbaOiO0BfGKNZLaia7iEqweCWgkdY0UfKIaYZRZLon
	 BEYrpUDVlmLg+aC1eRlETwfcS5ehdJDCGGhHOFpi57Y5Gobo49ocPFtNGR1R9KNv67
	 NPL7QJ4LuBX2w==
Message-ID: <sashiko-outbox-216822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/6] dmaengine: dw: serialize error recovery with
 channel termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-2-4a82d64fcd1a@gmail.com>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
 <20261116-submit-dw-dma-synchronize-v1-v8-2-4a82d64fcd1a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:01:01 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The tasklet samples RAW.ERROR before taking the channel lock. A
> concurrent termination can empty the active list before dwc_handle_error()
> uses that cached error to select a descriptor. The list head is then
> interpreted as a descriptor. Even with an active descriptor, moving
> queue.next unconditionally can put an empty queue's head on the active
> list and pass it to dwc_dostart().
>=20
> Recheck the error status under the channel lock and stop the channel
> before selecting its failed descriptor. Only one transaction is issued
> at a time, so take that descriptor directly instead of scanning for
> completions first. The scan can otherwise complete it and start queued
> work before the error handler has identified the failed transaction.
>=20
> Detach the failed descriptor under the same lock and use the queued-start
> helper, which leaves an empty queue alone. Clear the software-LLP flag
> before restarting so a failed multiblock transfer does not prevent the
> next transaction from starting. Keep the completion callback outside the
> lock, with the detached descriptor owned by the tasklet.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Fixes: f336e42f73d9 ("dw_dmac: Move single descriptor from dwc->queue to =
dwc->active_list in dwc_complete_all")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-submit-dw-=
dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com?part=3D2


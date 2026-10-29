Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313659;
	b=O26G/hD98V3FwNawf+zemWy6I33m6OIPceRITcqlATf8wGFGtRE4uveUtpB4DqCB1Yq1
	 dxmZk3RspJM5YgYC3OMxGq10ikTn637iDyTfeBTqC21OtsXUP4SBfq+wSXah5EGRJdhhR
	 pK/FJrrBMJR7SRvL+kdfpzFNEsifILAn+CMT0Crr9RcOgQ3Vo8IJODIGEKxlyBEUc6U97
	 /EtcWgIZFh+liCrVNxnCv/4TN95Q9E6rvSxh7+5zXTMCSNmjhx42yytFTe4dvZT3NEhTB
	 tZsN0nRd5U6IF4lWor4uMCIQCvXyrL+Eqq8unET2sbhqorsCDPgRVrPZCZjcq2TkTUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313659;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jKW9rFbBlyDZI3GrvBqSVfOB0JDZJoQr6ubMxay2d5o=;
	b=yBxibvBdZ4EoQPub1IBhM8z2odSk1JlwI69idIL4uIfOrKtcRjaRPP4A6nXoMUJTjKu+
	 HXFLf6K+12Uh0YNheaG06omr4tDFgYBq6u9zZdxJmed3gRQ1oHcA5x022z6sZELWe94fm
	 FPL1V0Lqiqz3a3nSZbJOyyvbXUbMvQB3G2U2rtBgGZSYqVHE2VOeCUTsysfP/EWI51nDK
	 tq7B6YyNx7cK9vLmdOzDZtajuy2vd1wpGcOp9JDxecwK+MGAdb+Nd+Hp/EMZ9cRHutxgo
	 iggDeUDyIT2ETGYA2feN+OjNpC2QYncZAQnR09WfJUtXmiiUBkVegHwB1JCJRiZOGgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ynz+KBO8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B20606A31D
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ynz+KBO8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2186E1F01825;
	Thu, 29 Oct 2026 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313658;
	bh=jKW9rFbBlyDZI3GrvBqSVfOB0JDZJoQr6ubMxay2d5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ynz+KBO83gtSmSxZzHwn31ycp3lVj0nbUq5YvRa8e99mMqkC45yfNpSuewJytk9CF
	 j+eQ1okKqh5xoaV92xF21sXtlcBFx1zVOoTPAE7oshztW80i/HZcrBDjHpQ/oYFgtC
	 Outh+rvauwlz5JTk5Sp1Wlio1J1svSfcFVJSKKjvmppqTutpRdOfDVsI7ave3/317e
	 UOAKk7fg3bfRevRsyQkFPaNRBn+mGTHjQuY0Dlcm1mKOHKSxz9smoCm5dKTbNnhvBB
	 rIEsBQ96ITIjlxC79UDN00G99oEABgCPvG0kmtGq6ZOHN7UAbyDQTG4rFcSbtxx+HF
	 sF4xIIxbPCsCA==
Message-ID: <sashiko-outbox-190093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] dmaengine: dw: synchronize completion callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-6-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-6-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:40:57 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The controller tasklet can detach completed descriptors and invoke their
> callbacks outside the channel lock. Terminating the channel does not wait
> for those callbacks, and there is no device_synchronize hook. A client can
> therefore reuse callback state or release its buffers after
> dmaengine_synchronize() while an old callback still uses them.
>=20
> Disable and re-enable the controller tasklet from device_synchronize,
> outside the channel lock. Disabling waits for an executing tasklet,
> including descriptors it already removed from the channel lists. After
> termination, a later tasklet run cannot acquire another descriptor from
> the terminated channel. Clients must continue to exclude new submissions
> on that channel until synchronization finishes.
>=20
> The tasklet is shared, so other channels may schedule it while this wait
> is in progress. Preserve those pending runs: tasklet_kill() temporarily
> owns the scheduling bit and can consume a concurrent scheduling request,
> leaving controller interrupts masked. The disable/enable pair leaves the
> scheduling bit and pending tasklet queue intact. Other channels' hardware
> transfers continue, though their callbacks may be briefly deferred.
>=20
> Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization=
 support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-180707@kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-dw-=
dma-synchronize-v1-v4-0-fea447d9f285@gmail.com?part=3D6


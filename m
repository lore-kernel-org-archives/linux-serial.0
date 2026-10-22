Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695801;
	b=XooYwoKOC7sRvRIm+hb8vHaCAJaJbND0tNY1OLEaSEKRLjZg3xjfeEQ4GaAkKPkS2BNn
	 DCTJcpwGvT+UsHPRidq3owANXTQeiSHiIUbRLArnd0Ol9nJVAvhMf01WzYcsKi9G71q+N
	 AdyJrNglkqVf4R/rrzsjieCh9RxpawQao7vWeBPmqO7fXcsRcnL3/RT/L1cOeJ0cgOffD
	 eoa4g+FGmbbR9javwWfcSpShUYf5iyCDHJjtBNo6mtl15Geqf2zxQy/OaB19RcraJ3c3a
	 6VyvlpWldPt4sa36dNSZK0pB4IQyM/4CpecGjo+WYJDYRZBkvtUnhYTLoZYuJEHqUVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695801;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eqn+YiBsFQasFGLkbUik3juNV9ywPgxIKwTCId/N+oU=;
	b=LD9AfcO+bpXyWVJJtJiXibHuk7Ju5sjxKx5Ps/3VvildI3TeGxT7zMijeFCCi5G3JaoR
	 9FKh/9uNG/JnhmJ3tL/0o3A3eOwUDWQcTSIz4L4UR+IResn8SrtqIK0ZmfagKuwCTf83u
	 wPQQe5m2f51+ClKFT20s02vYv75Z4m3MbKG38Yxrjl+8ildrhrWDSu/Wnnz1PPqdMw/qs
	 0iePN6budTB0BcKRt32xO21vfL2IbWu7Qb8u5U6NwXCGAhPiMStauefdPbFcyZJEJnEzZ
	 W+Gl399SjkbNgk1a+CaTxasnPio0RKq47ut6w8/ugK+rV7mWrhcapBSs0vZd15OOcBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIBMOuVI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C4606A319
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIBMOuVI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1341F01825;
	Thu, 22 Oct 2026 19:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695800;
	bh=eqn+YiBsFQasFGLkbUik3juNV9ywPgxIKwTCId/N+oU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gIBMOuVI8crfSc6z0Jt98QVhns+ZsppJirxFsHt4LExdrjG/o4heoJYIyNdGdtEHv
	 FwW9nY7viC0cWcKpf1sleCaX2K4P9xAJlTcEzHhY4/rz2Z2e+trdNozHWZ2tjQkknn
	 mSUGNgiTPqbrYlWIcyPr09kCjZTlsRGx5I0XGTp8wgz4MtMNogf7eLJbLWDP9oaTrX
	 5/te7lZBEA64pX/4+lbBTmTArTGBCQNzUb/9S3u4wAri8U+/pMuuOidQgD+PZaTKBR
	 vk96iNGbDlly5kR8/JcO0HP3yRtQJL0zdolzF00eFAYnU+UYfyppW8oEK1ve92HsEQ
	 0JaJhqUFCV/vg==
Message-ID: <sashiko-outbox-181947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] dmaengine: dw: synchronize completion callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-submit-dw-dma-synchronize-v1-v2-4-5244e94dca8c@gmail.com>
References: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
 <20261022-submit-dw-dma-synchronize-v1-v2-4-5244e94dca8c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 19:03:19 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The controller tasklet can remove a descriptor from active_list and
> invoke its callback outside the channel lock. Terminating the channel
> does not wait for that callback, and there is no device_synchronize
> hook. A client can therefore reuse callback state or release its buffers
> after dmaengine_synchronize() while an old callback still uses them.
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
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-180707@kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-submit-dw-=
dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com?part=3D4


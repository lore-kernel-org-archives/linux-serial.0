Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844282;
	b=F4WikurEbMmUsbX9VR0YieG5gEjZ8jAKRgp1K+gEhhCyhHk177dxStPhNIoE/Au71EOS
	 LSYO4SlETvEtPs2bJtC1BHWUi93+3OeGHxYnHO88NeHpijdrob/XKZ/zIkvZqClm2HCvv
	 Qbprb3o7bPafUq0df5Z486fVxTdXCdv6oLhXX1CRLZc9uEEJEy4/W3jfJsa2HAzYc6i80
	 Y26ODAoXvKyiZInuheJsTucVkBRByqpOISa1xgbBFN7wtBryRbXFpSvadWyhSJK7DVBdm
	 id8FMQorIxXo+usUOzDUuQadw2n4+QVS3aJGV5MqETXdo5B2I1XEpzOKND6GCN60iWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844282;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4UMT7/CEAHG5Vy9vioK1mFirwm7Y0UCiOobzuG1X6aQ=;
	b=Fm2I6MoD2le1qWq2CAOkAlIa5VEO0N2F7jg3XTH4OsbHVLCbMphkU7bT014uK5vs4wpT
	 boloQ50YOcU8H1yGABRcbgBcCm0Ym5kiIPTqJL9U0YXwrcXidz6CQAV108+Th4Iw0SiJZ
	 WyLyu5AI1zrW19XLlep8gTVGPiAGTlZNwPUj/F/3Fca6rCsrHnlp4D6B7eKgQTMAX0fhe
	 1MZsbxxXxHGf4uzUtrvtzhMYpFm6zimvp2ly+a438mIKXo9R/jSOzdM7UkEKMgyPghcSe
	 6bBhcNwbgwPjLveaGmdvae0/3MyOoccgjUk0FQ9UH9df1+mrQRkqdl7Qf0jvdp6fZKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISFXbg4m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A173606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISFXbg4m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C751F01825;
	Sat, 24 Oct 2026 12:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792844281;
	bh=4UMT7/CEAHG5Vy9vioK1mFirwm7Y0UCiOobzuG1X6aQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ISFXbg4msc1b2nj1QA1D+DuZR8SuNFm9/7KKjzQlzzVkoSBzLBcmgwJH4FO+mINLy
	 zlXIYokpgsNy6eAtJqnuWa+KpOuv1SgKSjw7XhzdhUSivKwqXoiA6wUtWy0Y7g58If
	 01QxAjDIymcg56vMQlixgOgAIvZ/S3biO5GEuS0xykzqQfyTttfbfujoyB24zZkBea
	 Wv2u9VoPYdEo7GD787C3s8JjJZQsWieN/e2DBDugVoD4gPkTFCX5Lca0Yps/Muj6jt
	 F7DiNk5loPTFOwprZroFL+16vmeB4gVcf6KUeSyBbFtDDF4ofcKHUUQLN6RkjvYxac
	 1CqJCqk3WexdQ==
Message-ID: <sashiko-outbox-183706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] platform/x86:
 lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <5e70a181599ada304c6aa6589cc61662f1a8d710.1792831564.git.an.wu@canonical.com>
References: <cover.1792831564.git.an.wu@canonical.com>
 <5e70a181599ada304c6aa6589cc61662f1a8d710.1792831564.git.an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 12:18:01 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The software-node-backed serdev client cannot be matched through ACPI or
> device tree and is force-attached to its driver.
>=20
> Pass the modalias to serdev_device_add() and give the serdev driver a
> matching id_table, so that the serdev core binds the two through normal
> matching. Deferred probing is then handled by the driver core, so the
> -EAGAIN translation is no longer needed.
>=20
> A failing serdev probe no longer propagates out of the platform probe;
> as for any other bus, the client is simply left unbound.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792831564.gi=
t.an.wu@canonical.com?part=3D3


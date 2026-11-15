Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727463;
	b=vBG8yg+3UP+FVyZRqU6rCpNvAc6FJUNohLIQ8QGjuhmXhkeG0suq85KQZlxW53Ah3IPS
	 zaV+XikY8ftzXtTHxfqCkzZu72PED9ZcxnwDDFBHWEt2NVchRsiCh3bPiVc6NfL7fSCup
	 StE3qIUWBCAKgDEHUwpK7CUQ+d968I8QSxKCglZUYjCUONNDk7cYRd4F8ShW8JiEfW5AK
	 P08gSAB7BFk2U9D1EvvfB4a9KQ+d3wA4/wXStMRH45I7yGc67vxIJz9rZWlQpJtCDUWXU
	 L/ve8+mfDbbwLE9JCHW+1t1ht9MFWeAlEjFtfjmbJFwDRhct77VNs/XZVHoG6CB3zxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727463;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=syPgXEgLdCcHidhoC9cg5/6Xfcp5lpL5EytjvRQnYx8=;
	b=pf7kPONd+ORJFOSqffkgytWaUo7J8EbJyvJTKzg7xMv/ARxWVIrwrcLHUrb79IqtE2ot
	 umBzszvzz9pljQmPyxy+iXe37bwDL2UYl/75VLaHR/jk7YPfr4vyIhGqv05h9bk1eBCbl
	 WuBc+YyVtscfyboJ60gyZtIdAW7NPI8cGIoyhwH3Nrb7nQZkVKXZB2SGzqhklgm2k960B
	 RjF9hbDTPHTEjIusCKsowlfUltnNzi8jkbIxT5cRRGz8ELTKoyWgL0u4JuIlfITw7YMuz
	 bjKeS3IvCPnVsdjzZ/Nk1sdVnuou6k/qFudLEJsDTLyJcaOFHpSTSV+o/HGLKVpR63g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAC1dJPY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF027606A330
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAC1dJPY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742451F000C5;
	Sun, 15 Nov 2026 07:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727462;
	bh=syPgXEgLdCcHidhoC9cg5/6Xfcp5lpL5EytjvRQnYx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DAC1dJPY2H7n3RVPgHnyK3mIlM0t/NBpI8PdDe/kGvGCNJbiQ2kkSa2ADF56nORO3
	 zDVJtJNQY1KFznxiSAQQvv40Z1Pd9ceizTBRMpdVZilJ5hLxC6FaUTF8m6GLiEarEl
	 L7EcUHhXUJ1mCAADg6hb9tM13vjOSM4aJswkiCNswOBZgVgqh3E5q9MvcraX9yYhvK
	 omKHfd2Vh3m6GM5RiDXoRnWKJ+jomzgKu4UhaYhfiyM6gQLm4X65j2q92Ar2s551dz
	 hek6MCf29L5v8YqSf7C/8U/RdF80x93j2g0QKhGiwIesgXZSheWHeWgYGNouuGgIj2
	 05fCmhT46BW8w==
Message-ID: <sashiko-outbox-215257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] dmaengine: dw: complete cookies before
 releasing the channel lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-3-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
 <20261115-submit-dw-dma-synchronize-v1-v7-3-8d58f3d49e4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:24:22 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Completion detaches a descriptor from the active list under the channel
> lock, but updates its cookie later when freeing it. Termination can take
> the lock in between and complete newer descriptors. Completing the older
> cookie afterwards moves completed_cookie backwards and makes an already
> terminated transfer appear outstanding again.
>=20
> Complete cookies while detaching descriptors in the completion, error
> recovery and termination paths. Keep the active-before-queued ordering
> when terminating so completed_cookie advances in submission order.
> Descriptor freeing and client notification no longer update cookies.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-submit-dw-=
dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com?part=3D3


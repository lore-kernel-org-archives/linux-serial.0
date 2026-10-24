Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792876242;
	b=mupfCArV9ufAGmNmUnoe0n2gqYasoz0fr2JKC9bOOZ/lNO7dIy1GbY45HMdnPeEUY8kE
	 jurb2IeTeqidprS0Aidmv6m27nzB5MkjULOJVH+dAoTR7opEa0zywDVmX4H0BRNaLvKJd
	 nzbf2GSXbwDWZqQn0Jutr6IiEWIjSHSyfdLIQGg1rnohOLO3ZsLmGyhj2C1+WUGUkte2g
	 JS9YTjuJCckcqo2N5jZTsgfV09iztO0lzg6X78HiuT+mAMPCfa4zcxuwfsj7uNs93pFaF
	 jpMbGRz1bxGhwGMyel+MpX7IlYzmQZ3jh0LqzxVn0rW414Ghr+pwapoPgFX1SSXx1uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792876242;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=speGue5KnK5nVOx5Hr1xigZlWM1HJwl5w7pQHgH8ZU0=;
	b=oFuqUobDrt81aaaw1pWlu+cxP+TRn/MBqLm7Ym8kD8x3kb5xfpOwZdMBfs0ScCvSG51x
	 jYU/vbnQnxHjgu/WpZuZ8mNcQzqXO03HWSGJY5vOm7gQh7/AzYB9W842pOTRniGtniB5w
	 dFeia7lmJJaYQryOu4oFYVdUbe0Sz7wWpqD6EyTeSeRcaLJr6eCphYFY4JkVv2cMSmW1L
	 eToluiJDlwvtMmOz9QC9m6sz5vHCT4YS+Dk3OiRMKVBU1GCLy4zew8uNlYkoNljTyUNsp
	 4LMVqN6CWILKMVK1aKPBk2z+VG/8D35vwovTu3Fv+PSie7s4MFf96L80QcHePbQ/waw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtSgQXVk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA87606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtSgQXVk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7391F01825;
	Sat, 24 Oct 2026 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792876241;
	bh=speGue5KnK5nVOx5Hr1xigZlWM1HJwl5w7pQHgH8ZU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TtSgQXVklO+9SjSRwyiBWStwB+zv2ZA1jfN6yvuM5Ug26yt+9B5Fm/4/9xiBtDZSk
	 1N+YIueJNEq4qKizXz2uv8awbtFH690RTHBQj4s2Um05NB+ZNRrgSo33bXkT8eyg3v
	 ZWkg6yPFf6nJZHCpSy2L68G+FW3v9TW2n8TlFehBTAq6tHSdiLYmaCO8scmOGHdziR
	 0/zVI2xn59NIEE1tQskXWpi8lTHBzWe2fX1KD+MbR+B3c5fOzFkOpUc4LoKbbjym4M
	 Usk1LhmkarNHWl4fajoX4KWjH0fjXRGsKjM5/XmcUgLY0++EOG1jAN9leAEofFjw+a
	 npElYrvMVMYXg==
Message-ID: <sashiko-outbox-183876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v6-1-6f366591f566@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v6-1-6f366591f566@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:10:41 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Separate the port-locked completion processing from the DMA callback
> wrapper. Keep the shutdown check and locking in the callback, and retain
> the existing FIFO accounting, delayed register restore and THRI handling
> in the helper.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-dma-cancel-v1-v6-0-6f366591f566@gmail.com?part=3D1


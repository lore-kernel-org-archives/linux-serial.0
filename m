Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912898;
	b=04YHJB2zyouF+TwLnCiby2uMK3ZZATRxyAbdPCzH3qeHvcPL5Nl1uRu0MhesVvh2/J0k
	 3RSst9N1QaNXcDqtlWeiDsHM926bx+aPLO8uKvwDvOEkN7GZsGpRbr7xyZCyZg9jl/mVW
	 bXrzxLac35Ua/+Udxt69FWBjy6UnR6h4L9NZOjx/T4r2fJoGlkeANur6MLiyhu5RDPla7
	 iPYoqPKp+8u/x6VDjXiMxg0hRrJ5x+QQuAyfA7FfFnr/5pgyEBzEHlCmVlhUWAu6H/rf5
	 Y3CtZC0WUeTOUYMRVqOq+v1awA98/ub4hnMxTKJTtNSmRNr+a1/YPV01vEvJCZLAbMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912898;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X6KaNEhIHuak7abOFT2MD2A5lAWG9aoZBvLWkxOmQPc=;
	b=Qs2hFxpkwmEJLTyASnMk35xOnpMSFaQ40EIMWE7Qfj5FT7RmzDBBPacwDBhuC0dEfd8l
	 vC3+FAKCstcgBW1gI1zBI7afyzbrYAQSkClVerGPpHSZbBNzzJ/uP9PpNCP7oeVTPtSKZ
	 RVWY/JlAK4y7VePuWaK9GvS5tN5pkVoJ5276AmYxx0brLPJDYOUepNY+654ScPBbXbgbn
	 G7h80m2NXozuRoW7qVPbE/QX5HlV+hYotQDOUeSuONPhEflNmOuEuCMZH+j1RkylS7+dE
	 LPDfpwBsaowWM3Hh4BfsVrwRzNRq0e6eX9Hj2ocKIPI5dYdP3t18fSSoYd+YNDeF1TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QselD/p1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA4606D804
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QselD/p1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF98E1F008A4;
	Thu,  5 Nov 2026 21:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912898;
	bh=X6KaNEhIHuak7abOFT2MD2A5lAWG9aoZBvLWkxOmQPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QselD/p1I4yEmZH6IPKMKaHiGhHkityqvRQBQAhimT1GITetYVha6OPxOaiK27x7Y
	 ykN+mLQSmW37SMtTIYzhkBSWhn7DDlC/7F53iLoA4zMFHKgWgmT5lj51e/WEqnZ/vU
	 ld3+dEML2lL3h1N3rOD0efivew+LVj+qnJrzlzYFszLDtlWlu6bn4keBisikoWp0eh
	 RGjHG0Gwc0E9rzsuOavpISL6DiOoM6F6hJ5jfmAGLSJtLiT57Y0o3KWPWNypbqIJUO
	 fsCeliWHkCqXEEVSxa2pOCiApkwJtJLX6Ps8bt4bh+6/eM6gE8U//+FWYuOh2hI2/E
	 sNbjzxTvTUFhg==
Message-ID: <sashiko-outbox-200189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/11] serial: 8250: share the RX trigger conversion
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-4-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-4-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:08:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Drivers can supply receive-trigger thresholds through the RX trigger
> callbacks without adding a legacy port type to uart_config[]. Extract the
> threshold search into serial8250_bytes_to_fcr() so those drivers can use
> the same conversion as the generic 8250 implementation.
>=20
> Keep the implementation in 8250_port.c and share it within 8250_base.
> Include the unsupported-table check and preserve the existing nearest-low=
er
> selection and highest-encoding fallback.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-h61=
6-uart-fifo-v1-v8-0-14024d2b184b@gmail.com?part=3D4


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5BF4C225E
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331539; cv=none; b=scMK25dBrNo1w9JY4UY+tQ9ltYSFHxRe8V19cvmAn9UPBtJ3OOKsHXrXZJjLqwfRxoom/rzPMjb4776zbQkgAT7VCiPVzJ7mU2xgVZkM7FzqalTe2tEO95v8RgZZY9dBdZuV09iUkqmZMsDseU0sRPRTviO0BBpfze3hEU+ueTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331539; c=relaxed/simple;
	bh=1vY2ThGykhyJpge0pAKnV2phfvFrqAjHizYPTSBqumo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qgurWJMaYtYNgdCouo3iIQb71JLzWBgDoAeq5/FB6CcafQz9v8Pg5CUAx+ap2uPXQvb9bpO4D9V5acz46k6BK7voabatP51yVPyUeEIt0pHAQxc/keUhy9GwSJM1ISDelg8rkkbqEprxN7enJwEi2CsZ84n+hPGvBapfhrS2pgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcgiGPbm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcgiGPbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25661F000C4;
	Sun, 18 Oct 2026 13:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331537;
	bh=1vY2ThGykhyJpge0pAKnV2phfvFrqAjHizYPTSBqumo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IcgiGPbmsg9lu0LTIiPyAbJb/nbIWLobxiXH6s3q6oIc5vtvjty41yc5ZHQKxpalY
	 DcsG3drTWo9th58nT3xy6FRsf8jg0GT4iVCi2Mh10w+PJQyr0RhqYveTAW4bbtssxS
	 RPwYoFuTgPQeUcWy2h3XxS47P9RHi7oaElm14Kk/BtpKyB7xdR4gG0hzys2rVbG3B8
	 lM7H0379hUOtup5HtlWiODfEUOp8jzl23nQ0oA50B2p1Qf4doY5R9BBss8NVawbGVJ
	 3ciVYuFFWqFftDhJll5i1Yd8w7CP2T2weNNdhyKG9lFzQO4QXWH9k1CCCx5URqNt8e
	 ghLkQ2TWM+bnQ==
Message-ID: <sashiko-outbox-176161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] sparc64: zero newly allocated IOMMU page
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261018134738.1016106-8-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
 <20261018134738.1016106-8-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:52:16 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> iopte_make_dummy() replaces only the physical page field, preserving
> all attributes. Applying it to an uninitialized table leaves validity,
> permissions, context and reserved bits dependent on prior page contents.
>=20
> Zero the table allocation before installing dummy page addresses. Keep
> iopte_make_dummy() unchanged for unmap callers that preserve attributes.
>=20
> This initialization pattern is already present in the initial Git
> import; the Fixes tag identifies its earliest recorded version.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134738.1016=
106-1-linmag7@gmail.com?part=3D7


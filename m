Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409721A682C
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791749055; cv=none; b=BLOv4Jdl4Zo6lbIcylVmyCARNTxPbJMvER4+DwoIAQjCmvdkktz0BRO4RTENruxiSiTUPeLYiXd92Uzg6yMSFVFqRj3GFHvtKppEtY7Zl6qMDVhJHdav1XvI4BCod3EPqhco5FdBcK2Nn45eHpKCwMb3Oz+pPVNnWo9e3KXgdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791749055; c=relaxed/simple;
	bh=w8x6zfNqT70xYXCIPuZDx2r6Ctu0wb8wDUAm40tA6s8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K0ujuCjMg+xDR+sOTRUbEc4ee5+4y3vbuWySCmRQ0n2Td1cezqE6f1DnYVjLrUExJ37cxXs2KKwvDluNBSudTThSCECoFj5PVg4vEb25ba0gZU/tYBPxV1VAwVe0TXVSKLCnJ3jPkFNUurqL/FXccRLDfjtu9sygDiK117D5jtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHQUcaNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHQUcaNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE091F0089B;
	Sun, 11 Oct 2026 20:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791749053;
	bh=w8x6zfNqT70xYXCIPuZDx2r6Ctu0wb8wDUAm40tA6s8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AHQUcaNQxM69K1Ab9rZDFuM0MRE+ooNznZysys1I6EvHXRb4Yhbq5IOSYExlodG65
	 TfWKdkJ8/ZJnmnrMQaTdq4eMOVPExlJQkwkfB3Qr1by5xImefXG5z2MKPLGHXiN+NF
	 fXRrftNAqpzImUh8mM+GW97HA2lRp/zqfx8ArycXcxWxSard/P5J+NdcsD4DFYEfXn
	 wgqZzaIlf2lJbnB2kC7zHITLUX5BscYumJWVnXvnMV1A/MjzKzEw3x5JqdyFcTvH8A
	 +Pu2cP/viZQoSp+Sg4LPZUDj7Gysy0N4U4lwTWr6ORC+sbr94hj5q9Mv/hUoWwuQOE
	 /JRXVibfbC/Xw==
Message-ID: <sashiko-outbox-167438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] sparc64: avoid huge kernel PUD mappings on sun4u
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261011195729.981243-4-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
 <20261011195729.981243-4-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:04:12 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The kernel PUD refill path merges virtual address bits 32:28 into a
> TTE, requiring a hardware page size of at least 256MB. On sun4u,
> kern_linear_pte_xor[2] and [3] instead select the 4MB fallback TTE.
> Consequently address bits 27:22 are lost when refilling a huge PUD.
>=20
> Keep the kernel linear mapping at PMD granularity on sun4u. Its refill
> path preserves bit 22, as required by the 4MB TTE. Leave the sun4v
> mapping selection unchanged.
>=20
> Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions=
 with large max_phys_bits.")
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011195729.9812=
43-1-linmag7@gmail.com?part=3D3


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250673;
	b=jVUT9lxSc+i/DkYm3EYEr04wdC4UhYOhhuHWH6lU++YF6er+0mYXUpS2KgUd+Ev/QEwB
	 wMaI8bP8wjcIIuCQCATTBcFutDIg954Vs2ssfr9UaagMUeyVmqYLbvlCX/qum9gXXdsWs
	 QZAHLjaNMOLo/UP3ZLDha66Z122rFfefD6IVL3ZRQ7kEmBjZzHPweXbTO4tul9dA6AY62
	 DFSTPxUYKwIlvNR2wZXFL2JQHWlglg40fs2+W1DS1Fi2U2G89fe8rGqRUjEkrX/0FXPlm
	 BY31CUMrl7ZKEkfhnyReNglkMHGQAy9lmj1LiCDH6czrIwvQjLxINHmuAguGNIxg+cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zotH/EtlVVB7Sgp5JQ9JIUWC/SNxPkHOC7W4mNOMjFQ=;
	b=Y/f0198cK/AxYyaCB39hO6qqPDNl22koFF+NqibPgiPFzlitU04C2yZG0Cu4tQ+OmO/r
	 x4+wbR5O/hx1VHlJdn3XQDXkTxDmaosPfZUD4k1cMtKoIfK1keRUTYe7c9GWYEPN0rmYs
	 sO5VCvtxnujAkgneG3my6ziYIPPEXrZi4YAW7BisD+aBveqekpOwxEUHh3DvdAwMBPnRr
	 kvULUWufhzuSJq8H5+NdkT5GPkFj/mtNOalcb15/puFcgJuSPl7mTZa1D+VMf0VsG7TX7
	 82JfpRJa/gdAPhRWMc9zYIOf94kuer5ar/i7Usy43cady8DNOh8phl0qAHZ7uhFSJpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RKFgqvoY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EAD606A31D
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RKFgqvoY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D971F01828;
	Thu, 29 Oct 2026 05:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250673;
	bh=zotH/EtlVVB7Sgp5JQ9JIUWC/SNxPkHOC7W4mNOMjFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RKFgqvoYM8NoIVaerJrb68In2jk2sVzLfOH1BoFsBm68d1Py60pvj7EZc1fnbS7T8
	 Wq1D7uwXvUnVvX4G1Gw0489SI3usEXMGueT2UxRAUj/sGN7DFD1QYZMbf9U6m2iV/k
	 SywSCP4UdnMsKED/R2GnnApeTgsIbgr8QCY0wqqG8f9ZZPl80OHa/4T40VdaQK7ovK
	 bD1LZrYnCrGP8GZITpJYMV3TTZ96BKFRE2UTB1fDYFWht4awxGQFProF+cQrUM5yGR
	 sNc8NzyS5aTFhml+IVXS/GCoPOZKJgT4AtC+VR5BLeIwS1TjmOAOnUKiA2ZQOx/dW0
	 edIkFa4jsI1RQ==
Message-ID: <sashiko-outbox-188738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/12] dt-bindings: riscv: Add Bouffalo Lab BL808
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kwanghoon Son" <asdfkwang@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-rust-bl808-console-v1-4-b736ee920078@gmail.com>
References: <20261029-rust-bl808-console-v1-0-b736ee920078@gmail.com>
 <20261029-rust-bl808-console-v1-4-b736ee920078@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:11:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Describe the Sipeed M1s Dock carrier, M1s system-on-module and BL808 SoC
> compatible chain. Initial Linux support targets the 64-bit D0 processor.
>=20
> Use the bflb vendor prefix shared with Zephyr.
>=20
> Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-rust-bl808=
-console-v1-0-b736ee920078@gmail.com?part=3D4


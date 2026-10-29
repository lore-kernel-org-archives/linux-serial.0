Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301020;
	b=Pzjc7zdUOgtMMUfckOK6kYR3Z6Ece8MEUb+Jgx6QxJUHlJ8FUcbRBoN7POgGOZTVaQ+2
	 t2XsQxdTqOPPPpS0elEYFaCSucpjykZ+Xy78/o8e1/cS2Sf2oD0NlsrOyv0U+ap/PXrBy
	 W3dQ89cG4bjZIgN+Ac63+9hOOqHb7rpgLDSFlTsNRPiRYMEvJaHzhF60NuscM0Gf+NdSZ
	 SD5rGOngV/x+cMAaKGYClAdrSy2LAMmpBHFIui8lsK/AB0nErY7wcyqTntTeLFq0QXWk4
	 TivbaTFdajrjyLapRYabl1Tm+CWDCxGEFwCgI8Nu1orOi1iLOy+lSYo+WLWtHJBEm1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301020;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=57cH6p3MhavV7eEc+fBBE3AG6qMgLyGlcp5PCd9yGzQ=;
	b=klvAwZBx+gphZsk2SrGVO/OEfXzQh05VrALZ3kDwsYhteV6ldlYVFQ/EUPNr92mMNjL3
	 GvfXnjbk9BBK0+prOysdBImaJJW1niykLD7LOzR3n7nPZhm0YXIG4LIYPr8z6jHWXp3Lx
	 Z6subah+LrvpWTb2QVj76C535udecpXpKoRhhqpkXHNCOlLsTpe25+arQOwvkSxljkOpu
	 BFO5oti+qyrO9gWzuYbQpF3bwSjcJJ9ejCuXnK4kiJrKIg5kt23IuLqcleS+5lWfqOyCy
	 vtNzWfSCPgQWTP8pJ0cVGfYg2p9sB9qd2d9W6qCRX+Hv1G27anyRf3CHxOvdoC4Fm6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDWMivXU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC49606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDWMivXU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0321F01816;
	Thu, 29 Oct 2026 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301019;
	bh=57cH6p3MhavV7eEc+fBBE3AG6qMgLyGlcp5PCd9yGzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nDWMivXUMb/oSXYmZ0R5G5Mms6L4R92EnKAl4xUzclNO4tR2xIBjDr3JvenAnB5Fl
	 y2piRp9ppdl4QvAOeQGAsQeSP6zebKE7+UgW3LBgvCfi18A7n7j97/gGZe1PwyIYsv
	 en9mmDkilijeoag1q4y4c0stA3Idyu/+wXznEtDA1YmSBo8ttDctiyQ+mXTYJmCQ2c
	 OC5i2BWaSY8pS/6FZ6mkb+EdsP9D5j12NZ8UnSy7rNudhPzkn5uEKKBUti2Q7cJuhh
	 ofH+vLtkeCZCilv4JCgkORKWrj3inS+zaFCBHAYS4CHQCCAXW+SCoDjiG5syse+D/V
	 PBXkTDkJsUvyw==
Message-ID: <sashiko-outbox-189845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] serial: 8250: share the RX trigger conversion
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-2-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
 <20261029-submit-h616-uart-fifo-v1-v5-2-53b433aebbf8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:10:19 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Extract the receive-trigger threshold search into serial8250_bytes_to_fcr=
()
> so drivers with per-port threshold tables can use the same conversion as
> the generic 8250 implementation. Keep the implementation in 8250_port.c a=
nd
> export it for subdrivers.
>=20
> Include the unsupported-table check in the helper and preserve the existi=
ng
> nearest-lower selection and highest-encoding fallback.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-h61=
6-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com?part=3D2


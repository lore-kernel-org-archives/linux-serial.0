Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849628;
	b=qlpjSK/yi51by1qk979tK64IQgB/9OUotedJAl5mVUk5h9RIJV0bJzFezRs+lIFtbJwe
	 Ua3Lh8gW/LmpjgZNcx3NhV07lbGr53ke01GEqoCPusJy9CnO4MOMP/9L2ivSctCVUN/vn
	 aZHoU5lVpEKuQQzElb1C+k1auT4Cgb/cbVv8FdeROwYqo8KAVhNaltXATxN9ioMrmBqK6
	 VJqBski7PzaP4+rDUpLdMd5PqKEKnQRE9FosAHj4cRHtUxRp7rfavMJMzmA9mgZMH4TiU
	 /chACn9it0zZdaa0oZwA2K4T5RLyCnTDrTNOu8buAsfh9AsI/8/OiV0C4M1wbJnQlDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849628;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/AKLZ2+Jpy+BQzQCmW//mk+cNxo7Zf8qkcPhXHwS4os=;
	b=Hman8SRwd6DKyjo+Eg9+WzJ8DtdvVTxRRAjsoK/eyJFMnfLgVyzgSHW9oCGHYdYwOmbC
	 NcM3fkCEOEP8AzmnoVWkjgT6ZsDizwWIPk0aCquZAn46rJ3la8XmIqIaH37j14YfRm2zM
	 +MBtRImmdW7Lk9UKbAjAXqwkIsYpOnLVWpMLNqQ4sY+4Vv1QosI84zaPcVuCcacEA+80t
	 8+pUwqrYDW7XjOlY2H41JmlvPNtRlSIjxE0iizyv773Ges4BEyQBFz+ncBC5ZMS6cSvwT
	 61+FQygVy5Ws16kliX6eupwh7D//3pwMjY6EKgbB0vnPy7Qz2lhxdNnqGWKclDJoURA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R4b46//C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AECB606A331
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4b46//C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32F51F000CE;
	Mon, 16 Nov 2026 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849628;
	bh=/AKLZ2+Jpy+BQzQCmW//mk+cNxo7Zf8qkcPhXHwS4os=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4b46//CWQC//+TZi7NXP/WOF5BKrW5o0O/r4bWIJ5O60pIYj+i+wCUtKQvHFLS+a
	 VMmhvEu86Gy+5u/6E2UkNnkGMx+agN/oLZ4abzimso5fylJPywelLLREpcF+h4QQr3
	 DuARTQK/kZVCEKbT5lpK+cq5MpFv/Fp/B27nVUUxeIjQptThlpvQoMEUQbLWRpxroG
	 EzoZVprEuKxx7OeJQwCC9unFi+nvL7W+87HiXWUvZA/8M4iEFMycce2oWNOCzh0wTE
	 YVUyEgoEcfvjImEDVGIgBSbhfWHGYcH7bZV8jicKZzwe45+0Sqk3p7EusRDVA3PDy7
	 wD3EUxlhNUs0Q==
Message-ID: <sashiko-outbox-217427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] dt-bindings: serial: mediatek,uart: Add
 compatible for MT8196
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julien Masson" <jmasson@baylibre.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <87zev8wv90.fsf@baylibre.com>
References: <87zev8wv90.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:20:27 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>=20
> Add a compatible string for the MediaTek MT8196 Chromebook SoC,
> which UART IPs are fully compatible with MT6577.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/87zev8wv90.fsf@bayl=
ibre.com?part=3D1


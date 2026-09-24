Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36940B0EE;
	Thu, 24 Sep 2026 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239294; cv=none; b=h1ofuuOokWDQshMzVCMDD9no5LCY+YBcvGL09o01UcSKRmAat8cI7wpHCs6+SPy1kYxD9V2QFgZo4IlKhc8VN2Wd5TD0FBCxuyO88PFH4sqBKfVOrAQXzGtP7h1z1cUhQLhxE6MyW4Ot1VB0d+jw7PLyAp9spDX5wcLFnTkwLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239294; c=relaxed/simple;
	bh=9n5bR+pgBTuS18u2c7Xkjk3FHVArtYb/GpIRDNyDOuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P4IRweoA2AJ2QUZ7xECf7VKF1kQHVaD4K78sHT8ZWwwFbjpASwD8zu/N/cZF8cdPO80M/E26bQ+PjwAMaEwNTL46oaxRTevEw1/YmAko3FptVfyirXIh1iL5FOExPYwMUhX9QlvEaXgd3T5ajHXzJj1PNqi+ttmLCKTFQB3l220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoWxSd2q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoWxSd2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7F51F000FF;
	Thu, 24 Sep 2026 08:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790239291;
	bh=9n5bR+pgBTuS18u2c7Xkjk3FHVArtYb/GpIRDNyDOuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CoWxSd2qnaegVNVkEYOZAWfucpkKX8lHnjjdxXnGvYlg2y1JWIxgPaCZXJvQJIDTl
	 419OjHRLZH4zs7sqizaPsJbcIRPqiHqSkXHfUff/kS1CUpVM5AaMxGk9fMoS3+vZBz
	 pskW8ikaClMqVuOf1T/FNW0YWEZT8D7BUx6jEhtuVz1n+j3vUhMx2rEXOFq098skT0
	 jw8jVya+FaKUVO5+IvjpW+w7VK8tXv6G8n7sgY6AVmaSaRhRJxLUyYXesIeKG+Hyhq
	 krmZo6hBZZAZLO3hnxRNkSX+FwJ+BHdOuC2bJYN9WiAfg7D3Ri+6tgINOGXOe8SqNi
	 YRAi6bF1qU0yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: serial: mediatek,uart: Add
 compatible for MT8189 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Louis-Alexis Eyraud" <louisalexis.eyraud@collabora.com>
Cc: linux-serial@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260924-add-mediatek-genio-520-720-evk-v3-1-2ec5c80677d4@collabora.com>
References: <20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com>
 <20260924-add-mediatek-genio-520-720-evk-v3-1-2ec5c80677d4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 08:41:30 +0000
Message-Id: <20260924084131.6D7F51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add a compatible string for the MT8189 SoC.
> The UART IPs in this chip are fully compatible with the one found in
> MT6577 SoC.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-add-mediat=
ek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com?part=3D1


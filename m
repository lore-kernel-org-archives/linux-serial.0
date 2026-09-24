Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF6361943;
	Thu, 24 Sep 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239466; cv=none; b=bM2OX57TDO1BOIXsfOy4RAUr34fJfhzU+GfwOcduZ02ETkLx5ODxw53wbBBsJHVQV6Dds8PX+Ij63WaI6P+A+jkFI+EPI3qgmYh4Z6KgqjW7TWouw+6GFt1usu5Or+LYHk+6J7NqqETNAm/kXSKMIO4DVfwtq9vzCWQWzYPZpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239466; c=relaxed/simple;
	bh=/NQGBQbZv2sG0jSb/npgG5HgXpYxk6sauZaCqFLS0oU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X5ffaqdVziCLwmbhQw+4WG68hJutaS4+7v8vjbcn2FU9A0nzo7eGikPcKz/RZdDmutWFKdo9jGx/82TBaNdG1lUK3Eu67ukdc0CyHjAKmqZK8NEu21EjSmpih5HX0WDo5W6p8Zz2uyJDZlJNINhGfSaAEPkQdCtveXH6klpL6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZhTxoHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZhTxoHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC7E1F000FF;
	Thu, 24 Sep 2026 08:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790239464;
	bh=/NQGBQbZv2sG0jSb/npgG5HgXpYxk6sauZaCqFLS0oU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bZhTxoHBX4DBkLkBw7ph7lbPpn6XY/LeFPj3qb/YORdxG0P5mf5A6yz48/UxAzxWG
	 cWfFk8rVLdlOsFrPbgRRRnBhWIhX/0iMwEcNHOf3y4pAvcUUs8GDICkY01UlDA9D58
	 5K9JV3I7FckZKXlarUGjywbWKx/H70mD8SRuhdAnWMG3ATSPl8/aHF33XToDk95red
	 ouIp2OrsdFn8dR2gDFT00+ViDe2tSqbVpYVJJcCVckhEh7EBgZDJ4RWe+/22xDEp7D
	 kEgzaR/Lz1wcIfN+03fS6V6+3u+5rsAGSaPAqvHnZyP09VA6utPrG+AwIpI9jE1/qW
	 1l6cXgIZau6SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: mediatek: add Mediatek Genio
 520/720-EVK boards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Louis-Alexis Eyraud" <louisalexis.eyraud@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260924-add-mediatek-genio-520-720-evk-v3-2-2ec5c80677d4@collabora.com>
References: <20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com>
 <20260924-add-mediatek-genio-520-720-evk-v3-2-2ec5c80677d4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 08:44:24 +0000
Message-Id: <20260924084424.ACC7E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add compatible strings for the Mediatek Genio 520-EVK (based on
> MT8371 SoC) and Mediatek Genio 720-EVK (based on MT8391 SoC) boards.
> MT8391 and MT8371 SoC are less powerful variants of MT8189 SoC,
> with identical hardware register maps.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-add-mediat=
ek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com?part=3D2


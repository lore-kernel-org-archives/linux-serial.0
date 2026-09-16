Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D73446C01;
	Wed, 16 Sep 2026 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549193; cv=none; b=X2cOa883uqQNQOatJNP6Z58E7p74KxtE4owCKg1pMkhbN5o2JZOhCoM8T2FXz5f8h61JqHNO7eFzpb+EzstBO7XlGBU4tMxqEPjc+3L6WY8lUr9EBAJ2Y5vxkuhzq5iznec80WLwGHPqBTifzx0B7TA92ohEsEqZxbPk25r7sCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549193; c=relaxed/simple;
	bh=sdRa80BT136FTfq/xQJ3uXlc82apFYmMWA1ZK+FqH5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ry+tj1IpLic+YW7+A51das5rgxpQqO40tcWCIgoVlsNakl+yLPo8oEuEnnyDsrFEOUyh95UQxR8l3yBBtdy4pfRKhbyMfy5IYZR3pOYaXUhLiBb41No0hb0m+g/fl8r064bDaBZzw+BLbEaamiLp9UEcUee/m2d1+LNO4lDdVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNl67hWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNl67hWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3431D1F000FF;
	Wed, 16 Sep 2026 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789549183;
	bh=sdRa80BT136FTfq/xQJ3uXlc82apFYmMWA1ZK+FqH5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNl67hWOEQqaMm5XuzstOYFLVdxARuyCgKmsszPwqQAIdUBfLSvvexJmGN70KdFob
	 bePP0EvB08FQvS+pMST2uYwLFxLaogDFWmN/d8v0UH0jq1IM6UXgsMEgfTQwJP+LWZ
	 Z62XaI1lsUze2XyzPy1/UfVfOfY9No+MH6K4snk/X3oIhYMKHh9ecmg0Vpsijh4yK3
	 /csnRmnlx/okg45WiuiAgEd3qWvGqP/x18RUHQUd9bs/bNB+ZcIL/bnf3wBA7wtkcF
	 0XoiuGUFHrRnk0WUXLnJR8/fn0+QMY/fR8l7GPa1uraCWvKyEaTd2/bodlGRw3lFjQ
	 IuIkI27xzZG1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: snps-dw-apb-uart: Add
 ti,tda54-uart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Moteen Shah" <m-shah@ti.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260916085520.2259420-2-m-shah@ti.com>
References: <20260916085520.2259420-1-m-shah@ti.com>
 <20260916085520.2259420-2-m-shah@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 08:59:42 +0000
Message-Id: <20260916085943.3431D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The TDA54 UART is compatible with the existing DesignWare APB UART
> binding. Add the ti,tda54-uart compatible string.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Signed-off-by: Moteen Shah <m-shah@ti.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916085520.2259=
420-1-m-shah@ti.com?part=3D1


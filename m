Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14154DDB26;
	Fri, 18 Sep 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758476; cv=none; b=tCkL1cbnkaJ/jQo1cONLp1aA+0Kok9hRUwVVXA5Va60QsuuWKsTPdV1aERsiGmMqonB4A/aF9MP1DsFZfK+F6pZFhhShYTcCr44uSLw6R0ee6emngQo+gd0qeW+UJxY1XSDa/rozBksIxR73NEVtb8vewjGZPCgQvauP6Fwxk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758476; c=relaxed/simple;
	bh=rvnqsih56sQQlXustXeJIWYo2NxB0kYlZl4ic+MSMZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fn2TdG9Dg5dd5D1ou0G0RpbrWYOKBDcqMRfhvzmYmozmcvZamu7bmw4WCgbLYIx+pnCEO0Fe7BBu+IqsmldjGjhjkerxwxxT9Ob0AK146KcczrwXlZxOrnyFCNTGet4glu/ZevNLeFTmdOVH1AhwHLYuFsddYdJlcF+6YPcgGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRD3t72D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRD3t72D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8641F000FF;
	Fri, 18 Sep 2026 19:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789758466;
	bh=rvnqsih56sQQlXustXeJIWYo2NxB0kYlZl4ic+MSMZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aRD3t72DDn36LzrR5u2rxfxH9zzczGwtqEv0Y9fuWsRmx1MFBKBLc4GhEqXAjrHMZ
	 97MojwRGSOxvKrXLRfyPDNW/6N+gWgpyI4/en/LAxaFdSoBTJbLdNibWNsfoIP58LU
	 ofAexzCirORDJjMdUyCddROYnKwSoCS6LCySPqSwaaSRIXTsPubPnRGDKcA63v5f+j
	 2kq/iCNiK0uEkVxyaEYydNgedFXUZxmnzG6+prbelBrd0b/wQAqexoQwbVe7v8LwGu
	 e9RpldK7tzYwiYM8Wh/SPCd2AKJZIw9NORchhooukA0HpvwXLFtpetaeptI8Z2NHt7
	 0p7TpQez65DFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: google: Add dt bindings for
 frankel/blazer/mustang
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Griffin" <peter.griffin@linaro.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v4-1-745eaca28b1a@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
 <20260918-contrib-pg-pixel10-initial-dts-v4-1-745eaca28b1a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 19:07:46 +0000
Message-Id: <20260918190746.9E8641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add binding documentation for Tensor G5 SoC (Laguna) which is referred
> to in code as "lga" and three of the boards that use the Laguna SoC
> Frankel (Pixel 10), Blazer (Pixel 10 Pro) and Mustang (Pixel 10 Pro XL).
>=20
> Additionally update to use a more efficient and scalable way to express
> the various names a SoC is known by.
>=20
> Co-developed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-contrib-pg=
-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org?part=3D1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BB495AD5;
	Fri, 18 Sep 2026 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758545; cv=none; b=ab1dZSREleJ65vTJLh5ZhCqZuH4APwv74Dm3WitVNbPWzmNb1dR741SxiwayTpCOETO05AoSozefN1qVQn+83lXqaVR1MP4VJ/7ClgMNe5qJcN4rwcBKxfO1wGp2bARpjyhlSkR3UuGx+ccsDJW4WL3RpxO0B0vEJxMii/AHB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758545; c=relaxed/simple;
	bh=/OdjKqM2F/vcYYUyKxt3UIVZUR99Tl2nhMG+UUGdslQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OSRmGrMpXyB94girFJCMwJtWLebu1aA0tjSf1xJX0ZovCEFDzqF4Ntw3990BG9eCzk+IUup0xd1dcKT5AZbhFW41GEAPh96miS4WQBdlZor/4iLOikMXCOmDceHy12Hr/Yy/DgoJ8CmXRZN+CVZOBtWcibRRK1zR0qXkJXJVkpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG70OG7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG70OG7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682B11F000FF;
	Fri, 18 Sep 2026 19:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789758538;
	bh=fd8dJDGap1OAz/8NhXAEQ5BUMK2BZD/cQf56wAhWyEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BG70OG7BpamhW/2cT9KaUl3narGuxyiL7cVgo3fYRb9l78M+rA+bfa5QRJd377+Do
	 IU7TRhstxJBb4vnRoMP1TH89+6nD7MIWxYekzccGzFjbO5g/gmGuumozgZ8A2mQRXY
	 NNkFFEnjQBgYfCKi45XBsOAhENQpTDqOD3OkkXh/sSV8F6fCVLFtQuB1UiGIDY4eK7
	 gS1t6qZpEtnLc/ampyyb9KHeggftEQD3SOBPr4DyeH2ShRcvgXscGSm5vLWhJJp4RC
	 vy1iCLUxbw0lCMIJVUlRbaDS0Dk4BFp9CY91xDVl8197o2crIOIGOfaPCwQSUjf4+v
	 fQkAKLZy1QIpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] arm64: dts: google: Add dts directory for
 Google-designed silicon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Griffin" <peter.griffin@linaro.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v4-2-745eaca28b1a@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
 <20260918-contrib-pg-pixel10-initial-dts-v4-2-745eaca28b1a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 19:08:57 +0000
Message-Id: <20260918190858.682B11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Douglas Anderson <dianders@chromium.org>
>=20
> The first four Google Tensor SoCs were offshoots of Samsung Exynos
> SoCs and their device trees were organized under the "exynos/google"
> directory. Starting with the Google Tensor G5 SoC in Pixel 10 phones,
> Google Tensor SoCs are now of Google's own design. Add a location in
> the tree to store these device tree files.
>=20
> Changes by Peter Griffin
>  * update config symbol help with at least 4 lines to avoid checkpatch
>    warning
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Tested-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-contrib-pg=
-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org?part=3D2


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078E51AFD9;
	Fri, 18 Sep 2026 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752557; cv=none; b=Q8XpNpxOq5yrrAzVkAY+ac+qtTsfJ1qbxQOmALF2OnuE+CSqbb+CxQISKiNcqOxDGTCabiAL66DhiErrG2i2hxXMvxcLW7N0X0fy8yJJXTi+zCMWVUKLMMtGUMeI20UfqNdW+tSMOfSjxZ/UftEV/vNSBM6Pj5WMDHc6JIz/sYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752557; c=relaxed/simple;
	bh=GTjeUoXaWU+7d1cquHEIIELQDDfQQZ6AhTVCkv2F9nk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QydvPEc5piHEoBb7wMUIeshtU7kj66WVb6Q9OpNe8Mj3zsXYtDVjtS4G+8Y8+bPCmMYYBJ4W8wev07c/b+NQlgguvR0Kk9TiYioEAogAl3VkhUtBihaqVa45WMOjHcinGkoByPlOqe2NHvX9y0ZOp61Ua98BHA22AWEV9urX8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNZPKhmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNZPKhmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88C11F000FF;
	Fri, 18 Sep 2026 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752550;
	bh=aiLsMrbZZs1/ikD2N7e+55gxTUrtaAsc4C4fweJ3h1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YNZPKhmTGmSJif+p7LBHTpoxuvMTq5NR3XnqFKpB0Ftofov5rsXEMgs0Suoa5+T/w
	 iMmaHBpSLPK+8CoOLGesTZSwqfYh3QAxecAQufPLWFMkZbDTgIENoXiQ+wkg7a/VDn
	 9bUAnEvesLsTf0wPKwEYJID5oGyriaJYaJq+FciwVXZkeTzWSa6fHFs4/2CF+k+e2/
	 ebLjfPD1sf4reB6josVmP9PfkapXxSNu+JnikjP8IRMGq+kS8oAXD7LlPy9WNZeClg
	 UWqytpGLkmE555CudncZUZrwGFP/RkfV3InbpO6Q9WWRvOfBetjpsJ7QRReo7J7Ped
	 c8QvrBgEPfuaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] arm64: dts: google: Add dts directory for
 Google-designed silicon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Griffin" <peter.griffin@linaro.org>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v3-2-c94e51140509@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v3-0-c94e51140509@linaro.org>
 <20260918-contrib-pg-pixel10-initial-dts-v3-2-c94e51140509@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:29:09 +0000
Message-Id: <20260918172909.E88C11F000FF@smtp.kernel.org>
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
-pixel10-initial-dts-v3-0-c94e51140509@linaro.org?part=3D2


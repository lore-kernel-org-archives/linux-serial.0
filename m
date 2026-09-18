Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF651AFC2;
	Fri, 18 Sep 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752534; cv=none; b=BIYMcj/V+Xd1nnmP69GfnptQ5Or+MMFGTF6/3826MswHA9fm/L/hTzDGoq7RqiaSGw8i5Zgf8hbz74q+DTHQ1TQ4pEoiu/HMw+7dWUptAzkiwg5nqFGIt4I4WaD+E2WIxGnob6o0i5WYp+GdRhuCiKl6dFymxRWZtYXohVEn0eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752534; c=relaxed/simple;
	bh=IdIHHwh4tRUr90eKfVM6gbm2vBNYFwwyQs7qzUosrzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iAJl7R6Hcl+AfeyNPGDzavp9EkY2Klkl+rCQvcHQHEcp3ayUBRpHPVqdkAk9lW8vaPPZJ37oDbHHkT6jl8mqD7MQRu8jCNCw6Z6KDOyp0Sn5D5twi2pQnXmqFOHPA7DZ1LlsZHqXSFfMKkPOYyxFIcw+Csqv55WVqQPlnGk152w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH1xMIiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH1xMIiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134381F000FF;
	Fri, 18 Sep 2026 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752529;
	bh=IdIHHwh4tRUr90eKfVM6gbm2vBNYFwwyQs7qzUosrzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DH1xMIiDtt7s0dCixf7q9yVwS6yu+YTj3inoz2zEL2fpfdLBpKauQso7820herAc8
	 udUa7FzyPcvSR9L8/pxuBSV+LBz7XTyYEc7ogV3NJgYFyw37h1rMYAV6sSq9zb9Hew
	 CJJIar0yA4VDD3n7pbQaIf/3s0nxFTZL+d44Em+0hYVyJs8eOBtsNTfLPUFvRnq78Z
	 uCehMq5SSzzqarRbqzabpSuEGHP0bT1+kMWOOBz5FcParOj8eiUpn6iKLrJG12Vq7n
	 TwIqaopZTNjDi0IFn4MjEs5nQCO6EXoT1MADejMcLC4EybBNrSL/IG2nCegt4ilOfA
	 Xk2BgaCU2RigQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] arm64: defconfig: enable Tensor G5 SoC family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Griffin" <peter.griffin@linaro.org>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v3-4-c94e51140509@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v3-0-c94e51140509@linaro.org>
 <20260918-contrib-pg-pixel10-initial-dts-v3-4-c94e51140509@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:28:48 +0000
Message-Id: <20260918172849.134381F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Enable the Google Tensor G5 (Laguna) SoC family in the arm64
> defconfig. This SoC family is found in Pixel 10 and later phones.
>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-contrib-pg=
-pixel10-initial-dts-v3-0-c94e51140509@linaro.org?part=3D4


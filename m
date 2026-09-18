Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320E51B16E;
	Fri, 18 Sep 2026 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752609; cv=none; b=eyt9bh+EV3WyhDJ1TtbuFDjdOoJJtyAuTtDByde9fHpBFKI+yzqq3szV8fE9sHCN0YqfWk8Fq0Sr5pNvVzdAY9vFH65WfTobLeYcFH4pV7sgh6eQ8tzTch8kE6yIEe6K1EarTSj1i3Sl5kmEeODCey+apAULrRA3905uputRFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752609; c=relaxed/simple;
	bh=+p4IgFMV0kNzEzTUZLtJAEbfwng0tLgUpcAxdefHls0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i2Jou+BHi1S1OQ9jStcJkH3JBzGF0auG7oHm6N9eVZZbHVj1glWipur8BVGuPCj2Oy1FbBGhwzSAs6E2i+kboERRMElUaicQygBJc7iF4fOXbjY5zY9uA6GQrqgHVfgENtduNGd5Dz7wc9HwOPgj8qTDPChAMD4prLzHbB/EXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6kMHzpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6kMHzpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C57B1F00898;
	Fri, 18 Sep 2026 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752601;
	bh=+p4IgFMV0kNzEzTUZLtJAEbfwng0tLgUpcAxdefHls0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X6kMHzpnzqJhFkKMPpzOVFM9GSArOiQP3uU05/EFR8WXlAtiOEztcLqEgrT0mNYkY
	 7sluCLLkgGfxq5l6eui/KrTfIGD0It7Dyl3bfdOq3HN2yQ5hhRV+XPGhnxab/LnXAv
	 CAhxfV+yTB/NgZMAG0x2IZLbIpNbHbBtHGjKGhQHq5+92z5guAF6hDf8sCsFwdSlbX
	 MSfsPbfOyOJSkpTmwbdqtZpsnTNBkXf50T8FiPLsKLcGDB3dBm9lpFj3nL9o0bfbJi
	 mkvTVO7VCCSFjez4JDuppzurWnkUm8JLGZmfQOe3zvUrZ31LGVdpFziitta//Di2ZD
	 QSU4KwQ/6okTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: google: Add dt bindings for
 frankel/blazer/mustang
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Griffin" <peter.griffin@linaro.org>
Cc: linux-serial@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v3-1-c94e51140509@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v3-0-c94e51140509@linaro.org>
 <20260918-contrib-pg-pixel10-initial-dts-v3-1-c94e51140509@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:30:00 +0000
Message-Id: <20260918173001.5C57B1F00898@smtp.kernel.org>
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
-pixel10-initial-dts-v3-0-c94e51140509@linaro.org?part=3D1


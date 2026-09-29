Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E942CAEB;
	Tue, 29 Sep 2026 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663957; cv=none; b=LWGdWZK5BRhXLXz/nY8nbqhyvk6k/Cliwu4H78VV674l4MjFOtF6/L0qSsU0vYfmfHIj3Xdw09ANAXhBEUO7MwhyGTiCjrL5lwR+BxIPhE7jVtX1cTjMTN+4Bn/3cVRFIpQyD65PefmdcdT+2hQVblR95LtMzB0hMcgwTXuAoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663957; c=relaxed/simple;
	bh=I5U0sXtR3w2jaTwAbtvqA6EKgKPWpEiqC6dQ6AT5K+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ne2EZQIQpPpduVg/Xv2/ijLUKm0SLPbOK8g0kzRbrPM/ZUPZ12qqnZ2LoSNq6amXrpc46frOMZ38FqkofMarSeoMmNGU9deLSLOUBD5lv6H0uWB6xSznRWL5dc0ZKatibgSAH5TNw5yln3tHiJIM75TMsO2TA3Uh7YzQ/1RV8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8u1ODgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8u1ODgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B6C1F000FF;
	Tue, 29 Sep 2026 06:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663956;
	bh=I5U0sXtR3w2jaTwAbtvqA6EKgKPWpEiqC6dQ6AT5K+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k8u1ODgTqiEqZojc/7MIa+HmnPRaYfqySzSmJ8pPYZuhM6QUpB+Swxado6SDPPMLZ
	 OOWP5j+C3keSdGUnaqBddDCN3R84GzZX6QrImEwKWkt+cUmQl0kjZMM+LlRuVTC3MX
	 lh0Rww+nIpqu8CicPMCwZvN6ELnOQQgrpNZAu5yqZABG4V2HF8rSgng36GzjIbFTj2
	 +4qApjomlArlXoxx/u7m3ytjP+Y48myg+HIttUF6W4JqHfcXh1QP9YyzleotLdZTXZ
	 BWeartKdWrbA29Yt/jt0P08+lPbC8QrDYhcyZVEHl6ED/6fk8fOxINNnx94ju1vqz9
	 ntCIIyrIQaJtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/20] dt-bindings: i2c: dw: Add Synaptics sl261x i2c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: conor+dt@kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-i3c@lists.infradead.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-serial@vger.kernel.org, lee@kernel.org, mfd@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260929061417.20733-3-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-3-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:39:15 +0000
Message-Id: <20260929063915.B7B6C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add the compatible for the Synaptics SL261X SoC I2C controllers, which
> are compatible with the Synopsys DesignWare I2C.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D2


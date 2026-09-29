Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C84349BF;
	Tue, 29 Sep 2026 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664265; cv=none; b=XChjRTMBpBzDJe0tBEkygOTAclnawRWP1dYqAmja+jY2hZ1F2ULOcm22VMPABeFHpRFx4XAqGUBvDP29FyAUTLJ+rw/82uQc2mFLHNNnaqIHbwjfaKyU9lMoaz1FmE8XgDJfjRAke9OghGcKos8QVzOyeaUTNYGtuHvExDJ2tFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664265; c=relaxed/simple;
	bh=X37Gdcud4+gtmCWNfBsw2cB7EFFMSxxV5Vh5vqoYvNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G/uHeXws5D49WiOIYTxtqkagHiObzafNWZVmgKZnVj4PGeor660AEdFYXR397V0x3k3vLYoP6SpdGstAzMEYqxcUTn4RPEZmW/ATynD1FEopQ7Iuku+/yy+4wI6ueRofrcDvWUqrmq6TRDHl/P5HzS+7VB9jSjHjkf8vq6hUkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSKibiE+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSKibiE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BCE1F000FF;
	Tue, 29 Sep 2026 06:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664264;
	bh=X37Gdcud4+gtmCWNfBsw2cB7EFFMSxxV5Vh5vqoYvNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VSKibiE+/c0jsVNZstl2WL7x42Fbha0Wh8W/6j5M1iHipGIw+wkgYGfwXPq6FF6gk
	 tPvzwW8LJcWsDv63m/vlfoQi+p5eBM/tDnYxMaS4Zx1GmAtzr/s0HYeOvoyp+HsUEc
	 S8AQId765mJj4ra3B6IIQXBoDtBqqo4hkVY1OA29VLenCrn4DM1yrj9Z29Z4/ido8b
	 o6K0TlG1I2ag9f0n4zJj7+z/zWKbwVGzkcxDtzhChG1my2lkJ946xg744kbIs2Fotg
	 pEJ7o6XDkYmR/AHkFa88BDYyHWFnZI69OvOBHs2GHgwaMe79RmY3yvYWXmcCDPIjS5
	 oH4h4sGvjT3pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/20] dt-bindings: serial: snps-dw-apb-uart: Add
 Synaptics sl261x uart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: conor+dt@kernel.org, Frank.Li@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org, linux-i3c@lists.infradead.org
In-Reply-To: <20260929061417.20733-2-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-2-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:44:23 +0000
Message-Id: <20260929064424.09BCE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add the compatible for the UARTs of the Synaptics SL261X, which are
> compatible with the Synopsys DesignWare APB UART.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D1


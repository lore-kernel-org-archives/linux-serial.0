Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795978;
	b=o2seMiJFigHQrsav5Ay2obwlsbskUCDGAXlxvvq2Oo8kpai+/iHb/rsbkF35C5iX9sdG
	 gpmqP5Bn5dHasQmJVgYcEdBVu/PegYO088gdlEmSlYT3bmSleqEC8iRwej+dOEUm6ooeL
	 sYGg+awpy18GWeUDF/V5jirmlEToGBBUM6xeKNfuRWPbGdlJASifWr4aJtOSkEKo7MqRz
	 mpNyY2SBb0GRO8TnJPI0rUxa5WjmPeWqhch2pYJSGqmZKSaigMLw4qZ9M3rlAGVQQz04b
	 o2Ycm+Le5vfmBTLW2gbWjKtCrJn3FeBerds2XHibuRXAFWPfaSDkMJXe025OsQSc17A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795978;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3eS3I+N6mwzYesPZvwBhY0xitCiDGGid3Bv1AOdaNoA=;
	b=nneXW2pD7eF3QTVn1Lcuc1FWaJGNiwLsiGaEJA5LohSHUV3aQJlCYLTN7hrILHukoiU/
	 SpLPlpxipTroQGaWSKeTDCblWc0aaLf5xSIYJHDwn9zh9nBrcXLOkH/o/45g6jBksEJWo
	 Q6dC7Uv7vECacxai6NKe6mgEO7qcckHfAYg1HFuf9WHbfUrTckhFH4btR0aMUlE783eyN
	 L4v4shouJpcluHSQXi2L/8uYgCGCQYRuMu2oG9AM+Xk1Ej0t6aapwO+v1OZmpBa5t1jwY
	 fSdWeXUCLqsEWMzy57HDgnySQFi2muPdy5iH+a5+t/tFUvujmEMyF0Z6sLsI+jtda0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ITV/6uJn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB594606A31E
	for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITV/6uJn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5181F00893;
	Fri, 27 Nov 2026 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795795978;
	bh=3eS3I+N6mwzYesPZvwBhY0xitCiDGGid3Bv1AOdaNoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ITV/6uJnVsmpXAxjFCLBDWKoDxx2YeOi/OH5uSZGg5nF2a5PsETxx36Ge69iY5Qb3
	 R11w9OgoN9TI+V2GQxEfePdGLzG7/NtMGxgz3y3c74Zda0DyuDdto51h2SDTADbb3Y
	 szNmtVwcZgLlUwj5bLPKZ1YbgajwX58L8wQSE1mnW/FivBEcLN6BHON2X/BaAXVEVL
	 RD1Ftj7pnyCskh6T4yq82XsTUoZYI5TwiCeC/aZZHCUMG0A0C4452ztHSeWYKKFSv1
	 RVBLN06n8xuMykk2aaVOBUURJdPrTIV2wx8nKHHMdwrAPO14DJg0+XcppdZ3YsXQTV
	 h9BWZh3HVnyKg==
Message-ID: <sashiko-outbox-237850@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/3] tty: serial: sh-sci: set the RSCI RX FIFO trigger
 to half the FIFO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261127-divo-ssgrlpcsrc-2996-rsci-rx-fixes-v1-0-cad6ce9f83bc@renesas.com>
References: <20261127-divo-ssgrlpcsrc-2996-rsci-rx-fixes-v1-0-cad6ce9f83bc@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:12:57 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 3-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-divo-ssgrl=
pcsrc-2996-rsci-rx-fixes-v1-0-cad6ce9f83bc@renesas.com

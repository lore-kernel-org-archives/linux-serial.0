Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233461;
	b=Sz0x12MDzaMJ6O+cPApHDhgR34gc2g+Prk2vqM5w1NDzED07SHTKeooBT/TGo1snf1ur
	 Ab6hGZ+oixqFwRdwtRwfmBeNer2cZfo+FbHcGI8TLVhzMYv+0O1uMq8EYAvk0ejsUmFH2
	 zfVNJjj/W2o5+3fD7DOl+iOxncpCjx0MLhou/zETMajA72Q4Ye4vP118by8XbvPqvgLUM
	 49QE9c96pvhy5ghb0oaJswikObvF1BjMDanFX+/E1QBHEWKASXnHDfWs4ocMxfIjaxQ21
	 yvPmA8WLRg+sXxEl/tl/RHAh2niD9AdliPbgL034WlNU17+cpV4inqh4XHJFKUmqkYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233461;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=meSV7w4pPDtZTRPEKGpC9u1WzxeRgLW/BXH8v2SVxUg=;
	b=JK7skD5uVjHwcML3wtOvplDb4OLlfJvSvaa2d00NSGEsFJWsls86xuB5EnjNG8AcLDSr
	 BqWyZNAmFNZHuifC08xD1IA6YijSRmcCicLLj2LkNYBkJQXoWPH84GzhE8hqVsRQAaKro
	 HNdaF0HApobM1SY5yJQopUuMRDD4ZmqwCQ3U+G+u9L33/XwSbEzMh4/HlRFH5p5XwHHTI
	 f6dL0idWJhZWNc1PZunN7l4MNMjPIDPo2M7+vCerc7easKwcrHVZ35E8aQj9RxuT9x0iQ
	 5CDbfF6U0cV5Vaaz6kZMzOaMoxE1SkWIE38B8irDAFajX01AEaQ1ASrMC0wA+mM9IWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1W60WeG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944E606A326
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1W60WeG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44641F01825;
	Thu, 29 Oct 2026 00:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793233461;
	bh=meSV7w4pPDtZTRPEKGpC9u1WzxeRgLW/BXH8v2SVxUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l1W60WeGraCf8zcrdTDvsheTNyptM7tP6JGJcCxPZIMTmozOgJy8TFi54ClxsMn5D
	 giLOq+Mav9/heADgv6yHAOsyCKxrewddaSFSfB0QWhoUqBu8vQ+OR8C0yieyF9vH/q
	 R6glg68JfJpQgHE7ZRZe3nBRLVhL90Ylq9rbVKWVeyNeH1+2WqVXo4HuRwZzaG5OnY
	 NISnx6Sv8QSeJW+F4yBtBCaQ6QNDlr9w+BSR4gZSf4fDPdK+yXXi1WVPQYQZQXhz/B
	 LVSigsqpELKEg7EqbNDxeyw3H/qur2Fxq0exjKdthtOEQi0GDGut4+QAXYKt7rgySm
	 GIs5JLglH/ssw==
Message-ID: <sashiko-outbox-188567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: n_tty: convert the full VTIME interval to jiffies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hungyu Lin" <dennylin0707@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029002052.54117-1-dennylin0707@gmail.com>
References: <20261029002052.54117-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 00:24:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> VTIME specifies a timeout in tenths of a second, but n_tty_read() divides
> HZ by 10 before multiplying by VTIME. For supported HZ values that are
> not divisible by 10, this truncates each decisecond and shortens the
> requested interval. For example, HZ=3D128 and VTIME=3D40 produce 480 ticks
> instead of 512 ticks for four seconds.
>=20
> Convert the full interval to milliseconds before calling
> msecs_to_jiffies(), for both the read and inter-byte timeouts. This
> preserves zero VTIME and avoids accumulating the initial division's
> rounding loss.
>=20
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029002052.5411=
7-1-dennylin0707@gmail.com?part=3D1


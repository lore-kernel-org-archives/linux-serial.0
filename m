Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794054275;
	b=yxOToJTDwEL1DJq1yXlciMAR7t7svhX4MbnbxYr+3Lbq+f/+HwLcD80vLK7ELy936VMd
	 kWmmh325rEAxMw/GsaHM6AWCov94jl+IZcNpYvLlVI+x09EQodyqugvAjBwr6bBvVkR6L
	 j6lFg3u1SFxMRrPHmrh59taMhQYYQs/OIkqr2QZ/3DLU4ezKv73rJHOuOLLndA6J543Bc
	 a2xdh/cBiGduaYKwRe7lbvjOKh8OkvqaILJmAySfGmzu7Mq3DBu0qAk+g3w/pyuWO/KKR
	 42wOLr+azEbDeMg1yxdFdSMxuWei/MfJImwp6Y8/Maf8ZaPPwQxltB6cSWsrptMLFMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054275;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3Fcd206544NSJdYCJerOGkJyO2tzcgrR/ihRpdip/gA=;
	b=33EXEf9VqC8YFyRJC9HQbvZKf/cfkdUkI8LOGJFiMyh7ugAhTefDbBxz1yxFX11tDmUR
	 EVCvZcUPYPcTR9RaMqcRkkre51fQbscF0W9ETa287ddN3/fe5S/pt8JN8nZg7H7UU4y7J
	 V8pURcPOaJMlL23Sut6ZJthlaoOLV+q6vPEVdwGHJf4AApV1Q7EAge5eTaSkHPzYAyOHH
	 6vQ+AFISJw7xbnlNvoxAnt0jT4am6JQvuXLKLC0gVrUTlAnpIpGQMIsN1WwLbwH543G3d
	 KuYGR8btpcrJmOBk76KMc4ML1CSDBdhILTPU1+e6iV6lTHxOOt27Ev1H9ubO5tOXyCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFph5tJK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF9606A326
	for <linux-serial@vger.kernel.org>; Sat,  7 Nov 2026 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFph5tJK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B68E1F008A1;
	Sat,  7 Nov 2026 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054275;
	bh=3Fcd206544NSJdYCJerOGkJyO2tzcgrR/ihRpdip/gA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UFph5tJKtFvHLHhH17y2kwLf6TKcpcN2JXCRq52Tw6UpuCUabhfKfqt/1XOcxSr+M
	 SBtfo9czZB6iHFFvXmU1HhwJ79AJycILZyacxdspbLAP7HJqz7dpzaldVpbzPblDxw
	 wiKK32rHrBFWKhc//cdWpTnwFggvI7y8XTJhnHyJ7Vs8n6VeMxZ+J/wKmSHlDZX/Ou
	 GmHZFGkAQxNKST3+pw9E9wZpSHSP2JWj7IcZtewDC4CKIiCtN0+puc4MJLtRG0U01U
	 bTDO62z6qOuAmGoNrvHEDKxqB/Hkpu4B9Xt6Ekt1kxr1wp3ZqFzS3Iw77YDWZMPkG0
	 Q/dDiRkt7Gp7w==
Message-ID: <sashiko-outbox-202890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: watchdog: mediatek,mtk-wdt: Add MT6833
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Cao" <i@udp0.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261107-mt6833-base-v1-2-bda21083e9f3@udp0.com>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
 <20261107-mt6833-base-v1-2-bda21083e9f3@udp0.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 12:24:32 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Rui Cao <i@udp0.com>
>=20
> Add MediaTek's MT6833 (Dimensity 700). Its watchdog works as MT6589's,
> which it falls back to.
>=20
> Signed-off-by: Rui Cao <i@udp0.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-mt6833-bas=
e-v1-0-bda21083e9f3@udp0.com?part=3D2


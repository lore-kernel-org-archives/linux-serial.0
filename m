Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202316;
	b=M3brdli0gKk8cvBi045y84PYQ3LRDp5qMJ58zhp6Lha6/HHdwU0e/D5d8eyxbygusLGF
	 Y+60gv725VaZJGifc2qkCKTBqHz7vzBrct35SGyIT05LlQ/m25hFzYhbOOwyoW8jPKj6D
	 xw5cnJHNEAHOdIgaS6URC2lDuwoHzg/4TkT9NJWk/8fEl+VDVz67DwNGuVU8nfjTZmt+7
	 UYzU253ZxFflxsk69/idu/D/0P6S1QZiOrc/taBJzyywjmK2MpddPaWLrOWwKHFE3czNQ
	 k9rEkz31rx8C0whnKntSp/5JzY5ickbHvPduT4Z9mVVfudNfizw8pMXpqlWNs50DbpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HIGb1GBbU9TziRJQWfmjrsu5RBvYboMRPX3QEXTq6Yk=;
	b=CA1nDAqA54MZj42WMrvAy0HkUukML4FY89SwDl0LbRSPF/DlIr+27UtSQTfgzAt9+WCs
	 1dr4T1YSyL9JEwKXd8H0LAw655dcAWR6pArlo45VwlR79bFjjlbZMDvXTw+ZqF25xcR0/
	 ZRD+4FFyKYoA/6v687n/3RxBkb7Zo8r/jXf7mXq9Arf0olNyOglhaJVlKLPDS7caOU3pe
	 QEnP7ugAUg8sfg+In5oVKDEYKHfFlpZpg0tXwi/8W31OQhHseNh1ojr6SgEuqCVw6wRNW
	 f/fgdwW0nnBRWfZ5Fk65Tns36vk/0ls2b7wi75gi0LIT4XvfXo/4GDSwsD5flETX0dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eTcY/xRm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488DF606A335
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTcY/xRm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DA51F000C4;
	Fri, 20 Nov 2026 19:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202315;
	bh=HIGb1GBbU9TziRJQWfmjrsu5RBvYboMRPX3QEXTq6Yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTcY/xRmJFO/VN4YkJoLXW1vVv+3lOnGp+ibGzm4R0NGNGGj1571is7Vl56n+PYeQ
	 R+N8A/OkmCm6Tum6e9aoPGVpXzxbd0ang382G2GDoKDMpro1D6jpvJrukZUcPiUVhN
	 tqE9sUxwPns04nbBJg0AoUppS5KzI7l47yRDHzBajWvIHpSx26SpHU34rUd1I8Rae0
	 KBfie4GWjrbVs5sHQ5yUw46anBY7Z7eMGo0cAHG/+5BAMIzrHf7wU/GE81v+4WRxGe
	 PkFIMxBfm2wdXalQQWdKlIlSghUBBBgrJu3kBt9LTAIH1NwBPvxOV6N6yijBdKZCvS
	 Lykxrb5o1GrCQ==
Message-ID: <sashiko-outbox-225903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/13] dt-bindings: interrupt-controller: add Zhihe
 A210 PLIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-4-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-4-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:18:34 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
>=20
> Add the A210 PLIC compatible with the thead,c900-plic fallback.
>=20
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D4


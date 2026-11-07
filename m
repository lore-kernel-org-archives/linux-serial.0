Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794056758;
	b=QOxCXG13zK26BfmqIg11hgvJlDaZ3xvoQBrCEwUlCIdpIOsVeZPJXkrjPI+CX4mZFTwn
	 NYU171fv4CJoZSKk19ZmmfodyM0TqYa0ZhjvFoKu+dHCa/mXC16DT9Nks84zBWfOewoPA
	 GKRtM5B1O76L6QM59zZB04rG5Z6Hpu8GROJXUdyNORWOGEIM7u2oxjTvdFBxuOZW3PgoF
	 9LkXXLPy50cbOp8DmRSwxSVjKivbS30XQh5HjzlNPD0VwYhMFUjRP1chJylOSIKrqEoHS
	 P83/D4tCO5QuPTxjRNgOw6oIxSdcuVfzBcTl5vjcYWZb+vcsX3I5bpJsTskoAw52crw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794056758;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/3sAFHtPYKh4hfh5oHSjJm2FliB8mRvDUUYSRjLsl2w=;
	b=zidxyxJhSXqWPhfsuR4/dFVD4efKHQ9j+baNhoaKnKwp2Du8NQItc8zdyDPvSLmyAOVZ
	 Th7BdU7mJ98tuX3bEq+RYsEB/na6UhpPkAM4fUfJ2Xmh/UU2EeesB/w+LfMVZENFT7Vqn
	 bG2GgJ3exEv9xvi04SDpQ+TQCFmFLhVV81CqioaIvO7yA5YDid9bfv84tMLhienTCqjie
	 ac/n6CLRfPAPlVUoVusI43iDtSuU7nFqepxIjXFd9jy+ACxI5L4NpoP3uzfDrQFEZd6+h
	 xbQMO6r48ClkV4TZe0Pd2TdIQPFZFHA1G7hh+ymNlzu+HKaYexzzi6wsXrhh1n5kfKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=EOjxcNSL;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47B606A332
	for <linux-serial@vger.kernel.org>; Sat,  7 Nov 2026 13:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B47B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=EOjxcNSL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794056754; x=1794315954;
	bh=/3sAFHtPYKh4hfh5oHSjJm2FliB8mRvDUUYSRjLsl2w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EOjxcNSL5Bum7bEk2C0Vd49WKS7rrBFS6p11yhtRpfi2ClHAQh3If5jMEiWF5MD3R
	 tXqq67EqzYI/aIZadN8AOLn4pTIoRN04HKqVVeYlMgW4sk2YFmEiwoicCJS1Gs/eK6
	 4kq2HEt5fmyoka4M4vcvnX1nEhXRSI78DVHmij4HSbYCvfce+hYD9J0hB69+Fn1nn7
	 Dqpdt0vGmNRgvJsrazIqqScVqHglXH6fqZN4WlZ6dvREP26oZK9qIlGzmcIjd+UfWv
	 OSWnfPLrZAcQ7dfY22sGl1gkknl0xR/F9ex2evxNoW3yvgxlZtnWTXO48H8TaBenf1
	 r44//TQ5n2eVA==
Date: Sat, 07 Nov 2026 13:05:50 +0000
To: i@udp0.com
From: Roman Vivchar <rva333@protonmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: watchdog: mediatek,mtk-wdt: Add MT6833
Message-ID: <NHTtBa55FlZroePPfTapZ39Pvy1b4wyqCCdSD04TWCQXFLmLQy2sA6FNcAybpbZP5XAT42Ze_JPK1F8mA3c49Wk7dm8_Uir4anxYntb_CNI=@protonmail.com>
In-Reply-To: <20261107-mt6833-base-v1-2-bda21083e9f3@udp0.com>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com> <20261107-mt6833-base-v1-2-bda21083e9f3@udp0.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 457835996074fe34483b037e7f2162c30162acfc
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Saturday, November 7th, 2026 at 2:22 PM, Rui Cao via B4 Relay <devnull+i=
.udp0.com@kernel.org> wrote:

> From: Rui Cao <i@udp0.com>
>=20
> Add MediaTek's MT6833 (Dimensity 700). Its watchdog works as MT6589's,
> which it falls back to.
>=20
> Signed-off-by: Rui Cao <i@udp0.com>

Does mt6833 watchdog have the same resets as mt6589? Please take a look
at mt6895 series [1].

[1]: https://lore.kernel.org/linux-mediatek/au7UMdlP9O6oo41i@buffalo-ssd/

Best regards,
Roman

> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.=
yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index f9b725592c2..dfdc06c758d 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -38,6 +38,7 @@ properties:
>                - mediatek,mt6572-wdt
>                - mediatek,mt6582-wdt
>                - mediatek,mt6797-wdt
> +              - mediatek,mt6833-wdt
>                - mediatek,mt7622-wdt
>                - mediatek,mt7623-wdt
>                - mediatek,mt7629-wdt
>=20
> --
> Git-157)
>=20
>=20
>=20
> 

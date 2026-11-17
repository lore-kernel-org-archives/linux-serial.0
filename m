Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916565;
	b=0yIdXXclEJesHwfqJYbnA853LNlzgC2+wA52z1gXkvTspKBLIBRvwDkq5miyRDXalKPV
	 y8oed1hGjzLOdYE+zftORtmSC6tur0/uv/MtPdBU3RPVt5/tiuuSSyTR20ovSKGKFr9S3
	 q6zjaBv/gAP/VvGT69U3ftFPsjMbcNYY3FV/maLSBGYxXmxfWjiXfyNIPQQVH0/X2suVb
	 bafAcgA1gBk86QqipETeh8RxZrpAXWmpUnB9eFocsATJs3hkxF6HByGzsqnQQN6Rm5t+T
	 AZChenuuB89KID/O63PxugkFvzUEACdb4sCJ/RXkgZ0j7nO06xRF+jPwtrFL1mw4NKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916565;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=7gp/tEK1h0CZZzF3joRMwW+MfGEJpki8fHwQoqeeKfw=;
	b=QewXQViCkCWan2RndkY2uaMkqpj431b4Cl+i4RVkG0CCdpiXmeXTrUFsFj3rS/ie5uoG
	 gUiwQZxveZCtUjIgdYavMvGCTZ+WUEhORDjvyA3D7dW+63Nso6y1P1SMJI96FP4XHSOXM
	 Y4XFcrChhVT50ohC5XYtk96V2lHwYo4BihFaiXQZ8FmxyqEzmDEO3/pCrfdYW4Lt8Eaxj
	 Eab2D4jbaugfNPBw70IUkScHCcNxqG+yMTa54yJzB80067gKuuDi3742/D7Jj32gR/XzR
	 MU2VpW7kJ49YX1OdbgcIO+3wxJv37/crCR9pjwTIKGRtJ1F/bVMWSC2CWCMYzU0RHSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.ch;
	spf=pass smtp.mailfrom=protonmail.ch;
	dkim=pass header.d=protonmail.ch header.i=@protonmail.ch header.a=rsa-sha256 header.s=protonmail3 header.b="O7F/AtX3";
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880F606A330;
	Tue, 17 Nov 2026 11:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E880F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.ch header.i=@protonmail.ch header.a=rsa-sha256 header.s=protonmail3 header.b=O7F/AtX3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1794916562; x=1795175762;
	bh=7gp/tEK1h0CZZzF3joRMwW+MfGEJpki8fHwQoqeeKfw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=O7F/AtX3l6DPqkI6RguZwNBMfZ8Q78/wqNX5ZpMBIWtPvvD1yed4ILge4ywzG8cPI
	 Lf+lgC64qGvbsf43OvQtAvHvhZsXNTIpYuxklutzWVBR2ckmfbetl/CxYxBeIG870Q
	 kRC/0tii1TIGYeprV3n9wmpYakL+gAb1X2to14AQD5dDrDZJCvoXwUptSno4qcWUDK
	 D3Nj91gHZtEceflE6OFXJxEN3d6M5/Q1Bm5VGKMg4Yq7dUQFRUW7NEsEPn8Yb1djRR
	 BJqc3Hyf0V8h9QaRmeAsaCSgZRxWsB4vb6Vm8IOnL7zusjkjV7bUpKGu/K3jims+7S
	 HwHvoHiSamLAQ==
Date: Tue, 17 Nov 2026 11:55:52 +0000
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
From: Ben Grisdale <bengris32@protonmail.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 0/6] arm64: Initial support for MediaTek MT8163 SoC
Message-ID: <20261117115545.1983774d@ben-desktop>
In-Reply-To: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
References: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
Feedback-ID: 27291966:user:proton
X-Pm-Message-ID: 638059f9793bf86f61db029f1075fb5536fbc904
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

Hi Angelo,

On Thu, 05 Nov 2026 14:28:45 +0000
"Ben Grisdale via B4 Relay" <devnull+bengris32.protonmail.ch@kernel.org> wr=
ote:

> This series adds basic support for the MediaTek MT8163 SoC.
>=20
> The MT8163 is a 64-bit SoC featuring four ARM Cortex-A53 cores,
> typically found in entry-level tablets and smart displays, such as
> the Amazon Echo and Fire HD devices.

Gentle ping on this patch series, v2 has been sitting for a bit so I
would appreciate your review on them when you have time :)

Best Regards,
Ben Grisdale


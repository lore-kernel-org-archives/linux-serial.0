Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778725;
	b=UCiGt9kuQdojWfOmBvLsQ/iXyzwoJmlTaj0ZQpqXrLiaxQH0bkJMaZ6n441U+ZdYBcIO
	 rYuKf3RykU7spGZEo5Sz8TWozp3E6a6IUzG2xqlCAQJUQMe5AAF/amR7/nLV93tRtvd8w
	 tplxAFTBpS89z1pHluv6j9drHNFU9mXXEaZE20O+cgmf8o8EA7yPtoyvyhnDtR4oGEwGc
	 sxwTgpUC5PCylxwfJHWV/TkCFuXUvbEGvW0vP+VvQM8avhavoHDfCgVA/eGbSlIaIGtuC
	 Ab3hXrS/rhBJvFesg7s80Vj5wu4mvrWeDr5CakG4QLlpLevDuBdh4HUzJn+0MI91nIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778725;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BINK9s4ZfoUl2+0apuQ6n3zUEKf+TvZJ1T4q11gk+Rg=;
	b=lHKfZw5ApL7U1ud9iNLtQoZg4quVAacxah3lTC9pw0VeEpQjEdClTFPHO3GVns+fh2D6
	 tbWyRMzfYLBR4RNeQWmJqgnAWCixD3W2wRIJdQ+Vgevu67SC/vIxgDAEQcehyC0yCfGxU
	 9ojX33j7vvH5plIlEoD5TcGiDsp/k3gwviEl4OHCM2XU8NnyPwBqGfKaVFahBDjW336R0
	 AVFsHTm2IVCRunHLZFuKd/ZfdMwLYPcxKMQI8xjcafmdGGBuMu/j+UD48cn1lzG90eVUa
	 FQDTwSNlZRUacm4C57nqKE1xERav97U6u9/FmJ6PAbDP9CQG+nn0Vs9+K5UTdlSP6ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToClG8IA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF5606A326;
	Wed,  4 Nov 2026 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToClG8IA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC6A1F000C1;
	Wed,  4 Nov 2026 07:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778725;
	bh=BINK9s4ZfoUl2+0apuQ6n3zUEKf+TvZJ1T4q11gk+Rg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ToClG8IAWJWNzQVhPkRQVkdHg8oX+fT42a8VOhsYAKAHnSWRQEvjQvD+jektXqqfQ
	 mvG8hEsCbDuyJmGH0934HE0G+MnWH26wGsqa/gYOYFzsTUQzLNZQunHuEEPRCuTOR4
	 4kv+efHW1+PHrmGfL2BAm0+Cgs8RhC3iLzeWFTlAuiDzZjYrfmRpWD5YgALRq+uD/k
	 xRcewPUaWokvCsIVSLH7laIykQCs+Qsh864NngADQRQSQNRonM2bH4VKLQN8X396Un
	 OZ54yeIluLsVzGmxjP0udBDrNOSECeNZUrYtaDltjeqAHMCiw8hXaZNXqCe1LRQ0gI
	 HvPmh15Tz2kxg==
Message-ID: <sashiko-outbox-196836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: serial: 8250: Add dedicated
 Loongson-2K3000 UART compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <c194b5248184779da500476281fd411fc80a98d6.1793776192.git.zhoubinbin@loongson.cn>
References: <cover.1793776192.git.zhoubinbin@loongson.cn>
 <c194b5248184779da500476281fd411fc80a98d6.1793776192.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:52:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: serial: 8250: duplicate ns16550a fallback block for ls=
2k3000
--

commit 71974153fe22bc00d365059be9198364c9cfaa86
Author: Binbin Zhou <zhoubinbin@loongson.cn>

dt-bindings: serial: 8250: Add dedicated Loongson-2K3000 UART compatible

This commit documents the loongson,ls2k3000-uart compatible string with
ns16550a as a fallback so the driver can distinguish the Loongson-2K3000 UA=
RT
from earlier Loongson UARTs that require MCR/MSR signal inversion.

> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index 01abd39509a7a..33c13c48ed56e 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -196,6 +196,9 @@ properties:
>                - loongson,ls2k2000-uart
>            - const: loongson,ls2k1500-uart
>            - const: ns16550a
> +      - items:
> +          - const: loongson,ls2k3000-uart
> +          - const: ns16550a

[Severity: Low]
This isn't a bug, but properties:compatible in
Documentation/devicetree/bindings/serial/8250.yaml already has a two-item
block with const: ns16550a as the fallback that includes the other base
Loongson UART compatibles:

      - items:
          - enum:
              ...
              - loongson,ls2k0500-uart
              - loongson,ls2k1500-uart
          - const: ns16550a

Could loongson,ls2k3000-uart be added to that existing enum instead of addi=
ng
a separate two-item block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793776192.gi=
t.zhoubinbin@loongson.cn?part=3D2

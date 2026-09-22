Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841454570F4;
	Tue, 22 Sep 2026 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071628; cv=none; b=pmkI+GT/Ywde7b7PeRzKM/rsBP4ixPEnRzeEtdIYTECygEP1ayiwxrTElyS265Kt3nCqs4M+NkmpX0Ma5giNu3+JgDqbDPg7h0vSgAIOxFpe55qD30uxHqEgGZ4JNcgiKWCwqo/WOZ8lW1oRMOaTNbFlshArVbhwt0eA6mpgBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071628; c=relaxed/simple;
	bh=BgDc/hpIhmBIjk2dxo+Is4ZBS8S4vEe4wpTFHHOXaNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ME4coNGLmhyg3m4OM3bWG1+7aMmVjUnjOdvFeCic0bz+5X1uX9DLyYmRdsZcC1jVe/seMiYmHzrq4m5lTeIFRmgh+TolTg+kHS+6fd+hunUaIFfQHd6RzxLS8esF/ng/6aiTDW4lLSVJHhjJWp0M5WDGekF7apxKoa493SHwW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjQTdC1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjQTdC1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32E41F000FF;
	Tue, 22 Sep 2026 10:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071627;
	bh=ZIYyH2tRYrN62CeRKt0owSK0zy9QVkh6fhoqcPiBxGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SjQTdC1CbK/ikG+BMjc1VVrx5N0hswdBjxiwMti2+lKmz6x0LOZw/+2zk1FgtTF9N
	 QIqrib1YNCD7gPX+XZJgoqrH7L3CBahn0bgMoX4Tm+QP5zIyc2DkBV2QDnL4mRcWlp
	 zAMZhwOgUQSblNuWCJJnBs6iQ7oJ47w+GxneuHW+z1W6sjUaPJEWknbMdiby+/mjsI
	 8tiUrrxXWfDT7vFa2qB+5sjflDIiy+A17kQP4pEXA9x0tU3wRkoAESRxPu55nZU4KV
	 QwGtmpnQhZY6XP51VVLzJ78DU+JU0n3DNZd1oLjLISzsDgfmj5gc+a8F++a9j1fcN/
	 KknbqszWiLvOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: renesas,scif: Increase number
 of DMA channels to 6
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <4dc02f4ff8a63c2bd41b15359828ce9befd2da2f.1790071199.git.geert+renesas@glider.be>
References: <4dc02f4ff8a63c2bd41b15359828ce9befd2da2f.1790071199.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:07:06 +0000
Message-Id: <20260922100706.D32E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: serial: missing conditional maxItems restriction for d=
mas
--

commit 24eddc5a7c6d95e9e9c7337b59a2dae1a4924772
Author: Geert Uytterhoeven <geert+renesas@glider.be>

dt-bindings: serial: renesas,scif: Increase number of DMA channels to 6

On R-Car X5H, SCIF serial interfaces are wired to three DMACs, hence
referring to up to six DMA channels.

> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b=
/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> index 82f54446835e6..b465c93c8357f 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -145,14 +145,14 @@ properties:
> =20
>    dmas:
>      minItems: 2
> -    maxItems: 4
> +    maxItems: 6

[Severity: Low]
Does this global relaxation of maxItems in properties.dmas cause incomplete
validation for older hardware?

By increasing the top-level maxItems limit to 6 globally without a conditio=
nal
restriction, device trees for older generations of SoCs (Gen1 through Gen4)
that incorrectly specify 5 or 6 DMA channels will now silently pass schema
validation. Previously they would be caught as errors.

This triggers when a developer defines an invalid device tree node for an o=
lder
SoC with more than 4 DMA channels and runs make dt_binding_check.

>      description:
>        Must contain a list of pairs of references to DMA specifiers, one =
for
>        transmission, and one for reception.
> =20
>    dma-names:
>      minItems: 2
> -    maxItems: 4
> +    maxItems: 6

[Severity: Low]
Similarly, does increasing the top-level maxItems limit in properties.dma-n=
ames
globally allow invalid device trees for older SoCs to bypass validation?

Without an if-then conditional block restricting older hardware, specifying=
 5
or 6 DMA channel names will silently pass schema checks for SoC generations
that only support up to 4.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4dc02f4ff8a63c2bd41=
b15359828ce9befd2da2f.1790071199.git.geert+renesas@glider.be?part=3D1

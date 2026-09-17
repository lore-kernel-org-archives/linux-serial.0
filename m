Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B3525A9C;
	Thu, 17 Sep 2026 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654464; cv=none; b=eMNn1G+Im21E1OSXnw+Iayk3TEqs4ocKvRSoNAlX/ie+frcTtjWw74n1UaX4NQz3R8yApvExF2mA3/BMLelkcjyBytJfJKn46Yjda3//kKLqKIqD7IxOzefq369lerNA5i+LIj9iPYnHzcMhdhaIclptZDg243gLGWbKdlfeih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654464; c=relaxed/simple;
	bh=ualloNXpBkU9Y2ruJR0cC5jQAFpoDDe+FOsyWW+G/1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aI14s/+8zcBPuL1E1vQ0eH/hWgujYmdkgxLXolivD/0c7n2IRUhCX86OnxQAKpvqqWPmWkV1nUIrtwV4altwPWUXLnVByoXyLTIx7rrvCx+CZQfNaozaBtBjYpdxTwX4n7bM5AcNYe53Q0g8ChX2f8I7ehm/osJJI9Xczekhz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7CgFAxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7CgFAxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34001F000FF;
	Thu, 17 Sep 2026 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654463;
	bh=RT/K/a7xRVIApAqjBWqUg4uP8xWehNdxGj2yv3lLUhE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7CgFAxtkYGG8Y77nIAwIqq5M03G/TfFVzUHbLaxfmG44JiWQ5F/4ShBcbRsy/DXg
	 jSxULVk5Zex/aPDPVOJ1KytjdVK/7he9hYuYRaD+virKTAZgk9o9K3Ctw5Ov7axuCU
	 wU3+iPGMiDlpXmYCHXhRH2F7IrQou1ePqDI370v+4upUxjn/nflY4+RL4yAL293vRV
	 M3TwqoG8XIPFS+hmmURBQkRT68Qzywj+6EaD9ppv9l9f4DDMIgLZv07sYUPpYsDeQU
	 zUwUcBriFi+D6DdH0J6aItHiA58ua2WslQO1pDJKkrv0FSZ2Nd/nFhS0ECdtr7GDzk
	 5ynRk9lChOS3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: serial: renesas,hscif: Increase number of
 DMA channels to 6
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: wsa+renesas@sang-engineering.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <a08834717c1df2c8974cb0b8300a20cc33c426fa.1789653869.git.geert@linux-m68k.org>
References: <a08834717c1df2c8974cb0b8300a20cc33c426fa.1789653869.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:14:22 +0000
Message-Id: <20260917141422.D34001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: serial: renesas,hscif: global DMA maxItems relaxati=
on permits invalid configurations
--

commit 5201605fb4ecc80faa0e010c992a164bfb0972af
Author: Geert Uytterhoeven <geert@linux-m68k.org>

dt-bindings: serial: renesas,hscif: Increase number of DMA channels to 6

This commit increases the maximum number of DMA channels for HSCIF serial
interfaces from 4 to 6. This change is intended to support the R-Car X5H
hardware, which has interfaces wired to three DMACs.

> diff --git a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml =
b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
> index 4b3f98a46cd9d..409cab32de3d8 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
> @@ -97,14 +97,14 @@ properties:
> =20
>    dmas:
>      minItems: 2
> -    maxItems: 4
> +    maxItems: 6

[Severity: Medium]
Does this global change to maxItems permit invalid configurations for older
hardware generations?

By globally increasing the maximum allowed items from 4 to 6 to support Gen5
hardware, the schema will now incorrectly pass validation for Gen1-Gen4 nod=
es
that specify 5 or 6 DMA channels, despite those SoCs only supporting up to =
4.

Should an if:then conditional block be used instead to enforce maxItems: 4
for earlier generations, or to allow 6 only for Gen5 hardware?

>      description:
>        Must contain a list of pairs of references to DMA specifiers, one =
for
>        transmission, and one for reception.
> =20
>    dma-names:
>      minItems: 2
> -    maxItems: 4
> +    maxItems: 6

[Severity: Medium]
Does this also weaken the schema validation for dma-names on older hardware
generations in the same way?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a08834717c1df2c8974=
cb0b8300a20cc33c426fa.1789653869.git.geert@linux-m68k.org?part=3D1

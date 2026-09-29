Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEACF350A0F;
	Tue, 29 Sep 2026 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664361; cv=none; b=DObDrlLudOdfidSznJAZEEhOuSZfI6QPKEasb2x9TWev5Wz95P2G2qTWpd0nXSF44WT4fNeAAJMOwq5AQnTVJR3rPnYKpKlfFrS7DHKjK/xmu+BbO9RlrgTrk+Sws1ZShgS0Z4BYiM+xrEyxgWNOlLNymbq03so0nY307JdP0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664361; c=relaxed/simple;
	bh=iMht4WMoNW/Ti5tGy9g6W0/b+So1/sGtPAb6F+ikNbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QY+3KEBT42+Tad3G7RjbH754E9F/cEHkCm+r3SoCwvo9g7A7md7okCf1+8/aXSf/FzhNJxXTVUCPUzW8jQxc+Yx5RxKQZS3PPORUHBm1auB2A8vjWBZcRpEwJtBaEu27G32TEdNE5AVlEWsBAGZyjRzNvNZtrTCPDplQsfZDdIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCmz6rm2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCmz6rm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B3B1F000FF;
	Tue, 29 Sep 2026 06:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664359;
	bh=IZHhgJLjo25dJ1nkN562Lxo3SiA7EGsmeTRlINNKXyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iCmz6rm2zcty76eQxqx5T5eVNZ+fta7FCDlZh6KMb7/W7sbUZhIrTGwwQ8tolfUOU
	 FEX3XgF6X3X/s4par6iuSsj2UJ68JsrPNRJIi4soXxh25y9cqJC5bkB30pOuAs3t+e
	 hKCOhREGphrI1djSf8VNPZUTjO/7GliZYdsPzzRPNK7Q07xKY5wYpadhjhIDh8blYf
	 7LVdLpRwpt3CJu4gxCLUgS37nkf3vnFzZPodxSXaZ1PBfxHczV6YQcduVtgoV58t4p
	 eR1GO3imlg9qxQzx9Q/sXyfiM0VEdFEWu6fFeVugHslMT82wU9nd8plxW+u2hby2EV
	 CgFNIzabdoGVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/20] dt-bindings: mfd: Add Synaptics SL261x global
 block binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: mfd@lists.linux.dev, linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, lee@kernel.org, linux-clk@vger.kernel.org, Frank.Li@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260929061417.20733-18-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-18-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:45:58 +0000
Message-Id: <20260929064559.30B3B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: mfd: hardcoded child node names reject standard generi=
c names
--

commit 0676aaa06a44b6b171bf0c3b295a14f6820c22d4
Author: Jisheng Zhang <jszhang@kernel.org>

dt-bindings: mfd: Add Synaptics SL261x global block binding

This commit introduces the device tree binding for Synaptics SL261x global
and control register blocks. It defines constraints for the AVIO global,
CPU wrapper, chip control, and MCU global blocks, exposing clocks, pinctrl,
and reset functions.

> diff --git a/Documentation/devicetree/bindings/mfd/syna,sl261x-gbl.yaml b=
/Documentation/devicetree/bindings/mfd/syna,sl261x-gbl.yaml
> new file mode 100644
> index 0000000000000..3e5842169c4a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/syna,sl261x-gbl.yaml
[ ... ]
> +properties:
[ ... ]
> +  reg:
> +    maxItems: 1
> +
> +  clock:
> +    type: object
> +    additionalProperties: true
> +
> +  pin-controller:
> +    type: object
> +    additionalProperties: true
> +
> +  reset:
> +    type: object
> +    additionalProperties: true

[Severity: Low]
Does enforcing these exact node names prevent devicetree authors from using
standard generic node names like clock-controller or reset-controller?

[ ... ]
> +        reset:
> +          properties:
> +            compatible:
> +              const: syna,sl261x-system-reset
> +
> +additionalProperties: false

[Severity: Low]
Could this strict validation reject devicetrees using standard generic name=
s,
since only clock, pin-controller, and reset are explicitly allowed in the
properties block?

Using patternProperties (e.g., "^clock-controller(@.*)?$": type: object)
would allow standard devicetree naming conventions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D17

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1D470E84;
	Tue,  1 Sep 2026 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257812; cv=none; b=oXw3lqF0w74In+oPfsQHzynm4NrQE4iDBo8w+K0HQG8pVK0e65lfnrtvx1iMU4gMKViVLZ8Jq+srCbJivgOjSp0Cl9cUltevPvY1DnKUOkFtVdI2XMPlPwQ3+vtNAH+jG0LFO6nDpWS07NEzHH6MIjVuaLq0oUS1BsaZSDCjgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257812; c=relaxed/simple;
	bh=DnD/iNMB/KP1774zZg5MWKZxw8E8HMSirGcNJqM4UGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXUZB66XzErDoviiig5aiBrXEcm6Wl3O7ry4Kq//4WaRrr6V5sbxidWR+FT5du1qCwPTma7x7AWyXAX0C/i0FrmOFntvtfRxXCO7wJCKFjchzOXG5PlJfQ3qCTY2ONMk/oH3sU8DPz0sjrSyetxsCxH4WQZlFUgKdg0Njfq+hQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ipt6SyiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipt6SyiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC7A1F000E9;
	Tue,  1 Sep 2026 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788257811;
	bh=ol6tR+j5Tl3m3HrcN4R4z8nuGHCVHXbd8qPHGmyFR8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ipt6SyiGher5ElQx1ABVBcBGC9zYG7RJrm/6lqDwCs8Z9jQ9kD7vb/0N6JO7v29s8
	 HXIUtG8wJ0oZymb802yruHE+AVXFOb7LHCVu++dOXcNoAMZZa0Cyvgi+RwfOHNtwzX
	 xh4IGOxuhBX47kz3gceVTjwsRuYSoXNPqfDpPeEFZ6XsSOxsJVWtaEeACZbA00g4VO
	 DckCwhFgJ1B17phH1PHvRGdFaXuEuYI1rBCg/RwhZV2SKRcEKh7pgmPvk6hfZCtunn
	 b028HjxPU0pvjkkdH9Ra+d6ZmqzyOIOCyTHRnLgGSa/l8TbD0e1oDiPxl4A8gWPgJA
	 fOhoNhBxrbivA==
Date: Tue, 1 Sep 2026 12:16:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, in file <devicetree@vger.kernel.org>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: 8250: add marvell,armada-38x-uart
 compatible
Message-ID: <20260901-sweet-hawk-of-research-d22ba3@quoll>
References: <20260901004203.49686-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901004203.49686-1-rosenp@gmail.com>

On Mon, Aug 31, 2026 at 05:42:03PM -0700, Rosen Penev wrote:
> The Armada 38x and 98DX3236 SoCs use this compatible, either paired
> with "ns16550a" (armada-38x.dtsi) or on its own
> (armada-xp-98dx3236.dtsi). Neither form is covered by the 8250
> binding, so dtbs_check reports:
> 
>   serial@12000: failed to match any schema with compatible:
>   ['marvell,armada-38x-uart', 'ns16550a']
> 
> Add a standalone const entry and a two-string variant paired with
> "ns16550a".
> 
> Validated with make dt_binding_check (8250.yaml) and dt-validate on
> armada-38x and armada-xp 98DX3236 boards: the UART schema errors are
> gone.

Drop last paragraph. If AI tool added it, then NEVER DO THAT. We don't
need to read LLM hallucinations.

Commit msgs do not have obvious build process outputs as confirmation
that you did absolutely basic build process step.

The same you do not say:
1. Code compiles
2. Code passes checkpatch
3. Code passes sparse, smatch etc.

> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index 8c2c177faf89..f71c6afe02f2 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -109,6 +109,7 @@ properties:
>        - const: aspeed,ast2500-vuart
>        - const: intel,xscale-uart
>        - const: mrvl,pxa-uart
> +      - const: marvell,armada-38x-uart

ma < mr, keep list ordered.

>        - const: nuvoton,wpcm450-uart
>        - const: nuvoton,npcm750-uart
>        - const: nvidia,tegra20-uart
> @@ -119,6 +120,9 @@ properties:
>                - exar,xr16l2551
>                - exar,xr16l2550
>            - const: ns8250
> +      - items:
> +          - const: marvell,armada-38x-uart

And what if the DTS is just wrong? So warning about wrong DTS is now
suppressed and made documented ABI change?

Best regards,
Krzysztof


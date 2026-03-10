Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1F43CECD;
	Tue, 10 Mar 2026 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135302; cv=none; b=OiX6CuQu26GAK328pSKBafAPiwgX1X2ES1nCXj7E8TxFQIQ9tcPMKPpvaOTB5iaGhrOlckrDVVSXav+2V7tUo7K/usE8p0lM5OcxsbDLqZOzE0KckabcZ3N7GAXt1kpS4yA+0+NLHNAlyPH1oQF4zqf5j88bwmWNvNwZshzX5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135302; c=relaxed/simple;
	bh=zMpeqIx7sBBI1S2RMUSCnMkIt07seU1gQt3Ztw7zkVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qs2r1mUMdc33I7+zYXC5jt8sHAfIzim85ay19dfbQgRMYhrqkDZ+pbvVcn9rSjixZg/+IBfDv4F98zoi0HSYpINYrhnXFhUv13+SCh5wLtN7+vdspRBR/BeZpKVsioBsrimtrxis1vj7dNmlTTduoC/abIeyU4hT8VxkqKcXgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 429FD341EE5;
	Tue, 10 Mar 2026 09:34:56 +0000 (UTC)
Date: Tue, 10 Mar 2026 17:34:46 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, Guodong Xu <guodong@riscstar.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: serial: 8250: spacemit: fix clock property
 for K3 SoC
Message-ID: <20260310093446-GYC318052@gentoo.org>
References: <20260304-01-uart-clock-names-v1-1-338483f04a8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-01-uart-clock-names-v1-1-338483f04a8b@kernel.org>

Hi Greg, Jiri,

  Do you mind if I taking this patch via SpacemiT's SoC tree? and if
possible, it would be nice to have your Acks..
(or either way works for me, if you grab it and merged via tty tree)

On 07:19 Wed 04 Mar     , Yixun Lan wrote:
> The UART of SpacemiT K3 SoC has same clock property as K1 generation which
> request two clock sources, fix the binding otherwise will get DT check
> warnings.
> 
> Fixes: b5024e804ee0 ("dt-bindings: serial: 8250: add SpacemiT K3 UART compatible")
I would just drop the Fixes tag, as I think at the time of Gudong
submitting the patch, the clock driver isn't ready, so he deliberatly
removed this clock contraint and provided with a fixed clock frequency
(the bindings match with DTS)

https://github.com/torvalds/linux/blob/v7.0-rc3/arch/riscv/boot/dts/spacemit/k3.dtsi#L414

> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index 73851f19330d..e9e07c2356bc 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -63,7 +63,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: spacemit,k1-uart
> +            enum:
> +              - spacemit,k1-uart
> +              - spacemit,k3-uart
>      then:
>        properties:
>          clock-names:
> @@ -76,6 +78,7 @@ allOf:
>            contains:
>              enum:
>                - spacemit,k1-uart
> +              - spacemit,k3-uart
>                - nxp,lpc1850-uart
>      then:
>        required:
> 
> ---
> base-commit: ec1fb4e55df47ed043ab2ccc6787e39b9d67e49b
> change-id: 20260304-01-uart-clock-names-551463132daa
> 
> Best regards,
> -- 
> Yixun Lan <dlan@kernel.org>
> 

-- 
Yixun Lan (dlan)

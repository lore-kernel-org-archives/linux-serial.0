Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120532139D4;
	Fri, 28 Jun 2024 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564662; cv=none; b=FI8kYUv/HLg0WFCJGxhKabIzCUlGQf13HGn0xucsJLOmQp4Egxhcy8hEbrgQwECPyAHBoDO/JvnmeAJyT081UrHlK3u/J5ODXAwlIPumS1viUxjIvK/2izdbkV2aR4tW3uiemOCZmVB6nEkJjlKlu8LgfHkZWLbwroSzgJ7Lyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564662; c=relaxed/simple;
	bh=sRiRwWssI1hNcvOqmyyk/vUQCAeh5SUxpNfB6bvBIkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1EaneClx7z+fM4MaxHL2s9tC5Z9shoq5ng8uJ1x2B0IX3CTEHz5WUFYWDNzVB5ckMQis7yE0kaHLWgS1lRKp86ko7ak/12v1TCRoUxM8AZIU388m6gPWJrnCb7p2Ym7owXfkv8sSZEFF7Y53zruSBXMgaHpZ+hiKiUMbsn5jAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Fri, 28 Jun 2024 08:50:55 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH v2 05/10] dt-bindings: interrupt-controller: Add SpacemiT
 K1 PLIC
Message-ID: <20240628085055.GB1752165@ofsar>
References: <20240627-k1-01-basic-dt-v2-0-3ffa8c189c66@gentoo.org>
 <20240627-k1-01-basic-dt-v2-5-3ffa8c189c66@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-k1-01-basic-dt-v2-5-3ffa8c189c66@gentoo.org>

Hi Conor:

On 15:11 Thu 27 Jun     , Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
> 
> Add compatible string for SpacemiT K1 PLIC.
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml  | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 709b2211276bd..3d0426b569042 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -59,6 +59,7 @@ properties:
>            - enum:
>                - canaan,k210-plic
>                - sifive,fu540-c000-plic
> +              - spacemit,k1-plic
>                - starfive,jh7100-plic
>                - starfive,jh7110-plic
>            - const: sifive,plic-1.0.0

..
> @@ -71,7 +72,9 @@ properties:
>                - thead,th1520-plic
>            - const: thead,c900-plic
>        - items:
> -          - const: sifive,plic-1.0.0
> +          - enum:
> +              - sifive,plic-1.0.0
> +              - spacemit,k1-plic
I think this is not needed, will fix it (also dts) in next version
(sorry, I missed your comment..)

>            - const: riscv,plic0
>          deprecated: true
>          description: For the QEMU virt machine only
> 
> -- 
> 2.45.2

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

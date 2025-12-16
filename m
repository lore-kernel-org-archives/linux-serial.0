Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F034D4CD;
	Tue, 16 Dec 2025 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897538; cv=none; b=p00AqGyBFnJ21ZBRpDG7BZdc2AjPh57WD0gNRjUl1k4/lIkszAadJB0+io55TIG2Ijlaz/mNbGJK0SzUwfYZevsF1ZQg1oRoKbmxjpQI3Qo3W3T96y9+4lHImCTppafybWUvc7IjZDEPEEARN/PysnpagExDn35OY1sPFb6R3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897538; c=relaxed/simple;
	bh=0HlmqGHaacXmfspPRtCJO7fwf8gtUeK5jq1XRazj+y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUtDHmNqaSE204f6d2Qz3OjHrzkaCdAUyeUK3s6ZTB/ittsefnL3glvV4sxRTeBDbZMdu5OgFEGskKCfHrLIiIp2TJXeFMqqSQsvNh8n2j7VW/C3UbaSX5/ZVz7dUhs89wGuGTsPeKqgrProu07yDaLZZDoIiN+OY63IrYqsfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2E93C3408CF;
	Tue, 16 Dec 2025 15:05:36 +0000 (UTC)
Date: Tue, 16 Dec 2025 23:05:30 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 6/8] dt-bindings: riscv: spacemit: add K3 and Pico-ITX
 board bindings
Message-ID: <20251216150530-GYD1903981@gentoo.org>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-6-a0d256c9dc92@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-k3-basic-dt-v1-6-a0d256c9dc92@riscstar.com>

Hi Guodong,

On 21:32 Tue 16 Dec     , Guodong Xu wrote:
> Add DT binding documentation for the SpacemiT K3 SoC and the board Pico-ITX
> which is a 2.5-inch single-board computer.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  Documentation/devicetree/bindings/riscv/spacemit.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> index 9c49482002f768cd0cc59be6db02659a43fa31ce..003b0bc1539b621e39172a0565dfea1274cbc8b8 100644
> --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> @@ -8,7 +8,8 @@ title: SpacemiT SoC-based boards
>  
>  maintainers:
>    - Yangyu Chen <cyy@cyyself.name>
> -  - Yixun Lan <dlan@gentoo.org>
> +  - Yixun Lan   <dlan@gentoo.org>
> +  - Guodong Xu  <guodong@riscstar.com>
please simply use "one blank space" here, it's more consistent,
trying to align them like this would result in even worse situation..
 
- only email addresses got aligned while not user names (first, second
  name?)
- adding another maintainer in future may break the alignment (if long
  name)

-- 
Yixun Lan (dlan)

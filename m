Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C4253340;
	Tue, 23 Dec 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497694; cv=none; b=e5ReMy8cHpG+GnI+Oq/VtgzYUciqlLT1zD7J7dCvtlWbJ0S7sI1VeFYVfgmzvAsYbZgfWI4o3oYylevG4/6/Z/e1iZ2+6YGGNxZl4+/JX4FQADQGxdbJZFC/uPES6wpEKASMlzJ3/EI5rs+Zwg2YvCcqqJYd40rHrvc3ERtakcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497694; c=relaxed/simple;
	bh=bx657OI5tibWzD3FtMAugH/0bfKDFap5W4/OxxvT4To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6hsMMI2RescwkE5q+UCYAHyPu8L87U4B8TokUOqGsFS3atcG+b/R4RasIVdupfqT/Gx69TZuW+gZon3czaQRP3hdhU1xkSIOUiJW+B6nU8NLkRy6vMjfMNxK2oKicyAB7PDWTDDKV2IBvD+n/hWTzdEnYCO0IY7gapoynXoWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es1swHfS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es1swHfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28794C113D0;
	Tue, 23 Dec 2025 13:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766497693;
	bh=bx657OI5tibWzD3FtMAugH/0bfKDFap5W4/OxxvT4To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Es1swHfSv6S6B2pHucKQZSoJ66PXsq6VNg9zC4wgOMhHg4ZrByc3vESkv7gopbzWI
	 D9464yDncxCMzlAVsmY6zWN0syhzVNp+5jrzbsJv60ORYXJ3BY0XfSiU5L8EDqYIIr
	 /VguxoOyUUlTkLnyzDX5qXCxvlkdvenU2Zn2MkHi/d29NWMOQJzcSz957qPCHLpYbE
	 iWQPXbtdFpHGfI6XVpYAcAQD3FJ1s+0Wr61gHyeDeJKLe3IoYe3L5l4LL3W+iaDaq2
	 w26G6AMjcUb6errmjMmyEEvGmIKGZFkHkyFuexrD8I3hXH/cLb3Ogk6eP0SeUaWLM1
	 azntYpSL9yRpw==
Date: Tue, 23 Dec 2025 14:48:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, linux-serial@vger.kernel.org, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 01/13] dt-bindings: riscv: add SpacemiT X100 CPU
 compatible
Message-ID: <20251223-just-indigo-coua-14b16e@quoll>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-1-3af3f3cd0f8a@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222-k3-basic-dt-v2-1-3af3f3cd0f8a@riscstar.com>

On Mon, Dec 22, 2025 at 09:04:11PM +0800, Guodong Xu wrote:
> Add compatible string for the SpacemiT X100 core. [1]
> 
> The X100 is a 64-bit RVA23-compliant RISC-V core from SpacemiT. X100
> supports the RISC-V vector and hypervisor extensions and all mandatory
> extersions as required by the RVA23U64 and RVA23S64 profiles, per the
> definition in 'RVA23 Profile, Version 1.0'. [2]
> 
> >From a microarchieture viewpoint, the X100 features a 4-issue
> out-of-order pipeline.
> 
> X100 is used in SpacemiT K3 SoC.
> 
> Link: https://www.spacemit.com/en/spacemit-x100-core/ [1]
> Link: https://docs.riscv.org/reference/profiles/rva23/_attachments/rva23-profile.pdf [2]
> Reviewed-by: Yixun Lan <dlan@gentoo.org>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v2: Fixed alphanumeric sorting of compatible strings, put x100 before x60,
>      as per Krzysztof's feedback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


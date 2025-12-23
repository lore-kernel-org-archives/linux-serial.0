Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B44233134;
	Tue, 23 Dec 2025 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497663; cv=none; b=GfglSrgAaffAnkcXBqwwfEheQKjGFqVbTzx/cR7OuPOZrnhYuNwcxif+6ZP8N/UUuXHTm6Z00vSajSCbFlJMuqleP1FTiKjUdNeewTERdQulziGhVeo296NGSEnjHzhYXmpbTWHJYVFfotqODjunN9l4/9VvnxRWbBHIFTorZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497663; c=relaxed/simple;
	bh=sfI6oSUVUszg+G4GEdk3ZFCt3nWG6J6yi2rcz+VwDqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnbJSLrnnsxLdLnBLyXsGQ0Do5Efo0LQV0wo00bpeYjOXBRHmp1GY8v/Htt2KgVA7NAPzNvmsMOc2Os2X6/BU28ArizNLXnf8s/sDqYZWgV+2YyH1YUnLX69Set5eyT3hMjPR6ckcysTuzVVoyOCZyh3uoWJIh3oCXyZPazrzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olU5v8t9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olU5v8t9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CBFC113D0;
	Tue, 23 Dec 2025 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766497663;
	bh=sfI6oSUVUszg+G4GEdk3ZFCt3nWG6J6yi2rcz+VwDqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=olU5v8t9qwqNRAYdoWlW7UthOf0g2d2x2lbOnnsWj8Iyzzh1yZr26pjKR5oGaXfMZ
	 zOOJHgsKHmavtCJn7jDOluVPrbnHjKirDPMzn7qqPef4MHoAZDAwXhTKu9SGkSME1C
	 1e6Ydp0+rBi9V6+6+/kEUgEHLbGr7H/0vGkmZMXSKMBbIKPoFTRHcrf/JqlbaEeAx5
	 X7rp+D2JC3t3bK1slt0HHL2ERwqe58eFIW0kXtr6Fn0Xb/SmtX9hHPr7u7YY91bdM2
	 8G/PpZxE0HEJ3syzQTjBhA8TLk2CVNTHnjfjc9HFpfnAAHWEhpwY60yZrEq11GWwzZ
	 y3D2L2yHDiAGA==
Date: Tue, 23 Dec 2025 14:47:40 +0100
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
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 04/13] dt-bindings: interrupt-controller: add SpacemiT
 K3 IMSIC
Message-ID: <20251223-careful-nebulous-griffin-9c6c08@quoll>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-4-3af3f3cd0f8a@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222-k3-basic-dt-v2-4-3af3f3cd0f8a@riscstar.com>

On Mon, Dec 22, 2025 at 09:04:14PM +0800, Guodong Xu wrote:
> Add compatible string for SpacemiT K3 IMSIC.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v2: Fix the order to keep things alphabetically.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


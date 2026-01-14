Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE133B947;
	Wed, 14 Jan 2026 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768433287; cv=none; b=Hh9L9qzJ+/3NN5kyOTnR1KlNlRrvbuMXCluD9fJWCNZEAwdM3m0AYAZ7O5ZafyYwMLwmGlNR8XV/f0eI+CFW+ycs29fGgqqGuFUAqbQ0gfxtvG/eo+bcu/bYHT9djXn0yWmF07od/XJF5A+YNYLMsWNtd4qRRvrFJ8dnT+eaWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768433287; c=relaxed/simple;
	bh=EI7BTv41G7olOZumH0mmXwnej0g2v1o+TsoL4iuuqBI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kwvuIlFDYHh4KHJRDI2bZHFNnPDF+2PnUprP/ob81hUxcJDDBfXrzOjiafNMZj4sburqI5/M8Y/yRn+3/CpvmjGpaxyu1SNikq7xgOXBNWsc3Awhx/lGt6nRqJ2lSlybAwTRwLhYPaoQx7/BRRe+IUM72+T2Ucm+t/1yRBk2kPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftSJZrR7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftSJZrR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D08C4CEF7;
	Wed, 14 Jan 2026 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768433284;
	bh=EI7BTv41G7olOZumH0mmXwnej0g2v1o+TsoL4iuuqBI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ftSJZrR70jl3YW9IC8y2ZJcUSo96xUVBE8KZCYUgZUhzfKJF9Dbjk3BhVTLJcH/dH
	 iqDlYbsyaYsHvnykBIf5QKOYV4s9Kzw5Crb+nUDI3tLWYkqfGsajOjTgsTmmJnp2Er
	 aX0LuILbS4R+4Onmel83tfFc7Mm5KYywvgXQc6ijueGYfV5/g8rQqRvBVyK+a9yJic
	 3etmK609O1U/qT5h2iwB9R4fPqR7wCKb3VlToJ+KkKIR4s0pqIUoyuwFyRsauDqS+/
	 DppzwFWTJ8eNnWgCV0NZYZwZVOhBg5PMdV/SNI1r0eeO2AA9/7dSiJwek8M6iVsX5o
	 RPtPmGtf5kJQQ==
Date: Wed, 14 Jan 2026 16:27:56 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    Samuel Holland <samuel.holland@sifive.com>, 
    Anup Patel <anup@brainfault.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
    Yangyu Chen <cyy@cyyself.name>, Paul Walmsley <paul.walmsley@sifive.com>, 
    Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
    Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
    Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    spacemit@lists.linux.dev, linux-serial@vger.kernel.org, 
    Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
    Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v4 01/11] dt-bindings: riscv: add SpacemiT X100 CPU
 compatible
In-Reply-To: <20260110-k3-basic-dt-v4-1-d492f3a30ffa@riscstar.com>
Message-ID: <006317ae-dec7-a893-372b-c68afe35863e@kernel.org>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com> <20260110-k3-basic-dt-v4-1-d492f3a30ffa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 10 Jan 2026, Guodong Xu wrote:

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
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Yixun Lan <dlan@gentoo.org>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

(just for completeness, since I acked the older version)

Acked-by: Paul Walmsley <pjw@kernel.org>


- Paul


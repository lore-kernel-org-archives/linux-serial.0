Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB50264A9D;
	Wed, 14 Jan 2026 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432655; cv=none; b=MqqjWsNAVmUxRNpAr1QFL7xykLgipfHJh/qLS76qmGcNqJviAXyL3lwgK+5XsdF9ckWZJh4NVtrvyzUBJNivEDZ1g0250d28MqB3EZ3l3TS6qb34J83POulRa2cAIRGj981IgPD2IUGZoJzTx1dJ5MIAIki5uKoQOTLBgt3G5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432655; c=relaxed/simple;
	bh=yiZaT2+yUxyzhmN9BLG28Zi7rtf5bP+HzkcRffYh+5w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W10kWN2DwA+qneC0hM4MwNFQujwsq6R6esz3KsCprEHSuIZxElA/wWQYNeqRG4y8Wkc6nSjTWp1WFoV83yL7w4WAO4xilZFdFn94TFtVJuIkdpie4ZskgRmRntS/M9nB22JuQ/JyScUt7KEOhROvbrSorW9Gkcvb/TpNm0M09fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/e0wuaV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/e0wuaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9B3C4CEF7;
	Wed, 14 Jan 2026 23:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768432655;
	bh=yiZaT2+yUxyzhmN9BLG28Zi7rtf5bP+HzkcRffYh+5w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=s/e0wuaVujPJ1SdsmwMkhm3Ij1DfE1MgW3bPGlVytD562/c2dbAEJhmCsodwRlcVC
	 AoWp/x/ep8hA2D3AUmd99Nzz/nMxJ2c3YsqiEWLGzmw8pHnTxvlb7YADZ49Q3n1h6u
	 FumOYq6cMf6O/kS3fDkB1PWUsqrUCFJTVAqGBve1QyueuC+UtTUMDtvAbsN8y911BK
	 m1+gta1U34OtyMzjo3wbDvhqarDbs37HFqXzVeVKGibJYZJh+bYL1dgaKhj1C4CW2E
	 gbEbXSbXVMLN7fs3xQ/ByFOc5p06RAEe3mfTUVpWRehrll28lZIeo8eaOtVrB8xr4a
	 MA6EoF2XZ5kcg==
Date: Wed, 14 Jan 2026 16:17:32 -0700 (MST)
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
Subject: Re: [PATCH v3 01/11] dt-bindings: riscv: add SpacemiT X100 CPU
 compatible
In-Reply-To: <20260108-k3-basic-dt-v3-1-ed99eb4c3ad3@riscstar.com>
Message-ID: <d15c3e1a-509b-0e99-c408-976fa4cf8e32@kernel.org>
References: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com> <20260108-k3-basic-dt-v3-1-ed99eb4c3ad3@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 8 Jan 2026, Guodong Xu wrote:

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

I think Yixun Lan is going to pick this up, so 

Acked-by: Paul Walmsley <pjw@kernel.org>


- Paul

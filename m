Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C792DA749
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883925; cv=none; b=dgShRcXnUFqpf0XgIQECmIGP4xbSbfxXN8uSCsAshgPX4UeBkkBC0KHJkxKHP1fuFrY0LtizpUSLi8Z7LDPwBhhBJ8G6mTUJEWqRlPibQBMBzHwvmb/GZ8daPluenURW8NQJeyPBRdf4ggXM+GBXyU6HImjKbMylvb6rF0bBgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883925; c=relaxed/simple;
	bh=do2UA+kUJ1TbXgXRbSmd0EaMt9CkyGUghFC1xnXimn8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ElXMeLMJslymLQz3i2wLB/GohfMCrewefFOwFVe/MfSpdoa3kfp9X/VlDt+iOMWdnETgrYxh5w8iriLfoe+mbpo/WFwYqYf1EWseQ+d74DkgG41W0D6KTkUPQR3eYslndxa4zV0xZ7ilx/QKY0y04xndHfo3olhVY/Cpsj13IJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIGbpUZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIGbpUZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575CA1F00A3A;
	Tue,  8 Sep 2026 16:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883923;
	bh=3bbGkobDpQdGYniX9EG7+4iZ/BE90dQ8CT8XcVZKJEY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=WIGbpUZrib61q8vONJ5FxSNakSuqaKCAsWJ+5gdMnCnFUkEPBkJwty8nxVVkN0Mv1
	 w9t0XZ7baGlhJo6FAfmbzQHeT6V1vAUfLWN4apw16QVaQoaDbWzrsztdNDktT/3N0X
	 iigUWVKzKZ4xSPjrUlzdr8zP6wW0E2DfPWCLVHHV/G8G3n7KOVbVsEwV0MVjf3kr7e
	 bwwkO3x7f2V+zWtZ0deWW2D5+s5mUpPxp+iIHyNV8byIQganVhI0jnbxR+VlciGb7C
	 dr69/ho0yadENGN25j4/oy5Stqto58/hMhZMDO7KOPS2seR908Ic/8L1QueLpqt231
	 UbD43Bz747fcQ==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id ACE13198003A;
	Tue,  8 Sep 2026 12:12:01 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 08 Sep 2026 12:12:01 -0400
X-ME-Sender: <xms:0DOgapxIuztF-xAq1Xu0-G1BF1NYaz6JIZlSC3D-dq3Fz6DWKbpWFg>
    <xme:0DOgakHmWMXsSA9O0-u_SlgufJhLfNf5hx5mRaEauyB0lcnspeq1oDMuGNavoa1ut
    50ZNN52M0vBDTGGdKeGtBDtZKuXvmfocVfBKTB9QPGRwSEIu2bRPRA>
X-ME-Proxy-Cause: dmFkZTFCMZbKka0PySpBSN0mOueOshb+uEL6ESVsVEH+1U1ATE4YvAKZeFRO257abuQ+ng
    4PZCmsJnRkV/CoaJ+mDv3YqAto2q5SqEOFwbw6IsHq7VZajVGrnhWI0oYBHvFuJO97HxDG
    pqfqxCPhTLzTprK3ntJZb0z9cfKzZw9S77ZLaTVZxLK7qnySfdKurKPqugdGDQMkjRCrqw
    AIrcDceS4WrKbdxeHBH9945l6oxC8GA3mo+q4fJylrSLhZGVKNcwvFuJMdyOUfqVFIRFQC
    NaLmAW7/Z+ubTtxnGKLueCuD7XLm/D3q6FipdVaMXj+xv+3IUzuF+mc2FDlpeEbdTinHad
    iTw2WIz06Xf0RdlLqA3VXTMZ43u3wfgRb9mF0Vqd0QgcFmBDd0d1wp6zCTX7oWlwgWq26y
    I+Og11aGh9ylDkTsSRZ7u/DLN7gYuRMYfqbK74bqmlce000gCwFqxe9BLdxFWsOL731qMT
    sjH8DirrK5v3MIywZvSKmTrtuysA/pVKnQKGR5NHHFRhn6pY6u/y0fIrdHzdOQfOOlUWEY
    7oEzUnt83MODHGRusAjEYJpctGSP6JuuIO0hg98JeaOn70wh9I4bN/io+rXokPnWu1dwXD
    xhymirxxSTjmLZvHZSk8Rp6mtd1KxfakPRkBMJqP06MsSwUt3rxVa9utsROA
X-ME-Proxy: <xmx:0TOgaoHVWd8BKffCEnm-xJwvT7eTaPZ3mte3HodUiQo0uSLW8oxbYg>
    <xmx:0TOgarXr5vRy8XaIdHcFcpHvMcxRaRlVZ1IOVs9Ws-lqna-6r2Bm5A>
    <xmx:0TOgaoyIMSeJ1juWayio0oZ0pDbHTGbiokBMtxKqKkQ3x90X-JNCZg>
    <xmx:0TOgaoTpjFqgNobdu2LnBZxU30xTI0rppen-HQRWsWcorfxeB4WWOg>
    <xmx:0TOgashVP2icbUUysxENXiCXVHDUiIBNO3Vldk61mtjQjpID9MMbC-Lx>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3E8B032A007B; Tue,  8 Sep 2026 12:12:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGTXWeH1PU47
Date: Tue, 08 Sep 2026 18:10:47 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, "Rob Herring" <robh@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, linux-serial@vger.kernel.org,
 "Frank Li" <Frank.Li@kernel.org>, imx@lists.linux.dev
Message-Id: <cfce9a0e-a7b7-409d-b9a4-abb9013469a9@app.fastmail.com>
In-Reply-To: <20260908155212.810C61F00A3A@smtp.kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-4-arnd@kernel.org>
 <20260908155212.810C61F00A3A@smtp.kernel.org>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 8, 2026, at 17:52, sashiko-bot@kernel.org wrote:
>
> The Acorn Risc PC platform and its associated drivers, configurations,
> and board files are being removed as the required gcc-8 compiler and
> -march=armv3 option are no longer supported.
>
>>     The main limitation here is the CPU bus that does not allow 16-bit
>>     wide data transfers and hence requires the kernel to be built with the
>>     -march=armv3 compiler option that was discontinued in gcc-9.
>
> [Severity: Low]
> Since this compiler option is the explicitly stated reason for removal in the
> commit message, should we also delete the compiler flag from the tree?
>
> arch/arm/Makefile:
>     arch-$(CONFIG_CPU_32v3)         :=-march=armv3m
>
> Additionally, the config symbol for this architecture version is now
> dead code because its only selector (ARCH_RPC) was removed:
>
> arch/arm/mm/Kconfig:config CPU_32v3
>     config CPU_32v3
>         bool

I decided to remove these two as part of the later StrongARM
removal patch that depends on this one.

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 81872f61b4317..fdd75b73bf293 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
> [ ... ]
>> -ARM MFM AND FLOPPY DRIVERS
>> -M:	Ian Molton <spyro@f2s.com>
>> -S:	Maintained
>> -F:	arch/arm/include/asm/floppy.h
>> -F:	arch/arm/mach-rpc/floppydma.S
>> -
>
> [Severity: Low]
> Does this leave the floppy header as dead code in the tree? It is removed
> from MAINTAINERS here, but the file itself was left in the tree:
>
> arch/arm/include/asm/floppy.h:
>     #ifndef __ASM_ARM_FLOPPY_H
>     #define __ASM_ARM_FLOPPY_H

This is removed along with ISA bus support later, which also
drops ARCH_MAY_HAVE_PC_FDC, ISA_DMA_API and GENERIC_ISA_DMA.

I could have split up the MAINTAINERS file change, but
it seemed better to do it in one place. Maybe the other
patch would have been better, but then I'd have another
dangling reference to mach-rpc here.

> The Makefile still references it:
>
> arch/arm/Makefile:
>     machine-$(CONFIG_ARCH_RPC)              += rpc

Fixed now, this ended up in the StrongARM patch by
accident.

> The machine type registry still contains it:
>
> arch/arm/tools/mach-types:
>     riscpc                  ARCH_RPC                RISCPC                  1

This is intentional.

> And the CPU selection still evaluates it:
>
> arch/arm/mm/Kconfig:config CPU_SA110
>     select CPU_32v3 if ARCH_RPC
>     select CPU_32v4 if !ARCH_RPC

Again, this is part of the StrongARM removal. I had considered
removing these two lines first, but then I'd have to split up
the CPU_32v3 removal out from that.

     Arnd

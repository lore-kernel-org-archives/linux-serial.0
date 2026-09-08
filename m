Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771154CF72;
	Tue,  8 Sep 2026 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882740; cv=none; b=PUENOhj64z+De2k+kBQNXgmnE3ztaF2ra+HwWpSvwKGPWZxHjXuvZAc7ZXafPll7L+5LinMa558eC+GtFWA4/5/VIt+BmbM4rGLfVia48IPX4T9xuhFDtjuea53QUD9h56Hnlxr++kq7Tzyb75zXz4X18QU7aS6Chur5ye1Vhko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882740; c=relaxed/simple;
	bh=d8w9NAT3V3A7zYcQXRinWDF+fm7HiJ40vU5rhlAvH6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OyccxrUW30zambBf0lV65Nbp1OwuiuFJQCuhUMTPeSZB9a9wnWM8KnyMw/bXtUxs5bYl8n0VfdTjUklcrUyUPPmCa09CMIjBW7He6riDCvWVeILZKRQVg+x+3OzKqC0XXLrAw7kFu4AykbQMulo+RKg7sGdtpr2+tcb9rEDJmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUy9AjLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUy9AjLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810C61F00A3A;
	Tue,  8 Sep 2026 15:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788882732;
	bh=duhkPdKZr6Q/w+H9JajtA5iWi+BD+H+jYq2zI/FxWn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eUy9AjLmPbJFndjapuT/L5mDK9FdeEbzL37FWvBagl2JPz4U5JzI9KDYahBzM8fyU
	 24wpeiPcz6TlmrbbO8X83ODEklS3CgWI7wwDaLOtBrLrv4dA4R5CT+wPFJc0+P/LJz
	 HetWqEKtviTbU8q4R/aPfgrWMN3+B6hIgYr/l97kDzhSEWcNOa4D4M76O3TkzVlP7b
	 6dO4U2QsjKiEitYOdErE7/VnG9HlXvKiwvtPhFePeFWGhP+gHkUs5zbk1Hyvuim1xB
	 ADeekBrJm3zRpqin6ENS+RCqUNANq7c7phAaNQFYeM09VuZ7EmzOysMOyBWl2FGFFO
	 BYR3djdMDOSLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] ARM: remove riscpc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260908152808.3928630-4-arnd@kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-4-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:52:12 +0000
Message-Id: <20260908155212.810C61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete removal of the ARCH_RPC platform and ARCH_ACORN config d=
ependency, leaving orphaned device drivers, Makefile/Kconfig references, an=
d dead code.
--

commit 90a4954ac0a5a6d8d3608046095747cf4673b8dd
Author: Arnd Bergmann <arnd@arndb.de>

ARM: remove riscpc

The Acorn Risc PC platform and its associated drivers, configurations,
and board files are being removed as the required gcc-8 compiler and
-march=3Darmv3 option are no longer supported.

>     The main limitation here is the CPU bus that does not allow 16-bit
>     wide data transfers and hence requires the kernel to be built with the
>     -march=3Darmv3 compiler option that was discontinued in gcc-9.

[Severity: Low]
Since this compiler option is the explicitly stated reason for removal in t=
he
commit message, should we also delete the compiler flag from the tree?

arch/arm/Makefile:
    arch-$(CONFIG_CPU_32v3)         :=3D-march=3Darmv3m

Additionally, the config symbol for this architecture version is now
dead code because its only selector (ARCH_RPC) was removed:

arch/arm/mm/Kconfig:config CPU_32v3
    config CPU_32v3
        bool

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81872f61b4317..fdd75b73bf293 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
[ ... ]
> -ARM MFM AND FLOPPY DRIVERS
> -M:	Ian Molton <spyro@f2s.com>
> -S:	Maintained
> -F:	arch/arm/include/asm/floppy.h
> -F:	arch/arm/mach-rpc/floppydma.S
> -

[Severity: Low]
Does this leave the floppy header as dead code in the tree? It is removed
from MAINTAINERS here, but the file itself was left in the tree:

arch/arm/include/asm/floppy.h:
    #ifndef __ASM_ARM_FLOPPY_H
    #define __ASM_ARM_FLOPPY_H

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c3d6b8abc815f..5770deca136d3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
[ ... ]
> @@ -429,8 +415,6 @@ source "arch/arm/mach-qcom/Kconfig"
> =20
>  source "arch/arm/mach-realtek/Kconfig"
> =20
> -source "arch/arm/mach-rpc/Kconfig"
> -
>  source "arch/arm/mach-rockchip/Kconfig"

[Severity: Low]
Are there dangling references to the removed CONFIG_ARCH_RPC?

The Makefile still references it:

arch/arm/Makefile:
    machine-$(CONFIG_ARCH_RPC)              +=3D rpc
   =20
The machine type registry still contains it:

arch/arm/tools/mach-types:
    riscpc                  ARCH_RPC                RISCPC                 =
 1
   =20
And the CPU selection still evaluates it:

arch/arm/mm/Kconfig:config CPU_SA110
    select CPU_32v3 if ARCH_RPC
    select CPU_32v4 if !ARCH_RPC

[ ... ]
> @@ -490,9 +474,6 @@ config ARCH_MPS2
>  	  This platform is scheduled for removal in early 2027
> =20
>  # Definitions to make life easier
> -config ARCH_ACORN
> -	bool
> -

[Severity: Low]
Does removing ARCH_ACORN leave orphaned device drivers in the tree?

All Acorn SCSI drivers depend on this removed config, leaving the entire
directory as dead code:

drivers/scsi/arm/Kconfig:config SCSI_ACORN
    depends on ARCH_ACORN && SCSI

While these removed configs make the dependent drivers unselectable and thus
don't break the build or introduce runtime issues, it leaves a significant
amount of dead code. I have verified that this dead code is not removed in
subsequent patches in the series.

> diff --git a/arch/arm/include/asm/ecard.h b/arch/arm/include/asm/ecard.h
> deleted file mode 100644
> index 7cbe001bf9ccc..0000000000000
> --- a/arch/arm/include/asm/ecard.h
> +++ /dev/null
> @@ -1,219 +0,0 @@
[ ... ]
> -#ifndef __ASM_ECARD_H
> -#define __ASM_ECARD_H

[Severity: Low]
Does this leave behind unselectable drivers that still include this deleted
header?

One of the remaining Risc PC drivers left in the tree still tries to include
it:

drivers/ata/pata_icside.c:
    #include <asm/ecard.h>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908152808.3928=
630-1-arnd@kernel.org?part=3D3

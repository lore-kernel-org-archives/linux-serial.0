From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
Date: Sat, 20 Jan 2018 15:33:51 +0100
Message-ID: <20180120143351.gmjpnqczaa2zov4o@gmail.com>
References: <20180118150951.28964-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180118150951.28964-1-prarit@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Timur Tabi <timur@codeaurora.org>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org


* Prarit Bhargava <prarit@redhat.com> wrote:

> Note on testing:  I've tested this on several ARM64 and x86 boxes (only
> earlycon, console=ttyS0,115200, and with both options), verified that
> functionality on ARM64 has not changed (ie, CONFIG_ACPI_SPCR_TABLE is
> always =y), and verified functionality when !CONFIG_ACPI_SPCR_TABLE on
> x86.
> 
> P.
> 
> ----8<----
> 
> SPCR is currently only enabled or ARM64 and x86 can use SPCR to setup an
> early console.
> 
> General fixes include updating Documentation & Kconfig (for x86), updating
> comments, and changing parse_spcr() to acpi_parse_spcr(), and
> earlycon_init_is_deferred to earlycon_acpi_spcr_enable to be more
> descriptive.
> 
> On x86, many systems have a valid SPCR table but the table version is not
> 2 so the table version check must be a warning.
> 
> On ARM64 when the kernel parameter earlycon is used both the early console
> and console are enabled.  On x86, only the earlycon should be enabled by
> by default.  Modify acpi_parse_spcr() to allow options for initializing
> the early console and console separately.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Rafael J. Wysocki" Mrjw@rjwysocki.net>
> Cc: Timur Tabi <timur@codeaurora.org>
> Cc: graeme.gregory@linaro.org
> Cc: mark.salter@redhat.com
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++---
>  arch/arm64/kernel/acpi.c                        |  4 ++--
>  arch/x86/kernel/acpi/boot.c                     |  3 +++
>  drivers/acpi/Kconfig                            |  7 +++++-
>  drivers/acpi/spcr.c                             | 29 +++++++++++++------------
>  drivers/tty/serial/earlycon.c                   | 15 +++++--------
>  include/linux/acpi.h                            |  7 ++++--
>  include/linux/serial_core.h                     |  4 ++--
>  8 files changed, 44 insertions(+), 34 deletions(-)

I'm fine with the x86 aspect of this:

Acked-by: Ingo Molnar <mingo@kernel.org>

>  	earlycon=	[KNL] Output early console device and options.
>  
> -			When used with no options, the early console is
> -			determined by the stdout-path property in device
> -			tree's chosen node.
> +			[ARM64] The early console is determined by the
> +			stdout-path property in device tree's chosen node,
> +			or determined by the ACPI SPCR table.

s/in device tree's chosen node
 /in the device tree's chosen node

Thanks,

	Ingo

From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/2] acpi, x86: Use SPCR table for earlycon on x86
Date: Tue, 12 Dec 2017 11:41:14 +0100
Message-ID: <20171212104114.nddfrykzhezmngnl@gmail.com>
References: <20171211155059.17062-1-prarit@redhat.com>
 <20171211155059.17062-3-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171211155059.17062-3-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Timur Tabi <timur@codeaurora.org>
List-Id: linux-serial@vger.kernel.org


* Prarit Bhargava <prarit@redhat.com> wrote:

> The ACPI SPCR code has been used to define an earlycon console for ARM64
> and can be used for x86.
> 
> Modify the ACPI SPCR parsing code to account for console behaviour
> differences between ARM64 and x86.  Initialize the SPCR code from
> x86 ACPI initialization code.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
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
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Timur Tabi <timur@codeaurora.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  arch/arm64/kernel/acpi.c                        | 2 +-
>  arch/x86/kernel/acpi/boot.c                     | 4 ++++
>  drivers/acpi/Kconfig                            | 2 +-
>  drivers/acpi/spcr.c                             | 7 +++++--
>  include/linux/acpi.h                            | 7 +++++--
>  6 files changed, 19 insertions(+), 6 deletions(-)

LGTM from an x86 perspective:

  Acked-by: Ingo Molnar <mingo@kernel.org>

(assuming it causes no regressions in linux-next.)

Since patch #1 affects ARM64 significantly, once that patch is acceptable to the 
arm64 folks feel free to upstream this second patch via the ARM64 tree as well.

Thanks,

	Ingo

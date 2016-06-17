From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v8 0/4] ACPI: parse the SPCR table
Date: Fri, 17 Jun 2016 18:24:57 -0500
Message-ID: <CAOZdJXVMZCFtppMOdruD9sY_EzkATv9XWBqi_NqZ-p2zEo8+2Q@mail.gmail.com>
References: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Zheng, Lv" <lv.zheng@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, linux-acpi@vger.kernel.org, Yury Norov <ynorov@caviumnetworks.com>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, May 20, 2016 at 8:03 AM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port Console
> Redirection Table) [2] as a mandatory ACPI table that specifies the
> configuration of serial console.
>
> Move "earlycon" early_param handling to earlycon.c to parse this option once
>
> Parse SPCR table, setup earlycon and register specified console.
>
> Enable parsing this table on ARM64.  Earlycon should be set up as early as
> possible.  ACPI boot tables are mapped in
> arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from setup_arch() and
> that's where we parse spcr.  So it has to be opted-in per-arch. When
> ACPI_SPCR_TABLE is defined initialization of DT earlycon is deferred until the
> DT/ACPI decision is done.
>
> Implement console_match() for pl011.
>
> Based on the work by Leif Lindholm [3]
> Thanks to Peter Hurley for explaining how this should work.
>
> Should be applied to next-20160520
> Tested on QEMU and ThunderX.
> SPCR support is included in QEMU's ARM64 mach-virt since 2.4 release.
>
> v8:
> - rebase to next-20160520
> - remove the patch "ACPICA: Headers: Add new constants for the DBG2 ACPI table"
>   as it have got to linux-next
> - add Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Reviewed-by:
>   Peter Hurley <peter@hurleysoftware.com> (but see below)
> - fix the patch "serial: pl011: add console matching function".  The patch by
>   Christopher Covington [4] specifies that SBSA uart does 32-bit access to
>   registers and this breaks the match function.  In this series the function
>   was changed to match when SPCR specifies both mmio32 and mmio access.
>   I removed Acked-by: Greg from this patch because of these changes.

All four patches:

Tested-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

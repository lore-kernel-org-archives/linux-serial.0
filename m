From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 0/5] ACPI: parse the SPCR table
Date: Thu, 24 Mar 2016 14:16:16 +0100
Message-ID: <CAJZ5v0gzjtFzig7nEumr83+J2dGb+OA8GNR2i45ZqznfV_hA-A@mail.gmail.com>
References: <1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 24, 2016 at 1:51 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port
> Console Redirection Table) [2] as a mandatory ACPI table that
> specifies the configuration of serial console.
>
> Move "earlycon" early_param handling to earlycon.c to parse this option once
>
> Patch "ACPI: add definitions of DBG2 subtypes" is required for the next patch.
> ACPI maintainers said that they had got it for the next release of ACPICA,
> but it has not appeared in linux-next yet.

It will.  Patches containing it have just been posted.

> Parse SPCR table, setup earlycon and add register specified console.
>
> Enable parsing this table on ARM64.  Earlycon should be set up
> as early as possible.  ACPI boot tables are mapped in
> arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from setup_arch()
> and that's where we parse spcr.  So it has to be opted-in per-arch.
>
> Implement console_match() for pl011.
>
> Based on the work by Leif Lindholm [3]
> Thanks to Peter Hurley for explaining how this should work.
>
> Should be applied to next-20160324.
>
> Tested on QEMU.  SPCR support is included in QEMU's ARM mach-virt
> since 2.4 release.

Honestly, I'm not sure why I'm regarded as the right maintainer to send this to.

The only patch here touching generic ACPI code is [3/5] (the [2/5] is
going in through ACPICA) and the rest is all about ARM64 AFAICS.  Why
don't you send it to the ARM64 maintainers instead?

I'll have some comments on [3/5], I'll send them later today or tomorrow.

Thanks,
Rafael

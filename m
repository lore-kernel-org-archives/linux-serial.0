From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v10 3/4] ARM64: ACPI: enable ACPI_SPCR_TABLE
Date: Fri, 9 Sep 2016 18:07:04 +0300
Message-ID: <ffcabf79-17b8-f386-32b5-a6052f27f992@linaro.org>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
 <20160905123617.18775-4-aleksey.makarov@linaro.org>
 <7e5486cc-4080-2d1e-8f6d-98874379887d@gmail.com>
 <20160909092958.GB20192@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160909092958.GB20192@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Aleksey Makarov <amakarov.linux@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, linux-acpi@vger.kernel.org, Yury Norov <ynorov@caviumnetworks.com>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org



On 09/09/2016 12:29 PM, Will Deacon wrote:
> On Wed, Sep 07, 2016 at 12:30:19PM +0300, Aleksey Makarov wrote:
>>
>> On 09/05/2016 03:36 PM, Aleksey Makarov wrote:
>>> SBBR mentions SPCR as a mandatory ACPI table.  So enable it for ARM64
>>>
>>> Earlycon should be set up as early as possible.  ACPI boot tables are
>>> mapped in arch/arm64/kernel/acpi.c:acpi_boot_table_init() that
>>> is called from setup_arch() and that's where we parse SPCR.
>>> So it has to be opted-in per-arch.
>>>
>>> When ACPI_SPCR_TABLE is defined initialization of DT earlycon is
>>> deferred until the DT/ACPI decision is done.  Initialize DT earlycon
>>> if ACPI is disabled.
>>
>> Hi Will, Catalin,
>>
>> Can you review this patch and consider ACKing it please?
> 
> Since the ACPI folks seem happy with the series, then:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> for this patch.

Thank you.  Can you pull the series?  Should I ask Rafael?

> 
> Will
> 

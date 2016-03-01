From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 6/7] ACPI: enable ACPI_DBG2_TABLE on ARM64
Date: Tue, 1 Mar 2016 09:25:34 -0800
Message-ID: <56D5D08E.3030902@hurleysoftware.com>
References: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
 <1456749726-30261-7-git-send-email-aleksey.makarov@linaro.org>
 <56D5ACBB.50408@hurleysoftware.com> <56D5CB42.3030806@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56D5CB42.3030806@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Matthias Brugger <mbrugger@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-serial@vger.kernel.org

On 03/01/2016 09:02 AM, Aleksey Makarov wrote:
> 
> 
> On 03/01/2016 05:52 PM, Peter Hurley wrote:
>> On 02/29/2016 04:42 AM, Aleksey Makarov wrote:
>>> SBBR mentions DBG2 as a mandatory ACPI table.
>>> So enable it for ARM64
>>
>> Why does this have to be opted-in per-arch?
> 
> DBG2 can specify earlycons.  They should start as soon as possible.
> On ARM64 it is just after boot tables become available (in arch_init()).
> So it has to be per-arch unless we decide not to start earlycons on 
> DBG2 ports.

OF does all that already but the earlycon opt-in is not per-arch.


>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>> ---
>>>  arch/arm64/Kconfig       | 1 +
>>>  arch/arm64/kernel/acpi.c | 2 ++
>>>  2 files changed, 3 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 9dc5209..0b614d4 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -3,6 +3,7 @@ config ARM64
>>>  	select ACPI_CCA_REQUIRED if ACPI
>>>  	select ACPI_GENERIC_GSI if ACPI
>>>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>>> +	select ACPI_DBG2_TABLE if ACPI
>>>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>>>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>>  	select ARCH_HAS_ELF_RANDOMIZE
>>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>>> index d1ce8e2..3370046 100644
>>> --- a/arch/arm64/kernel/acpi.c
>>> +++ b/arch/arm64/kernel/acpi.c
>>> @@ -208,6 +208,8 @@ void __init acpi_boot_table_init(void)
>>>  		pr_err("Failed to init ACPI tables\n");
>>>  		if (!param_acpi_force)
>>>  			disable_acpi();
>>> +	} else {
>>> +		acpi_probe_device_table(dbg2);
>>>  	}
>>>  }
>>>  
>>>
>>


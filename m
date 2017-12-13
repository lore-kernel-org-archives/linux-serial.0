From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 1/2] acpi, spcr: Make SPCR avialable to other
 architectures
Date: Wed, 13 Dec 2017 15:11:33 -0600
Message-ID: <d967861e-9f83-689c-2b14-58d7450c848b@codeaurora.org>
References: <20171211155059.17062-1-prarit@redhat.com>
 <20171211155059.17062-2-prarit@redhat.com> <20171213124533.GA32362@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171213124533.GA32362@red-moon>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org

On 12/13/2017 06:45 AM, Lorenzo Pieralisi wrote:
>> +/*
>> + * Erratum 44 for QDF2432v1 and QDF2400v1 SoCs describes the BUSY bit as
>> + * occasionally getting stuck as 1. To avoid the potential for a hang, check
>> + * TXFE == 0 instead of BUSY == 1. This may not be suitable for all UART
>> + * implementations, so only do so if an affected platform is detected in
>> + * acpi_parse_spcr().
>> + */
>> +bool qdf2400_e44_present;
>> +EXPORT_SYMBOL(qdf2400_e44_present);
> 
> My eyes, this is horrible but it is not introduced by this patch. It
> would have been much better if:
> 
> drivers/tty/serial/amba-pl011.c
> 
> parsed the SPCR table (again) to detect it instead of relying on this
> horrible exported flag.

I didn't want to put any ACPI code in amba-pl011.c, so putting it in 
spcr.c made the most sense.  I agree the global variable is ugly.  If 
you have a better idea, I'm all ears.

If it's any consolation, this erratum affects only 1.x silicon, which is 
technically pre-production (although a lot of people have them).  This 
work-around will eventually be reverted.

>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 46505396869e..9ae98eeada76 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -79,7 +79,12 @@ config ACPI_DEBUGGER_USER
>>   endif
>>   
>>   config ACPI_SPCR_TABLE
>> -	bool
>> +	bool "ACPI Serial Port Console Redirection Support"
>> +	default y if ARM64
> 
> You need to remove the selection in arch/arm64 then. Also, moving away
> from a non-visible config may have consequences on ARM64, Graeme and
> Mark are more familiar with the SPCR dependencies so please chime in.

I did raise this as a concern in the previous version of the patch.  I 
also think it should not be a selectable option.

Keeping the "select" does force SPCR to be enabled on ARM64 ACPI 
platforms, but if it's an option for x86, it should be an option for ARM.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

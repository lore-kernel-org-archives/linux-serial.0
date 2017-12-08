From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH 0/2] acpi, x86: Add SPCR table support
Date: Fri, 8 Dec 2017 08:31:53 -0700
Message-ID: <bd727a15-c697-741f-864b-8b48b8e5e272@codeaurora.org>
References: <20171207172912.17868-1-prarit@redhat.com>
 <20171208062925.64ov23u7oxmdfzyk@gmail.com>
 <f078ada7-1e30-41cc-28dc-077ed2a5986d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <f078ada7-1e30-41cc-28dc-077ed2a5986d@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, linux-serial@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 12/8/2017 7:29 AM, Prarit Bhargava wrote:
> 
> 
> On 12/08/2017 01:29 AM, Ingo Molnar wrote:
>>
>> * Prarit Bhargava <prarit@redhat.com> wrote:
>>
>>> The SPCR (Serial Port Console Redirection) Table provides information
>>> about the configuration of serial port.  This information can be used
>>> to configure the early console.
>>
>> s/about the configuration of serial port
>>   /about the configuration of the serial port
>>
>>> SPCR support was added for arm64 and is made available across all arches
>>> in this patchset.  The first patch adds a weak per-arch configuration function
>>> and moves the SPCR code into ACPI.  The second patch adds support to x86.
>>>
>>> The existing behaviour on arm64 is maintained.  If the SPCR exists the
>>> earlycon and console are automatically configured.
>>
>> s/arm64
>>   /ARM64
>>
>> which is easier to read and it's also the prevalent spelling:
>>
>>   triton:~/tip> for N in $(git grep -ih arm64 arch/arm64/ | sed 's/[[:punct:]]/ /g'); do echo $N | grep -iw arm64; done | sort | uniq -c
>>       412 arm64
>>         1 Arm64
>>       854 ARM64
>>
>>> The existing default behaviour on x86 is also maintained.  If no console or
>>> earlycon parameter is defined and the SPCR exists , the serial port is not
>>> configured.  If the earlycon parameter is used both the early console
>>> and the console are configured using the data from the SPCR.
>>
>> s/exists , the
>>   /exists, the
>>
>> But, the logic to not use the SPCR looks confusing to me.
>>
>> The SPCR is only present if the user has explicitly configured a serial console
>> for that machine, either in the firmware, or remotely via IPMI, correct? I.e. SPCR
>> will not be spuriously present by default on systems that have a serial console
>> but the user never expressed any interest for them, right?
> 
> If I disable "Serial Port Console Debug" in my BIOS I still see the SPCR configured:
> 
> [root@prarit-lab ~]# dmesg | grep SPCR
> [    0.000000] ACPI: SPCR 0x0000000069031000 000050 (v01
> 00000000      00000000)
> 
> AFAICT the SPCR is always enabled on some systems.

"Serial Port Console Debug" sounds like DBG2 to me, although I am unsure 
of the specific platform you are referencing.

> 
>>
>> If so then we should pick up that serial console configuration and activate it,
>> regardless of any kernel boot options!
> 
> I'm worried about someone who doesn't want a console on ttyS0 suddenly ending up
> with one.  The SPCR could contain incorrect data, etc.
> 
> I originally wanted this on by default, but the chances of breaking someone's
> setup seems significant doesn't it?  Maybe I'm being too cautious.  Anyone else
> want to weigh in?  I'm not ignoring your idea Ingo, I'm just worried about being
> yelled at by a user :) because I broke their default console setup.
> 

SPCR is always present on QDF2400 (ARM64 platform).  Firmware will 
automatically update the SPCR table to point to the correct console (IE 
Serial-over-LAN or SOL if configured via IPMI).  Unless a user 
specifically chooses to override the SPCR via "console=", we expect that 
a console will be present based on the data in SPCR.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

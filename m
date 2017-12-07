From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 1/2] acpi, spcr: Make SPCR avialable to other
 architectures
Date: Thu, 7 Dec 2017 13:35:02 -0600
Message-ID: <8a50d3c3-2a85-c0ea-a881-1dcd46a3ea41@codeaurora.org>
References: <20171207172912.17868-1-prarit@redhat.com>
 <20171207172912.17868-2-prarit@redhat.com>
 <CAOZdJXV4E6gu=Ed6nOCcEp2afe_g8Ot-H5oO5=6+ye51cv9hUg@mail.gmail.com>
 <f8ab5b48-cc72-3f46-0843-d2df5964eb21@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <f8ab5b48-cc72-3f46-0843-d2df5964eb21@redhat.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, the arch/x86 maintainers <x86@kernel.org>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, linux-serial@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jeffrey Hugo <jhugo@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 12/07/2017 01:05 PM, Prarit Bhargava wrote:
>> Please give us a chance to test this patch before merging. We've had a
>> lot of problems with our E44 work-around, and we need to make sure
>> that qdf2400_erratum_44_present function is called before the pl011
>> driver is probed.

> Timor, do you know of a specific system that has this problem?  If so, I
> could see if we have one @ Red Hat and test on it to verify the WAR.

Yes, Red Hat has our QDF2400 systems.  You need one with 1.x silicon. 
Contact anyone you know in the ARM server group.  Email me offline if 
you can't find anyone.

>>> + * APM X-Gene v1 and v2 UART hardware is an 16550 like device but has its
>>> + * register aligned to 32-bit. In addition, the BIOS also encoded the
>>> + * access width to be 8 bits. This function detects this errata condition.
>>> + */
>>> +static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
>>> +{
>>> +       bool xgene_8250 = false;
>>> +
>>> +       if (tb->interface_type != ACPI_DBG2_16550_COMPATIBLE)
>>> +               return false;
>>> +
>>> +       if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE) &&
>>> +           memcmp(tb->header.oem_id, "HPE   ", ACPI_OEM_ID_SIZE))
>>> +               return false;
>>> +
>>> +       if (!memcmp(tb->header.oem_table_id, "XGENESPC",
>>> +           ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 0)
>>> +               xgene_8250 = true;
>>> +
>>> +       if (!memcmp(tb->header.oem_table_id, "ProLiant",
>>> +           ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 1)
>>> +               xgene_8250 = true;
>>> +
>>> +       return xgene_8250;
>>> +}
>> I suspect that this function has the same issues as
>> qdf2400_erratum_44_present().
>>
> Ditto.

I don't know if Red Hat has any XGene systems.

> 
>>> +config ACPI_SPCR_TABLE
>>> +       bool "ACPI Serial Port Console Redirection Support"
>>> +       default y if ARM64
>>> +       help
>>> +         Enable support for Serial Port Console Redirection (SPCR) Table.
>>> +         This table provides information about the configuration of the
>>> +         earlycon console.
>>> +
>> So ACPI without SPCR has never been tested by us.  Making it optional
>> makes me a little nervous.  We'll have to evaluate this change.
>>
> It is 'y' for ARM64?  Maybe I have that wrong but I thought that would
> always build it for ARM64.

It was forced 't' for ARM64.  That is, if ACPI is enabled, SPCR is 
always enabled and always used.  With your patch, we would need to test 
our kernel with console=ttyAMA0,0xfeblabla,etc to make sure that it 
still works.

'default y' means that some can turn SPCR off, but keep ACPI still on.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

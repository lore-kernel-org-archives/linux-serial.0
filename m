From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 2/2] acpi, x86: Use SPCR table for earlycon on x86
Date: Thu, 7 Dec 2017 14:03:20 -0500
Message-ID: <c6ff196d-98e4-ab31-5d51-c342539afe96@redhat.com>
References: <20171207172912.17868-1-prarit@redhat.com>
 <20171207172912.17868-3-prarit@redhat.com>
 <CAOZdJXXdeY0+SRfSQC_X-L1UNemigO7DDgRk7jRdMKVe34NWvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAOZdJXXdeY0+SRfSQC_X-L1UNemigO7DDgRk7jRdMKVe34NWvQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, the arch/x86 maintainers <x86@kernel.org>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, linux-serial@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jeffrey Hugo <jhugo@codeaurora.org>
List-Id: linux-serial@vger.kernel.org



On 12/07/2017 01:46 PM, Timur Tabi wrote:
> On Thu, Dec 7, 2017 at 11:29 AM, Prarit Bhargava <prarit@redhat.com> wrote:
>> -int __init acpi_parse_spcr(bool earlycon)
>> +int __init acpi_parse_spcr(bool earlycon, bool enable_console)
>>  {
>>         static char opts[ACPI_SPCR_OPTS_SIZE];
>>         static char uart[ACPI_SPCR_BUF_SIZE];
>> @@ -113,7 +113,8 @@ int __init acpi_parse_spcr(bool earlycon)
>>         if (earlycon)
>>                 setup_earlycon(opts);
>>
>> -       err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
>> +       if (enable_console)
>> +               err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
> 
> So if earlycon==true but enable_console==false, then you parse SPCR
> and use it for the early console, but not the primary console?  I'm
> not sure what that gives you.
> 

On arm64 the original SPCR code provides both early and primary consoles (as
you've pointed out).  IOW, if SPRC exists on arm64 a console will be
initialized.  That is still the case after my change.

The expected behaviour on x86 is that unless someone specifies 'earlycon' or
'console=' that no console should be initialized.  There are users (some IOT
boxes, etc.) that do NOT want a console.

The above code keeps the existing x86 behaviour.

P.

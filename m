From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v5 3/6] ACPI: parse SPCR and enable matching console
Date: Tue, 22 Mar 2016 10:32:22 -0700
Message-ID: <56F181A6.3070502@hurleysoftware.com>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
 <1458643595-14719-4-git-send-email-aleksey.makarov@linaro.org>
 <20160322122650.GA10616@yury-N73SV> <56F15D40.9020401@hurleysoftware.com>
 <20160322165122.GB10616@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160322165122.GB10616@yury-N73SV>
Sender: linux-acpi-owner@vger.kernel.org
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On 03/22/2016 09:51 AM, Yury Norov wrote:
> On Tue, Mar 22, 2016 at 07:57:04AM -0700, Peter Hurley wrote:
> 
> [...]
> 
>>>> +static bool init_earlycon;
>>>> +
>>>> +void __init init_spcr_earlycon(void)
>>>> +{
>>>> +	init_earlycon = true;
>>>> +}
>>>> +
>>>
>>> 1. I see you keep in mind multiple access.
>>
>> Concurrent access is not a concern here: only the boot cpu is running
>> and intrs are off.
>>
>> The "init_earlycon" flag is used because parsing the "earlycon" early param
>> is earlier than parsing ACPI tables.
>>
> 
> OK got it. My concern is that it's generic code, and parse_spcr() is public
> function. I think corresponding comment is needed at least. The other option is
> to make it race-safe and forget. I prefer second one, moreover it's 2 simple
> changes.

Earlycon is generic only in the sense of platform independence, not in the
sense of temporal independence. There is no serialization in earlycon, anywhere.
Adding serialization will unnecessarily confuse casual observers into
believing it is necessary.

An argument could be made that earlycon needs some standalone documentation,
but I don't think this patch needs to be that.


>>  Then you'd worry about race
>>> conditions as well. In this case, I'd consider atomic access to
>>> variable.
>>> 2. It seems you need is_init() helper too.
>>>
>>>> +int __init parse_spcr(void)
>>>> +{
>>>> +	static char opts[64];
>>>> +	struct acpi_table_spcr *table;
>>>> +	acpi_size table_size;
>>>> +	acpi_status status;
>>>> +	char *uart;
>>>> +	char *iotype;
>>>> +	int baud_rate;
>>>> +	int err = 0;
>>>
>>> You can do not initialize 'err'.
>>
>> Why?
>>
> 
> Because there's no path here that doesn't init err with some value.
> So this initialization is useless waste of cycles.

Ok.

Regards,
Peter Hurley

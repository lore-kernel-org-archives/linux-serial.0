From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v5 3/6] ACPI: parse SPCR and enable matching console
Date: Tue, 22 Mar 2016 10:21:51 -0700
Message-ID: <56F17F2F.7050305@hurleysoftware.com>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
 <1458643595-14719-4-git-send-email-aleksey.makarov@linaro.org>
 <CAHp75VfsayWWSgkvpgrxcER6c2rZyykbvOtm7wBQROR6SFFfWw@mail.gmail.com>
 <56F16DC2.7030901@hurleysoftware.com> <56F17B0B.306@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56F17B0B.306@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On 03/22/2016 10:04 AM, Aleksey Makarov wrote:
> 
> 
> On 03/22/2016 07:07 PM, Peter Hurley wrote:
>> On 03/22/2016 04:09 AM, Andy Shevchenko wrote:
>>> On Tue, Mar 22, 2016 at 12:46 PM, Aleksey Makarov
>>> <aleksey.makarov@linaro.org> wrote:
> 
>>>> +       sprintf(opts, "%s,%s,0x%llx,%d", uart, iotype,
>>>> +               table->serial_port.address, baud_rate);
>>>
>>> You may use snprintf(), though my question here what would happen on
>>> 32-bit kernel when you supply 64-bit address as an option?
>>
>> Yeah this should probably use %pa for the printf specifier.
>>
>> But note this exposes underlying bug in the earlycon support, because
>> that was originally written without 32/64-mixed bitness in mind; ie.,
>> the address is parsed and handled as unsigned long in most places.
> 
> I don't quite follow this.  table->serial_port.address is explicitly u64,
> not pointer, so, according to printk-formats.txt %llx is ok here, %pa is wrong.
> Am I missing something?

No, you're right.
There is still the underlying bug I noted; I'll fix that in this release cycle.


>>>>         /*
>>>> -        * Just 'earlycon' is a valid param for devicetree earlycons;
>>>> -        * don't generate a warning from parse_early_params() in that case
>>>> +        * Just 'earlycon' is a valid param for devicetree and ACPI SPCR
>>>> +        * earlycons; don't generate a warning from parse_early_params()
>>>> +        * in that case
>>>>          */
>>>> -       if (!buf || !buf[0])
>>>> -               return early_init_dt_scan_chosen_serial();
>>>> +       if (!buf || !buf[0]) {
>>>> +               init_spcr_earlycon();
>>>
>>>> +               early_init_dt_scan_chosen_serial();
>>>> +               return 0;
>>>
>>> And you hide an error?
>>
>> Well, this is a little bit tricky because "earlycon" early parameter with
>> missing /chosen/stdout-path node is no longer an error, since ACPI may be
>> specifying the earlycon instead.
> 
> Agree, but note the email by Rob Herring.  The code should be like this:
> 
> if (!buf || !buf[0]) {
> 	if (acpi_disabled) {
> 		return early_init_dt_scan_chosen_serial();
> 	} else {
> 		init_spcr_earlycon();
> 		return 0;
> 	}
> }

Ok.


> But that requires to have made ACPI/DT decision at this point.

It's an unfortunate command-line option dependency, but I think it's ok
for the moment.  The same problem would exist if DT could be disabled
via the command line.


> 
> Thank you
> Aleksey
> 


From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v3 0/3]
Date: Fri, 19 Aug 2016 14:26:11 +0800
Message-ID: <f10ce2dd-dd7a-ff02-83c7-7d73461d0841@huawei.com>
References: <1468580485-28567-1-git-send-email-wangkefeng.wang@huawei.com>
 <1470758477.25395.12.camel@linux.intel.com>
 <471cc4e4-7e08-7cbf-022f-05d4fe3f378b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <471cc4e4-7e08-7cbf-022f-05d4fe3f378b@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, guohanjun@huawei.com, z.liuxinliang@hisilicon.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org
List-Id: linux-serial@vger.kernel.org



On 2016/8/10 13:36, Kefeng Wang wrote:
> 
> 
> On 2016/8/10 0:01, Andy Shevchenko wrote:
>> On Fri, 2016-07-15 at 19:01 +0800, Kefeng Wang wrote:
>>> Make dw8250_set_termios() as the default set_termios callback for 8250
>>> dw uart, correct me
>>> if I am wrong.
>>>
>>> Then add ACPI support for uart on Hisilicon Hip05 soc, be careful that
>>> it is not 16500
>>> compatible. Meanwhile, set dw8250_serial_out32 to keep consistent
>>> between serial_out
>>> and serial_in in ACPI.
>>
>> I will review it perhaps late this week.
> 

Hi Andy, kindly ping...


> Thanks.
> 
>> Though have a quick question, did you test it? I hope you have done.
> 
> Yes, I have already tested the patchset on D02 board.
> 
> Kefeng
> 
>>
>>>
>>> Change since v2:
>>> - Add a new patch to use new var dev in probe
>>> - Use built-in device properties to set device parameters for existing
>>> device probed by acpi,
>>>   suggested by Andy Shevchenko 
>>>
>>>
>>> Change since v1:
>>> - Use acpi_match_device() instead of acpi_dev_found(), limit the check
>>> to the device
>>>   being probed and not a global search for whole DSDT (pointed by grae
>>> me.gregory@linaro.org)
>>>
>>> Kefeng Wang (3):
>>>   serial: 8250_dw: make dw8250_set_termios as default set_termios
>>>     callback
>>>   serial: 8250_dw: Use new dev variable in probe
>>>   serial: 8250_dw: add ACPI support for uart on Hisilicon Hip05 soc
>>>
>>>  drivers/tty/serial/8250/8250_dw.c | 71 ++++++++++++++++++++++------
>>> -----------
>>>  1 file changed, 41 insertions(+), 30 deletions(-)
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


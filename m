From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v5 6/6] serial: pl011: add EARLYCON_DECLARE
Date: Tue, 22 Mar 2016 10:41:46 -0700
Message-ID: <56F183DA.2090408@hurleysoftware.com>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
 <1458643595-14719-7-git-send-email-aleksey.makarov@linaro.org>
 <56F16F93.808@hurleysoftware.com> <56F17C2C.2060102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56F17C2C.2060102@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <amakarov.linux@gmail.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On 03/22/2016 10:09 AM, Aleksey Makarov wrote:
> 
> On 03/22/2016 07:15 PM, Peter Hurley wrote:
>> On 03/22/2016 03:46 AM, Aleksey Makarov wrote:
>>> This patch adds definition of early console data for pl011.
>>> It allows setting up an early console with a string passed in
>>> command line or compiled by the ACPI SPCR table handler.
>>
>> This shouldn't be necessary in 4.5+ since OF_EARLYCON_DECLARE()
>> should be equivalent to EARLYCON_DECLARE() as well.

Sorry, I wrote 4.5+ but I meant 4.6+

> Ok, I will test it and drop this patch
> 
> Thank you
> Aleksey Makarov
> 
>>
>> Regards,
>> Peter Hurley
>>
>>
>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>> ---
>>>  drivers/tty/serial/amba-pl011.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>>> index 59b743f..af6f87cf 100644
>>> --- a/drivers/tty/serial/amba-pl011.c
>>> +++ b/drivers/tty/serial/amba-pl011.c
>>> @@ -2385,6 +2385,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
>>>  	return 0;
>>>  }
>>>  OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
>>> +EARLYCON_DECLARE(pl011, pl011_early_console_setup);
>>>  
>>>  #else
>>>  #define AMBA_CONSOLE	NULL
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>


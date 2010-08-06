From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] serial: samsung: fix device name
Date: Fri, 06 Aug 2010 16:06:10 +0900
Message-ID: <4C5BB462.6010409@samsung.com>
References: <20100805201000.14030.34703.stgit@darius-desktop>
 <AANLkTikp2ThBqF2jkU4CXS9-iYRoy3AWpeqWXjmLF6Gd@mail.gmail.com>
 <4C5BAFF6.10606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:61041 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab0HFHGb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Aug 2010 03:06:31 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L6P006CEYEBKTB0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Fri, 06 Aug 2010 16:06:11 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L6P007NTYEBCP@mmp2.samsung.com> for
 linux-serial@vger.kernel.org; Fri, 06 Aug 2010 16:06:11 +0900 (KST)
In-reply-to: <4C5BAFF6.10606@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Kyungmin Park <kmpark@infradead.org>, Darius Augulis <augulis.darius@gmail.com>, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-serial@vger.kernel.org

On 8/6/2010 3:47 PM, Paulius Zaleckas wrote:
> On 08/06/2010 03:04 AM, Kyungmin Park wrote:
>> Hi,
>>
>> It's already posted by Mr. Shim
>> http://marc.info/?l=linux-arm-kernel&m=127410047306149&w=2
> 
> Darius patch is a little bit cleaner.
> 

OK, it's better.

Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>

>> As discussed with Ben. even though it's right patch, there's some
>> users to use previous interface.
>> I also think it will be fixed. but need to coordinate with existing
>> users.
> 
> IMO this is obvious bug fix.
> 
> Acked-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> 
>> Ben, how to you think?
>>
>> On Fri, Aug 6, 2010 at 5:10 AM, Darius
>> Augulis<augulis.darius@gmail.com>  wrote:
>>> Swap device and driver names in serial/samsung.c
>>>
>>> Signed-off-by: Darius Augulis<augulis.darius@gmail.com>
>>> ---
>>>   drivers/serial/samsung.c |    4 ++--
>>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
>>> index a9d6c56..9d63f24 100644
>>> --- a/drivers/serial/samsung.c
>>> +++ b/drivers/serial/samsung.c
>>> @@ -878,10 +878,10 @@ static struct uart_ops s3c24xx_serial_ops = {
>>>
>>>   static struct uart_driver s3c24xx_uart_drv = {
>>>         .owner          = THIS_MODULE,
>>> -       .dev_name       = "s3c2410_serial",
>>> +       .driver_name    = "s3c2410_serial",
>>>         .nr             = CONFIG_SERIAL_SAMSUNG_UARTS,
>>>         .cons           = S3C24XX_SERIAL_CONSOLE,
>>> -       .driver_name    = S3C24XX_SERIAL_NAME,
>>> +       .dev_name       = S3C24XX_SERIAL_NAME,
>>>         .major          = S3C24XX_SERIAL_MAJOR,
>>>         .minor          = S3C24XX_SERIAL_MINOR,
>>>   };
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-serial" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 


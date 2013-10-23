From: David Cohen <david.a.cohen@linux.intel.com>
Subject: Re: [PATCH 2/2] mrst_max3110: fix SPI UART interrupt parameters
Date: Wed, 23 Oct 2013 11:33:45 -0700
Message-ID: <52681689.2090004@linux.intel.com>
References: <1382470930-13807-1-git-send-email-david.a.cohen@linux.intel.com> <5266E070.2060408@linux.intel.com> <5267041F.2090905@linux.intel.com> <1382509666.28248007@f107.i.mail.ru> <52681128.2010404@linux.intel.com> <20131023182143.GK25954@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:54517 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727Ab3JWS3e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Oct 2013 14:29:34 -0400
In-Reply-To: <20131023182143.GK25954@gimli>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: balbi@ti.com
Cc: Alexander Shiyan <shc_work@mail.ru>, gregkh@linuxfoundation.org, jslaby@suse.cz, ning.li@intel.com, ivan.gorinov@intel.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 10/23/2013 11:21 AM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Oct 23, 2013 at 11:10:48AM -0700, David Cohen wrote:
>>> My idea is always use threaded irq and passing flags into request.
>>> Like as:
>>> unsigned long flags = res->flags & IORESOURCE_BITS;
>>> ...
>>> request_threaded_irq(max->irq, serial_m3110_irq, IRQF_ONESHOT | flags, "max3110", max);
>>
>>
>> Oh, maybe we were talking about different things afterall :)
>> The reason this struct plat_max3110 was created is to allow platform
>> code (located under arch/x86/platform/intel-mid/device_libs/) to define
>> the irq edge type.
>> When I saw your comment I though you were referring to struct resource
>> (which has IORESOURCE_IRQ_* flags). But unlike platform_device,
>> spi_device has no struct resource * to replace the need of struct
>> plat_max3110.
>>
>> OTOH your suggestion can replace this piece of code:
>>
>> @@ -68,6 +69,7 @@ struct uart_max3110 {
>>          u8 clock;
>>          u8 parity, word_7bits;
>>          u16 irq;
>> +       u16 irq_edge_triggered;
>
> max3110 is already edge triggered:
>
> 495                 ret = request_irq(max->irq, serial_m3110_irq,
> 496                                 IRQ_TYPE_EDGE_FALLING, "max3110", max);

Yeah. But in Merrifield case (at least the reference board used now) 
it's not edge triggered. I need this driver to support this situation
prior to send mrst_max3110 platform code for it.

>
> it would be nice a threaded IRQ instead of using a singlethread
> workqueue, though.
>

That sounds reasonable. I'll add this to my TODO list too. Thanks.

Br, David Cohen

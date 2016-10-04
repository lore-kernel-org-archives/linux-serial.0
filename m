From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Tue, 4 Oct 2016 13:02:25 +0100
Message-ID: <6bbfeb57-7a55-6a3e-60b2-3f44525e5882@huawei.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <5140357.dcW9ibtZJ6@wuerfel> <57D963C4.4010406@hisilicon.com>
 <5869118.UilSPY9Sai@wuerfel>
 <2af4f2d8-e3a4-fa00-e700-60af70bf4560@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2af4f2d8-e3a4-fa00-e700-60af70bf4560-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Masters <jcm-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 02/10/2016 23:03, Jon Masters wrote:
> On 09/14/2016 02:32 PM, Arnd Bergmann wrote:
>> On Wednesday, September 14, 2016 10:50:44 PM CEST zhichang.yuan wrote:
>
>>> And there are probably multiple child devices under LPC, the global arm64_extio_ops only can cover one PIO range. It is fortunate only ipmi driver can not support I/O
>>> operation registering, serial driver has serial_in/serial_out to
>>> be registered. So, only the PIO range for ipmi device is stored
>>> in arm64_extio_ops and the indirect-IO
>>> works well for ipmi device.
>>
>> You should not do that in the serial driver, please just use the
>> normal 8250 driver that works fine once you handle the entire
>> port range.
>
> Just for the record, Arnd has the right idea. There is only one type of
> UART permitted by SBSA (PL011). We carved out an exception for a design
> that was already in flight and allowed it to be 16550. That other design
> was then corrected in future generations to be PL011 as we required it
> to be. Then there's the Hip06. I've given feedback elsewhere about the
> need for there to be (at most) two types of UART in the wild. This "LPC"
> stuff needs cleaning up (feedback given elsewhere already on that), but
> we won't be adding a third serial driver into the mix in order to make
> it work. There will be standard ARM servers. There will not be the
> kinda-sorta-standard. Thanks.
>

Right, so I think Zhichang can make the necessary generic changes to 
8250 OF driver to support IO port as well as MMIO-based.

However an LPC-based earlycon driver is still required.

A note on hip07-based D05 (for those unaware): this does not use 
LPC-based uart. It uses PL011. The hardware guys have managed some 
trickery where they loopback the serial line around the BMC/CPLD. But we 
still need it for hip06 D03 and any other boards which want to use LPC 
bus for uart.

A question on SBSA: does it propose how to provide serial via BMC for SOL?


> Jon.
>
>
> .
>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

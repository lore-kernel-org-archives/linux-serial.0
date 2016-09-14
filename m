From: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH V3 3/4] ARM64 LPC: support serial based on low-pin-count
Date: Wed, 14 Sep 2016 23:04:33 +0800
Message-ID: <57D96701.4050700@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473855354-150093-4-git-send-email-yuanzhichang@hisilicon.com>
 <4340181.AghlmQIy28@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4340181.AghlmQIy28@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org



On 2016/9/14 20:25, Arnd Bergmann wrote:
> On Wednesday, September 14, 2016 8:15:53 PM CEST Zhichang Yuan wrote:
>> From: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>
>> On Hip06 platform, a 16550 compatible UART is connected to low-pin-count and
>> controlled through the LPC I/O cycles. After registering the LPC uart specific
>> serial_in/serial_out to 8250 core driver, serial data can be read/written
>> through the LPC.
>>
>> Signed-off-by: zhichang.yuan <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>>
> 
> I still think this should be handled by 8250_of.c after the addition of
> support for IORESOURCE_IO.

The 8250_hisi_lpc.c support both ACPI and dts similar to 8250_dw :

+static struct platform_driver hs_lpc8250_driver = {
+	.driver = {
+		.name		= "hisi-lpc-uart",
+		.of_match_table	= hs8250_of_match,
+		.acpi_match_table = ACPI_PTR(hs8250_acpi_match),

So, I am a little confused why we need to support dts in 8250_of.c and support ACPI in another
driver file.

best,
Zhichang


> 
> 	Arnd
> 
> 
> .
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

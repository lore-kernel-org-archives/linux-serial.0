From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: [PATCH resend] Add sc16is7x2 driver
Date: Mon, 18 Oct 2010 11:46:38 +0200
Message-ID: <4CBC177E.8020407@iis.fraunhofer.de>
References: <4CAD818B.2070603@iis.fraunhofer.de> <20101014190133.GB1009@kroah.com> <4CB801B2.808@iis.fraunhofer.de> <20101015142709.GA18905@kroah.com> <4CB86E8F.3060907@iis.fraunhofer.de> <20101015164922.GB21576@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060103070301000404050208"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101015164922.GB21576@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------060103070301000404050208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id LAA29476

On 15.10.2010 18:49, Greg KH wrote:
> On Fri, Oct 15, 2010 at 05:09:03PM +0200, Manuel Stahl wrote:
>> On 15.10.2010 16:27, Greg KH wrote:
>>> On Fri, Oct 15, 2010 at 09:24:34AM +0200, Manuel Stahl wrote:
>>>> On 14.10.2010 21:01, Greg KH wrote:
>>>>> On Thu, Oct 07, 2010 at 10:15:07AM +0200, Manuel Stahl wrote:
>>>>>> --- /dev/null
>>>>>> +++ b/include/linux/spi/sc16is7x2.h
>>>>>> @@ -0,0 +1,17 @@
>>>>>> +#ifndef LINUX_SPI_SC16IS752_H
>>>>>> +#define LINUX_SPI_SC16IS752_H
>>>>>> +
>>>>>> +#define SC16IS7X2_NR_GPIOS 8
>>>>>> +
>>>>>> +struct sc16is7x2_platform_data {
>>>>>> +	unsigned int	uartclk;
>>>>>> +	/* uart line number of the first channel */
>>>>>> +	unsigned	uart_base;
>>>>>> +	/* number assigned to the first GPIO */
>>>>>> +	unsigned	gpio_base;
>>>>>> +	char		*label;
>>>>>> +	/* list of GPIO names (array length =3D SC16IS7X2_NR_GPIOS) */
>>>>>> +	const char	*const *names;
>>>>>> +};
>>>>>> +
>>>>>> +#endif
>>>>>
>>>>> Why is this needed in a .h file?  What other .c file uses this defi=
ne
>>>>> and structure?
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>
>>>> The board setup code can pass information about the uart and gpio
>>>> enumeration.
>>>
>>> What "board setup code"?  I don't see that here in the patch anywhere.
>>
>> SPI devices are generally set up for a specific hardware board. I.e. f=
or
>> some ARM boards there is setup code in
>> linux/arch/arm/mach-at91/board-<xyz>.c
>>
>> I use the sc16is7x2 for a board that is not yet in vanilla, so the boa=
rd
>> setup code is not included in the patch.
>
> Then why not add this header (or move it to the header file) when your
> board setup code is merged?  No need to have it there now, right?

Cause everyone who want's to use this driver for his board needs the=20
header. The board I use is a prototype, nearly the same as some Atmel=20
Demo board, but with the sc16is752 attached to the SPI port. Therefore I=20
don't see any benefit in publishing my board setup code.

> Care to resend this driver changed that way?

As I said the header definitely belongs to the driver, not to the board.

Regards,
--=20
Manuel Stahl
Fraunhofer-Institut IIS
Leistungsoptimierte Systeme

Nordostpark 93
D90411 N=FCrnberg
Telefon  +49 (0)911/58061-6419
Fax      +49 (0)911/58061-6398
E-Mail   manuel.stahl@iis.fraunhofer.de

http://www.iis.fraunhofer.de
http://www.smart-power.fraunhofer.de

--------------060103070301000404050208
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
fn:Manuel Stahl
n:Stahl;Manuel
email;internet:manuel.stahl@iis.fraunhofer.de
tel;work:+49 911 58061-6419
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------060103070301000404050208--

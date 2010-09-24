From: Darius Augulis <augulis.darius@gmail.com>
Subject: Re: [RESEND PATCH] serial: samsung: fix device name
Date: Fri, 24 Sep 2010 09:57:19 +0300
Message-ID: <AANLkTi=S8v19iT1DC=6Nh9BEgRvKzyzKTKoJmS0Bw1Fb@mail.gmail.com>
References: <20100923190212.18863.25678.stgit@darius-desktop>
	<4C9BE577.4050504@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62872 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649Ab0IXG5U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Sep 2010 02:57:20 -0400
In-Reply-To: <4C9BE577.4050504@fluff.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, linux-kernel@vger.kernel.org, paulius.zaleckas@gmail.com, linux-serial@vger.kernel.org

Hi,

On Fri, Sep 24, 2010 at 2:40 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On 23/09/10 20:15, Darius Augulis wrote:
>> Swap device and driver names in serial/samsung.c
>
> This is far too short, please see the notes below on trying
> to make this more informative.
>
>> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
>> ---
>>
>> This patch was submitted about 3 months ago, but still not merged.
>> There was another similar patch from Joonyoung Shim
>> <jy0922.shim@samsung.com> and was discussed here:
>> http://marc.info/?l=3Dlinux-serial&m=3D127416101222281&w=3D2.
>> Joonyoung Shim acked my patch and other people on ARM mailing list
>> acked it. The maintainer, Ben Dooks, still not responding for
>> a long time. Another maintainer, Kukjin Kim, refused to merge
>> it without Ben's review.
>> I would like to ask somebody pick up this bugfix.
>
> I belive last time this was brought up I asked about the affect
> this has on the userspace. The following issues would be helpful
> or essential to have noted in the header about the effect of this.
>
> - Does it change the /dev name of the device? if so I would thinl
>  carefully about applying it, as it would be a change in the way
>  that userspace sees the kernel.

It does - now devices are named /dev/s3c2410_serial, and patch changes
its name to /dev/ttySAC

>
> - Does it change the kernel output itself? A note on what diffeences
>  can be seen in things like dmesg would be helpful.

It does. Serial driver reports device names when probing, so there
will appear ttySACx instead of
s3c2410_serialx.

>
> - Are there any other side effects
>
> - Why is this a bug? Maybe the previous points will explain what is
>  going on, but if not, then a reasonably concise description of
>  what is going on here.

This is bug, because of several points:

1. Because it contradicts kernel documentation. Please read
Documentation/arm/Samsung-S3C24XX/Overview.txt line 196.
This should be enough to apply this patch.

2. Because s3c2410_serial isn't correct name for serial device node.
It's name of Samsung serial driver.

3. Because now almost all userspace systems workaround it by creating s=
ymlink
/dev/ttySACx > /dev/s3c2410_serialx and only then put some getty on
created symlink, not on original device.
Systems which don't create this symlink, fail to boot at all, because
of wrong console name. Good example is Buildroot.

>
>> =A0drivers/serial/samsung.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
>> index b1156ba..25c0d0f 100644
>> --- a/drivers/serial/samsung.c
>> +++ b/drivers/serial/samsung.c
>> @@ -883,10 +883,10 @@ static struct uart_ops s3c24xx_serial_ops =3D =
{
>>
>> =A0static struct uart_driver s3c24xx_uart_drv =3D {
>> =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
>> - =A0 =A0 .dev_name =A0 =A0 =A0 =3D "s3c2410_serial",
>> + =A0 =A0 .driver_name =A0 =A0=3D "s3c2410_serial",
>> =A0 =A0 =A0 .nr =A0 =A0 =A0 =A0 =A0 =A0 =3D CONFIG_SERIAL_SAMSUNG_UA=
RTS,
>> =A0 =A0 =A0 .cons =A0 =A0 =A0 =A0 =A0 =3D S3C24XX_SERIAL_CONSOLE,
>> - =A0 =A0 .driver_name =A0 =A0=3D S3C24XX_SERIAL_NAME,
>> + =A0 =A0 .dev_name =A0 =A0 =A0 =3D S3C24XX_SERIAL_NAME,
>> =A0 =A0 =A0 .major =A0 =A0 =A0 =A0 =A0=3D S3C24XX_SERIAL_MAJOR,
>> =A0 =A0 =A0 .minor =A0 =A0 =A0 =A0 =A0=3D S3C24XX_SERIAL_MINOR,
>> =A0};
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

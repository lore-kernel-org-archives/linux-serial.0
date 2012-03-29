From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial: PL011: move interrupt clearing
Date: Thu, 29 Mar 2012 23:22:55 +0200
Message-ID: <CACRpkdZ4pxUDpe3aEv3y_Smn5K17f_Q5G-k=EVPzw8NvxpF2iw@mail.gmail.com>
References: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
	<CACxGe6u+KeYzWwiJ7MK7pWG444Y99CQ1LLCZP4m3R=zdYFR_pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44337 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760069Ab2C2VW4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Mar 2012 17:22:56 -0400
Received: by ghrr11 with SMTP id r11so1882831ghr.19
        for <linux-serial@vger.kernel.org>; Thu, 29 Mar 2012 14:22:55 -0700 (PDT)
In-Reply-To: <CACxGe6u+KeYzWwiJ7MK7pWG444Y99CQ1LLCZP4m3R=zdYFR_pg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, stable <stable@vger.kernel.org>, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Thu, Mar 29, 2012 at 10:49 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:

>> Commit 360f748b204275229f8398cb2f9f53955db1503b
>> "serial: PL011: clear pending interrupts"
>> attempts to clear interrupts by writing to a
>> yet-unassigned memory address. This fixes the issue.
>
> Ugh; the original patch is obviously broken. =A0How did it get applie=
d
> without testing?

I've felt bad about that for a while, but to the best of my knowledge I=
 did
test it. Either I did some manual slip with the boot images or there wa=
s
something else causing it to actually work as it looked... Chanho also
had it working IIRC.

> Greg, can you get this out to Linus ASAP please? =A0I have one commen=
t
> below, but I don't think it should block merging this patch.
>
> Tested-by: Grant Likely <grant.likely@secretlab.ca>

Thanks.

>> - =A0 =A0 =A0 /* Ensure interrupts from this UART are masked and cle=
ared */
>> - =A0 =A0 =A0 writew(0, uap->port.membase + UART011_IMSC);
>> - =A0 =A0 =A0 writew(0xffff, uap->port.membase + UART011_ICR);
>> -
>> =A0 =A0 =A0 =A0uap->vendor =3D vendor;
>> =A0 =A0 =A0 =A0uap->lcrh_rx =3D vendor->lcrh_rx;
>> =A0 =A0 =A0 =A0uap->lcrh_tx =3D vendor->lcrh_tx;
>> @@ -1951,6 +1947,10 @@ static int pl011_probe(struct amba_device *de=
v, const struct amba_id *id)
>> =A0 =A0 =A0 =A0uap->port.line =3D i;
>> =A0 =A0 =A0 =A0pl011_dma_probe(uap);
>>
>> + =A0 =A0 =A0 /* Ensure interrupts from this UART are masked and cle=
ared */
>> + =A0 =A0 =A0 writew(0, uap->port.membase + UART011_IMSC);
>> + =A0 =A0 =A0 writew(0xffff, uap->port.membase + UART011_ICR);
>> +
>
> Is it correct to move the interrupt clearing below the
> pl011_dma_probe() call? =A0I've tested the fix with the interrupt
> clearing both above and below the pl011_dma_probe() call and versatil=
e
> qemu boots in both cases.

pl011_dma_probe() basically just make logical setup so we do the
clear-out as the last step of setup.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

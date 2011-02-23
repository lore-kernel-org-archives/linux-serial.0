From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: SC16is752 I2c driver
Date: Wed, 23 Feb 2011 09:15:02 +0100
Message-ID: <4D64C206.8010106@iis.fraunhofer.de>
References: <4D63C80A.3070005@dawning.com> <4D64B7E1.7090708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay03-haj2.antispameurope.com ([83.246.65.53]:44215 "EHLO
	relay03-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754759Ab1BWIPG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Feb 2011 03:15:06 -0500
In-Reply-To: <4D64B7E1.7090708@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Weber <thomas.weber.linux@googlemail.com>
Cc: Pete Murray <pmurray@dawning.com>, linux-serial@vger.kernel.org

On 23.02.2011 08:31, Thomas Weber wrote:
> Hello Manuel,
>
> Am 22.02.2011 15:28, schrieb Pete Murray:
>> Hello,
>>
>> I wrote an I2C  driver for the SC16is752 dual Uart chip, I see there=
 is
>> an SPI version now.  There was no SPI version when I was developing,=
 if
>> there was I would have tried to add I2C support to that driver inste=
ad.
>> Is this something I should post for review, or should I work on addi=
ng
>> support to the existing SPI version?
>> Thanks
>> Pete
>>
>
> do you have an updated version of your SC16IS752 driver, so that Pete
> can add his I2C part?

My latest version is the one from 7th February 2011 that was posted on=20
linux-serial.

Regards,
--=20
Manuel Stahl
=46raunhofer-Institut IIS
Leistungsoptimierte Systeme

Nordostpark 93
D90411 N=FCrnberg
Telefon  +49 (0)911/58061-6419
=46ax      +49 (0)911/58061-6398
E-Mail   manuel.stahl@iis.fraunhofer.de

http://www.iis.fraunhofer.de
http://www.smart-power.fraunhofer.de
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

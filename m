From: Guillermo Rodriguez <guille.rodriguez@gmail.com>
Subject: Re: Fwd: Issues with parity error handling in s3c2410 serial driver
Date: Fri, 09 May 2014 09:25:30 +0200
Message-ID: <536C82EA.2060504@gmail.com>
References: <CABDcavZnY8-uNhYZkvCEy5sdbAQB2vgcYq1PFiNwpvxj32Xn2Q@mail.gmail.com> <CABDcavZyCDPpt1MTGpJfgaYnG=oaHcmB-Sqe=PC1SWuQhf-iTg@mail.gmail.com> <20140508195510.GA8479@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:49827 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbaEIHZb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 May 2014 03:25:31 -0400
Received: by mail-wg0-f51.google.com with SMTP id x13so3493668wgg.34
        for <linux-serial@vger.kernel.org>; Fri, 09 May 2014 00:25:30 -0700 (PDT)
In-Reply-To: <20140508195510.GA8479@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

El 08/05/2014 21:55, Greg Kroah-Hartman escribi=F3:
> On Thu, May 08, 2014 at 01:31:10PM +0200, Guillermo Rodriguez Garcia =
wrote:
>> Hello all,
>>
>> I think I have found some issues with the handling of parity errors =
in the
>> s3c2410 serial driver (drivers/tty/serial/samsung.c)
>>
>> 1.
>> The driver defines S3C2410_UERSTAT_PARITY as 0x1000
>> (see http://lxr.free-electrons.com/source/drivers/tty/serial/samsung=
=2Ec#L265)
>>
>> However, at least in the S3C2440, the correct value should be 0x02.
>> This matches the definition in include/linux/serial_s3c.h for the S3=
C2443 (see
>> http://lxr.free-electrons.com/source/include/linux/serial_s3c.h#L165=
)
>>
>> 2.
>> The driver currently contains code to detect parity errors, but this=
 code is
>> guarded by the following check:
>>
>> if (unlikely(uerstat & S3C2410_UERSTAT_ANY)) {
>> ...
>> }
>>
>> And the definition of S3C2410_UERSTAT_ANY in include/linux/serial_s3=
c.h
>> does not include the parity bit.
>>
>> This means that the code that currently checks for parity errors in =
the serial
>> driver won't actually be run when a parity error occurs. I think tha=
t this is a
>> bug and that S3C2410_UERSTAT_ANY should also contain the parity bit
>>
>> 3.
>> The code that detects parity errors does not increment the parity er=
ror
>> counter in the serial_icounter_struct structure. Other errors (frami=
ng and
>> overrun) are accounted for -- it is just the parity error that is no=
t traced
>> (see http://lxr.free-electrons.com/source/drivers/tty/serial/samsung=
=2Ec#L277).
>>
>> This means that parity errors will not be reported via the TIOCGICOU=
NT
>> ioctl call.
>>
>>
>> Can someone comment on the above?
>=20
> Can you make up a patch to resolve these and be sure to cc: the drive=
r
> authors and this list?

I think it would be a good idea to split this in two patches. Issue 3/ =
above
is trivial to fix and this can get through easily.

=46or 1/ and 2/ I am sure that the problem is _not_ specific to the s3c=
2440
(the way it is now, parity errors are never checked since S3C2410_UERST=
AT_ANY
only contains the overrun and framing bit masks). However I can only te=
st on
the s3c2440. Shall I make a patch specifically for the s3c2440, or shou=
ld I
try to make it generic? If the latter, I could use some help with testi=
ng on
other s3c SoCs.

Thank you,

Guillermo Rodriguez
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: =?ISO-8859-1?Q?Frank_Sch=E4fer?= <fschaefer.oss@googlemail.com>
Subject: Re: USB to Serial converter code pl2303
Date: Thu, 20 Feb 2014 19:19:13 +0100
Message-ID: <53064721.3080905@googlemail.com>
References: <1392688665.7323.32.camel@mange> <20140218090946.GA1954@localhost> <1392828260.3113.24.camel@mange> <20140219170039.GG24335@localhost> <5304E472.2000203@dct.mine.nu> <20140219171406.GH24335@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:47099 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742AbaBTSSL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Feb 2014 13:18:11 -0500
In-Reply-To: <20140219171406.GH24335@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>, Karsten Malcher <debian@dct.mine.nu>
Cc: Magnus <magnus-swe@telia.com>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org


Am 19.02.2014 18:14, schrieb Johan Hovold:
> On Wed, Feb 19, 2014 at 06:05:54PM +0100, Karsten Malcher wrote:
>> Am 19.02.2014 18:00, schrieb Johan Hovold:
>>> I need an adapter that can handle 2400 Baud to talk to the
>>> ft639/ede639 servo controller chip or possibly a pl2303 driver
>>> that is improved.
>>> The pl2303-driver can handle 2400 baud, but not sure exactly what b=
aud
>>> rates are available for a cloned/pirated pl2303 chip (if that is wh=
at
>>> you've got). 115200 baud should be supported, though.
>> We have tested different baud rates with the PL2303HX china clones.
>> All are working including non standard baud rates.
Urgh... Karsten... don't confuse the people. :/
Yes, _your_ clones behave exactly like HX originals, but others don't.

> Ok, good, so 2400 baud should work.
Indeed.
Even the bad clones should support all standard baud rates up o 115200.

>
>> But the non standard baud rates are only available with the modified
>> driver from Frank Sch=E4fer.
> What driver is that? The latest clone-related patch from Frank that I=
've
> seen stated:
>
> 	"According to Prolific, several (unauthorized) cheap and less
> 	 functional clones of the PL2303HX chip are in circulation. [1]
> 	 I've had the chance to test such a cloned device and it turned
> 	 out that it doesn't support any baud rates above 115200 baud
> 	 (original: 6 Mbaud) It also doesn't support the divisior based
> 	 baud rate encoding method, so no continuous baud rate adjustment
> 	 is possible."
This patch is still 100% valid.
The "good" clones are detected as originals, which is fine.

Regards,
=46rank

> Thanks,
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

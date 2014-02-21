From: Karsten Malcher <debian@dct.mine.nu>
Subject: Re: USB to Serial converter code pl2303
Date: Fri, 21 Feb 2014 09:47:14 +0100
Message-ID: <53071292.3050800@dct.mine.nu>
References: <1392688665.7323.32.camel@mange> <20140218090946.GA1954@localhost> <1392828260.3113.24.camel@mange> <20140219170039.GG24335@localhost> <5304E472.2000203@dct.mine.nu> <20140219171406.GH24335@localhost> <53064721.3080905@googlemail.com>
Reply-To: debian@dct.mine.nu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:52413 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbaBUIrT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Feb 2014 03:47:19 -0500
In-Reply-To: <53064721.3080905@googlemail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Frank_Sch=E4fer?= <fschaefer.oss@googlemail.com>
Cc: Johan Hovold <jhovold@gmail.com>, Magnus <magnus-swe@telia.com>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

Am 20.02.2014 19:19, schrieb Frank Sch=E4fer:
>> We have tested different baud rates with the PL2303HX china clones.
>> All are working including non standard baud rates.
> Urgh... Karsten... don't confuse the people. :/
> Yes, _your_ clones behave exactly like HX originals, but others don't=
=2E

O.K. - all of them is not correct.
My meaning was all i have tested from the PL2303HX clones.

At least all standard driver only support the standard baud rates.
That's sufficient for nearly all purposes.
But if someone needs to support non standard baud rates, it might be go=
od to know that this is possible with some chips.

Cheers
Karsten
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

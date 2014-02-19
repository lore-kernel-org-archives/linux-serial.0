From: Karsten Malcher <debian@dct.mine.nu>
Subject: Re: USB to Serial converter code pl2303
Date: Wed, 19 Feb 2014 18:05:54 +0100
Message-ID: <5304E472.2000203@dct.mine.nu>
References: <1392688665.7323.32.camel@mange> <20140218090946.GA1954@localhost> <1392828260.3113.24.camel@mange> <20140219170039.GG24335@localhost>
Reply-To: debian@dct.mine.nu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:56934 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbaBSRF6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Feb 2014 12:05:58 -0500
In-Reply-To: <20140219170039.GG24335@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Magnus <magnus-swe@telia.com>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

Am 19.02.2014 18:00, schrieb Johan Hovold:
> I need an adapter that can handle 2400 Baud to talk to the
> ft639/ede639 servo controller chip or possibly a pl2303 driver
> that is improved.
> The pl2303-driver can handle 2400 baud, but not sure exactly what bau=
d
> rates are available for a cloned/pirated pl2303 chip (if that is what
> you've got). 115200 baud should be supported, though.

We have tested different baud rates with the PL2303HX china clones.
All are working including non standard baud rates.
But the non standard baud rates are only available with the modified dr=
iver from Frank Sch=E4fer.

Cheers
Karsten
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

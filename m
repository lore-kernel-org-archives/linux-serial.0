From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] tty: of_serial: add no-loopback-test property
Date: Sat, 14 Jul 2012 17:41:54 +0200
Message-ID: <50019342.6080008@openwrt.org>
References: <1342267580-3672-1-git-send-email-juhosg@openwrt.org> <20120714150101.1810c829@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:48489 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab2GNPmB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2012 11:42:01 -0400
In-Reply-To: <20120714150101.1810c829@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-serial@vger.kernel.org

2012.07.14. 16:01 keltez=E9ssel, Alan Cox =EDrta:
> On Sat, 14 Jul 2012 14:06:20 +0200
> Gabor Juhos <juhosg@openwrt.org> wrote:
>=20
>> The loopback test mode is not implemented in all
>> NS16550 compatible UARTs. The 8250 driver uses the
>> UPF_SKIP_TEST flag to indicate this, however it is
>> not possible to set this flag via device-tree.
>>
>> Add a new 'no-loopback-test' property, and modify
>> the of_serial driver to set the UPF_SKIP_TEST flag
>> if the property is present.
>>
>> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
>=20
> Looks good to me but clashes with the sync of the termios changes, wh=
ich
> we urgently need to get in first.
>=20
> Greg - I'll add this to my patch stack with the relevant changes so t=
hat
> it doesn't get messed up.

Thank you!

-Gabor
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

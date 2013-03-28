From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] serial: 8250_dw: add support for clk api
Date: Fri, 29 Mar 2013 00:06:52 +0100
Message-ID: <5154CD0C.60901@free-electrons.com>
References: <1364387748-13015-1-git-send-email-maxime.ripard@free-electrons.com> <20130328230342.GA24556@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:39965 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab3C1XGz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Mar 2013 19:06:55 -0400
In-Reply-To: <20130328230342.GA24556@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Greg,

Le 29/03/2013 00:03, Greg Kroah-Hartman a =E9crit :
> On Wed, Mar 27, 2013 at 01:35:48PM +0100, Maxime Ripard wrote:
>> From: Emilio L=F3pez <emilio@elopez.com.ar>
>>
>> This commit implements support for using the clk api; this lets us u=
se
>> the "clocks" property with device tree, instead of having to use
>> clock-frequency.
>>
>> Signed-off-by: Emilio L=F3pez <emilio@elopez.com.ar>
>> ---
>=20
> Why aren't you signing off on this patch as well?

Hmm, I forgot to do so, and no one pointed that one before. Sorry.

Do you want me to resend it with my SoB?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

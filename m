From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] serial: 8250_dw: add support for clk api
Date: Tue, 26 Mar 2013 11:35:18 +0100
Message-ID: <515179E6.4020709@free-electrons.com>
References: <1363689316-7847-2-git-send-email-maxime.ripard@free-electrons.com> <1363690369-8067-1-git-send-email-maxime.ripard@free-electrons.com> <20130321084707.GB2862@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:51618 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab3CZKfX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Mar 2013 06:35:23 -0400
In-Reply-To: <20130321084707.GB2862@xps8300>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-arm-kernel@lists.infradead.org, kevin@allwinnertech.com, sunny@allwinnertech.com, shuge@allwinnertech.com, linux-serial@vger.kernel.org, =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org

Hi Greg,

Le 21/03/2013 09:47, Heikki Krogerus a =E9crit :
> On Tue, Mar 19, 2013 at 11:52:49AM +0100, Maxime Ripard wrote:
>> From: Emilio L=F3pez <emilio@elopez.com.ar>
>>
>> This commit implements support for using the clk api; this lets us u=
se
>> the "clocks" property with device tree, instead of having to use
>> clock-frequency.
>>
>> Signed-off-by: Emilio L=F3pez <emilio@elopez.com.ar>
>=20
> FWIW,
>=20
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Would you consider merging this patch, or do you have additional commen=
ts?

We have several patch series that depends on this one that I'd like to
see included in 3.10, and we begin to see the end of the 3.9 release cy=
cle.

Thanks,
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

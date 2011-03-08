From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] n_gsm: improve behaviour with encoding 0
Date: Tue, 8 Mar 2011 13:01:45 +0000
Message-ID: <20110308130145.3bacbe1b@lxorguk.ukuu.org.uk>
References: <1299543872-14580-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49744 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754593Ab1CHNBj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Mar 2011 08:01:39 -0500
In-Reply-To: <1299543872-14580-1-git-send-email-eric@eukrea.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Eric =?ISO-8859-14?B?QuluYXJk?= <eric@eukrea.com>
Cc: linux-serial@vger.kernel.org

On Tue,  8 Mar 2011 01:24:31 +0100
Eric B=E9nard <eric@eukrea.com> wrote:

> * on Telit & Sim.com modems, using encoding 0, opening a new DLC
> randomly fails. Not setting PF bit of the control byte gives a
> reliable behaviour on these modems.

Any change needs doing with reference to the standard not modem specifi=
c
hacks. Chances are the modem is right about the PF bit and we perhaps a=
re
not - but it's not an encoding dependant bit so the patch is certainly
wrong.

In this case:

5.4.3.1 says (of UI/UIH etc) 'both stations shall set the P bit to 0'

so the modem is right and we are wrong.

I think what is actually needed is to just remove the PF setting
completely for that function. Obviously the other modems don't care or
check the bit.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

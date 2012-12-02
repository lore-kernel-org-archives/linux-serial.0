From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] synclink fix ldisc buffer argument
Date: Sun, 2 Dec 2012 18:10:57 +0000
Message-ID: <20121202181057.097012c6@pyramind.ukuu.org.uk>
References: <50B6E751.9000000@asianux.com>
	<20121129051335.GA4375@kroah.com>
	<50B6F967.3050000@asianux.com>
	<20121129183207.GA4688@kroah.com>
	<50B81F76.8020508@asianux.com>
	<50B8DDAC.8070901@microgate.com>
	<50B90D0D.9040401@microgate.com>
	<20121202151332.3b6a6504@pyramind.ukuu.org.uk>
	<F6B8A325-7DBF-4623-B16C-CDC5642EFD16@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49414 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab2LBSFx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Dec 2012 13:05:53 -0500
In-Reply-To: <F6B8A325-7DBF-4623-B16C-CDC5642EFD16@microgate.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Fulghum <paulkf@microgate.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Chen Gang <gang.chen@asianux.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

On Sun, 2 Dec 2012 10:11:58 -0600
Paul Fulghum <paulkf@microgate.com> wrote:

> True, in this mode line disciplines other than N_HDLC would not be fu=
nctional and N_HDLC ignores the flag buffer.
> This change won=92t make other line disciplines useful, it will just =
prevent the case of a mistakenly selected line discipline accessing bey=
ond the end of the (dummy) flag buffer.
>=20
> I=92m fine with or without the change. It is functional now with a ch=
ance to read past then end of a buffer if misconfigured. With the chang=
e, it has the same functionality without the ability to read past the e=
nd of a buffer if misconfigured.

With the change its feeding crap in the flags buffer, which may matter =
in
future depending what happens to the other bits.

If this is a real issue far better to just kzalloc a blank flag buffer =
to
match the mtu.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

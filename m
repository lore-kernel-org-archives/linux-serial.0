From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] synclink fix ldisc buffer argument
Date: Fri, 07 Dec 2012 10:15:22 +0800
Message-ID: <50C1513A.4010600@asianux.com>
References: <50B6E751.9000000@asianux.com> <20121129051335.GA4375@kroah.com> <50B6F967.3050000@asianux.com> <20121129183207.GA4688@kroah.com> <50B81F76.8020508@asianux.com> <50B8DDAC.8070901@microgate.com> <50B90D0D.9040401@microgate.com> <50BCDDB4.6010608@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:64279 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671Ab2LGCOa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 21:14:30 -0500
In-Reply-To: <50BCDDB4.6010608@microgate.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Fulghum <paulkf@microgate.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello Greg Kroah-Hartman:


=E4=BA=8E 2012=E5=B9=B412=E6=9C=8804=E6=97=A5 01:13, Paul Fulghum =E5=86=
=99=E9=81=93:
> Fix call to line discipline receive_buf by synclink drivers.
> Dummy flag buffer argument is ignored by N_HDLC line discipline but m=
ight
> be of insufficient size if accessed by a different line discipline
> selected by mistake. flag buffer allocation now matches max size of d=
ata
> buffer. Unused char_buf buffers are removed.
>=20
> Signed-off-by: Paul Fulghum <paulkf@microgate.com>

if no additional questions:
  is it suitable to let this patch pass checking ?
  at least for me, it is surely solve an issue, and no negative effect.

now, maybe Paul Fulghum is busy...
  the left questions what I have sent seems minor.
  so they can be delayed, until he has free time.

when Paul Fulghum has free time.
  can still check what my left questions whether valid.
  if they are valid, can send additional patch for them.


  is it OK ?

  Regards

--=20
Chen Gang

Asianux Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

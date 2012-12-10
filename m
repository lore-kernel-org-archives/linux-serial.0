From: Chen Gang <gang.chen@asianux.com>
Subject: [Consult]: Re: [PATCH] synclink fix ldisc buffer argument
Date: Mon, 10 Dec 2012 09:32:21 +0800
Message-ID: <50C53BA5.2030805@asianux.com>
References: <50B6E751.9000000@asianux.com> <20121129051335.GA4375@kroah.com> <50B6F967.3050000@asianux.com> <20121129183207.GA4688@kroah.com> <50B81F76.8020508@asianux.com> <50B8DDAC.8070901@microgate.com> <50B90D0D.9040401@microgate.com> <50BCDDB4.6010608@microgate.com> <50C1513A.4010600@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:17647 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab2LJBb2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Dec 2012 20:31:28 -0500
In-Reply-To: <50C1513A.4010600@asianux.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Fulghum <paulkf@microgate.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello Paul Fulghum:

  Firstly, sorry for my mistake:
    I am a reporter (not reviewer), and not suitable to review maintain=
er's patch.
    when you send relative patch, need not cc to me (I am not reviewer)

  so:
    could you send patch again (not need cc to me) ?
      (and also it is better to mark me as Reported-by in your patch)

  sorry for my mistake, again.

gchen.


=E4=BA=8E 2012=E5=B9=B412=E6=9C=8807=E6=97=A5 10:15, Chen Gang =E5=86=99=
=E9=81=93:
> Hello Greg Kroah-Hartman:
>=20
>=20
> =E4=BA=8E 2012=E5=B9=B412=E6=9C=8804=E6=97=A5 01:13, Paul Fulghum =E5=
=86=99=E9=81=93:
>> Fix call to line discipline receive_buf by synclink drivers.
>> Dummy flag buffer argument is ignored by N_HDLC line discipline but =
might
>> be of insufficient size if accessed by a different line discipline
>> selected by mistake. flag buffer allocation now matches max size of =
data
>> buffer. Unused char_buf buffers are removed.
>>
>> Signed-off-by: Paul Fulghum <paulkf@microgate.com>
>=20
> if no additional questions:
>   is it suitable to let this patch pass checking ?
>   at least for me, it is surely solve an issue, and no negative effec=
t.
>=20
> now, maybe Paul Fulghum is busy...
>   the left questions what I have sent seems minor.
>   so they can be delayed, until he has free time.
>=20
> when Paul Fulghum has free time.
>   can still check what my left questions whether valid.
>   if they are valid, can send additional patch for them.
>=20
>=20
>   is it OK ?
>=20
>   Regards
>=20


--=20
Chen Gang

Asianux Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH V2] tty/serial: add support for Xilinx PS UART
Date: Fri, 22 Apr 2011 09:47:59 -0600
Message-ID: <edfeec92-bda0-4d02-90eb-bf4d04084c86@VA3EHSMHS024.ehs.local>
References: <90e49570-bc82-41a9-ac79-2f5007e93a2a@VA3EHSMHS018.ehs.local> <BANLkTimhk-szP=gbZLpRrofi2EB2YbXrqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:40035
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755110Ab1DVPsD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Apr 2011 11:48:03 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <BANLkTimhk-szP=gbZLpRrofi2EB2YbXrqg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
> Grant Likely
> Sent: Friday, April 22, 2011 9:41 AM
> To: John Linn
> Cc: linux-kernel@vger.kernel.org; linux-serial@vger.kernel.org;
> alan@lxorguk.ukuu.org.uk; greg@kroah.com
> Subject: Re: [PATCH V2] tty/serial: add support for Xilinx PS UART
>=20
> On Wed, Apr 20, 2011 at 1:03 PM, John Linn <john.linn@xilinx.com>
> wrote:
> > The Xilinx PS Uart is used on the new ARM based SoC. This
> > UART is not compatible with others such that a seperate
> > driver is required.
> >
> > Signed-off-by: John Linn <john.linn@xilinx.com>
>=20
> Out of curiosity, who is the vendor of this uart IP block?  Is it new
> hardware created by xilinx for zinq, or is it provided by a third
> party.  If its from a third party it is within the realm of
> possibility that a driver already exists for it.
>=20
> g.

Hi Grant,

It is an IP block from a vendor. I would like to say, but would have=20
my head handed to me I'm told. I wish it wasn't that way as it's not=20
helping the open source process.

I did try to review all the drivers and their registers to see if=20
there was already one written before I sent the patches.  I didn't=20
see one that matched as it would definitely be easier if there was.

Thanks,
John

<snip>

> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> > Please read the FAQ at =A0http://www.tux.org/lkml/
> >
>=20
>=20
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.


This email and any attachments are intended for the sole use of the nam=
ed recipient(s) and contain(s) confidential information that may be pro=
prietary, privileged or copyrighted under applicable law. If you are no=
t the intended recipient, do not read, copy, or forward this email mess=
age or any attachments. Delete this email message and any attachments i=
mmediately.


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Greg KH <greg@kroah.com>
Subject: Re: Line Discipline Kernel BUG when using usb-serial and mos7840 in
 v3.11
Date: Fri, 25 Apr 2014 12:53:44 -0700
Message-ID: <20140425195344.GA905@kroah.com>
References: <CAEBke53+w73+hBmNpafnaY9dYps=JayZGjYz2E=BrmTFsOfVmg@mail.gmail.com>
 <20140425182025.GA6331@kroah.com>
 <CAEBke535FyNouGNg+2A3jeyO+F_Mfj8KG822SXBbH_rSzWm_6A@mail.gmail.com>
 <20140425192405.GA32455@kroah.com>
 <CAEBke52mKD+w2G9SZqM=Lc-qhbLeX7ZAa86BK5TQPEOQSXic=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54209 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750812AbaDYTux (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Apr 2014 15:50:53 -0400
Content-Disposition: inline
In-Reply-To: <CAEBke52mKD+w2G9SZqM=Lc-qhbLeX7ZAa86BK5TQPEOQSXic=g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Coleman Brumley <coleman.brumley@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Fri, Apr 25, 2014 at 03:40:17PM -0400, Coleman Brumley wrote:
> > =A0 =A0 There's been lots of changes in the tty layer over the past=
 year or so.
>=20
> Have there been many changes in the ldisc API? I know there were some
> subtle ones between 2.4 and 2.6, but were there many between v2.6 and
> v3.0?

I can't recall, given the very high number of tty patches in the past
few years, I am guessing there were a lot.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

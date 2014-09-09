From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: sirf: fix line over 80 characters style issue
Date: Mon, 8 Sep 2014 18:33:08 -0700
Message-ID: <20140909013308.GB16363@kroah.com>
References: <20140908231527.GA23907@kroah.com>
 <D034651C.21637%21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37137 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbaIIBdJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Sep 2014 21:33:09 -0400
Content-Disposition: inline
In-Reply-To: <D034651C.21637%21cnbao@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Barry Song <Barry.Song@csr.com>, linux-serial@vger.kernel.org, workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

On Tue, Sep 09, 2014 at 08:16:47AM +0800, Barry Song wrote:
>=20
>=20
> On 14-9-9 =E4=B8=8A=E5=8D=887:15, "Greg KH" <gregkh@linuxfoundation.o=
rg> wrote:
>=20
> >On Mon, Aug 18, 2014 at 05:32:52PM +0800, Barry Song wrote:
> >> From: Qipan Li <Qipan.Li@csr.com>
> >>=20
> >> According to key customer's requirement, fix "line over 80
> >> characters".
> >
> >Someone is forcing you to fix all upstream kernel.org code for 80
> >columns?  Who?
>=20
> we were asked to fix csr platform codes some days ago. They have been
> fixed locally.=20

What is "locally"?

And you really are forced to do foolish cleanups for no reason in
mainline kernel code for no reason?

> You know, the difficulty is maintaining the difference between
> mainline and local codes.
> So I thought this is better if you can merge it.

I'm not taking stuff that isn't correct.  Or is foolish.  Neither shoul=
d
you.

> >Sorry, not going to take this, if your customer blames you, point th=
em
> >at me.
>=20
> I understand you are very helpful. But pointing them to you will actu=
ally
> make things worse as I think we have no chance to convince them as we=
 have
> tried our best to do that.
> The benefit of this patch is making people happy. But if you are not
> happy, I can make myself unhappy to maintain two versions.

Try fixing the code to look better, your changes were not valid ones,
you are quieting some automatic tool checker, you aren't doing the
correct thing and following the "spirit" of the rule here.

Make the code look cleaner, and I'll be glad to take the change.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Corbin <corbinat@gmail.com>
Subject: Re: [PATCH 1/1] serial_core: Update buffer overrun statistics.
Date: Tue, 15 May 2012 11:20:19 -0500
Message-ID: <CAA0x6_-6tAHspcjFmD9Gz7NV4dUwP6St-UtivXTTQiANfBcX7A@mail.gmail.com>
References: <1336152910-5276-1-git-send-email-corbin.atkinson@ni.com>
 <20120515165339.6b142cd2@pyramind.ukuu.org.uk> <20120515155833.GA24878@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34637 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965642Ab2EOQUj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 12:20:39 -0400
Received: by vbbff1 with SMTP id ff1so6197997vbb.19
        for <linux-serial@vger.kernel.org>; Tue, 15 May 2012 09:20:39 -0700 (PDT)
In-Reply-To: <20120515155833.GA24878@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Corbin Atkinson <corbin.atkinson@ni.com>

I agree that losing bytes in the software layer wouldn't happen under
normal circumstances, but it is still important to know when it
happens. My understanding was that the overrun field in the port's
icount was for logging hardware overruns, while the buf_overrun field
should be used for software overruns. If this is not the case then is
there another method for determining when the software layer is losing
bytes?

Thanks,
Corbin

On Tue, May 15, 2012 at 10:58 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 15, 2012 at 04:53:39PM +0100, Alan Cox wrote:
> > On Fri, =A04 May 2012 12:35:10 -0500
> > Corbin Atkinson <corbinat@gmail.com> wrote:
> >
> > > Currently, serial drivers don't report buffer overruns. When a bu=
ffer
> > > overrun
> > > occurs, tty_insert_flip_char returns 0, and no attempt is made to
> > > insert that
> > > same character again (i.e. it is lost). This patch reports buffer
> > > overruns via
> > > the buf_overrun field in the port's icount structure.
> >
> > I think this is mostly a misunderstanding - it's always been interp=
reted
> > as logging hardware reported overrruns. The case of the software la=
yer
> > losing bytes is a "doesn't happen in normal circumstances" situatio=
n. At
> > least it should be.
>
> Hm, I applied this already, should I revert it?
>
> thanks,
>
> greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

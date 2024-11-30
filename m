Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C81EB3D;
	Sat, 30 Nov 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732984238; cv=none; b=lfsReETnDfuTaBa7vnVeLFSkhGqKk5Ar0JRXM02ibyuJhpKRMDeQ3ASNzbqnaeKze0/eYkL+dId+0nNfsPH8hCqdViVlybqgWUA0WZZsvNQjX/Eoy+DOLaFRq9IgVC7Zt0lQDZKmSJ1GRy2vrchIESWKKAQD0j+arORM+trcPLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732984238; c=relaxed/simple;
	bh=0ui7pg5NuYo4VWOkGTQDzP5G//4epnLRm4v5LBQpWJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSjaigLLXz+utIhWaX6G0PWxvodqAgWtn33PgX2vm3jZiQ5uLzZNATbgJkMVhFN3RMKDXTDpwW2f4wNWqHHJ8GgzxQtREjPXQLnJfnERC2Cey1UaP81X+Hw1YNYVdvQoab2zMw9E8Gzyira0sPNL15weB0cy3QtdZU5Z+IAYAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTaK9+Vx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTaK9+Vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2483DC4CECC;
	Sat, 30 Nov 2024 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732984237;
	bh=0ui7pg5NuYo4VWOkGTQDzP5G//4epnLRm4v5LBQpWJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTaK9+Vx8TqWh6nqbdcpiXVJqoXJehtZPpcLl62Z0H4HonrmgLuc2Da3WZOsQizc0
	 pPYcvRL8kNhFHUIK3cOyZO/XLjk4HHtaw2MXUgSmH9vYSwEiR/hYAxFMJCNPDF6yzj
	 eKkH0Zkuhxvi4Ajsmu5c5vn3XlOyuhDK02oB0PlE=
Date: Sat, 30 Nov 2024 17:30:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Slaby <jslaby@suse.cz>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.13-rc1
Message-ID: <2024113055-concave-obnoxious-6240@gregkh>
References: <Z0lCihhE75lE9Zjd@kroah.com>
 <CAMuHMdXwdyb6RA5jksNfw-M9h_nERvm8M4b7XU1_1N-C+bf94A@mail.gmail.com>
 <2024112952-headphone-vastness-3814@gregkh>
 <CAMuHMdW9j-=hEgvth0L=AS+BgdFwgFfOkt=xbB7RCP=4UAvocw@mail.gmail.com>
 <TYCPR01MB6478F8FA81F06970E49763AB9F2A2@TYCPR01MB6478.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB6478F8FA81F06970E49763AB9F2A2@TYCPR01MB6478.jpnprd01.prod.outlook.com>

On Fri, Nov 29, 2024 at 10:58:28AM +0000, Claudiu Beznea wrote:
> Hi, Geert, Greg,
> 
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 29 November 2024 12:42
> > To: Greg KH <gregkh@linuxfoundation.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>; Jiri Slaby
> > <jslaby@suse.cz>; Stephen Rothwell <sfr@canb.auug.org.au>; Andrew Morton
> > <akpm@linux-foundation.org>; linux-kernel@vger.kernel.org; linux-
> > serial@vger.kernel.org; Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.13-rc1
> > 
> > Hi Greg,
> > 
> > CC Claudiu
> > 
> > On Fri, Nov 29, 2024 at 11:31 AM Greg KH <gregkh@linuxfoundation.org>
> > wrote:
> > > On Fri, Nov 29, 2024 at 08:58:28AM +0100, Geert Uytterhoeven wrote:
> > > > On Fri, Nov 29, 2024 at 5:26 AM Greg KH <gregkh@linuxfoundation.org>
> > wrote:
> > > > > The following changes since commit
> > 42f7652d3eb527d03665b09edac47f85fb600924:
> > > > >
> > > > >   Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> > > > > tags/tty-6.13-rc1
> > > > >
> > > > > for you to fetch changes up to
> > b5a23a60e8ab5711f4952912424347bf3864ce8d:
> > > > >
> > > > >   serial: amba-pl011: fix build regression (2024-11-16 09:52:55
> > > > > +0100)
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > TTY / Serial driver updates for 6.13-rc1
> > > >
> > > > [...]
> > > >
> > > > > All of these have been in linux-next for a while with no reported
> > > > > issues.
> > > >
> > > > Oh, how do I love this boilerplate...
> > >
> > > I hand-craft that every time :)
> > >
> > > > > Claudiu Beznea (1):
> > > > >       serial: sh-sci: Clean sci_ports[0] after at earlycon exit
> > > >
> > > > "BUG: spinlock bad magic"
> > > > https://lore.kernel.org/all/CAMuHMdX57_AEYC_6CbrJn-+B+ivU8oFiXR0FXF7
> > > > Lrqv5dWZWYA@mail.gmail.com/
> > >
> > > Ah, yes, sorry, missed that.  I assumed that it would be fixed soon,
> > > do you want me to revert it instead?
> > 
> > Let's hope it gets fixed soon.
> > It's not super-critical, as earlycon is not meant for regular use
> > (although lots of unaffected non-Renesas platforms do have "earlycon"
> >  in their DTS chosen/bootargs, sigh).
> 
> I'm working on now. However, using debug serial with an alias
> other than zero and having both "earlycon keep_bootcon" as bootargs give
> me some pain in progressing.
> 
> If you can, please drop it and hopefully, I'll soon manage to find a fix
> for all these.

Thanks, I'll revert it now.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F4F374187;
	Mon, 11 May 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511603; cv=none; b=Jjy8td9BWiCACSQBkMAqvSIna516A7880Qbjs1rn2y044sOVqqkNnlwTqB20kqLxc+tzuREpz4b37Mvd41hJKgis+t3V43s2AercPCZw1FdXefAmu6AAxIk3f0qhADXu7Mvt0QcjcqNEBXZc+b3oTInUAudeCxyomRcSSIOImNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511603; c=relaxed/simple;
	bh=L7mGvX3leX4pM/6djYPLzb/k+tkJ1EJqE39VXKyY1HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ut0AtJVgqv+mSiA4zOMgayyY4ghK8JD5V8X3Kz7syTioPzNnxQwU7blzUYCpd7Y7G7dAfbY/yQAcBb4nHZHcQAy1Acvwmtq03NvNjMgVJQQXAwV1NAnuaLuFIBRVoWN6OeEGskDUxFBMhXYYZc4VumWWRxeud63FiejPg0p0mCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C2X4XEE5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C2X4XEE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8199C2BCC9;
	Mon, 11 May 2026 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778511603;
	bh=L7mGvX3leX4pM/6djYPLzb/k+tkJ1EJqE39VXKyY1HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2X4XEE5SdK05Nd3MqXD1r60wfyOmRRa7UThkwZ4aHnQsLD5ZiMDeroV8Be7zCQ/H
	 GDzIwQlLsF3rjN5RWi1QomZazqJ7flooxQlBgY30KG7HXFalJfyfXeGsPQs2lo+hRa
	 PAJhLriIY+O+owuExl3l1Bj3BYTnY3sBE19vAAmA=
Date: Mon, 11 May 2026 17:00:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	linux-serial@vger.kernel.org,
	Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH tty v4 3/6] serial: sh-sci: Avoid deprecated UPF_CONS_FLOW
Message-ID: <2026051134-revisable-sherry-e5b5@gregkh>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
 <20260506121606.5805-4-john.ogness@linutronix.de>
 <CAMuHMdXs94k3-7YD-yO7p2=+u8waYGAz8mpP5LDbMf3szt4V-w@mail.gmail.com>
 <87v7d08ztd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7d08ztd.fsf@jogness.linutronix.de>

On Wed, May 06, 2026 at 02:59:02PM +0206, John Ogness wrote:
> Hi Geert,
> 
> On 2026-05-06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> --- a/drivers/tty/serial/sh-sci.c
> >> +++ b/drivers/tty/serial/sh-sci.c
> >> @@ -3369,9 +3369,12 @@ static int sci_init_single(struct platform_device *dev,
> >>         }
> >>
> >>         port->type              = SCI_PUBLIC_PORT_ID(p->type);
> >> -       port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
> >> +       port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF |
> >> +                                 (p->flags & ~UPF_CONS_FLOW);
> >
> > This seems over-cautious to me.
> > The last setter of p->flags was removed in commit 37744feebc086908
> > ("sh: remove sh5 support") in v5.8.  No platform data ever set the
> > UPF_CONS_FLOW flag before.  I would rather remove plat_sci_port.flags
> > and this "| p->flags", so we don't have to care about UPF_CONS_FLOW
> > in this driver at all.
> 
> If there is a v5, I will drop this patch. If v4 is acceptable, the
> maintainer can just drop this patch.
> 
> I will leave the plat_sci_port.flags removal as an excercise for the sh
> folks.

Ah, this is what confused me.  I've taken the first two patches here,
can you respin the rest on my branch and resend them?

thanks,

greg k-h

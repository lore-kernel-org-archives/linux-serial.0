Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98704378811;
	Sun, 31 May 2026 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215180; cv=none; b=AEKqNfZ/nMLSeXWIq15BRyWqUhO5gW+89tJHwEV42CzIQSSWhdb5r17HC7PAA8t918UcY7NPRUY9jRu6UaZatOn5Ftj9jBrfsZ0SIU8Dq2Af7qo4jrtCMRc1BFFOoEdhQScR5nCPfcGLuxQ5LYss8eQ3Hy+oJA2G4+ElFpPuVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215180; c=relaxed/simple;
	bh=i/D1O99Fe+jVjdXsNJMuvB2P8M2S/msHN4nRB0/9Jp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRpnq7zimxq7rtDxbW0MMM9LEytKhnEFtbOKMLH1TKR+7dN/kxO2IlLO2fJqV3pfRiaS85mHm3Dg1ZbNJif5pDTtArKa4TIVVCzYCY28wS8uGg5vUo9D/z9Hoi9X7MFoK+BtyWvLuHxWO4bhuxJoGm3ceAsL8Tk7dvnw+kr01Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aVVGjGyw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aVVGjGyw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97301F00893;
	Sun, 31 May 2026 08:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780215179;
	bh=v3vy2y7L3kPE58fCukjhM9NjJEBR+78/a8BS7ldleJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aVVGjGywLCBbgFBMmc+J7+KfGIZ2b3bZc/5QrNuDeREfmpl9xBqIMimr2dsDIY2Ml
	 MEB7cZTqmy+SdS0FTqWsBEbRoY9uwSWWRaQpr1MNksAxHs7zMB1yCXh0FaRHAIRUH0
	 bQjqrKKmGsTIkzAMwnjENtmK9XCpBYJKlK77nijg=
Date: Sun, 31 May 2026 10:12:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv2] serial: mxs-auart: fix probe error paths and clock
 handling
Message-ID: <2026053149-baggy-reaction-ff9d@gregkh>
References: <20260530195525.5059-1-rosenp@gmail.com>
 <2026053127-nastily-fool-88eb@gregkh>
 <CAKxU2N8bNT+irM-gOk9SM5DHPbcbh7zvNM7n4wF5+q4TSEMkSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8bNT+irM-gOk9SM5DHPbcbh7zvNM7n4wF5+q4TSEMkSA@mail.gmail.com>

On Sun, May 31, 2026 at 01:00:21AM -0700, Rosen Penev wrote:
> On Sun, May 31, 2026 at 12:52 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, May 30, 2026 at 12:55:03PM -0700, Rosen Penev wrote:
> > > Sashiko reported three pre-existing bugs in the mxs-auart driver:
> > >
> > > - For non-ASM9260 variants, mxs_get_clks() obtained the clock but never
> > >   prepared/enabled it, leaving register accesses in probe at risk of
> > >   faulting if the bootloader had gated the clock.
> > > - The error path and remove function used pdev->id instead of
> > >   s->port.line to clear the auart_port[] slot.  For DT-probed devices
> > >   pdev->id is -1, causing an out-of-bounds write and leaving a dangling
> > >   pointer in the array.
> > > - The probe error path called iounmap() while the IRQ was still
> > >   registered. An interrupt during that window would dereference the
> > >   unmapped membase.
> >
> > This should still be broken up into smaller pieces, don't you think?
> >
> > Whenever you have to list the different things you do in a patch, that's
> > a huge hint to do so.
> I'll do so. Although I doubt the bot will be happy either way.

What bot?  Yours?  If so, please don't use it.

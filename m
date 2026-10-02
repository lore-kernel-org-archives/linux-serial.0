Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3564636826B;
	Fri,  2 Oct 2026 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790920531; cv=none; b=jWkY7+/gX25HHb5DDIjWmLKj1kuoGhQDpvWHP+v+o+ZZZU/LfXeZipmsvp6StnsjzDPcbZeLpS5/km6vX6HYfOUur3pmYMegXZNphBcDAfEW6/51OoxoHeQi18BI+600eYLI4JNleRDjLJ/PV8Wy7uuijstNbH3ysP+S2Zuiza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790920531; c=relaxed/simple;
	bh=o6UmG2gffY9OlETAnAvPfc0nJpg4QkbL+uCnTZ2/MGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRRNH5yCh3F5j7AQlOeiQCLFy1RuhYwYATXk9N4akPmj2JnmxEbWztZZ6lbFupJSunRjvJ95t/tRYKCnrLyC52znwAilqWrjsp2C5IvmsALM2HlQjcbSk2pXzhq0v7lAFAPjPdfr0V62CBTRBw1AznsOFRm0pt9DwmWruvyc3ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hlyf3B/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hlyf3B/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA421F00893;
	Fri,  2 Oct 2026 05:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790920529;
	bh=teFEjoGk60hAbwZymf2+s37EdO1MwSiFUps+HmGIonM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hlyf3B/3jW5Fjj/XlutaeoqUTgnIkcJz3K27C+78KPSM6jFqxqPDR9YGni1RNxw0j
	 S30K8I0anbPyx6df5YR3YefCl3DsNcJ5zbxgF0Qu8QYhiY/grpLHJj7C8VDLAVzves
	 O2vlOKRNf+VQjYIgL3rpiRYyUO8lHQestRe3ATr8=
Date: Fri, 2 Oct 2026 07:55:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: arc_uart: Use platform IRQ helper
Message-ID: <2026100211-unturned-scam-fd80@gregkh>
References: <20260925183050.56839-1-rosenp@gmail.com>
 <2026100129-unrest-cleaver-6528@gregkh>
 <CAKxU2N8Z-CSxki5mWQvJCEiQDmy00WLJqPEMgujOA0LQzbHHjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8Z-CSxki5mWQvJCEiQDmy00WLJqPEMgujOA0LQzbHHjw@mail.gmail.com>

On Thu, Oct 01, 2026 at 11:58:05AM -0700, Rosen Penev wrote:
> On Thu, Oct 1, 2026 at 1:42 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Sep 25, 2026 at 11:30:50AM -0700, Rosen Penev wrote:
> > > Avoid calling irq_dispose_mapping() by letting the platform_device
> > > machinery handle it. Also enable possibility of handling -EPROBE_DEFER
> > > and other errors. Handle as early as possible to avoid doing unnecessary
> > > work.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/tty/serial/arc_uart.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
> > > index 3988e5958896..b46b057a181b 100644
> > > --- a/drivers/tty/serial/arc_uart.c
> > > +++ b/drivers/tty/serial/arc_uart.c
> > > @@ -30,7 +30,6 @@
> > >  #include <linux/tty_flip.h>
> > >  #include <linux/serial_core.h>
> > >  #include <linux/io.h>
> > > -#include <linux/of_irq.h>
> > >  #include <linux/of_address.h>
> > >
> > >  /*************************************
> > > @@ -571,12 +570,17 @@ static int arc_serial_probe(struct platform_device *pdev)
> > >       struct arc_uart_port *uart;
> > >       struct uart_port *port;
> > >       int dev_id;
> > > +     int irq;
> > >       u32 val;
> > >
> > >       /* no device tree device */
> > >       if (!np)
> > >               return -ENODEV;
> > >
> > > +     irq = platform_get_irq(pdev, 0);
> > > +     if (irq < 0)
> > > +             return irq;
> > > +
> > >       dev_id = of_alias_get_id(np, "serial");
> > >       if (dev_id < 0)
> > >               dev_id = 0;
> > > @@ -607,7 +611,7 @@ static int arc_serial_probe(struct platform_device *pdev)
> > >               return PTR_ERR(port->membase);
> > >       }
> > >
> > > -     port->irq = irq_of_parse_and_map(np, 0);
> > > +     port->irq = irq;
> > >
> > >       port->dev = &pdev->dev;
> > >       port->iotype = UPIO_MEM;
> > > --
> > > 2.55.0
> > >
> > >
> >
> > You forgot an Assisted-by: tag here :(
> No LLM used here.

Then what tool was used to find this issue?

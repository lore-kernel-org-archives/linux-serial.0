Return-Path: <SRS0=RakX=7L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7C2C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 17:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13B820707
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 17:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJJA9uvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2RKj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 May 2020 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgE2RKi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 May 2020 13:10:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7936AC03E969;
        Fri, 29 May 2020 10:10:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so2767322ejr.9;
        Fri, 29 May 2020 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WDKIKX1lbJucTTgJr5+MTkahkiaPobMxaKnS1Wdvl/c=;
        b=oJJA9uvozHW0ofiymw21F8d1PYu2PWYbNXATWv2Cma0j7/VjXp6mi1yS0jKvwr3kED
         zUZweQgWNosYY5HQrBS1mNWkVZcvstkkUutLLm6G2+qzUHx1wpM1JTOLQ/iFRc1vetix
         izmUASDNm51tZW2QK7UhSQfiZVurM2MjYVabi30WhmkqeHzJHNl5QgPcRA1x+/oOCjSW
         RF39a33sE/lbKpj1ABUUUAnbiAm/2e2RaGa/hfSb4bRxHehLDY9Kdq9A1munTtMaSbw0
         bI96rsrrKCRD7xTqf4WIdWFfNF/tGKZ7iKfWNFnu+tlX9M7vjGA4Q5/8cmPYnbiSh8l1
         qRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WDKIKX1lbJucTTgJr5+MTkahkiaPobMxaKnS1Wdvl/c=;
        b=QUw9mTNHx+b2NL/rb1Ftq8B/Vwl4yFk8yD5XfNqk+PKjD047stHtLx8dZCOW8HiCJu
         IIkrDgQzSTUGNkIjYdwwY8iohfczb2UYW7AMvtzwWJwfTi/OTM2THBRz6pngZt5E8c7h
         6LHpSzllNx3NpOYMZqrksW8lhrZxGBJAdE2DYQngVjj8dJJfhVTp9NKWp4S4wbS6kQ0C
         4c8/xEYsvFZByPfWnjmg/7Ye61rsaDeSSmoYZU5KtlsSwTra5z+h1z14ouDcKHnvDMDT
         ejP4jf0ZylYBmNP/dyWp/AOepMhqyZVx/k2ro3u8QcPu74sYHbXWBTjj6UeuaehWAmFg
         1y7g==
X-Gm-Message-State: AOAM531NSac7MgqLfYPz/fJ3L/LmLcNDfksT6aKt08bdhQee4ak5R4V6
        v8KWRlJuPaQQKi/egBX96yHpWbF0AL4=
X-Google-Smtp-Source: ABdhPJw6wUAlq2Fosg/mAumHMUr0rJcmxqFtd4b6i9qv98juDHBgQYVuNyHFlfQU7csJJhx0XejmRA==
X-Received: by 2002:a17:906:2c07:: with SMTP id e7mr8620770ejh.172.1590772237131;
        Fri, 29 May 2020 10:10:37 -0700 (PDT)
Received: from BV030612LT ([188.27.38.213])
        by smtp.gmail.com with ESMTPSA id s2sm7740809ejm.50.2020.05.29.10.10.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 10:10:35 -0700 (PDT)
Date:   Fri, 29 May 2020 20:10:32 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH 1/1] tty: serial: owl: Add support for kernel debugger
Message-ID: <20200529171032.GA26724@BV030612LT>
References: <6ee88060c129715980592a1ae33c93923916a14b.1590766726.git.cristian.ciocaltea@gmail.com>
 <16ff435f-9172-e01d-dfe6-7aa8575c4bd6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16ff435f-9172-e01d-dfe6-7aa8575c4bd6@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 29, 2020 at 05:56:47PM +0200, Andreas Färber wrote:
> Hi,
> 
> Am 29.05.20 um 17:50 schrieb Cristian Ciocaltea:
> > Implement poll_put_char and poll_get_char callbacks in struct uart_ops
> > that enables OWL UART to be used for KGDB debugging over serial line.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >   drivers/tty/serial/owl-uart.c | 45 ++++++++++++++++++++++++++++++-----
> >   1 file changed, 39 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
> > index c2fa2f15d50a..26dcc374dec5 100644
> > --- a/drivers/tty/serial/owl-uart.c
> > +++ b/drivers/tty/serial/owl-uart.c
> > @@ -12,6 +12,7 @@
> >   #include <linux/console.h>
> >   #include <linux/delay.h>
> >   #include <linux/io.h>
> > +#include <linux/iopoll.h>
> >   #include <linux/module.h>
> >   #include <linux/of.h>
> >   #include <linux/platform_device.h>
> > @@ -20,13 +21,13 @@
> >   #include <linux/tty.h>
> >   #include <linux/tty_flip.h>
> > -#define OWL_UART_PORT_NUM 7
> > -#define OWL_UART_DEV_NAME "ttyOWL"
> > +#define OWL_UART_PORT_NUM		7
> > +#define OWL_UART_DEV_NAME		"ttyOWL"
> > -#define OWL_UART_CTL	0x000
> > -#define OWL_UART_RXDAT	0x004
> > -#define OWL_UART_TXDAT	0x008
> > -#define OWL_UART_STAT	0x00c
> > +#define OWL_UART_CTL			0x000
> > +#define OWL_UART_RXDAT			0x004
> > +#define OWL_UART_TXDAT			0x008
> > +#define OWL_UART_STAT			0x00c
> 
> Please do not unnecessarily re-indent kernel code. You can do so when you're
> actually adding something new.
> 

Hi Andreas,

Thank you for reviewing!

Sure, I will revert unnecessary changes.

>
> >   #define OWL_UART_CTL_DWLS_MASK		GENMASK(1, 0)
> >   #define OWL_UART_CTL_DWLS_5BITS		(0x0 << 0)
> > @@ -461,6 +462,34 @@ static void owl_uart_config_port(struct uart_port *port, int flags)
> >   	}
> >   }
> > +#ifdef CONFIG_CONSOLE_POLL
> > +
> > +static int owl_uart_poll_get_char(struct uart_port *port)
> > +{
> > +	u32 c = NO_POLL_CHAR;
> > +
> > +	if (!(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_RFEM))
> > +		c = owl_uart_read(port, OWL_UART_RXDAT);
> > +
> > +	return c;
> > +}
> > +
> > +static void owl_uart_poll_put_char(struct uart_port *port, unsigned char c)
> > +{
> > +	/* Wait while TX FIFO is full */
> > +	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)
> > +		cpu_relax();
> > +
> > +	/* Send the character out */
> > +	owl_uart_write(port, c, OWL_UART_TXDAT);
> > +
> > +	/* Wait for transmitter to become empty */
> > +	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TRFL_MASK)
> > +		cpu_relax();
> > +}
> 
> How is this different from earlycon? I dislike that this is being
> open-coded. Please try to reuse existing functions for this.
>

I actually tried initially to reuse the existing code, but I found
a few (possible) issues:

- owl_uart_port_write() does more things than I think it's really
needed here, i.e. I'm not sure if the locking stuff and the IRQ
setup are required. From what I've noticed, most serial drivers provide
a very simple implementation (and lock free) for the callbacks, but
I couldn't figure out if locking could be required in some
circumstances.

- owl_console_putchar() could be a better alternative, but it depends
on CONFIG_SERIAL_OWL_CONSOLE which might not be enabled if the user
only chooses CONFIG_KGDB_SERIAL_CONSOLE, although this is probably
not a valid scenario.

Kind regards,
Cristi

> 
> Regards,
> Andreas
> 
> > +
> > +#endif /* CONFIG_CONSOLE_POLL */
> > +
> >   static const struct uart_ops owl_uart_ops = {
> >   	.set_mctrl = owl_uart_set_mctrl,
> >   	.get_mctrl = owl_uart_get_mctrl,
> > @@ -476,6 +505,10 @@ static const struct uart_ops owl_uart_ops = {
> >   	.request_port = owl_uart_request_port,
> >   	.release_port = owl_uart_release_port,
> >   	.verify_port = owl_uart_verify_port,
> > +#ifdef CONFIG_CONSOLE_POLL
> > +	.poll_get_char	= owl_uart_poll_get_char,
> > +	.poll_put_char	= owl_uart_poll_put_char,
> > +#endif
> >   };
> >   #ifdef CONFIG_SERIAL_OWL_CONSOLE
> > 
> 
> 
> -- 
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer
> HRB 36809 (AG Nürnberg)

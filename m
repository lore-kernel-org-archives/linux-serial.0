From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Pericom PCIe Serial board Support (12d8:7952/4/8) - Chip
 PI7C9X7952/4/8
Date: Tue, 15 Oct 2013 10:28:01 -0700
Message-ID: <20131015172801.GA27279@kroah.com>
References: <CAO5Y4f2pszuzTYewAwzJ91BHeoNeSJsMynscyY7CjFTspeaYzg@mail.gmail.com>
 <CAO5Y4f0jtcZP2ScWxt2X7On3W1PzuvZnMG3+2uZ5puvrFbmMvA@mail.gmail.com>
 <20131015140903.GA20755@kroah.com>
 <CAO5Y4f1Em-WG9Yk41OUmJQCdZo2N=eDXK+R+wq0K4BxoNGoaug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51673 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933002Ab3JOR2C (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 13:28:02 -0400
Content-Disposition: inline
In-Reply-To: <CAO5Y4f1Em-WG9Yk41OUmJQCdZo2N=eDXK+R+wq0K4BxoNGoaug@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Angelo Butti <buttiangelo@gmail.com>
Cc: linux-serial@vger.kernel.org

On Tue, Oct 15, 2013 at 07:20:18PM +0200, Angelo Butti wrote:
> I'm really sorry for my mistake.

No worries, but your email client turned all tabs into spaces, and made
the patch imposible to apply :(

> Also, maybe that there is a simple way to change the clock without
> rewrite the standard serial setup procedure, but I cannot find it ....
> Below the correct one:
> 
> --- linux-3.10.11-200.fc19.i686/drivers/tty/serial/8250/8250_pci.c.orig
> 2013-09-16 20:13:52.918548000 +0300
> +++ linux-3.10.11-200.fc19.i686/drivers/tty/serial/8250/8250_pci.c
> 2013-10-15 16:20:18.566685996 +0300
> @@ -1308,6 +1308,29 @@ static int pci_default_setup(struct seri
>   return setup_port(priv, port, bar, offset, board->reg_shift);
>  }
> 
> +static int pci_pericom_setup(struct serial_private *priv,
> +  const struct pciserial_board *board,
> +  struct uart_8250_port *port, int idx)

See?

Also, we need a "Signed-off-by:" line as per the instructions in the
Documentation/SubmittingPatches file (take a look at it for what that
means.)

Care to try again?

thanks,

greg k-h

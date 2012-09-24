From: Sean Young <sean@mess.org>
Subject: Re: [PATCH v3 0/2] winbond-cir: Fix initialization
Date: Mon, 24 Sep 2012 10:53:02 +0100
Message-ID: <20120924095301.GA9201@pequod.mess.org>
References: <cover.1347029782.git.sean@mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pequod.mess.org ([93.97.41.153]:52294 "EHLO pequod.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298Ab2IXJxE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Sep 2012 05:53:04 -0400
Content-Disposition: inline
In-Reply-To: <cover.1347029782.git.sean@mess.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>, Mauro Carvalho Chehab <mchehab@redhat.com>

Hi Alan,

On Fri, Sep 07, 2012 at 07:06:22PM +0100, Sean Young wrote:
> The serial driver will detect the winbond cir device as a serial port,
> since it looks exactly like a serial port unless you know what it is
> from the PNP ID.
> 
> v2:
> Alan Cox pointed out[1] that the pnp serial probe should be done before
> the legacy probe and we should keep track of any IR ports during the
> pnp scan. This is an implementation of that idea.
> 
> [1] http://www.spinics.net/lists/linux-serial/msg06757.html
> 
> v3:
>  - Removed IrDA entries
>  - Renamed PORT_IR to PORT_8250_CIR
>  - commit message rewording

It's been more than two weeks. Do you have any review comments? It
would be great to have this in 3.7.

Thanks
Sean

> Diffed against tty-next.
> 
> Sean Young (2):
>   8250_pnp: do pnp probe before legacy probe
>   8250: blacklist Winbond CIR port
> 
>  drivers/tty/serial/8250/8250.c     |   47 ++++++++++++++++++++++++-----------
>  drivers/tty/serial/8250/8250.h     |    9 +++++++
>  drivers/tty/serial/8250/8250_pnp.c |   31 +++++++++++++----------
>  drivers/tty/serial/8250/Kconfig    |   16 ++++++------
>  drivers/tty/serial/8250/Makefile   |    5 ++-
>  include/linux/serial_core.h        |    3 +-
>  6 files changed, 72 insertions(+), 39 deletions(-)
> 
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct
 accessors
Date: Mon, 13 Jun 2011 10:19:26 +0100
Message-ID: <20110613091926.GB2472@pulham.picochip.com>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
 <20110610035817.GA6740@linux-mips.org>
 <20110610075426.GM3711@pulham.picochip.com>
 <20110610145724.1e0c0983@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:39655 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab1FMJTb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Jun 2011 05:19:31 -0400
Received: by wwk4 with SMTP id 4so2404914wwk.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Jun 2011 02:19:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110610145724.1e0c0983@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Jamie Iles <jamie@jamieiles.com>, Ralf Baechle <ralf@linux-mips.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org, Marc St-Jean <bluezzer@gmail.com>, Shane McDonald <mcdonald.shane@gmail.com>, Anoop P A <anoop.pa@gmail.com>

On Fri, Jun 10, 2011 at 02:57:24PM +0100, Alan Cox wrote:
> > I found this series from Alan 
> > (http://www.spinics.net/lists/linux-serial/msg03484.html) which looks 
> > like it would do the job if we added the extra irq callback.  Ideally
> > we just remove both of the UPIO_DWAPB and UPIO_DWAPB32 and let the
> > platform specify the ops.
> 
> I've not yet had time to go back and revisit those patches and debug
> them so they actually work but as and when someone gets time I think
> it's the right basic path to follow, and the irq callback looks
> sensible too.

As an intermediate step, how about adding the irq callback to 
uart_8250_port and removing UPIO_DWAPB and UPIO_DWAPB32 from the driver?  

Jamie

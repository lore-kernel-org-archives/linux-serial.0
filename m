From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM63xx: Add serial driver for bcm63xx
	integrated UART.
Date: Wed, 23 Sep 2009 10:28:00 +0100
Message-ID: <20090923092800.GE5457@linux-mips.org>
References: <1253271898.1627.272.camel@sakura.staff.proxad.net> <20090918145715.GB8884@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57502 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbZIWJ0r (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Sep 2009 05:26:47 -0400
Content-Disposition: inline
In-Reply-To: <20090918145715.GB8884@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Maxime Bizon <mbizon@freebox.fr>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org

On Fri, Sep 18, 2009 at 07:57:15AM -0700, Greg KH wrote:

> > This is a serial driver for the bcm63xx mips SOCs, it was already posted
> > twice:
> > 
> > one year ago: http://marc.info/?l=linux-serial&m=122438266322439&w=2
> > three months ago: http://lkml.org/lkml/2009/7/1/370
> > 
> > but got no review or ack.
> > 
> > 
> > Linus merged the SOC support patch from Ralf tree yesterday, but without
> > serial support.
> > 
> > Could you please have a look at it ? Is it ok if it goes upstream
> > through Ralf tree ?
> 
> I have no objection for this to go through Ralf's tree.  Or if he needs
> it to go through mine, just let me know.
> 
> > Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Thanks, merged.  Will go to Linus asap.

  Ralf

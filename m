From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct
 accessors
Date: Fri, 10 Jun 2011 14:57:24 +0100
Message-ID: <20110610145724.1e0c0983@bob.linux.org.uk>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
	<20110610035817.GA6740@linux-mips.org>
	<20110610075426.GM3711@pulham.picochip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34376 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932238Ab1FJN71 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Jun 2011 09:59:27 -0400
In-Reply-To: <20110610075426.GM3711@pulham.picochip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org, Marc St-Jean <bluezzer@gmail.com>, Shane McDonald <mcdonald.shane@gmail.com>, Anoop P A <anoop.pa@gmail.com>

> I found this series from Alan 
> (http://www.spinics.net/lists/linux-serial/msg03484.html) which looks 
> like it would do the job if we added the extra irq callback.  Ideally
> we just remove both of the UPIO_DWAPB and UPIO_DWAPB32 and let the
> platform specify the ops.

I've not yet had time to go back and revisit those patches and debug
them so they actually work but as and when someone gets time I think
it's the right basic path to follow, and the irq callback looks
sensible too.

Ultimately yes I'd also like to see all board specific ops banished
from 8250.c

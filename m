From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v3 0/2] winbond-cir: Fix initialization
Date: Mon, 24 Sep 2012 14:18:51 +0100
Message-ID: <20120924141851.156b6099@bob.linux.org.uk>
References: <cover.1347029782.git.sean@mess.org>
	<20120924095301.GA9201@pequod.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:6959 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291Ab2IXNR2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Sep 2012 09:17:28 -0400
In-Reply-To: <20120924095301.GA9201@pequod.mess.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, David =?UTF-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>, Mauro Carvalho Chehab <mchehab@redhat.com>

> > 
> > [1] http://www.spinics.net/lists/linux-serial/msg06757.html
> > 
> > v3:
> >  - Removed IrDA entries
> >  - Renamed PORT_IR to PORT_8250_CIR
> >  - commit message rewording
> 
> It's been more than two weeks. Do you have any review comments? It
> would be great to have this in 3.7.

Agreed - I'd been trying to see if there was a nicer way to split the
PnP and non PnP stuff cleanly but no inspiration has appeared

Acked-by: Alan Cox <alan@linux.intel.com>


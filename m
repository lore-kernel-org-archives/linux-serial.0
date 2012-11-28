From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 5/5] serial: 8250_dw: Set FIFO size dynamically
Date: Wed, 28 Nov 2012 15:37:04 +0200
Message-ID: <20121128133704.GB14698@as23.pp.htv.fi>
References: <1354106924-11013-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1354106924-11013-6-git-send-email-heikki.krogerus@linux.intel.com>
 <20121128131826.38391319@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:42521 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab2K1NhI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Nov 2012 08:37:08 -0500
Content-Disposition: inline
In-Reply-To: <20121128131826.38391319@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, Nov 28, 2012 at 01:18:26PM +0000, Alan Cox wrote:
> > +	if (!reg || (reg & 0xff) != '*')
> > +		return;
> > +
> 
> That looks bogus. If reg == 0 then reg & 0xFF != '*'
> 
> So why the double test ?

No reason. It is something I forgot to cleanup. I'll resend this.

Thanks!

-- 
heikki

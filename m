From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: uart: add hw flow control support configuration
Date: Thu, 24 Apr 2014 16:30:27 -0700
Message-ID: <20140424233027.GA21443@kroah.com>
References: <1397243877-23234-1-git-send-email-m-karicheri2@ti.com>
 <3E54258959B69E4282D79E01AB1F32B70471B198@DFLE11.ent.ti.com>
 <20140423152717.7100f604@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40455 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbaDXX1e (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Apr 2014 19:27:34 -0400
Content-Disposition: inline
In-Reply-To: <20140423152717.7100f604@alan.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "Karicheri, Muralidharan" <m-karicheri2@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Jiri Slaby <jslaby@suse.cz>

On Wed, Apr 23, 2014 at 03:27:17PM +0100, One Thousand Gnomes wrote:
> > >-	if (up->capabilities & UART_CAP_AFE && port->fifosize >= 32) {
> > >+	if ((up->capabilities & UART_CAP_AFE && (port->fifosize >= 32)) ||
> > >+	    port->flags & UPF_HARD_FLOW) {
> > 
> > [Alan] Surely you want brackets on the port->flags & UPF_HARD_FLOW ??
> > 
> > The C precedence table shows following order:=
> > -> & ||
> > 
> > So flags will be accessed first and then AND-ed with  UPF_HARD_FLOW and
> > result will be OR-ed with left side expression value. So no need for bracket IMO.
> 
> Yep... agreed.

Perhaps, but please put them there so we all _know_ what it is doing is
correct.

greg k-h

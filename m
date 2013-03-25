From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 3/3] serial: of_serial: Handle hw-flow-control property
Date: Mon, 25 Mar 2013 14:57:57 +0200
Message-ID: <20130325125757.GA2847@xps8300>
References: <1364211286-31611-1-git-send-email-heikki.krogerus@linux.intel.com>
 <201303251140.31866.arnd@arndb.de>
 <20130325122851.GB20052@xps8300>
 <201303251247.58823.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17954 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757383Ab3CYM6B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Mar 2013 08:58:01 -0400
Content-Disposition: inline
In-Reply-To: <201303251247.58823.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ley Foon Tan <lftan@altera.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, Mar 25, 2013 at 12:47:58PM +0000, Arnd Bergmann wrote:
> On Monday 25 March 2013, Heikki Krogerus wrote:
> > On Mon, Mar 25, 2013 at 11:40:31AM +0000, Arnd Bergmann wrote:
> > > On Monday 25 March 2013, Heikki Krogerus wrote:
> > > > This will add support for hardware flow control. It is
> > > > limited to be used only with 8250 driver.
> > > > 
> > > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > 
> > > Does this imply that we can use hardware flow control only when this
> > > flag is set in the device tree? I assumed that working flow control
> > > would be the default. Is it not?
> > 
> > OK, the commit message is wrong. Is the patch otherwise OK?
> 
> I still find the text in the binding and the name of the property confusing,
> because it seems to imply that you have no hardware flow control without this.
> I think what you mean here is really "automatic flow control" rather than
> "hardware flow control".

Ah, I understand. I'll change the property name to auto-flow-control.

-- 
heikki

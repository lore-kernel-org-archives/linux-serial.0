From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 2/2] serial: of_serial: Handle fifosize property
Date: Fri, 22 Mar 2013 09:41:54 +0200
Message-ID: <20130322074154.GA9250@xps8300>
References: <20130321104651.GC2862@xps8300>
 <1363862880-17295-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1363866099.2289.8.camel@leyfoon-vm>
 <20130321132415.GA2902@xps8300>
 <1363923138.2289.14.camel@leyfoon-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47449 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab3CVHmA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Mar 2013 03:42:00 -0400
Content-Disposition: inline
In-Reply-To: <1363923138.2289.14.camel@leyfoon-vm>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Mar 22, 2013 at 11:32:18AM +0800, Ley Foon Tan wrote:
> On Thu, 2013-03-21 at 15:24 +0200, Heikki Krogerus wrote:
> > On Thu, Mar 21, 2013 at 07:41:39PM +0800, Ley Foon Tan wrote:
> > > Suggest to use "fifo-size" for the device tree property, to align with
> > > other DT properties.
> > 
> > I was going to, but then I noticed that in some .dtsi files "fifosize"
> > is used with uarts. Should I still change it?
> I just make the grep for "fifosize" in arch/. It is used by other serial
> drivers (not of_serial.c). So, you are safe to change it to "fifo-size".

OK, I'll change it.

Thanks!

-- 
heikki

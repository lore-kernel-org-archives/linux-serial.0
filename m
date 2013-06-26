From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/8] pch_uart: Add uart_clk selection for the MinnowBoard
Date: Tue, 25 Jun 2013 21:16:21 -0700
Message-ID: <20130626041621.GA12612@kroah.com>
References: <cover.1372211451.git.dvhart@linux.intel.com>
 <6cc125b9eb85dd3cae4a2496fdb7f0d17b18f930.1372211451.git.dvhart@linux.intel.com>
 <20130626023143.GB23320@kroah.com>
 <1372216578.8177.9.camel@envy.home>
 <20130626033926.GA27165@kroah.com>
 <1372219125.8177.12.camel@envy.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1372219125.8177.12.camel@envy.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, peter.p.waskiewicz.jr@intel.com, andriy.shevchenko@linux.intel.com, danders@circuitco.com, vishal.l.verma@intel.com, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 25, 2013 at 08:58:45PM -0700, Darren Hart wrote:
> > How about this, which makes it easy to backport, then you fix it up
> > properly for 3.12?  This comes after my tree is pretty much closed for
> > 3.11, but a simple device id addition like this is acceptable, but I'll
> > not get to it until after 3.11-rc1 is out...
> 
> Sure. So something like this is what you have in mind? Build tested
> only, I'll include it in V2 with proper testing, but just wanted to
> make sure we're on the same page while I have your attention:

Yes, that patch looks good to me, and it makes it easier to add new
devices later as well.

thanks,

greg k-h

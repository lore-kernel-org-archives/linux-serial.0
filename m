From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Re: [PATCH v3] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Date: Thu, 11 Jul 2019 18:21:44 +0200
Message-ID: <20190711162144.GA588@kroah.com>
References: <20190705083349.44047-1-je.yen.tam@ni.com>
 <20190705090422.GA32289@kroah.com>
 <MN2PR04MB592075355D90BC59B79DFCF8B7F50@MN2PR04MB5920.namprd04.prod.outlook.com>
 <MN2PR04MB59207F479D213EE19333CA6AB7F30@MN2PR04MB5920.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <MN2PR04MB59207F479D213EE19333CA6AB7F30@MN2PR04MB5920.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Je Yen Tam <je.yen.tam@ni.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 11, 2019 at 04:01:28PM +0000, Je Yen Tam wrote:
> > > On Fri, Jul 05, 2019 at 01:33:49AM -0700, jeyentam wrote:
> > > > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> > > >
> > > > Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_pci.c | 298 ++++++++++++++++++++++++++++-
> > > >  1 file changed, 294 insertions(+), 4 deletions(-)
> > >
> > > What changed from the previous versions?
> > >
> > > Always put that below the --- line.
> > >
> > > Please fix up and send a v4 with that information.
> >
> > Ok, will do so.
> 
> Hi, please be noted that a v4 is submitted and ready for review.

It is the middle of the merge window.  I can't do anything with any
patches until after 5.3-rc1 is out, and then, give me a few weeks to
catch up on the pending backlog.

thanks,

greg k-h

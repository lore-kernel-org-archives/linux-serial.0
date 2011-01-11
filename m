From: "Lee Howard" <lee.howard@mainpine.com>
Subject: RE: Mainpine IQ Express Rev3 problems beginning 2.6.36
Date: Tue, 11 Jan 2011 11:16:06 -0800
Message-ID: <687E92CB36AA40FC9ABC8B0E23843D36@callisto>
References: <4D001AF1.80902@mainpine.com> <20101209064259.GA10714@kroah.com> <9BEA64D1D71A4BCFA22E0ECE7A4B3A01@callisto> <20101212165201.GB14184@kroah.com> <E2D1FFBE046E485284F82CC8135FD901@callisto> <64E919E148714BFCB46D62A05E9EF13D@callisto> <20110111000231.GA30424@kroah.com>
Reply-To: <lee.howard@mainpine.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pandora.howardsilvan.com ([216.235.106.114]:37263 "EHLO
	mail.mainpine.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756147Ab1AKTQF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Jan 2011 14:16:05 -0500
In-Reply-To: <20110111000231.GA30424@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg KH' <greg@kroah.com>
Cc: linux-serial@vger.kernel.org


> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> Sent: Monday, January 10, 2011 4:03 PM
> To: Lee Howard
> Cc: linux-serial@vger.kernel.org
> Subject: Re: Mainpine IQ Express Rev3 problems beginning 2.6.36
> 
> On Fri, Dec 17, 2010 at 05:25:19AM -0800, Lee Howard wrote:
> > > -----Original Message-----
> > > From: linux-serial-owner@vger.kernel.org
> > > [mailto:linux-serial-owner@vger.kernel.org] On Behalf Of 
> Lee Howard
> > > Sent: Tuesday, December 14, 2010 11:50 AM
> > > To: 'Greg KH'
> > > Cc: linux-serial@vger.kernel.org
> > > Subject: RE: Mainpine IQ Express Rev3 problems beginning 2.6.36
> > > 
> > > > -----Original Message-----
> > > > From: Greg KH [mailto:greg@kroah.com]
> > > > Sent: Sunday, December 12, 2010 8:52 AM
> > > 
> > > > As for build issues, try to make a minimal working 
> config for your 
> > > > system, using 'make localmodconfig'.  That will speed up your 
> > > > build time immensely as well as reduce your chances of 
> build and 
> > > > runtime problems with the intermediate kernels.
> > > 
> > > Thank-you, that did help immensely.
> > > 
> > > Here's the 'git bisect' result...
> > > 
> > > --------------
> > > 7a56aa45982bb87bfca98a2832b5ae782c03364a is the first bad commit 
> > > commit 7a56aa45982bb87bfca98a2832b5ae782c03364a
> > > Author: Yegor Yefremov <yegor_sub1@visionsystems.de>
> > > Date:   Wed Jun 16 16:29:55 2010 +0200
> > > 
> > >     serial: add UART_CAP_EFR and UART_CAP_SLEEP flags to 16C950 
> > > UARTs definition
> > >     
> > >     Adding UART_CAP_EFR and UART_CAP_SLEEP flags will 
> enable sleep 
> > > mode
> > >     and automatic CTS flow control for 16C950 UARTs. It will also 
> > > avoid
> > >     capabilities detection warning like this:
> > >     
> > >     "ttyS0: detected caps 00000700 should be 00000100"
> > >     
> > >     Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> > >     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > > 
> > > :040000 040000 1776ca8d5c653834363c0778b5b404ee52bd2d69
> > > b81cfe4f302a674935181bd248641873820517e5 M      drivers
> > > --------------
> > > 
> > > Indeed, if I remove the UART_CAP_EFR flag from later kernel 
> > > revisions there is no problem.
> > 
> > Greg,
> > 
> > What's to be done?
> 
> Sorry for the delay, I think Pavel's posted patch will solve 
> this issue for you, right?

I've looked in the linux-serial archives for posts by Pavel for the last
month, but I don't see a patch.  Please tell me where I can find this patch.

Thanks,

Lee.


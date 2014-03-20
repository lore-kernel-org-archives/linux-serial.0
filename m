From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: hci_ldsic nested locking problem
Date: Thu, 20 Mar 2014 11:45:44 -0700
Message-ID: <20140320184544.GA1113@kroah.com>
References: <20140320163435.GH32692@saruman.home>
 <1395333736.22077.32.camel@acox1-desk.ger.corp.intel.com>
 <20140320171621.GA2827@saruman.home>
 <20140320172920.GC2827@saruman.home>
 <532B26C1.8080806@hurleysoftware.com>
 <20140320173518.GD2827@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140320173518.GD2827-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Muralidharan Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 20, 2014 at 12:35:18PM -0500, Felipe Balbi wrote:
> On Thu, Mar 20, 2014 at 01:34:57PM -0400, Peter Hurley wrote:
> > [ +cc Huang Shijie ]
> > 
> > On 03/20/2014 01:29 PM, Felipe Balbi wrote:
> > >then we need updates to Documentation:
> > >
> > >Documentation/serial/tty.txt::
> > >
> > >|  Driver Side Interfaces:
> > >|
> > >|  receive_buf()	-	Hand buffers of bytes from the driver to the ldisc
> > >|  			for processing. Semantics currently rather
> > >|  			mysterious 8(
> > >|
> > >|  write_wakeup()	-	May be called at any point between open and close.
> > >|  			The TTY_DO_WRITE_WAKEUP flag indicates if a call
> > >|  			is needed but always races versus calls. Thus the
> > >|  			ldisc must be careful about setting order and to
> > >|  			handle unexpected calls. Must not sleep.
> > >|
> > >|  			The driver is forbidden from calling this directly
> > >|  			from the ->write call from the ldisc as the ldisc
> > >|  			is permitted to call the driver write method from
> > >|  			this function. In such a situation defer it.
> > >
> > >documentation says ldisc is allowed to call ->write() from
> > >->write_wakeup(). huh ?
> > 
> > Patch submitted but never applied.
> > 
> > http://www.spinics.net/lists/linux-serial/msg11144.html
> 
> Thank you. For that patch:
> 
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Can someone resend it, this is lost in my tree for some reason...

From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] tty: Re-add external interface for tty_set_termios()
Date: Tue, 21 Apr 2015 11:06:40 +0200
Message-ID: <20150421090640.GB1569@kroah.com>
References: <1428671585-13310-1-git-send-email-frederic.danis@linux.intel.com>
 <5527CEFB.5070406@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5527CEFB.5070406-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 10, 2015 at 09:24:11AM -0400, Peter Hurley wrote:
> On 04/10/2015 09:13 AM, Frederic Danis wrote:
> > This is needed by Bluetooth hci_uart module to be able to change speed
> > of Bluetooth controller and local UART.
> 
> Because this is the lesser evil right now,
> 
> Reviewed-by: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>

Does this need to be in 4.1-rc1?  Or is this a 4.2 thing?

thanks,

greg k-h

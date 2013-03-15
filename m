From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] tty: atmel_serial_probe(): index of atmel_ports[] fix
Date: Fri, 15 Mar 2013 07:58:44 -0700
Message-ID: <20130315145844.GA30916@kroah.com>
References: <1361377580-10437-1-git-send-email-wpawel@gmail.com>
 <514331F6.6070204@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <514331F6.6070204@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Pawel Wieczorkiewicz <wpawel@gmail.com>, jslaby@suse.cz, grant.likely@secretlab.ca, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 15, 2013 at 03:36:38PM +0100, Nicolas Ferre wrote:
> On 02/20/2013 05:26 PM, Pawel Wieczorkiewicz :
> > From: Pawel Wieczorkiewicz <wpawel@gmail.com>
> > 
> > Index of atmel_ports[ATMEL_MAX_UART] should be smaller
> > than ATMEL_MAX_UART.
> > 
> > Signed-off-by: Pawel Wieczorkiewicz <wpawel@gmail.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> It can be good to include this one in 3.9-rc.
> 
> I also would like to add the "stable" tag to it:
> 
> Cc: stable <stable@vger.kernel.org> # 3.2+
> 
> Greg, can you take this one or do I need to re-send it with appropriate
> "stable" line?

I can add it, thanks.

greg k-h

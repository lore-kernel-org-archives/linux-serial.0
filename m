From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [LINUX PATCHv3 0/9] serial-uartlite: Add support for dynamic
 allocation
Date: Fri, 9 Nov 2018 08:45:49 -0800
Message-ID: <20181109164549.GA28175@kroah.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shubhrajyoti.datta@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jslaby@suse.com, jacmet@sunsite.dk, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 16, 2018 at 03:47:59PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Currently the number of uarts are configured through a Kconfig
> option Make it dynamic.
> While at it adapt to the runtime framework.
> 
> It is based a similar series on the uartps from Michal

I've applied the first 5, can you fix up the rest and resend so that
they do not cause build breakage at any point?

thanks,

greg k-h

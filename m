From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2 1/2] serial: sh-sci: Fix cast warning
Date: Thu, 13 Feb 2014 09:15:40 -0800
Message-ID: <20140213171540.GA29959@kroah.com>
References: <000001cf220d$1fd2ed70$5f78c850$%han@samsung.com>
 <2819790.IHlWH9aZoh@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60829 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbaBMROX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 12:14:23 -0500
Content-Disposition: inline
In-Reply-To: <2819790.IHlWH9aZoh@avalon>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jingoo Han <jg1.han@samsung.com>, 'Simon Horman' <horms+renesas@verge.net.au>, linux-serial@vger.kernel.org

On Mon, Feb 10, 2014 at 02:15:23PM +0100, Laurent Pinchart wrote:
> Hi Jingoo,
> 
> Thank you for the patch.
> 
> On Wednesday 05 February 2014 09:56:37 Jingoo Han wrote:
> > Fix the following compile warning about cast to pointer from
> > integer of different size.
> > 
> > drivers/tty/serial/sh-sci.c:2021:19: warning: cast to pointer from integer
> > of different size [-Wint-to-pointer-cast]
> > 
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Simon, Greg, how do you plan to handle sh-sci patches for v3.15 ?

This is just a serial driver patch, I'll take it.

thanks,

greg k-h

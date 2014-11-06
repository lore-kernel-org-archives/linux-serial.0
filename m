From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 01/11] serial_core: Handle TIOC[GS]RS485 ioctls.
Date: Thu, 6 Nov 2014 15:02:42 -0800
Message-ID: <20141106230242.GB2770@kroah.com>
References: <1415310374-11648-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55777 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbaKFXCn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 18:02:43 -0500
Content-Disposition: inline
In-Reply-To: <1415310374-11648-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Thu, Nov 06, 2014 at 10:46:13PM +0100, Ricardo Ribalda Delgado wrote:
> The following drivers: 8250_core, atmel_serial, max310x, mcf, omap-serial
> and sci16is7xx implement code to handle RS485 ioctls.
> 
> In order to avoid code duplication, we implement a simple ioctl handler
> on the serial_core layer.
> 
> This handler can be used by all the other drivers instead of duplicating
> code.
> 
> Until this is the only RS485 ioctl handler, it will try first the
> rs485_config callback and if it is not present it will call the driver
> specific ioctl.
> 
> Reviewed-by: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> 
> v3: Fix invalid length on copy_from_user


I've replaced this and the 08 patch you sent in my tree, so all should
be good now, thanks.

greg k-h

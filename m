From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: Fix build failure caused by missing header file
Date: Mon, 25 Aug 2014 13:13:24 -0700
Message-ID: <20140825201324.GA32033@kroah.com>
References: <1408553745-3536-1-git-send-email-bobby.prani@gmail.com>
 <1408553745-3536-2-git-send-email-bobby.prani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33169 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933458AbaHYUOF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Aug 2014 16:14:05 -0400
Content-Disposition: inline
In-Reply-To: <1408553745-3536-2-git-send-email-bobby.prani@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Wed, Aug 20, 2014 at 12:55:45PM -0400, Pranith Kumar wrote:
> Fix build failure caused by missing header file:
> 
> drivers/tty/serial/nwpserial.c: In function 'wait_for_bits':
> drivers/tty/serial/nwpserial.c:53:3: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  drivers/tty/serial/nwpserial.c | 1 +
>  1 file changed, 1 insertion(+)

Where is this failing?  What arch?  What kernel version did it show up
in (i.e. what commit caused this problem?)

thanks,

greg k-h

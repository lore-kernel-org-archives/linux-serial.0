From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: sc16is7xx: remove retval from gpiochip_remove()
Date: Tue, 16 Sep 2014 15:33:00 -0700
Message-ID: <20140916223300.GA14038@kroah.com>
References: <1410905815-22970-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42295 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaIPWdu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Sep 2014 18:33:50 -0400
Content-Disposition: inline
In-Reply-To: <1410905815-22970-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-serial@vger.kernel.org

On Tue, Sep 16, 2014 at 03:16:55PM -0700, Linus Walleij wrote:
> We are trying to smoke out the use of the return value from
> gpiochip_remove() from the kernel, this has been missed.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Greg, can you ACK this so I can merge it into the GPIO tree along
> with the removal of the actual return value.
> ---
>  drivers/tty/serial/sc16is7xx.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

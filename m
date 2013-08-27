From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: ar933x_uart: use the clk API to get the uart clock
Date: Tue, 27 Aug 2013 16:27:07 -0700
Message-ID: <20130827232707.GA10719@kroah.com>
References: <1377634465-8353-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43048 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab3H0XYt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Aug 2013 19:24:49 -0400
Content-Disposition: inline
In-Reply-To: <1377634465-8353-1-git-send-email-juhosg@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-serial@vger.kernel.org

On Tue, Aug 27, 2013 at 10:14:25PM +0200, Gabor Juhos wrote:
> The AR933x UARTs are only used on the Atheros AR933x
> SoCs. The base clock frequency of the UART is passed
> to the driver via platform data. The SoC support code
> implements the generic clock API, and the clock rate
> can be retrieved via that.
> 
> Update the code to get the clock rate via the generic
> clock API instead of using the platform data.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
> Note:
> 
> Because the driver specific platform data only contains
> the clock frequency it can be removed. In order to avoid
> merge conflicts between different trees, it will be removed
> by a later patch once this one is merged upstream.

I don't understand what you mean by this.

Also, this patch doesn't even apply to my tty-next tree, so I can't
accept it as-is, so please fix it up, work with the people whose patches
yours is conflicting with, and figure out how to do this with the least
amount of merge issues.

thanks,

greg k-h

From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] serial/amba-pl011: move custom pin control to driver
Date: Fri, 25 May 2012 14:26:09 +0800
Message-ID: <20120525062606.GF3332@S2101-09.ap.freescale.net>
References: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56905 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab2EYGZe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 May 2012 02:25:34 -0400
Received: by dady13 with SMTP id y13so829070dad.19
        for <linux-serial@vger.kernel.org>; Thu, 24 May 2012 23:25:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>

On Wed, May 23, 2012 at 09:18:46PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> We had a boot regression in Ux500 in the merge window because
> two orthogonal pin control schemes for the PL011 were merged
> at the same time:
> 
> - One using the .init() and .exit() hooks into the platform
>   for Ux500 putting the pins into default vs sleep state
>   respectively as the port was started/stopped.
>   commit a09806607fd20bed2f8c41fe22793386790a14aa
>   "ARM: ux500: switch to using pinctrl for uart0"
> 
> - One hogging the default setting at PL011 probe()
>   commit 258e055111d3cde2607e0d04eb91da2f7a59b591
>   "serial: amba-pl011: adopt pinctrl support"
> 
> To get a solution that works for both let's scrap the stuff
> in the platform callbacks, instead have the driver itself
> select default and sleep states when the port is
> started/stopped. Hopefully this works for all clients.
> Platform callbacks are bad for device tree migration anyway,
> so this rids us of another problem in Ux500.
> 
> Cc: linux-serial@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

On imx28:

Tested-by: Shawn Guo <shawn.guo@linaro.org>

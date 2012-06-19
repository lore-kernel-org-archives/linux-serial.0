From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serial/amba-pl011: use devm_* allocators
Date: Mon, 18 Jun 2012 17:34:27 -0700
Message-ID: <20120619003427.GA3114@kroah.com>
References: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52820 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab2FSAeb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 20:34:31 -0400
Received: by pbbrp8 with SMTP id rp8so8900867pbb.19
        for <linux-serial@vger.kernel.org>; Mon, 18 Jun 2012 17:34:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

On Sun, Jun 17, 2012 at 03:44:08PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This switches a bunch of allocation and remapping to use the
> devm_* garbage collected methods and cleans up the error
> path and remove() paths consequently.
> 
> devm_ioremap() is only in <linux/io.h> so fix up the
> erroneous <asm/*> include as well.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c |   20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 

This patch doesn't apply, what tree did you make it against?

greg k-h

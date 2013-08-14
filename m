From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] serial: sirf: drop redundant
 pinctrl_get_select_default as pinctrl core does it
Date: Wed, 14 Aug 2013 12:11:18 -0700
Message-ID: <20130814191118.GA17612@kroah.com>
References: <1376392697-20664-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53778 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933065Ab3HNTLT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Aug 2013 15:11:19 -0400
Content-Disposition: inline
In-Reply-To: <1376392697-20664-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-serial@vger.kernel.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>, Linus Walleij <linus.walleij@linaro.org>

On Tue, Aug 13, 2013 at 07:18:15PM +0800, Barry Song wrote:
> pinctrl core will get default pinmux, so drop it in the sirfsoc serial driver.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/tty/serial/sirfsoc_uart.c | 12 ------------
>  drivers/tty/serial/sirfsoc_uart.h |  1 -
>  2 files changed, 13 deletions(-)

This patch fails to apply to my tree:

checking file drivers/tty/serial/sirfsoc_uart.c
Hunk #3 FAILED at 917.
Hunk #4 FAILED at 928.
2 out of 4 hunks FAILED
checking file drivers/tty/serial/sirfsoc_uart.h

And as such, I can't take any of the patches in this series :(

Care to redo them against my tty-next branch if you wish to have them
applied?

thanks,

greg k-h

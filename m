From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: Remove old SC26XX driver
Date: Sun, 8 Dec 2013 17:09:52 -0800
Message-ID: <20131209010952.GA30880@kroah.com>
References: <1386084192-24158-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47967 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab3LIIWL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Dec 2013 03:22:11 -0500
Content-Disposition: inline
In-Reply-To: <1386084192-24158-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Tue, Dec 03, 2013 at 07:23:12PM +0400, Alexander Shiyan wrote:
> New driver for NXP (Philips) UART ICs was introduced in September 2012.
> Old driver no longer used anywhere, this patch removes it.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/tty/serial/Kconfig  |  18 --
>  drivers/tty/serial/Makefile |   1 -
>  drivers/tty/serial/sc26xx.c | 749 --------------------------------------------
>  3 files changed, 768 deletions(-)
>  delete mode 100644 drivers/tty/serial/sc26xx.c

This patch doesn't apply to my tree for some reason, can you redo it
against the tty-next branch of the tty.git tree on git.kernel.org and
resend it?

thanks,

greg k-h

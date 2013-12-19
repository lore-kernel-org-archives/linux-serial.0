From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND] serial: Remove old SC26XX driver
Date: Thu, 19 Dec 2013 12:34:55 -0800
Message-ID: <20131219203455.GA18275@kroah.com>
References: <1387483370-15510-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45939 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958Ab3LSUex (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Dec 2013 15:34:53 -0500
Content-Disposition: inline
In-Reply-To: <1387483370-15510-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Fri, Dec 20, 2013 at 12:02:50AM +0400, Alexander Shiyan wrote:
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

This one worked just fine, thanks.

greg k-h

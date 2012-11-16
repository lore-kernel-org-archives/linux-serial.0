From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [tty:tty-next 76/76] drivers/tty/serial/ifx6x60.c:516:2:
 warning: ISO C90 forbids mixed declarations and code
Date: Thu, 15 Nov 2012 18:06:05 -0800
Message-ID: <20121116020605.GA30669@kroah.com>
References: <50a59244.WYf95+M2VB2UsDXN%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63700 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab2KPCGI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 21:06:08 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1508397pad.19
        for <linux-serial@vger.kernel.org>; Thu, 15 Nov 2012 18:06:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50a59244.WYf95+M2VB2UsDXN%fengguang.wu@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Jun Chen <jun.d.chen@intel.com>, linux-serial@vger.kernel.org

On Fri, Nov 16, 2012 at 09:09:24AM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> head:   e8823f1ca8d5a0c5d69a8862682ee8bde26990ca
> commit: e8823f1ca8d5a0c5d69a8862682ee8bde26990ca [76/76] serial: ifx6x60: ifx_spi_write don't need to do mrdy_assert when fifo is not empty
> config: i386-randconfig-b691 (attached as .config)
> 
> All warnings:
> 
> drivers/tty/serial/ifx6x60.c: In function 'ifx_spi_write':
> drivers/tty/serial/ifx6x60.c:516:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]

Ah, missed that one.  Jun, care to send a fix for this?

> drivers/tty/serial/ifx6x60.c: In function 'ifx_spi_complete':
> drivers/tty/serial/ifx6x60.c:726:8: warning: 'more' may be used uninitialized in this function [-Wmaybe-uninitialized]

And verify that this isn't a real problem please.

thanks,

greg k-h

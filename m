From: "Chen, Jun D" <jun.d.chen@intel.com>
Subject: RE: [tty:tty-next 76/76] drivers/tty/serial/ifx6x60.c:516:2:
 warning: ISO C90 forbids mixed declarations and code
Date: Fri, 16 Nov 2012 03:13:35 +0000
Message-ID: <9E44E06DBBA23A489DED933DBC291A850FD7707A@SHSMSX102.ccr.corp.intel.com>
References: <50a59244.WYf95+M2VB2UsDXN%fengguang.wu@intel.com>
 <20121116020605.GA30669@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54383 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084Ab2KPDO0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 22:14:26 -0500
In-Reply-To: <20121116020605.GA30669@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Wu, Fengguang" <fengguang.wu@intel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>



-----Original Message-----
From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org] 
Sent: Friday, November 16, 2012 10:06 AM
To: Wu, Fengguang
Cc: Chen, Jun D; linux-serial@vger.kernel.org
Subject: Re: [tty:tty-next 76/76] drivers/tty/serial/ifx6x60.c:516:2: warning: ISO C90 forbids mixed declarations and code

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
[Jun] I have already sent the new patch to fix this warning.

> drivers/tty/serial/ifx6x60.c: In function 'ifx_spi_complete':
> drivers/tty/serial/ifx6x60.c:726:8: warning: 'more' may be used uninitialized in this function [-Wmaybe-uninitialized]

And verify that this isn't a real problem please.
[Jun] I didn't modify this line, but I also checked it and can't find warning for " more ". 
thanks,

greg k-h

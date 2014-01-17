From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers: tty: serial: xilinx_uartps: check related
 config macro before processing 'sysrq'
Date: Fri, 17 Jan 2014 07:16:18 -0800
Message-ID: <20140117151618.GA16623@kroah.com>
References: <52D9465C.9000207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38177 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbaAQPPu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Jan 2014 10:15:50 -0500
Content-Disposition: inline
In-Reply-To: <52D9465C.9000207@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: jslaby@suse.cz, James Hogan <james.hogan@imgtec.com>, linux-serial@vger.kernel.org

On Fri, Jan 17, 2014 at 11:03:56PM +0800, Chen Gang wrote:
> Hello Maintainers:
> 
> Please help check this patch, when you have time, thanks.
> 
> And now I find it is already fixed, but I still feel it can be
> improved: "add defined(CONFIG_SERIAL_CORE_CONSOLE)".

What do you mean by this?

What can I do with this patch, it's not in a format I can apply it in,
and you say it's not needed anymore, so I guess I'll just delete it :(

greg k-h

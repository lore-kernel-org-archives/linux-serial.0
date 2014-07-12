From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial/arc: Fix warning with CONSOLE_POLL
Date: Fri, 11 Jul 2014 17:48:21 -0700
Message-ID: <20140712004821.GB13893@kroah.com>
References: <53bf1d9a.l51qTAII/GCO14wJ%fengguang.wu@intel.com>
 <1405083697-10719-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42729 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbaGLAnw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jul 2014 20:43:52 -0400
Content-Disposition: inline
In-Reply-To: <1405083697-10719-1-git-send-email-vgupta@synopsys.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-serial@vger.kernel.org

On Fri, Jul 11, 2014 at 06:31:37PM +0530, Vineet Gupta wrote:
> | drivers/tty/serial/arc_uart.c:516:2: warning: (near initialization for 'arc_serial_pops.poll_put_char') [enabled by default]
> 
> This partially undoes "serial/arc: use uart_console_write() helper" by
> restoring the prototpye of poll helper and use a different one in
> uart_console_write()
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

You forgot a "Reported-by:" line here.

I'll go add it...


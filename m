From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: altera_uart: Check for NULL platform_data
 in probe.
Date: Thu, 29 Mar 2012 09:13:37 -0700
Message-ID: <20120329161337.GA28858@kroah.com>
References: <1333007727-24045-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49485 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576Ab2C2QNm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Mar 2012 12:13:42 -0400
Received: by ghrr11 with SMTP id r11so1621663ghr.19
        for <linux-serial@vger.kernel.org>; Thu, 29 Mar 2012 09:13:41 -0700 (PDT)
In-Reply-To: <1333007727-24045-1-git-send-email-tklauser@distanz.ch>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Yuriy Kozlov <ykozlov@ptcusa.com>

On Thu, Mar 29, 2012 at 09:55:27AM +0200, Tobias Klauser wrote:
> From: Yuriy Kozlov <ykozlov@ptcusa.com>
> 
> Follow altera_jtag_uart.  This fixes a crash if there is a mistake in the DTS.

Is this something you have seen in the wild?  Is this something to be
backported to stable kernels?

thanks,

greg k-h

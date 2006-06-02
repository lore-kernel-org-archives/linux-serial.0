From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 2.6.16.18] 8250: Serial console enable Tx fix
Date: Fri, 2 Jun 2006 17:48:46 +0100
Message-ID: <20060602164846.GF3100@flint.arm.linux.org.uk>
References: <4477B018.1020101@pitt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46865 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932513AbWFBQsw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jun 2006 12:48:52 -0400
Content-Disposition: inline
In-Reply-To: <4477B018.1020101@pitt.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Hordijk <mwh13@pitt.edu>
Cc: linux-serial@vger.kernel.org

On Fri, May 26, 2006 at 09:49:12PM -0400, Michael Hordijk wrote:
>     Enabling the Tx interrupt from console_write on buggy UART 
>     (UART_BUG_TXEN) breaks console transmit on said UART.  Revert to previous 
> UART_IER restore and use serial8250_start_tx() to cause the transmit path 
> to start and not hang.

Please look at how this got solved in the 2.6.17-rc kernels and
implement the same fix.  Enabling the transmitter at the end of
every console write is just plain buggy and asking for problems.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

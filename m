From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Fri, 2 Jun 2006 17:47:41 +0100
Message-ID: <20060602164741.GE3100@flint.arm.linux.org.uk>
References: <87ac9o3ak3.fsf@sleipner.barco.com> <20060511222001.GC28693@flint.arm.linux.org.uk> <87slnapagf.fsf@LKG7F3A44.lan> <20060516125329.GE15481@flint.arm.linux.org.uk> <87lkt2xgt7.fsf@LKG7F3A44.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28941 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932511AbWFBQrs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jun 2006 12:47:48 -0400
Content-Disposition: inline
In-Reply-To: <87lkt2xgt7.fsf@LKG7F3A44.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: tnt@246tNt.com, linux-serial@vger.kernel.org

On Tue, May 16, 2006 at 03:03:32PM +0200, Peter Korsgaard wrote:
> Ok, the following little patch updates Documentation/serial/driver to
> match:
> 
> Update documentation to match reality. INPCK controls whether input
> parity checking is enabled.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

Thanks, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch] icom: select FW_LOADER
Date: Sat, 25 Mar 2006 17:44:34 +0000
Message-ID: <20060325174434.GF6100@flint.arm.linux.org.uk>
References: <20060325144411.GD883@nancy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39696 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751474AbWCYRol (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 25 Mar 2006 12:44:41 -0500
Content-Disposition: inline
In-Reply-To: <20060325144411.GD883@nancy>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: maximilian attems <maks@sternwelten.at>
Cc: linux-serial@vger.kernel.org

On Sat, Mar 25, 2006 at 03:44:11PM +0100, maximilian attems wrote:
> The icom driver uses request_firmware()
> and thus needs to select FW_LOADER.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

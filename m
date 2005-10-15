From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 2.6.14-rc4] 8250 add SupraExpress 56i support
Date: Sat, 15 Oct 2005 10:44:05 +0100
Message-ID: <20051015094405.GA5724@flint.arm.linux.org.uk>
References: <20051014232618.GK30947@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32012 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750901AbVJOJoM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 15 Oct 2005 05:44:12 -0400
Content-Disposition: inline
In-Reply-To: <20051014232618.GK30947@sputnik.stro.at>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: maximilian attems <janitor@sternwelten.at>
Cc: linux-serial@vger.kernel.org

On Sat, Oct 15, 2005 at 01:26:18AM +0200, maximilian attems wrote:
> The modem is said to work with belows addition to pnp_dev_table[]:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=296011

Thanks, Applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

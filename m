From: Russell King <rmk+serial@arm.linux.org.uk>
Subject: Re: [2.6 patch] drivers/serial/8250_pci.c: don't probe non-serial softmodems
Date: Sat, 30 Apr 2005 09:54:16 +0100
Message-ID: <20050430095416.A31027@flint.arm.linux.org.uk>
References: <20050419235608.GB8276@tecr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40970 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261162AbVD3IyU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 30 Apr 2005 04:54:20 -0400
Content-Disposition: inline
In-Reply-To: <20050419235608.GB8276@tecr>; from sashak@smlink.com on Wed, Apr 20, 2005 at 02:56:08AM +0300
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sasha Khapyorsky <sashak@smlink.com>
Cc: linux-serial@vger.kernel.org

On Wed, Apr 20, 2005 at 02:56:08AM +0300, Sasha Khapyorsky wrote:
> Some soft modem pci devices (known list in the patch) claim to have 
> 'communication' class, and as result they are grabbed by serial driver.
> Actually those devices are useless for serial drivers (it is not "real"
> modem and doesn't have serial interface), but this prevents probing from
> soft modem drivers (there are few in ALSA).

What class id are these devices?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

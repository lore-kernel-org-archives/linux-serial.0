From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/2] serial: pl010: Move uart_register_driver call to
 device probe
Date: Fri, 24 Mar 2017 16:47:32 +0000
Message-ID: <20170324164732.GJ7909@n2100.armlinux.org.uk>
References: <20170324162634.8880-1-sjoerd.simons@collabora.co.uk>
 <20170324162634.8880-2-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170324162634.8880-2-sjoerd.simons@collabora.co.uk>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 24, 2017 at 05:26:33PM +0100, Sjoerd Simons wrote:
> uart_register_driver call binds the driver to a specific device
> node through tty_register_driver call. This should typically
> happen during device probe call.
> 
> In a multiplatform scenario, it is possible that multiple serial
> drivers are part of the kernel. Currently the driver registration fails
> if multiple serial drivers with overlapping major/minor numbers are
> included.

This is racy.  The driver model locking is on a _per_ device basis,
it is not on a per driver basis.

It is entirely possible for a driver to be probed by two devices at
once, possibly on two different CPUs.  Checking the state of the
UART driver structure and then registering it means there is a window
where we could end up with two CPUs registering the same UART driver
at the same time, which would cause things to go wrong.

Therefore, this needs some form of locking.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

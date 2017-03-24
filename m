From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/2] Move uart_register_driver call to device probe for
 pl010 and sh-sci
Date: Fri, 24 Mar 2017 16:42:02 +0000
Message-ID: <20170324164202.GI7909@n2100.armlinux.org.uk>
References: <20170324162634.8880-1-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170324162634.8880-1-sjoerd.simons@collabora.co.uk>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 24, 2017 at 05:26:32PM +0100, Sjoerd Simons wrote:
> When testing on a Renesas board with the PL010 serial driver enabled
> serial output broke. Turns out the minor device numbers for both
> drivers happen to overlap, causing whichever driver happened to be the
> second one to register to fail.

How the **** has the SH serial driver ended up with overlapping device
numbers?

What happened to our maintained list of allocated major/minor device
numbers, which is supposed to stop crap like this happening?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

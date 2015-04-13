From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: of-serial: Remove device_type = "serial"
 registration
Date: Mon, 13 Apr 2015 19:00:44 +0200
Message-ID: <20150413170044.GD32634@kroah.com>
References: <b8ba9c125be49a8a70a04807179c5f7fe79b1ae0.1428935724.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b8ba9c125be49a8a70a04807179c5f7fe79b1ae0.1428935724.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 13, 2015 at 04:35:27PM +0200, Michal Simek wrote:
> Do not probe all serial drivers by of_serial.c which are using
> device_type = "serial"; property. Only drivers which have valid
> compatible strings listed in the driver should be probed.

Why?  This was added for some reason, what has changed since then?

greg k-h

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: uartps: Fix uartps_major handling
Date: Fri, 4 Oct 2019 14:52:03 +0200
Message-ID: <20191004125203.GA583048@kroah.com>
References: <00a269bc15c4f8c0a73c14958c5d7a5d37ff70ce.1568359707.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00a269bc15c4f8c0a73c14958c5d7a5d37ff70ce.1568359707.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, Paul Thomas <pthomas8589@gmail.com>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 13, 2019 at 09:28:29AM +0200, Michal Simek wrote:
> There are two parts which should be fixed. The first one is to assigned
> uartps_major at the end of probe() to avoid complicated logic when
> something fails.
> The second part is initialized uartps_major number to 0 when last device is
> removed. This will ensure that on next probe driver will ask for new
> dynamic major number.
> 
> Fixes: c9712e333809 ("serial: uartps: Use the same dynamic major number for all ports")

This is not a valid sha1 in Linus's tree :(

Please fix up and resend.

thanks,

greg k-h

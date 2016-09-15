From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/9] tty: tty_struct dependency clean-ups
Date: Thu, 15 Sep 2016 12:43:15 +0200
Message-ID: <20160915104315.GA4607@kroah.com>
References: <20160909223711.26238-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160909223711.26238-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 09, 2016 at 05:37:01PM -0500, Rob Herring wrote:
> This patch series removes or prepares to remove some of the dependencies 
> on tty_struct within tty_port drivers. This will allow using tty_ports 
> directly for so called UART slave devices. 
> 
> The first patch fixes a regression from the last round with tty 
> closing. Patches 2-4 are mechanical conversions generated with 
> coccinelle. This is my first adventure into coccinelle, so hopefully I 
> didn't screw things up. :) Only serial_core has some of its tty_struct 
> dependencies removed as those are the drivers we immediately care about 
> supporting slave devices with.
> 
> Next up after this are moving some functions to the tty_port ops. I've 
> got some WIP patches for some of that, but nothing ready to send out 
> quite yet.

I've applied the first patch here, and wanted to apply patch 3, but it
depended on #2, so I'll wait for your next round of patches.

thanks,

greg k-h

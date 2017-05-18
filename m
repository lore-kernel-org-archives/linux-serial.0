From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/4] tty/serdev: add serdev registration interface
Date: Thu, 18 May 2017 16:43:42 +0200
Message-ID: <20170518144342.GA10503@kroah.com>
References: <20170411170731.4085-1-johan@kernel.org>
 <20170411170731.4085-4-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170411170731.4085-4-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 11, 2017 at 07:07:30PM +0200, Johan Hovold wrote:
> Add a new interface for registering a serdev controller and clients, and
> a helper function to deregister serdev devices (or a tty device) that
> were previously registered using the new interface.
> 
> Once every driver currently using the tty_port_register_device() helpers
> have been vetted and converted to use the new serdev registration
> interface (at least for deregistration), we can move serdev registration
> to the current helpers and get rid of the serdev-specific functions.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/tty/serdev/serdev-ttyport.c |  6 ++-
>  drivers/tty/tty_port.c              | 76 +++++++++++++++++++++++++++++++++++++
>  include/linux/serdev.h              |  7 +++-
>  include/linux/tty.h                 |  9 +++++
>  4 files changed, 94 insertions(+), 4 deletions(-)

This patch doesn't apply, and should it really be a 4.12-final patch?

I've dropped this one, and the 4th as well, from my queue.

thanks,

greg k-h

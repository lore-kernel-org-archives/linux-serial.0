From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] serial: imx: support enabling rs485 at boot time
 with DT option
Date: Tue, 18 Apr 2017 19:36:47 +0200
Message-ID: <20170418173647.GB8087@kroah.com>
References: <20170418165434.21252-1-lexszero@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170418165434.21252-1-lexszero@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Ignatov <lexszero@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 18, 2017 at 07:54:33PM +0300, Alexey Ignatov wrote:
> Signed-off-by: Alexey Ignatov <lexszero@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

I can't take patches without any changelog text at all, sorry.

And you forgot to cc: the maintainer of the subsystem you are writing a
patch for, not a good way to get it accepted :)

Please use scripts/get_maintainer.pl to help you out.

thanks,

greg k-h

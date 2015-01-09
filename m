From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH/RFC] serial: sh-sci: Remove overrun message
Date: Fri, 9 Jan 2015 13:42:22 -0800
Message-ID: <20150109214222.GB7952@kroah.com>
References: <1418652793-6770-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418652793-6770-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 15, 2014 at 11:13:13PM +0900, Yoshihiro Kaneko wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> 
> Since the driver cannot return from overrun error if characters
> are output during overrun process, the error message of overrun
> is removed.
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> 
> This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
> tree.
> 
>  drivers/tty/serial/sh-sci.c | 1 -
>  1 file changed, 1 deletion(-)

I don't apply "RFC" patches, as it is evident that you don't feel they
should be applied.

Please resend anything without that marking if you want me to apply
them.

thanks,

greg k-h

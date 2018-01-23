From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] serdev: add method to set parity
Date: Tue, 23 Jan 2018 12:34:34 +1100
Message-ID: <20180123013434.GK3286@localhost>
References: <1516643792-22840-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1516643792-22840-1-git-send-email-ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 22, 2018 at 06:56:32PM +0100, Ulrich Hecht wrote:
> Adds serdev_device_set_parity() and an implementation for ttyport.
> The interface uses an enum with the values SERIAL_PARITY_NONE,
> SERIAL_PARITY_EVEN and SERIAL_PARITY_ODD.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> ---
> 
> Hi!
> 
> This revision addresses Johan's comments (see below for details) and adds
> Sebastian's Reviewed-by tag. Thank you for your reviews!
> 
> CU
> Uli
> 
> 
> Changes since v1:
> - added Reviewed-by tag
> - expanded commit message
> - shuffled stuff around to keep line-setting bits together
> - clear CMSPAR
> - (hopefully) detect errors correctly by checking tty->termios after call
>   to tty_set_termios().

Thanks for the v2. Looks good to me now.

Reviewed-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Johan

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Tty: serial - Fix possible NULL derefrence.
Date: Mon, 30 Jan 2017 20:37:43 +0100
Message-ID: <20170130193743.GB27138@kroah.com>
References: <CGME20170127111619epcas4p44c21059f85b7aa091016019c98d42939@epcas4p4.samsung.com>
 <1485515773-3542-1-git-send-email-shailendra.v@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485515773-3542-1-git-send-email-shailendra.v@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shailendra Verma <shailendra.v@samsung.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 27, 2017 at 04:46:13PM +0530, Shailendra Verma wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.
> 
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  drivers/tty/serial/max310x.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 8a3e926..a94d147 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1323,6 +1323,10 @@ static int max310x_spi_probe(struct spi_device *spi)
>  	if (spi->dev.of_node) {
>  		const struct of_device_id *of_id =
>  			of_match_device(max310x_dt_ids, &spi->dev);
> +		if (!of_id) {
> +			dev_err(&spi->dev, "Error: No device match found\n");
> +			return -ENODEV;
> +		}

Patch now dropped as this isn't possible.

thanks,

greg k-h

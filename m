From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/7] serial: sh-sci: increase RX FIFO trigger defaults
 for (H)SCIF
Date: Fri, 3 Feb 2017 10:16:11 +0100
Message-ID: <20170203091611.GA28577@kroah.com>
References: <1486055420-31595-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1486055420-31595-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486055420-31595-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org, linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 02, 2017 at 06:10:17PM +0100, Ulrich Hecht wrote:
> Sets reasonable trigger defaults for the various SCIF variants.
> Also corrects the FIFO size for SH7705-style ports.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

This patch doesn't apply cleanly, so I've stopped here in the series.
Please rebase and resend the rest.

thanks,

greg k-h

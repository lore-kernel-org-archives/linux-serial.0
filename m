From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 4/7] serial: sh-sci: increase RX FIFO trigger defaults
 for (H)SCIF
Date: Wed, 25 Jan 2017 11:06:14 +0100
Message-ID: <20170125100614.GA17954@kroah.com>
References: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1485187458-8195-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485187458-8195-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org, linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 23, 2017 at 05:04:15PM +0100, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/tty/serial/sh-sci.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

I will not take a patch without any changelog text, sorry...

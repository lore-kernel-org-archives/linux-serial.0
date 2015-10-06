From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v2] Revert "serial: 8250_dma: don't bother DMA with small
 transfers"
Date: Tue, 6 Oct 2015 14:55:03 +0100
Message-ID: <20151006135503.GA13250@kroah.com>
References: <1444136920-17969-1-git-send-email-frederic.danis@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444136920-17969-1-git-send-email-frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 06, 2015 at 03:08:40PM +0200, Frederic Danis wrote:
> This reverts commit 9119fba0cfeda6d415c9f068df66838a104b87cb.
> 
> This commit prevents from sending "big" file using Bluetooth.
> When sending a lot of data quickly through the Bluetooth interface, and
> after a variable amount of data sent, transfer fails with error:
>     kernel: [  415.247453] Bluetooth: hci0 hardware error 0x00
> 
> Found on T100TA.
> 
> After reverting this commit, send works fine for any file size.
> 
> Signed-off-by: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> v2: Re-send to correct people
> 
>  drivers/tty/serial/8250/8250_dma.c | 4 ----
>  1 file changed, 4 deletions(-)

Andy, any objections?

Frederic, don't you want to see this backported to 4.0 and newer?

thanks,

greg k-h

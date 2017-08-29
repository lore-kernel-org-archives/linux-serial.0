From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH][serial-next] serial: 8250: don't dereference em485 until
 it has been null checked
Date: Tue, 29 Aug 2017 23:04:11 +0300
Message-ID: <20170829200411.wbqdsihcnhpg2gmr@mwanda>
References: <20170829165815.23429-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170829165815.23429-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phil Elwell <phil@raspberrypi.org>, Jan Kiszka <jan.kiszka@siemens.com>, Eric Anholt <eric@anholt.net>, Thor Thayer <tthayer@opensource.altera.com>, Rafael Gago <rafael.gago@gmail.com>, David Lechner <david@lechnology.com>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 29, 2017 at 05:58:15PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently, the pointer em485 is dereferenced to get p and then later
> em485 is checked to see if it is null before calling __start_tx. In
> the case where em485 is null, we get a null pointer dereference. Fix
> this by moving the deference and the associated spinlock/unlocks on
> p to the code block where em485 is known to be not null.
> 
> Detected by CoverityScan, CID#14555001 ("Dereference before null check")
> 
> Fixes 6e0a5de2136b ("serial: 8250: Use hrtimers for rs485 delays")

I don't understand which tree this commit is from.  I have it fetched
but when I do a git log on drivers/tty/serial/8250/8250_port.c then I
don't see it.  I have today's linux-next.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 4726aa276968..c20b581313f0 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1606,18 +1606,18 @@ static inline void start_tx_rs485(struct uart_port *port)
>  static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)

I'm pretty sure "t" isn't ever NULL.

regards,
dan carpenter



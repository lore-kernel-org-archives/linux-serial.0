From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Subject: Re: [PATCH] tty: serial: jsm: remove redundant pointer ts
Date: Tue, 7 Nov 2017 10:53:47 -0200
Message-ID: <077747a9-4ed2-9716-4de6-35f2fa269183@linux.vnet.ibm.com>
References: <20171107114107.22805-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171107114107.22805-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/07/2017 09:41 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer ts is assigned a value that is never read, ts is therefore
> redundant and can be removed. Cleans up clang warning:
> 
> drivers/tty/serial/jsm/jsm_tty.c:285:2: warning: Value stored to 'ts'
> is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks Colin!

Acked-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>


> ---
>  drivers/tty/serial/jsm/jsm_tty.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
> index e69227cc3827..5ecd878669b8 100644
> --- a/drivers/tty/serial/jsm/jsm_tty.c
> +++ b/drivers/tty/serial/jsm/jsm_tty.c
> @@ -275,14 +275,12 @@ static int jsm_tty_open(struct uart_port *port)
>  static void jsm_tty_close(struct uart_port *port)
>  {
>  	struct jsm_board *bd;
> -	struct ktermios *ts;
>  	struct jsm_channel *channel =
>  		container_of(port, struct jsm_channel, uart_port);
> 
>  	jsm_dbg(CLOSE, &channel->ch_bd->pci_dev, "start\n");
> 
>  	bd = channel->ch_bd;
> -	ts = &port->state->port.tty->termios;
> 
>  	channel->ch_flags &= ~(CH_STOPI);
> 

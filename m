From: =?ISO-8859-2?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH v2] serial: mxs-auart: Fix mxs_auart_set_ldisc()
Date: Fri, 14 Nov 2014 23:53:14 +0100
Message-ID: <546687DA.6010503@elproma.com.pl>
References: <1415831569-6904-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1415831569-6904-1-git-send-email-festevam@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi,

Procedure of the test:
* PPS source connected to a DCD line of the driver (gpio)
* ldattach PPS /dev/ttyAPPn
* watch -n 1 cat /sys/class/pps/pps0/assert
* watch -n 1 cat /sys/class/pps/pps0/clear

I just tested and finally it works on my hardware and 
3.18.0-rc4-next-20141114+.
Before I applied the your patch-fix and 2 others which were missed (I 
apologize you here):
"[PATCH] serial: mxs-auart: fix gpio change detection on interrupt"
"[PATCH] gpio: mxs: implement get_direction callback"

I submitted them as separate patches because the first fixes tty-next 
and the second
concerns gpio-next (gpiolib in fact).
I hope they could be picked up for linux-next.

My next step for the mxs-auart driver will be:
* RFC patch for spinlocks in the driver, I hope it helps here:
    http://thread.gmane.org/gmane.linux.serial/16795
    It wasn't continued here:
    http://www.spinics.net/lists/linux-serial/msg10887.html
    "By the way, where did the spinlocks go in this driver?"
* sync the driver to commit d41510ce2f071c9ccb1903d7a5135443a57dbe4e:
   ( "serial: Take uart port lock for direct *_enable_ms()")
* sync the driver to commit cab68f89546ba5a04bf28aaeaca841d4ccc2fd52:
   ( "serial: Test/disable MSIs if switching from N_PPS")
* tx_empty() fix like here with better explanation:
   http://comments.gmane.org/gmane.linux.ports.arm.kernel/283882

have a nice weekend
Janusz

W dniu 2014-11-12 o 23:32, Fabio Estevam pisze:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Commit 732a84a037a4 ("serial: core: Pass termios to set_ldisc() notifications")
> changed the set_ldisc prototype.
>
> At the time of this commit the mxs_auart driver did not implement set_ldisc,
> so that's why it has not been converted.
>
> Adapt also mxs_auart_set_ldisc() so that the following build warning can be
> fixed:
>
> drivers/tty/serial/mxs-auart.c:962:2: warning: initialization from
> incompatible pointer type
>    .set_ldisc      = mxs_auart_set_ldisc,
>    ^
> drivers/tty/serial/mxs-auart.c:962:2: warning: (near initialization
> for 'mxs_auart_ops.set_ldisc')
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Fix the explanation for the error
>
> Janusz,
>
> This is build-tested only. Please test it on real hardware, if possible.
>
>   drivers/tty/serial/mxs-auart.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 3784920..a6d2bb9f4 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -784,9 +784,10 @@ static void mxs_auart_settermios(struct uart_port *u,
>   		mxs_auart_disable_ms(u);
>   }
>   
> -static void mxs_auart_set_ldisc(struct uart_port *port, int new)
> +static void mxs_auart_set_ldisc(struct uart_port *port,
> +				struct ktermios *termios)
>   {
> -	if (new == N_PPS) {
> +	if (termios->c_line == N_PPS) {
>   		port->flags |= UPF_HARDPPS_CD;
>   		mxs_auart_enable_ms(port);
>   	} else {


From: =?ISO-8859-2?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH v2] serial: mxs-auart: Fix mxs_auart_set_ldisc()
Date: Sat, 15 Nov 2014 18:35:55 +0100
Message-ID: <54678EFB.5060007@elproma.com.pl>
References: <1415831569-6904-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:64894 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754138AbaKORfx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 15 Nov 2014 12:35:53 -0500
In-Reply-To: <1415831569-6904-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>


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

Tested-by: Janusz Uzycki <j.uzycki@elproma.com.pl>


From: =?ISO-8859-2?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH] serial: mxs-auart: Fix mxs_auart_set_ldisc()
Date: Wed, 12 Nov 2014 22:52:28 +0100
Message-ID: <5463D69C.8080206@elproma.com.pl>
References: <1415813712-5872-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:53183 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752176AbaKLVw0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 16:52:26 -0500
In-Reply-To: <1415813712-5872-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Thanks Fabio for the fix. I hope I will test it this week.
In fact, commit 36a262782b045220bfccf89bd2c4d78cbe152c8e
("serial: core: Pass termios to set_ldisc() notifications")
with the 36a262782b04 commit resulted in the problem.

I also noticed 2 successive patches in the next:
* d41510ce2f071c9ccb1903d7a5135443a57dbe4e
   ("serial: Take uart port lock for direct *_enable_ms()")
* cab68f89546ba5a04bf28aaeaca841d4ccc2fd52
   ("serial: Test/disable MSIs if switching from N_PPS")
should be applied for the patch. However they aren't critical.
I'll submit them after a patch which adds to mxs-auart driver spin-locks.

best regards
Janusz

W dniu 2014-11-12 o 18:35, Fabio Estevam pisze:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Since commit 36a262782b04 ("serial: mxs-auart: enable PPS support")
> the following build warning is seen:
>
> drivers/tty/serial/mxs-auart.c:962:2: warning: initialization from
> incompatible pointer type
>    .set_ldisc      = mxs_auart_set_ldisc,
>    ^
> drivers/tty/serial/mxs-auart.c:962:2: warning: (near initialization
> for 'mxs_auart_ops.set_ldisc')
>
> The second argument of set_ldisc should be 'struct ktermios *termios', so
> fix it accordingly.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
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


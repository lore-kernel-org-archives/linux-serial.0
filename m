Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA628423EA9;
	Mon,  3 Aug 2026 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768391; cv=none; b=HSxcVL1XQqDwQx65om9JZsq1pdgqpQTwygHhlTWorCzYJHlLwHf1bzaYuB0tX26Y85TKyIgzUdgYxCQHmTEKMHKPOgCtWnkLOmRhVFRfkmnFmIIAa41qhV1SVHMU1G1zEfkrvJl9w3yOks6o6C61jbjitnvNgCx/kyUgiqzHo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768391; c=relaxed/simple;
	bh=x0LxHdLYX3mSkEcX2DoQj+daGEOxkfDvkV9fxFaoHzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlHYaGYH/iRax82OL2EWo+E1Qx/2KYC1xwY8d2FcQ5ZGIIHf4iN0QhMT0oY9QHhvvAI/T0vInN1ncplE+TPG3fWaHww98pfCHnk6Xz1iYdCQjIxT/5NkXof3FmCXIPSRIiOr+5yg3ROJlpxTAiTWJ+frjEGKEc+XG5Nv8S4vwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BRjsT75o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BRjsT75o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D671F000E9;
	Mon,  3 Aug 2026 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785768390;
	bh=2e60ISEMLAjDjPJmg0fyZ5+WfgdVEmJgBrMUEwYQF5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BRjsT75o1oJt2ylPkDCUT8RyhIPnFyVwj5YzK8lm7T2ZnHXfLrPXD2qmaxRXKMpEt
	 8EF938Dc6/6Xt2zCk3D6qTN0ykjHjcBe+XfXZCZkCekyGQb6k2cr4Dr+fwtYsntWcY
	 iSfAzG5V+ZAQV16DPQ1h9J0F7OvZqy51I3w1m/fI=
Date: Mon, 3 Aug 2026 16:46:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/6] serial: txx9: Drop usage of uart_match_port()
Message-ID: <2026080352-chatter-neurotic-48c3@gregkh>
References: <cover.1785489518.git.ukleinek@kernel.org>
 <c785f3269794934d126909719e94d5ad6c35f7dc.1785489518.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c785f3269794934d126909719e94d5ad6c35f7dc.1785489518.git.ukleinek@kernel.org>

On Fri, Jul 31, 2026 at 11:39:05AM +0200, Uwe Kleine-König wrote:
> In this driver .iotype is always UPIO_PORT. So uart_match_port() is
> equivalent to comparing .iobase. Remove the call to uart_match_port()
> which then only has a single caller that is handled in the next commit.
> 
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> ---
>  drivers/tty/serial/serial_txx9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
> index 5ed20129b44b..2368081c3742 100644
> --- a/drivers/tty/serial/serial_txx9.c
> +++ b/drivers/tty/serial/serial_txx9.c
> @@ -965,7 +965,7 @@ static int serial_txx9_register_port(struct uart_port *port)
>  	mutex_lock(&serial_txx9_mutex);
>  	for (i = 0; i < UART_NR; i++) {
>  		uart = &serial_txx9_ports[i];
> -		if (uart_match_port(uart, port)) {
> +		if (uart->iobase == port->iobase)
>  			uart_remove_one_port(&serial_txx9_reg, uart);
>  			break;
>  		}

Does this even build?

:(

thanks,

greg k-h

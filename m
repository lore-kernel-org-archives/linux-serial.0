Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F2B31F9A4;
	Mon, 31 Aug 2026 03:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788145670; cv=none; b=RUGM7ztF4WI6gpkM1AbmkodjT7FT1M2pH1v+obBkn+WRJno8X34AwvXA8lRfGjXytXRfPgsrFpEs8l6TzK87CYF0BzBtnIBBfs3qHIAPElDWZe+cNtVakCDgMv/j9Y+2nxDmTNkLrxoXhE5jmMpvCp8UTRPcp9ZX8hxN53KbGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788145670; c=relaxed/simple;
	bh=gLr+Iwb+ZCQmXvh641mg06UhyG3OYgUsPvWbmyuhsq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LajmICAYi4XjIct4ObiolRMQXjDeSOoH+du3XsWoRxcnjcllLpsYXDHGUY/hdPAPK3+3wRTmk2DOgxhk66UT4BewwvQrRLE9kohpkk8aXquPpAWvtd44uNVemY+vYT6jezooV8OfUG/T8Re9JSpkSqE7eHgp2v9I0UtAuKzQxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeEmWeHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeEmWeHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2334A1F000E9;
	Mon, 31 Aug 2026 03:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788145669;
	bh=3PBI0fUvzmz9NLpVR+qeiZpMag6fP4x3JVvKUNI8hvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HeEmWeHY82ZIX6dLS7QxC6izKBTZloyocSHkK1Sh4VXrx9UJGXxyXJYtokn/Wjj6G
	 6RaypVC7JMGQSVqpHv1qMTeMeFRMyBOoSZvZLRsTosuIIJV2Rc965PY8tUxn/Nos5O
	 1KKOeM407KJBNwGjzxv4nXYqslwdV88/UCyRcQm8cD57L/FsS6WbcVSYjYknR9UaS/
	 H3H+3PoMTjHkZOL73lFHaEh+D5biSNnY5gMqI8q/0W9dLJ7yjV8+qaj5skN8dQUCJ6
	 Ehq2AWxp0vf8goZ2PqoRk50Y7eZkkhulzy1IujxurOx993ACKUUsnPdcGaG94Bjhul
	 M38pJvVTkrK9w==
Message-ID: <8f39c9fd-cc6e-42cf-9761-ae1922898d4a@kernel.org>
Date: Mon, 31 Aug 2026 05:07:46 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: 8250_mid: wait for LSR tx empty before
 setting termios
To: Tate Whiteberg <whiteberg@arista.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20260828175733.1650267-1-whiteberg@arista.com>
 <20260828175733.1650267-3-whiteberg@arista.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260828175733.1650267-3-whiteberg@arista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28. 08. 26, 19:57, Tate Whiteberg wrote:
> If mid8250_set_termios() is called while data is still in transmission,
> the corresponding register updates will corrupt the transmission.
> 
> Fix this by locking the port and and waiting for the transmitter to
> empty before performing updates. It is necessary to wait for both
> UART_LSR_THRE and UART_LSR_TEMT to ensure the final character is sent.
> 
> Fixes: d9eda9bab237 ("serial: 8250_pci: Intel MID UART support to its own driver")
> Signed-off-by: Tate Whiteberg <whiteberg@arista.com>
> ---
> Changes in v2:
>    - Separate changes to 8250.h and 8250_port.c into prerequisite patch,
>      as recommended by andriy.shevchenko@intel.com
>    - Apply feedback from andriy.shevchenko@intel.com to 8250_mid.c
> 
>   drivers/tty/serial/8250/8250_mid.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
> index 82656645b8a6..ce792888acfe 100644
> --- a/drivers/tty/serial/8250/8250_mid.c
> +++ b/drivers/tty/serial/8250/8250_mid.c
> @@ -209,6 +209,7 @@ static void mid8250_set_termios(struct uart_port *p, struct ktermios *termios,
>   				const struct ktermios *old)
>   {
>   	unsigned int baud = tty_termios_baud_rate(termios);
> +	struct uart_8250_port *up = up_to_u8250p(p);
>   	struct mid8250 *mid = p->private_data;
>   	unsigned short ps = 16;
>   	unsigned long fuart = baud * ps;
> @@ -231,12 +232,18 @@ static void mid8250_set_termios(struct uart_port *p, struct ktermios *termios,
>   	}
>   
>   	rational_best_approximation(fuart, mid->board->freq, w, w, &mul, &div);
> +
> +	uart_port_lock_irq(p);

Use scoped_guard(), please.

-- 
js
suse labs

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116532ED3A;
	Thu, 30 Jul 2026 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390595; cv=none; b=pmcXNqEMa9c2WvsnAQnx9mlq4kof2qj+FtVnKOOHAUCN6mGzVJFaIp/xWNSMutPZ4YfQDkmxr1+dY5RreyhL6lU0LxRUbFUNCEiJKS9e6aEKyr2IDYJJJwUgCby/0gc/trv7uUHyVYdiP/jWlP27bRmzIqDQE6tMg0rLbqXn1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390595; c=relaxed/simple;
	bh=L5OlKOGonYLda5FedjM33T4BZvXL6e+L8Cxt0+IOpqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkPSR9tcqweuX8mFMe/qBdsh5bpMJWYPgp11j6kt/mcywYF0bIG2+YDkfpHUQ3etRmJiy6LszxHuG8P+iASQeLfHGTxWHNORwYZR/i1US+xAlZwf8MAqBB4jbKTDS5+3hCtpoBBGcSdCy9ktvBYTxYrDH7RTr7YY6JenQdhACT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GULkMyuE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GULkMyuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCC41F000E9;
	Thu, 30 Jul 2026 05:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785390594;
	bh=tKA1qT4g+rLJRWBX4pdd62gjNJBehqiiwoW1GWrwqZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GULkMyuEcG6EB2uPqj9NBBQZi3ioCU1hcBCIglU6vKm16CknDCUgaAWj34G5whPT8
	 XjMwx7pgLa3YQ2Cfp8qnMO1Lal22sVGACPjclE5q2PmElxlZ+zEAl5ZHyGJKgRzeWi
	 RHmgeL9YY9ftSimhnPgNN/cUKshIStD5mIb8yqvZJyVxVWUwewph0xtJk5UJSihxeZ
	 HP6MvzVfxkKR6kqsvmRJ33dm77hqT823h2W13A+Kj3mUhB8MgnMwHph1vL4rJSL8g2
	 5DcvYh0aBDPSRJ2Nn0mCa/XP5knl1qUg1OPBnRIMyIpLbjdQeujAzjrQBsqM3BwRFB
	 VZ8apwBKbxM3Q==
Message-ID: <82cb09bd-7f95-4cb8-9cd9-634dbcf38729@kernel.org>
Date: Thu, 30 Jul 2026 07:49:43 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/14] serial: 8250_mxpcie: offload XON/XOFF flow
 control to MUEx50 hardware
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com, EddieSY.Lin@moxa.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
 <20260729060602.492430-6-crescentcy.hsieh@moxa.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260729060602.492430-6-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29. 07. 26, 8:05, Crescent Hsieh wrote:
> The MUEx50 UART can handle in-band software flow control (XON/XOFF)
> directly in hardware.
> 
> Program the on-chip XON/XOFF characters from termios settings and enable
> the corresponding MUEx50 flow control modes when IXON or IXOFF is
> requested. Provide throttle and unthrottle callbacks so RX can be
> stopped and resumed cleanly.
> 
> Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/serial/8250/8250_mxpcie.c | 55 +++++++++++++++++++++++++--
>   1 file changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
> index 1124c7d951b3..0517caaf2d26 100644
> --- a/drivers/tty/serial/8250/8250_mxpcie.c
> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
...> @@ -172,6 +184,23 @@ static void mxpcie8250_set_termios(struct 
uart_port *port,
>   		efr |= (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
>   		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
>   	}
> +	/* Set on-chip software flow control character */
> +	serial_out(up, MOXA_PUART_XON1, START_CHAR(tty));
> +	serial_out(up, MOXA_PUART_XON2, START_CHAR(tty));
> +	serial_out(up, MOXA_PUART_XOFF1, STOP_CHAR(tty));
> +	serial_out(up, MOXA_PUART_XOFF2, STOP_CHAR(tty));
> +
> +	efr &= ~(MOXA_PUART_EFR_RX_FLOW_MASK | MOXA_PUART_EFR_TX_FLOW_MASK);

This is not needed, as you use FIELD_MODIFY(), right?

> +	val = I_IXON(tty) ? MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_RX_FLOW_DISABLED;
> +	efr = FIELD_MODIFY(MOXA_PUART_EFR_RX_FLOW_MASK, &efr, val);
> +
> +	val = I_IXOFF(tty) ? MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_TX_FLOW_DISABLED;
> +	efr = FIELD_MODIFY(MOXA_PUART_EFR_TX_FLOW_MASK, &efr, val);

Assigning back to efr is unnecessary. The reg is updated in-place.

thanks,
-- 
js
suse labs

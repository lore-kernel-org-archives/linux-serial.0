Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099807;
	b=j0yIbT7LDqzT0K4zNJ0uMCRAyQm56/jvwzd6ok06KgTvEOrGDFj/km85QecusFQniRjY
	 3Ia8vmC/OY+9VoQRkVQJKjuvKTBfkx0sYXCzgQ3Kb+l/zCiOSrlF9QDQz2etWx74lJ6G6
	 PrsNq5jWxFQsf/1t1ASO/X+kc0u+W/V8ix0peWPG+E0hLDYumF9Dx6r/n74s9QZBQmLEy
	 iKZzf36z7+onzB98Mj3Xe8QvvjrnfjHsk3ii6gPacgiWAuVzw4IUYj/g8Idh0EhCOnxa2
	 mEL+XIn+Dy3uP9sijDWQ6xIVzlBeQAd7LQuzYh3rVssAgzmKAHNlgH82kXccd7NEG4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099807;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=yPv5p+sEloJUUYC5PLdURybRSNu6Ze9OVlX0ezUUl50=;
	b=t/IOw8tMqjsM3dysImmOgo4j4JxFrB0IdkuNapCXVIDwzJQ17xxMHKzcnZqu5MxQo/A2
	 hggzJcKaPUAt75ww2b0UWMOWQglhVch2eZ91XH7lwZOC7WM5A4my0ky2YecNDzzPYS0Pp
	 gqZg4v6yhMbONsKfkKYYixQEKlRtrGQACz3cQcxVoYgtjjY44C/Uj5+AQ+/ZD/4QxKWFd
	 NYHbssr4csvXDSS+p5pZuoezJAog8WD5gXgUzAWaLjNfYIaHhW+xg8l3CFM/H5X1a+3Cd
	 lte+VLZ32coRohP4sP6hFBGG/g5g49KS6RokKuB7BQhpSKG5mS/zzRnVJG2wKPVJxqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q34KGzie;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C833E606A31B;
	Tue, 27 Oct 2026 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q34KGzie
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2531F01825;
	Tue, 27 Oct 2026 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099806;
	bh=yPv5p+sEloJUUYC5PLdURybRSNu6Ze9OVlX0ezUUl50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q34KGzieN3gXoPvF6uFxKWHy3Rqtt0zM5tqC76zFvVrpcw1e1+ACrGKcGge/82+q4
	 Ll/UWqhui6ecfIBOrzSgW6nE53b4F5Cbn57R8HbVfx3mOmnFpHYbtjO8zxb1TesHEj
	 8EhHkYGvD0wZhObzmYwiDK4ybyfiULiTW7n3Mn3QRJuXUu7k7jLcTDA/VM157287JP
	 MoPg6nqQuIXL69fAsWq6402V7BnMUcON7knWfqkMgFxUZbWoXccqftfZP/X8pYZYHy
	 X8u3sEgvflkyg+ZavKdfPM4t6V6LyC71QMhsM9KsQ2dg80yp8dpTXTw6mDSDs6Nbk1
	 ctB1tiCfhh09A==
Message-ID: <46833c7c-9c49-403e-bdb6-e9cf5fc2d3aa@kernel.org>
Date: Tue, 27 Oct 2026 12:16:37 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] serial: 8250: clear subdriver state on port
 unregister
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joshua Rogers <linux@joshua.hu>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
Cc: Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>,
 Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Peter Hurley <peter@hurleysoftware.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>,
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Robert Baldyga
 <r.baldyga@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>,
 Kukjin Kim <kgene.kim@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
 Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, stable <stable@kernel.org>,
 John Ogness <john.ogness@linutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Fushuai Wang <wangfushuai@baidu.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-5-99b0202ae546@linuxfoundation.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20261027-tty-llm-v1-5-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27. 10. 26, 12:06, Greg Kroah-Hartman wrote:
> From: Joshua Rogers <linux@joshua.hu>
> 
> When serial8250_unregister_port() re-adds a port as a fallback ISA port,
> it only partially resets the port state via serial8250_init_port(). All
> subdriver-owned function pointers and per-driver state copied during
> registration (such as startup, shutdown, handle_break, get_mctrl,
> set_mctrl, set_termios, private_data, dma, gpios, and rs485 callbacks)
> are left intact. After the original driver module is unloaded, these
> become dangling pointers that can trigger use-after-free on subsequent
> port operations.
> 
> Clear all subdriver-copied fields and call serial8250_set_defaults() to
> restore default I/O accessors before re-adding the fallback port.
> 
> Cc: stable <stable@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
> Cc: Fushuai Wang <wangfushuai@baidu.com>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/tty/serial/8250/8250_core.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 0951d3e42e1f..673fde55828a 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -956,7 +956,35 @@ void serial8250_unregister_port(struct uart_8250_port *uart)
>   		uart->port.dev = &serial8250_isa_devs->dev;
>   		uart->port.port_id = uart->port.line;
>   		uart->capabilities = 0;
> +
> +		/*
> +		 * Clear subdriver-owned state copied by
> +		 * serial8250_register_8250_port() to prevent dangling
> +		 * pointers after the original driver module is unloaded.
> +		 */
> +		uart->port.private_data = NULL;
> +		uart->port.set_termios = NULL;
> +		uart->port.set_ldisc = NULL;
> +		uart->port.get_mctrl = NULL;
> +		uart->port.set_mctrl = NULL;
> +		uart->port.get_divisor = NULL;
> +		uart->port.set_divisor = NULL;
> +		uart->port.startup = NULL;
> +		uart->port.shutdown = NULL;
> +		uart->port.throttle = NULL;
> +		uart->port.unthrottle = NULL;
> +		uart->port.handle_break = NULL;
> +		uart->port.rs485_config = NULL;
> +		memset(&uart->port.rs485, 0, sizeof(uart->port.rs485));
> +		memset(&uart->port.rs485_supported, 0,
> +		       sizeof(uart->port.rs485_supported));
> +		uart->gpios = NULL;
> +		uart->dma = NULL;
> +		uart->rs485_start_tx = NULL;
> +		uart->rs485_stop_tx = NULL;
> +

Ha! The above gives an answer to my today's:
https://lore.kernel.org/all/53624662-e94e-4fcb-9902-7fa4143c7689@kernel.org/

(And obviously this conflicts with that patch.)


And with the current state of LLMs, I should perhaps revive my "move ops 
to a separate struct" as the above is a PITA. I have been unable to 
finish the series on my own to date.

>   		serial8250_init_port(uart);
> +		serial8250_set_defaults(uart);
>   		serial8250_apply_quirks(uart);
>   		uart_add_one_port(&serial8250_reg, &uart->port);
>   	} else {
> 

thanks,
-- 
js
suse labs

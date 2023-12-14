Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="B00+lRyE"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E50510A;
	Thu, 14 Dec 2023 01:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702544401; x=1703149201; i=linosanfilippo@gmx.de;
	bh=i3Hz+ytUFA4jUXYAsPUZy/EuCtWs2rkgtqsGERhQNr8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=B00+lRyETfYe+87IC1S0gO42UrRzj4IDXlh5QSrQaqOPX+XYx5aaj7GX6YkYb9uF
	 AAykgwveahf/4uyrhpjTWPw8yZ4B4FUNAi7h9iiLE1bLTP/fFDrNMWdMm4L5wWHHu
	 IH6w26ZKnTf80aTjcEm4n8X9sdoZm1gzArguieF9jFJAeYhY+l8dCPsZ/BT5OOMZh
	 3513Xpp0mCZEsW1bJWHDP+S9c+m1qn7DyxADCN8hBoYL4P7CkK6S/13rCyznijwzk
	 aOs7m6cMSfRx7WQdMnjsKWAcwGC4A9rmNRcQ1UkfRHXOpcgLFXs4NO/wX4VkntzAr
	 /KbF3bwitUGfbnaBmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.3.177]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1rH80a053l-017mQx; Thu, 14
 Dec 2023 10:00:01 +0100
Message-ID: <e8cf9ed3-e2d3-4764-b1c3-87e38e99b4a5@gmx.de>
Date: Thu, 14 Dec 2023 10:00:00 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/3] tty: serial: uartps: Add rs485 support to uartps
 driver
Content-Language: en-US
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
 michal.simek@amd.com, gregkh@linuxfoundation.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
 shubhrajyoti.datta@amd.com, manion05gk@gmail.com
References: <20231213130023.606486-1-manikanta.guntupalli@amd.com>
 <20231213130023.606486-4-manikanta.guntupalli@amd.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20231213130023.606486-4-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pK8MFRjHp2YaZUknT+LRCDyINjh9i/0Jrq0/enwVR0460Vv8uBG
 jEhoBvjHDZiW26EnG9lgKBjPWoxplSfjGuR22APQXvVrno70BetBrA7LSnxExszo1a/O5gV
 loInpLjPZxRyVQeVsIoD4xa8mR/aqLRKC+QCl58O4a0vJjWQzZEDtjsldDjbI0O+RoaXHfw
 karSL1jB/+wDGZDkoKmaQ==
UI-OutboundReport: notjunk:1;M01:P0:EI9S+Cq+1aU=;Siw+EKHPttacc+oKnTGnheJocRM
 CF0+vm3a9XnjSROmSR4PRlaHwFYax+mLYqDdXpk0rCt/S7wCBe4kgryA5z7HH1Qk8/jC5qn/k
 argluzBsuic8Xdvl4Zs1namxqEOcbwGCx9UE04NQQBPe6jJXFgAThrLJFU7p8zm/3TiTIHjOb
 4ooaGAw5Aa96JE/VpnzFZGDCnwTdryMI26wIOHUoNpLavPSwAUAU/9kdP2fK61Z+nt5nfqyqE
 tJWmHOx+x3nfni11q22hBl2ioHVrRr08KEZgs6gyDBIUlCygZ1oo8mGdhXIhecbgSYtnrsK+C
 GowdrnlFFBClau64OgmrHBUrkpH6HlgVldEUo7+wP6ssF9UrmumnMpsXYvSvwZG+L4EgsgYHx
 z/Zrzkd5G8L7IeDJq+8Baic2h+lltxO9vrWzch7XTD6+bpGV/wLLkkrYdcKwKEhKKytu2h+yK
 fUOEYAN//xiWOW89UZb4+NSP9yYDLabHJNmfLMIus8ze0OGfFxy0sTfZpN7f18ULlPQrVmOdb
 oPRBnExJNdMLIObU/l4Ct7CdLBZNcTfHRt3JBv1QAGKoC5IR7DqW2bqEdGoj4xMzRgERlmaez
 LCPoF4+oOTrKmzmzLHCK+mOOCZD6eYq39gsNHwxiPcFX5hT0tCSMVvlbQ6axOerYvqD4+s26M
 jZ9CEX1NV56FLCPNlACfCkNXttel570pUfgPxjZ1TmLyszRp3s3eHytzj/U+E/CXz3xrVW1Eh
 faz1DwqpXE7dXbRKU6VGhjCzSUSc4EvBaG7IodmXhQDlMsJC2Js+EojhOGwCYbl/y/xIB3fzu
 u9d8KsBNlmKugz35thMUdJF4j5QA4SyjINH5RloMTKP69ncSd5nd0Y4NUCtL67qDtmmQm/2FL
 eKE0ub6FS6jeDcZmujL+72KEXKTWbiwr7mb0gMNQlRlsk5tWh2zhksBr53yK7xY1/CrW4H2hl
 cNsGTQ==


Hi,

On 13.12.23 14:00, Manikanta Guntupalli wrote:

>
> +/**
> + * cdns_rs485_rx_callback - Timer rx callback handler for rs485.
> + * @t: Handle to the timer list structure
> + */
> +static void cdns_rs485_rx_callback(struct timer_list *t)
> +{
> +	struct cdns_uart *cdns_uart =3D from_timer(cdns_uart, t, timer);
> +
> +	/*
> +	 * Default Rx should be setup, because Rx signaling path
> +	 * need to enable to receive data.
> +	 */
> +	cdns_rs485_rx_setup(cdns_uart);
> +}
> +
> +/**
> + * cdns_rs485_tx_callback - Timer tx callback handler for rs485.
> + * @t: Handle to the timer list structure
> + */
> +static void cdns_rs485_tx_callback(struct timer_list *t)
> +{
> +	struct cdns_uart *cdns_uart =3D from_timer(cdns_uart, t, timer);
> +
> +	cdns_uart_handle_tx(cdns_uart->port);

This is called without holding the port lock now. Are you sure the lock is=
 not
needed? AFAIK the port lock is needed at least for accessing the circular
buffer.

> +
> +	/* Enable the TX Empty interrupt */
> +	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + CDNS_UART_IER=
);
> +
> +	if (uart_circ_empty(&cdns_uart->port->state->xmit) ||
> +	    uart_tx_stopped(cdns_uart->port)) {
> +		timer_setup(&cdns_uart->timer, cdns_rs485_rx_callback, 0);
> +		mod_timer(&cdns_uart->timer, jiffies +
> +			  msecs_to_jiffies(cdns_uart->port->rs485.delay_rts_after_send));
> +	}
> +}

Regards,
Lino

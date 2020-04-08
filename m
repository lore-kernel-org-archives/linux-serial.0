Return-Path: <SRS0=0Mhk=5Y=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05604C2D0EA
	for <linux-serial@archiver.kernel.org>; Wed,  8 Apr 2020 15:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D039A20730
	for <linux-serial@archiver.kernel.org>; Wed,  8 Apr 2020 15:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgDHPvI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:51:08 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:44597 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729176AbgDHPvI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Apr 2020 11:51:08 -0400
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.11 beta 1) with ESMTPA;
        Wed, 8 Apr 2020 17:50:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Apr 2020 17:50:32 +0200
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH] serial: uartps: Wait for tx_empty in console setup
In-Reply-To: <1586278391-9061-1-git-send-email-raviteja.narayanam@xilinx.com>
References: <1586278391-9061-1-git-send-email-raviteja.narayanam@xilinx.com>
Message-ID: <396bcf8a0068fc05e70cc439a4843b61@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-04-07 18:53, Raviteja Narayanam wrote:
> On some platforms, the log is corrupted while console is being
> registered. It is observed that when set_termios is called, there
> are still some bytes in the FIFO to be transmitted.
> 
> So, wait for tx_empty inside cdns_uart_console_setup before
> calling set_termios.
> 
> Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c
> b/drivers/tty/serial/xilinx_uartps.c
> index 6b26f76..23468ff 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1260,6 +1260,8 @@ static int cdns_uart_console_setup(struct
> console *co, char *options)
>  	int bits = 8;
>  	int parity = 'n';
>  	int flow = 'n';
> +	unsigned long time_out = jiffies + usecs_to_jiffies(TX_TIMEOUT);
> +	int status;
> 
>  	if (!port->membase) {
>  		pr_debug("console on " CDNS_UART_TTY_NAME "%i not present\n",
> @@ -1270,6 +1272,14 @@ static int cdns_uart_console_setup(struct
> console *co, char *options)
>  	if (options)
>  		uart_parse_options(options, &baud, &parity, &bits, &flow);
> 
> +	/* Wait for tx_empty before setting up the console */
> +	while (time_before(jiffies, time_out)) {
> +		status = cdns_uart_tx_empty(port);
> +		if (status == TIOCSER_TEMT)
> +			break;
> +		cpu_relax();
> +	}
> +
>  	return uart_set_options(port, co, baud, parity, bits, flow);
>  }
>  #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */

You could do without the status variable. You could even combine the
while and if conditions.

And while you're at it, you might as well also rewrite the lines
1236-1238 to also use cdns_uart_tx_empty() for clarity.

Maarten


Return-Path: <SRS0=CtGi=5G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237A3C4332B
	for <linux-serial@archiver.kernel.org>; Sat, 21 Mar 2020 10:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F283A2072C
	for <linux-serial@archiver.kernel.org>; Sat, 21 Mar 2020 10:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgCUKhp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:37:45 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:50212 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726607AbgCUKhp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Mar 2020 06:37:45 -0400
X-Greylist: delayed 1811 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Mar 2020 06:37:44 EDT
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.11 beta 1) with ESMTPA;
        Sat, 21 Mar 2020 11:07:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 21 Mar 2020 11:07:10 +0100
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH v4 2/2] serial: uartps: Add TACTIVE check in
 cdns_uart_tx_empty function
In-Reply-To: <e2514818af5973be291cc117d07739f068b71639.1584610774.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1584610774.git.shubhrajyoti.datta@xilinx.com>
 <e2514818af5973be291cc117d07739f068b71639.1584610774.git.shubhrajyoti.datta@xilinx.com>
Message-ID: <afd6fd6bc3413692ee91123fc3028583@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-03-19 10:44, Shubhrajyoti Datta wrote:
> From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> 
> Make sure that all bytes are transmitted out of Uart by monitoring
> CDNS_UART_SR_TACTIVE bit as well.
> 
> Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c
> b/drivers/tty/serial/xilinx_uartps.c
> index 662b8ab..38cb76a9 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -663,8 +663,8 @@ static unsigned int cdns_uart_tx_empty(struct
> uart_port *port)
>  	unsigned int status;
> 
>  	status = readl(port->membase + CDNS_UART_SR) &
> -				CDNS_UART_SR_TXEMPTY;
> -	return status ? TIOCSER_TEMT : 0;
> +		       (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
> +	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
>  }
> 
>  /**

Acked-by: Maarten Brock <m.brock@vanmierlo.com>


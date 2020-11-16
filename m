Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7AFC6379D
	for <linux-serial@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB9320853
	for <linux-serial@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgKPLZl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Nov 2020 06:25:41 -0500
Received: from fieber.vanmierlo.com ([84.243.197.177]:39456 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729110AbgKPLZl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Nov 2020 06:25:41 -0500
X-Greylist: delayed 1816 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 06:25:40 EST
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.12 patch 1) with ESMTPA;
        Mon, 16 Nov 2020 11:55:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Nov 2020 11:55:01 +0100
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 22/36] tty: serial: xilinx_uartps: Supply description for
 missing member 'cts_override'
In-Reply-To: <20201104193549.4026187-23-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-23-lee.jones@linaro.org>
Message-ID: <230a462dd8d22fc8cd9dc6f4827edf04@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-11-04 20:35, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/tty/serial/xilinx_uartps.c:205: warning: Function parameter
> or member 'cts_override' not described in 'cdns_uart'
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c
> b/drivers/tty/serial/xilinx_uartps.c
> index a9b1ee27183a7..a14c5d9964739 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -192,6 +192,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
>   * @baud:		Current baud rate
>   * @clk_rate_change_nb:	Notifier block for clock changes
>   * @quirks:		Flags for RXBS support.
> + * @cts_override:	Modem control state override
>   */
>  struct cdns_uart {
>  	struct uart_port	*port;

While you are at it, would you consider to also fix the indentation of 
the
cts_override flag at line 208?

Maarten


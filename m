Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0A6C43217
	for <linux-serial@archiver.kernel.org>; Thu,  1 Dec 2022 12:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiLAMJl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Dec 2022 07:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLAMJk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Dec 2022 07:09:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872BC94565
        for <linux-serial@vger.kernel.org>; Thu,  1 Dec 2022 04:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669896579; x=1701432579;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c2A3JlbdQzPIBwuXqYqtYZK3Lxugj8gZL6mBVUWZu0s=;
  b=GW3xL5Z5JWGO+KafMb3yF1NrJ6msc1AaoNSrwde8odTl7jahzs1UaSuX
   2qXXzFpEvuMZ3uWqq1M27Hp5Wc4UHr0HoI00kRWlcqXYz+7HSIgoH7CF3
   SdlkJvXjloehKn7jrg31BoCAg09Avs/kWtqSWt9wsqEorjBoocjt+57eJ
   iupjRTpAybozEzGjtjzqC4cBQh0H9ol1reDyqDrjDQ3UVQNaFbWaE8Gdk
   l7mY2c9Ps7DhbmQKEFyDdwkmCOHzZMjsmJgjFsDzsslUAEOViGxGIShCW
   kcAmRZLz6ksW68qim48EW11MiZ+q0WuaTTs0ngGWMTQmOfI21NGS3XU36
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313298019"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="313298019"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 04:09:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="595042881"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="595042881"
Received: from akoroglu-mobl.ger.corp.intel.com ([10.251.212.165])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 04:09:35 -0800
Date:   Thu, 1 Dec 2022 14:09:32 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, marex@denx.de,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexander Dahl <ada@thorsis.com>, kernel@dh-electronics.com,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH V3 4/4] serial: stm32: Add support for rs485 RX_DURING_TX
 output GPIO
In-Reply-To: <20221201110237.7917-4-cniedermaier@dh-electronics.com>
Message-ID: <2d909d7f-9c6-474-ce15-76a55fdafed3@linux.intel.com>
References: <20221201110237.7917-1-cniedermaier@dh-electronics.com> <20221201110237.7917-4-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 1 Dec 2022, Christoph Niedermaier wrote:

> If a RX_DURING_TX GPIO is defined by the DT property "rs485-rx-during-tx-gpios"
> this patch switches this GPIO accordingly to the RS485 flag RX_DURING_TX in user
> space. Controlled by this GPIO, now the hardware is responsible for connecting
> or disconnecting RX during TX.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Alexander Dahl <ada@thorsis.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-serial@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: - Rework of the commit message
> V3: - No changes
> ---
>  drivers/tty/serial/stm32-usart.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index a1490033aa16..0f2cca9054ba 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -226,7 +226,14 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
>  
>  	stm32_usart_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
>  
> -	rs485conf->flags |= SER_RS485_RX_DURING_TX;
> +	if (port->rs485_rx_during_tx_gpio) {
> +		if (rs485conf->flags & SER_RS485_RX_DURING_TX)
> +			gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio, 1);
> +		else
> +			gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio, 0);

gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
			 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));

And the same comment also for the other patch.

-- 
 i.

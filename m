Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C4C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 28 Nov 2022 14:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiK1OcB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiK1Obr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Nov 2022 09:31:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85707222B8;
        Mon, 28 Nov 2022 06:31:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21B14611CC;
        Mon, 28 Nov 2022 14:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8F8C433C1;
        Mon, 28 Nov 2022 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669645877;
        bh=o6vs9x16gtpUsWQXrNUt1RAdeTIsOsJrIh1//CI7WcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cvl/V8Cdke02ytFWeQMSOfxV3zHGc1NmsEpKtrNhyfgGO1lEP62W2rmIndHnkful9
         lDAHRxaTVcId6ZfW8aNbYOBso3/cQccmdpjo1ztEEqiWLPfaGwPGlWYeR2imhWUSy7
         rSXLFrTckP8/lbRuNZuwnaqZ2eGH66mZ3Kl3WFyzSnGlGJCsr2eBMKdKhfBsdd/76S
         n98FZztU6y9Btv0HpPpxEy0FfVIUPvSXLpEMKttXHdLtim9fhJ1rnUE9S5YXj5OEV6
         01bOaG93q2gw3gOPcdhXAQW4QcXmjg/Uu/C3zrcERB5q3obnQwXku1CjvvpX4fDOf1
         AJ27pLmtsPKzA==
Date:   Mon, 28 Nov 2022 22:21:23 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/9] serial: bflb_uart: add Bouffalolab UART Driver
Message-ID: <Y4TD48v84CJcMS+S@xhacker>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-3-jszhang@kernel.org>
 <c0406076-04e1-6b81-1bba-ac684516d898@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0406076-04e1-6b81-1bba-ac684516d898@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 28, 2022 at 07:10:41AM +0100, Jiri Slaby wrote:
> On 27. 11. 22, 14:24, Jisheng Zhang wrote:
> > +static void bflb_uart_tx_chars(struct uart_port *port)
> 
> Again:
> 
> Are you unable to use the TX helper? If so:

You know serial subsystem better than me, may I ask for more
details? For example,
Besides uart_xmit_advance(), do you expect other TX helpers? If yes,
can you please list them?

> * why?
> * use uart_advance_xmit() at least.

Do you mean uart_xmit_advance()? in the do while loop below?

I'm not sure I understand the meaning, correct me If I misunderstand
something.

thanks
> 
> > +{
> > +	struct circ_buf *xmit = &port->state->xmit;
> > +	unsigned int count;
> > +
> > +	if (port->x_char) {
> > +		/* Send special char - probably flow control */
> > +		wrl(port, UART_FIFO_WDATA, port->x_char);
> > +		port->x_char = 0;
> > +		port->icount.tx++;
> > +		return;
> > +	}
> > +
> > +	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> > +		bflb_uart_stop_tx(port);
> > +		return;
> > +	}
> > +
> > +	count = BFLB_UART_TX_FIFO_TH;
> > +	do {
> > +		wrl(port, UART_FIFO_WDATA, xmit->buf[xmit->tail]);
> > +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> > +		port->icount.tx++;
> > +		if (uart_circ_empty(xmit))
> > +			break;
> > +	} while (--count > 0);
> > +
> > +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > +		uart_write_wakeup(port);
> > +
> > +	if (uart_circ_empty(xmit))
> > +		bflb_uart_stop_tx(port);
> > +}
> 
> -- 
> js
> suse labs
> 

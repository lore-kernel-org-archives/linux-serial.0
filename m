Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FBAC433B4
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 06:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397C361355
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 06:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhESGgo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 02:36:44 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56505 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236954AbhESGgo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 02:36:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id B3D45580D4A;
        Wed, 19 May 2021 02:35:24 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 19 May 2021 02:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=jS0Qnsk+x812+QOJj7P8LcihXVmZ9by
        +e5Cbm2C4ce0=; b=Q9R1crHIzEfmhvsoE2ER+21RAh9fslXaQfzwLrfN+h0D9Kv
        2mmCdtZr0E/7BSeF0FmPn1GGN4GEsl1UqaWRA+eXN48t7VJbWU0V/qVnFgB4Q96z
        0JZVQT8Rnk0DEmgVl7joC1/MPGOnhd5kjEGhkoY/lL/IcpJeMJzpg+JEhbauGfi2
        xaPGhmy88Xex1GN/rUqR0Bk6SpPMm8TAYpNsFRX0K21rWk2n5IzSK5hNjT/7pCeO
        AXQ0i8D2BSoI3nlO2jeQ9MCxZVTgoNEkH5dCI9zRfFkqx3qVE0HOtOYNBYehCOzf
        JDA5joHwgyNQ0m9tV41FI4pXQl6JbkquFFeI87g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jS0Qns
        k+x812+QOJj7P8LcihXVmZ9by+e5Cbm2C4ce0=; b=dYK4lyCr9+O0BJhH0F4P/Q
        D2P3nY0k/GU+kwyex5nGCCyc09Jp8BGwoRfBejOCj5Pd6+V0hugbtIFehUwIwUAv
        lpID4DrAE3mtwoDl6DdX3OJjlhMU+eLC4bkQqT+E+rNatx4TIrnGx283TyungFyn
        dyXW6DsJuB2BliAYQ/zsZO/rVHega9dagOYUdXLk0+6TX6mymnglNbaUSzSUmQe0
        fjH5ZLH3q5SrfCy9I2CT9gINNdQDOGERmiPog9NRwwlbXxJrxAkRSZ/Yfr8HM136
        e2HR2RRciequKu5qyz+eMw1rG+HJIB00OLBUFffcNucel44lOEj50Idn+JRBTTtw
        ==
X-ME-Sender: <xms:q7GkYAECxc8l-CVyxQd4nRbLi4rjOkQziEhICc2cd-8zKQ8A9bd3NA>
    <xme:q7GkYJXckHWe6h2h8tzlGL4GuxRB2sc6TfTHbYBsnZOQyJki-JqmC8FLaJu2Q1QNj
    K98Shm_Znef2O1nsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeikedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedv
    hefhveeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:q7GkYKIhmLu5d2Q0SEe67oaztuO86hMRqsrtGprUulY3nLvKGkTf_w>
    <xmx:q7GkYCFKOVAXvseAXgyT_FX2hKEct1lY9xeCcJALbfOygekgUH6ZgQ>
    <xmx:q7GkYGX6rdGx28TrGTkHPqxPijntydqAGVhCUTRnlppq-v_boVmI4A>
    <xmx:rLGkYKq2-gb8mBXnILBc_IoPgyI61INShkiHEWDTvz3XW6opqkNESw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8BF9FA00079; Wed, 19 May 2021 02:35:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <53e8d6d3-bccc-4c80-8e7d-ea4d3f7ff488@www.fastmail.com>
In-Reply-To: <a67f0c95-7708-569f-099b-db9e2ad9616d@kernel.org>
References: <20210519000704.3661773-1-andrew@aj.id.au>
 <20210519000704.3661773-3-andrew@aj.id.au>
 <56ec152a-560b-1eed-97e2-c12e4fed171a@kernel.org>
 <2bb7dfc4-a20e-4e3e-8fa5-74ff264c4e44@www.fastmail.com>
 <a67f0c95-7708-569f-099b-db9e2ad9616d@kernel.org>
Date:   Wed, 19 May 2021 16:05:02 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Jiri Slaby" <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Joel Stanley" <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, "Ryan Chen" <ryan_chen@aspeedtech.com>,
        "Milton Miller II" <miltonm@us.ibm.com>
Subject: Re: [PATCH v2 2/2] serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Wed, 19 May 2021, at 16:02, Jiri Slaby wrote:
> On 19. 05. 21, 8:27, Andrew Jeffery wrote:
> > 
> > 
> > On Wed, 19 May 2021, at 15:44, Jiri Slaby wrote:
> >> On 19. 05. 21, 2:07, Andrew Jeffery wrote:
> >>> BIT(x) improves readability and safety with respect to shifts.
> >>>
> >>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >>> ---
> >>>    drivers/tty/serial/8250/8250.h | 33 +++++++++++++++++----------------
> >>>    1 file changed, 17 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> >>> index 34aa2714f3c9..4fbf1088fad8 100644
> >>> --- a/drivers/tty/serial/8250/8250.h
> >>> +++ b/drivers/tty/serial/8250/8250.h
> >>> @@ -7,6 +7,7 @@
> >>>     *  Copyright (C) 2001 Russell King.
> >>>     */
> >>>    
> >>> +#include <linux/bitops.h>
> >>>    #include <linux/serial_8250.h>
> >>>    #include <linux/serial_reg.h>
> >>>    #include <linux/dmaengine.h>
> >>> @@ -70,25 +71,25 @@ struct serial8250_config {
> >>>    	unsigned int	flags;
> >>>    };
> >>>    
> >>> -#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
> >>> -#define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
> >>> -#define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
> >>> -#define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
> >>> -#define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
> >>> -#define UART_CAP_RTOIE	(1 << 13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
> >>> -#define UART_CAP_HFIFO	(1 << 14)	/* UART has a "hidden" FIFO */
> >>> -#define UART_CAP_RPM	(1 << 15)	/* Runtime PM is active while idle */
> >>> -#define UART_CAP_IRDA	(1 << 16)	/* UART supports IrDA line discipline */
> >>> -#define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
> >>> +#define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
> >>> +#define UART_CAP_EFR	BIT(9)	/* UART has EFR */
> >>> +#define UART_CAP_SLEEP	BIT(10)	/* UART has IER sleep */
> >>
> >>
> >> Perfect, except the include: BIT is not defined in bitops.h, but in
> >> bits.h (which includes vdso/bits.h). In fact, bitops.h includes bits.h
> >> too, but it's superfluous to include all those bitops.
> > 
> > Maybe the recommendation in the checkpatch documentation should be
> > fixed then?
> 
> +1 since:
> 
> commit 8bd9cb51daac89337295b6f037b0486911e1b408
> Author: Will Deacon <will@kernel.org>
> Date:   Tue Jun 19 13:53:08 2018 +0100
> 
>      locking/atomics, asm-generic: Move some macros from 
> <linux/bitops.h> to a new <linux/bits.h> file
> 
> So care to fix checkpatch too :)?

Yeah, I'll sort that out.

Andrew

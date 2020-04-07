Return-Path: <SRS0=8eBw=5X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61D7C2BA80
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 07:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDE420747
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 07:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586244155;
	bh=Q27V+A2JX8XPv0ScoBfKnA5v3xkz+y1ZgJjp3nEk5SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hn7/wlr2lAhOahPYV/wlBore128phNPB0x0DOdDYJkbz1fqUlTHR1p/tmnSOZYs9q
	 idKWfN605SsfUuJFAfLhQ81fRAT4Ur59uaOWcodUS7jMUUwCbn7cVj6gGdgjNARzC/
	 INEH5L47TdQDzeg1s5us58yb3BgMQ0HPhrOLhbTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgDGHW1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:22:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37171 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgDGHW1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Apr 2020 03:22:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id de14so2776356edb.4;
        Tue, 07 Apr 2020 00:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2R+3gjNy0SnBLUw5qWy9RI2DQvlFhSy+vrS7w50bWE4=;
        b=m8+AAhZiJIL9VNZQZombf4JhXv8ni3nKHXgrxcFEKM31ImIKDSZXbPIM0bizOmwh1c
         IZ7LNpGPGt6gX0+w+CS9Km3WDJSLymYlWDzfIDHvWmWqv1q0MbCC3RTt74xthYrYkMyZ
         csIm0cd0QwZuyKLqckQzlkuDRTC7QINss+NeX2kQ0palKv6jagXuwvKzuSNJ3EvBxsug
         g1h5Ck+S74owN1qpwENEaKbfwiuZn9IUeguOypRRvMWCwbb/Ly3QugamAzDxSvPwTl+S
         OJWvceqU+HKdZ4NEX3gyNcQ3ds9GukfDjQr9cdmdohUCTLzBY/8fG1VLiWabAJKpkhc4
         tupg==
X-Gm-Message-State: AGi0PuY6STpJdp8e1MKVRje0egafGEesjYcrXPNzKc6Rjn72pa+uZEw8
        jnClWoWJx0oz21tYyxLQm6o=
X-Google-Smtp-Source: APiQypIAGwgfjaRfHihsJeJ737ZyX6DGCobU8BkZcdk7Gc5hUQmvmBkfIOK6sewJ+lnv4/IXbMKBwg==
X-Received: by 2002:a50:9b58:: with SMTP id a24mr759017edj.353.1586244144485;
        Tue, 07 Apr 2020 00:22:24 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id qu11sm230130ejb.12.2020.04.07.00.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 00:22:23 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:22:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>, gregkh@linuxfoundation.org,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200407072221.GA18236@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200406230902epcas2p19a8df6805dac59968d664efb9bc9419b@epcas2p1.samsung.com>
 <20200406230855.13772-1-hyunki00.koo@samsung.com>
 <62a918df-b3ba-21f4-b3ad-9f638ad104ad@suse.com>
 <20200407062439.GA21995@kozik-lap>
 <257f278b-ce96-4cfb-85ff-53e123a076f5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <257f278b-ce96-4cfb-85ff-53e123a076f5@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 07, 2020 at 08:32:56AM +0200, Jiri Slaby wrote:
> On 07. 04. 20, 8:24, Krzysztof Kozlowski wrote:
> > On Tue, Apr 07, 2020 at 06:49:29AM +0200, Jiri Slaby wrote:
> >> On 07. 04. 20, 1:08, Hyunki Koo wrote:
> >>> Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> >>>
> >>> This is required for some newer SoCs.
> >>>
> >>> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> >> ...
> >>> ---
> >>>  drivers/tty/serial/samsung_tty.c | 76 +++++++++++++++++++++++++++++++++-------
> >>>  1 file changed, 64 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> >>> index 73f951d65b93..bdf1d4d12cb1 100644
> >>> --- a/drivers/tty/serial/samsung_tty.c
> >>> +++ b/drivers/tty/serial/samsung_tty.c
> >>> @@ -154,12 +154,47 @@ struct s3c24xx_uart_port {
> >> ...
> >>> -#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
> >>> +static void wr_reg(struct uart_port *port, u32 reg, u32 val)
> >>> +{
> >>> +	switch (port->iotype) {
> >>> +	case UPIO_MEM:
> >>> +		writeb_relaxed(val, portaddr(port, reg));
> >>> +		break;
> >>> +	case UPIO_MEM32:
> >>> +		writel_relaxed(val, portaddr(port, reg));
> >>> +		break;
> >>> +	}
> >>> +}
> >>> +
> >>>  #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
> >>>  
> >>> +static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
> >>
> >> You need to explain, why you need this _barrier variant now. This change
> >> should be done in a separate patch too.
> > 
> > There is no functional change in regard of barrier.  The ordered IO was
> > used there before.
> 
> The patch changes one wr_reg to wr_reg_barrier without any explanation.
> This will hardly be accepted.

I cannot find such change... I see only:

@@ -2612,7 +2664,7 @@ static void samsung_early_putc(struct uart_port *port, int c)
-       writeb(c, port->membase + S3C2410_UTXH);
+       wr_reg_barrier(port, S3C2410_UTXH, c);

which is the same except 'b' -> 'b/l'.

Best regards,
Krzysztof


Return-Path: <SRS0=8eBw=5X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00A6C2BA16
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 06:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0A8206F5
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 06:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586240685;
	bh=lFd3xUZgjSLQKT5HvwOd9sO9AYekMLxBd35dCVDxBeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZAP7oRhwJCicEX+7LT2YXAL0BGaTyujpxUShWezO4KhEvu74gNVbqiD0kgXav5ZXq
	 2nLSOo2VFIyu7CCaD6G8aelCshcgExJ0kEHKJEmBkXHQvNAAKirfc2v1Fv8jK3je2v
	 tJIy3fGJO25+kLy1CFZNsyXAD7jGbxbJEsVhzo1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDGGYo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:24:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41610 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGGYo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Apr 2020 02:24:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id v1so2580590edq.8;
        Mon, 06 Apr 2020 23:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XMcoO/jmJQX0wn0jevzXywHIyf04521+JgmN8nTeS/A=;
        b=phF0UoDlzWPfqBruneLgce8E14pUGFOJm0QDerd4uF4dOWLde2v6ALZmDYhO2S6vpg
         yEgefLqn2qBJ94n4TpeXMnfGtQ6zEG3cqZtNuwvzI3R8mVFZU9qUf1FraxVUE5hILxdE
         0ngrjaB4FlMWKBqKlQ5jVZ6o1Q+FUx4XW5lqxZozVTFLLJ3K89GkKneC3o5TCdHQ/PAt
         ld/HPW6lsiDrZT6TsR6ZbTU91RTRfHa37pxMKoO+HAKsF087E0CgTH6suBBH2xD9d5RD
         9MZ6/SmPRt3rba50ah0Fy3rvmvVoFr1B16dYYJhRkyFoVAD7YEHJJoHVPaT4QcnZdFpe
         hT6g==
X-Gm-Message-State: AGi0Pub5987MqfLqtVHzRdlysr/wAwM3hNt6JfMezx+Vb0EuUJsrJXX6
        uu8NOi+BiIRR5IAeMGStsUc=
X-Google-Smtp-Source: APiQypInt6ClyApEfxnhSeElIxNVGVy6nRZPT0xhcqJw0iu1DrDdSZA1qPzNvKgca/CJflqT0TIPMQ==
X-Received: by 2002:a50:e007:: with SMTP id e7mr585733edl.361.1586240682039;
        Mon, 06 Apr 2020 23:24:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id u6sm1243905ejb.68.2020.04.06.23.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 23:24:41 -0700 (PDT)
Date:   Tue, 7 Apr 2020 08:24:39 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>, gregkh@linuxfoundation.org,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200407062439.GA21995@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200406230902epcas2p19a8df6805dac59968d664efb9bc9419b@epcas2p1.samsung.com>
 <20200406230855.13772-1-hyunki00.koo@samsung.com>
 <62a918df-b3ba-21f4-b3ad-9f638ad104ad@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62a918df-b3ba-21f4-b3ad-9f638ad104ad@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 07, 2020 at 06:49:29AM +0200, Jiri Slaby wrote:
> On 07. 04. 20, 1:08, Hyunki Koo wrote:
> > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> > 
> > This is required for some newer SoCs.
> > 
> > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ...
> > ---
> >  drivers/tty/serial/samsung_tty.c | 76 +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 64 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > index 73f951d65b93..bdf1d4d12cb1 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -154,12 +154,47 @@ struct s3c24xx_uart_port {
> ...
> > -#define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
> > +static void wr_reg(struct uart_port *port, u32 reg, u32 val)
> > +{
> > +	switch (port->iotype) {
> > +	case UPIO_MEM:
> > +		writeb_relaxed(val, portaddr(port, reg));
> > +		break;
> > +	case UPIO_MEM32:
> > +		writel_relaxed(val, portaddr(port, reg));
> > +		break;
> > +	}
> > +}
> > +
> >  #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
> >  
> > +static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
> 
> You need to explain, why you need this _barrier variant now. This change
> should be done in a separate patch too.

There is no functional change in regard of barrier.  The ordered IO was
used there before.

Best regards,
Krzysztof


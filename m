Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD380C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 06:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E53661059
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 06:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhESG3k (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 02:29:40 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48121 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhESG3f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 02:29:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7F74B580D37;
        Wed, 19 May 2021 02:28:15 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 19 May 2021 02:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=ZQqIDNjegD+sDLfm5aGwnybvoXnL4d+
        m25V093T+MCk=; b=IAlTlTk/SoQiNwmA80MnW0XoVydNXktP3zTa9kv77qM7SDU
        Irn6xqQH0a0hMTDvR+efIIZSRPp0v6gteRp5OcuJvpRHhEPfTb7fChbCpdXiT8Xd
        xn1L5DDqLw2+ZcZdk6PT3IFJ27l/AYcgAixUPTD0XUNUaJFcTR7yTWvuDDLCHX/I
        uSFpQ3bfiBT+aLHixvDsKFByJJTVtPd4IxDe9sQuOMUjGmjoLRXYS2UwKK88+rSK
        TWhazV/vKiLIA/T78Ne6AY+cga1DPB4MyyMsEnjZHxe4ZseKFJ3bzq0KvvauKDr6
        c7zfFHJFYOzvS3ezutmLvRs+hNf/yz2D3rt/SMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZQqIDN
        jegD+sDLfm5aGwnybvoXnL4d+m25V093T+MCk=; b=rqUBadeIeBeUvBDi9c+IuK
        +JmxFjGQXQZChGk6T9WrzEQ7GGw2KY+nU3zwm66tcMfoKkhQyp+rX073hegad+j6
        VXjiyctLWbjIhCtUEErcNxbvwZSmZ6JcCtHIyrm/XnbImmACIoycZ5dsKVFD58E4
        XlsCPnNmRiKcRsJUZcRApHm+APZS8JJ5tj1Z32fGsOigUjV9UtN//sfjkvb6zqFH
        GR1jMlx92bTAiWtE6qPUi2D7i/5mTwtkmIoDA34AyqtmV7vI3at6+ltUxxP1jHIy
        ShPde321oeSZflusKhcsDCD0HftYbwaEkRsVhMGWszIyeOkarguTkhcSad8cchTQ
        ==
X-ME-Sender: <xms:_q-kYKycpXMLw8AQ1PQgAVN52MW9TSzhWR63jWwoJmH2Cg8t1NjM3Q>
    <xme:_q-kYGRZzObRj1viunLQ2QWCKWXgtag7hBTYcX3luh1EryiiXVCgU_uhIot6SHFOW
    7l6Wo5T4ejthVH9-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeikedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeduffdtvdevkeffgfetffffueevgeejleeghfffjedthedthfelgfek
    fefhfeekieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgr
    uh
X-ME-Proxy: <xmx:_q-kYMU_4vShvTrxTCNFqHjPWUo9l6y6NCSyQC8LHMinI-8kUxyjOg>
    <xmx:_q-kYAiRH24iwWvK1nsliTYRPcUKrQ_UngVnEUlz35rPltCXOaFpJg>
    <xmx:_q-kYMC0YR-rtkOBYc-kexg0WbpyEIyvGuCrp6wTwNbCJMIEZmIvsg>
    <xmx:_6-kYI2j5O5WLzbC6WAmNZJpbRiVZBhcj9c3AELIlElJIrUer-1jmA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1C47AA0007A; Wed, 19 May 2021 02:28:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <2bb7dfc4-a20e-4e3e-8fa5-74ff264c4e44@www.fastmail.com>
In-Reply-To: <56ec152a-560b-1eed-97e2-c12e4fed171a@kernel.org>
References: <20210519000704.3661773-1-andrew@aj.id.au>
 <20210519000704.3661773-3-andrew@aj.id.au>
 <56ec152a-560b-1eed-97e2-c12e4fed171a@kernel.org>
Date:   Wed, 19 May 2021 15:57:47 +0930
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



On Wed, 19 May 2021, at 15:44, Jiri Slaby wrote:
> On 19. 05. 21, 2:07, Andrew Jeffery wrote:
> > BIT(x) improves readability and safety with respect to shifts.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >   drivers/tty/serial/8250/8250.h | 33 +++++++++++++++++----------------
> >   1 file changed, 17 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> > index 34aa2714f3c9..4fbf1088fad8 100644
> > --- a/drivers/tty/serial/8250/8250.h
> > +++ b/drivers/tty/serial/8250/8250.h
> > @@ -7,6 +7,7 @@
> >    *  Copyright (C) 2001 Russell King.
> >    */
> >   
> > +#include <linux/bitops.h>
> >   #include <linux/serial_8250.h>
> >   #include <linux/serial_reg.h>
> >   #include <linux/dmaengine.h>
> > @@ -70,25 +71,25 @@ struct serial8250_config {
> >   	unsigned int	flags;
> >   };
> >   
> > -#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
> > -#define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
> > -#define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
> > -#define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
> > -#define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
> > -#define UART_CAP_RTOIE	(1 << 13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
> > -#define UART_CAP_HFIFO	(1 << 14)	/* UART has a "hidden" FIFO */
> > -#define UART_CAP_RPM	(1 << 15)	/* Runtime PM is active while idle */
> > -#define UART_CAP_IRDA	(1 << 16)	/* UART supports IrDA line discipline */
> > -#define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
> > +#define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
> > +#define UART_CAP_EFR	BIT(9)	/* UART has EFR */
> > +#define UART_CAP_SLEEP	BIT(10)	/* UART has IER sleep */
> 
> 
> Perfect, except the include: BIT is not defined in bitops.h, but in 
> bits.h (which includes vdso/bits.h). In fact, bitops.h includes bits.h 
> too, but it's superfluous to include all those bitops.

Maybe the recommendation in the checkpatch documentation should be 
fixed then?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/checkpatch.rst?h=v5.13-rc2#n473

I didn't dig through the include maze to optimise my choice.

That said, I will switch to bits.h based on your feedback above.

Thanks,

Andrew

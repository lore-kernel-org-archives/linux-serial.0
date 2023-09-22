Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC2EE7D0C2
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 04:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjIVEKK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 00:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVEKJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 00:10:09 -0400
X-Greylist: delayed 449 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 21:10:01 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4FEF1
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 21:10:01 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4C23A2802B8B8;
        Fri, 22 Sep 2023 06:02:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2E7BD2CDB1; Fri, 22 Sep 2023 06:02:28 +0200 (CEST)
Date:   Fri, 22 Sep 2023 06:02:28 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH tty-linus] serial: Reduce spinlocked portion of
 uart_rs485_config()
Message-ID: <20230922040228.GA9800@wunner.de>
References: <f3a35967c28b32f3c6432d0aa5936e6a9908282d.1695307688.git.lukas@wunner.de>
 <9888a15-d626-d262-203f-b5f49fa4494@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9888a15-d626-d262-203f-b5f49fa4494@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 21, 2023 at 06:01:41PM +0300, Ilpo Järvinen wrote:
> On Thu, 21 Sep 2023, Lukas Wunner wrote:
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -1404,12 +1404,18 @@ static void uart_set_rs485_termination(struct uart_port *port,
> >  static int uart_rs485_config(struct uart_port *port)
> >  {
> >  	struct serial_rs485 *rs485 = &port->rs485;
> > +	unsigned long flags;
> >  	int ret;
> >  
> > +	if (!(rs485->flags & SER_RS485_ENABLED))
> > +		return 0;
> > +
> >  	uart_sanitize_serial_rs485(port, rs485);
> 
> There's a subtle change in behavior here, uart_sanitize_serial_rs485() 
> memset()s rs485 if RS485 is not enabled but the early return above does 
> not.

The two callers of uart_rs485_config() only call it if
(!(uport->rs485.flags & SER_RS485_ENABLED)).

Adding that early return ensures that the behavior doesn't change.

So I don't quite see why you think there's a change in behavior?
Am I missing something?

Thanks,

Lukas

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46979C4332B
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 17:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF1623125
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 17:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391055AbhALRr0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:47:26 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:47494 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389660AbhALRr0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jan 2021 12:47:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id E40B411FFB1;
        Tue, 12 Jan 2021 18:46:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1610473602;
        bh=//DIcFXDZIAYmFU2LDqtdLkGc3tYcmYhiwmP/GcTx3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mv0LnyYFLowUG3bUX6y6qwcecYBu/ZTnMRD4vmpYc55ZESt3n4JMETbLiE7EYRGip
         EFMIj7jzpTzb5bT0JxW1APTCEPjThwXqYKuv0L4MVsICsIjKX+Un4LQZawyHnYGB+n
         ygPd3byxsTn/SeysROoq7+QTlkEJdqLeAgLBdd6tQApvWGXslf+0C/RWLcmZFilAb/
         b8gR7c2EKZpGc07zwsjj9vI5WxDUq0wGTeQehQySa4pRVjKUS6k2JPC2Oln28T53Ez
         xjVjH9I6eNhf4tW4/AHsTZiksZLwV39SvCEf1bgib55VU5lF3ZdxXGtgbqfMzAQCDK
         ILBgRNZn5vwig==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2wTmrbJY3-u0; Tue, 12 Jan 2021 18:46:16 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 88B7C11FFAC;
        Tue, 12 Jan 2021 18:46:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1610473576;
        bh=//DIcFXDZIAYmFU2LDqtdLkGc3tYcmYhiwmP/GcTx3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tig1Hp130I94YYjJ3L3vecbHhZfPopyLIwHPEs2A2BuGOjU3eBHsomv65WJUnhGZ1
         GDXQAHBA5v3SJ0syJB++lRkcyTKe1PUoLxHc+aCrWViMgNYXhwhdTB+vJ7wNlAvSrs
         h5EXQfBqmeLenBOsG2GtlzWYhr2ejUhdZI7lk9OJh40qPacYYC/wZTLlTENIFbzQYh
         ZL235ajM+rkOyqBxdVbabcoK1ypkQeFsVkZoAdtHzd/KPvULQT7A7BF8m96pKQrnhf
         8poKXE9lEvxVip/CkgdLe2ieuHOef4oc1VdwD7EEGkCY8yELL6r+RXMH3QQmhiWKU8
         IINC7SEZqhbwg==
Date:   Tue, 12 Jan 2021 17:46:13 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] Serial: silabs si4455 serial driver
Message-ID: <20210112174613.GA8782@dev>
References: <20210112101831.GA12483@dev>
 <X/15uOstG/7bj2Lm@kroah.com>
 <20210112154322.GA31198@dev>
 <X/3KnP3S4siAxTfG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X/3KnP3S4siAxTfG@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 12, 2021 at 05:13:16PM +0100, 'Greg Kroah-Hartman' wrote:
> On Tue, Jan 12, 2021 at 03:43:22PM +0000, József Horváth wrote:
> > On Tue, Jan 12, 2021 at 11:28:08AM +0100, 'Greg Kroah-Hartman' wrote:
> > > On Tue, Jan 12, 2021 at 10:18:33AM +0000, Jozsef Horvath wrote:
> > > > --- a/include/uapi/linux/serial_core.h
> > > > +++ b/include/uapi/linux/serial_core.h
> > > > @@ -279,4 +279,7 @@
> > > >  /* Freescale LINFlexD UART */
> > > >  #define PORT_LINFLEXUART	122
> > > >  
> > > > +/* Silicon Labs SI4455 */
> > > > +#define PORT_SI4455     123
> > > 
> > > What userspace tool is going to need this value?
> > 
> > The PORT_SI4455 is defined for using as port type value in struct uart_port.
> > I checked other serial drivers under drivers/tty/serial and the port types
> > used by serial drivers are defined in two places:
> > 
> > include/uapi/linux/serial_core.h
> > include/uapi/linux/serial.h
> > 
> > The port type is required by serial_core, and its value goes back to
> > user space with TIOCGSERIAL ioctl call.
> 
> What is it required for?  Who uses this?
> 
> > I can't set port type value to 0(PORT_UNKNOWN).
> 
> Why not?

In drivers/tty/serial/serial_core.c
1784:	uart_port_activate(...)
1799:		->	uart_startup(...)
260:			->	uart_port_startup(...)

183:	static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
184:			int init_hw)
...
191:		if (uport->type == PORT_UNKNOWN)
192:			return 1;
...
221:		retval = uport->ops->startup(uport);	<--This is the reason. The drivers
 startup function is not get called if type==PORT_UNKNOWN
...

> 
> > I think my drivers source is not the best place to defining PORT_SI4455,
> >  but I can't find better place then include/uapi/linux/serial_core.h
> > 
> > Could you please help me where is the correct location for this definition?
> 
> I ask as I am trying to figure out why we keep adding these ids, yet no
> tool that i know of seems to actually use them.
> 
> If you don't have a tool that needs to use a new id, then I would
> recommend not adding it, right?

This definition is not my requirement, but I would avoid collision with other
 drivers port type value.
At this point as I understand your words, these definitions will be obsolete
 or optional soon and I can choose any value for drivers port type.

Right?

I would ask you about dev name (ttySSi).
Is it okay?

I didnt find any similar.

> 
> thanks,
> 
> greg k-h

Üdvözlettel / Best regards:
József Horváth


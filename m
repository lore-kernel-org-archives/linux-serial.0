Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329B8C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 09:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C4920643
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 09:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgERJTG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 05:19:06 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:45337 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgERJTG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 05:19:06 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 0FD1F2800B6F4;
        Mon, 18 May 2020 11:19:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D09523A19E0; Mon, 18 May 2020 11:19:03 +0200 (CEST)
Date:   Mon, 18 May 2020 11:19:03 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH v3 3/5] serial: 8250: Support separate rs485 rx-enable
 GPIO
Message-ID: <20200518091903.4rj5exdfrb53vfzz@wunner.de>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-4-heiko@sntech.de>
 <20200518045006.s6e5aedgqwreqgd7@wunner.de>
 <2693913.H5ugjTTm6y@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2693913.H5ugjTTm6y@diego>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 18, 2020 at 10:04:05AM +0200, Heiko Stübner wrote:
> Am Montag, 18. Mai 2020, 06:50:06 CEST schrieb Lukas Wunner:
> > On Sun, May 17, 2020 at 11:56:08PM +0200, Heiko Stuebner wrote:
> > > @@ -1457,6 +1458,7 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
> > >  	 * Enable previously disabled RX interrupts.
> > >  	 */
> > >  	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> > > +		gpiod_set_value(port->rs485_re_gpio, 1);
> > >  		serial8250_clear_and_reinit_fifos(p);
> > >  
> > >  		p->ier |= UART_IER_RLSI | UART_IER_RDI;
> > 
> > The added line needs to be conditional on if (port->rs485_re_gpio)
> > because the gpiod could be NULL and gpiod_set_value() doesn't check
> > for that.
> 
> Need to look deeper at the other comment below, but gpiod_set_value does
> check for NULL ;-)

I'll be damned.  That means I should respin my patch [4/4] and
drop the NULL check. :-/

Thanks!

Lukas

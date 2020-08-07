Return-Path: <SRS0=6PWm=BR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9471CC433DF
	for <linux-serial@archiver.kernel.org>; Fri,  7 Aug 2020 09:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A64221E5
	for <linux-serial@archiver.kernel.org>; Fri,  7 Aug 2020 09:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596793708;
	bh=PcmJrNmkKXFSnXfYxarKgwFKdUaxsn6gLY15nHsiy+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uYwla5RlrARS4aZU6O9FC3pC2v/fRe6QCo0dld1tlpzNiKAWe9cul9tLP98vxTvEM
	 A/cJAN1AP58Ey1WSEUGV6PWudkTu/A0B798A2DHTe3ToUHhy08WXFcNlrESiORwDE3
	 OlvcMlAXHj/Ba7L52MBbCRET6TS8c9mtQ5WyJXPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHGJsZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgHGJsW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 Aug 2020 05:48:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF779221E5;
        Fri,  7 Aug 2020 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596793701;
        bh=PcmJrNmkKXFSnXfYxarKgwFKdUaxsn6gLY15nHsiy+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWlFBRPJWUoSvqida/H+MLdkn5zPYE2eiHgUT700CFRHSU4WWIGWrhOFZZqMXEhGZ
         dBZ4/83WIu2m1P2cfHnH9ABh7DcVOHkuzsxDetFbqFv9soht4uZMK59kJ9EeE/V6Qq
         OC3Bqt7FJ1bJSY7bWr1/zZYn8jpEhNsyJ+RdKMRs=
Date:   Fri, 7 Aug 2020 11:48:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= 
        <JohnsonCH.Chen@moxa.com>
Cc:     Jiri Slaby <jirislaby@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jason Chen =?utf-8?B?KOmZs+WFhuWFiCk=?= <Jason.Chen@moxa.com>,
        Victor Yu =?utf-8?B?KOa4uOWLnee+qSk=?= <victor.yu@moxa.com>,
        Danny Lin =?utf-8?B?KOael+aUv+aYkyk=?= <danny.lin@moxa.com>
Subject: Re: [PATCH] tty: Add MOXA NPort Real TTY Driver
Message-ID: <20200807094834.GA3069990@kroah.com>
References: <HK2PR01MB328134FB2EF5F9D1E381BDA3FA610@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <7b190f5c-c2f4-032a-af89-444a1f7d9a80@gmail.com>
 <HK2PR01MB328115306D9656E2E95D85ECFA490@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK2PR01MB328115306D9656E2E95D85ECFA490@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 07, 2020 at 09:18:57AM +0000, Johnson CH Chen (陳昭勳) wrote:
> > > +	if (info->modem_control & UART_MCR_RTS)
> > > +		nd->cmd_buffer[6] = 1;
> > > +	else
> > > +		nd->cmd_buffer[6] = 0;
> > > +
> > > +	if (termio->c_cflag & CRTSCTS) {
> > > +		nd->cmd_buffer[7] = 1;
> > > +		nd->cmd_buffer[8] = 1;
> > > +	} else {
> > > +		nd->cmd_buffer[7] = 0;
> > > +		nd->cmd_buffer[8] = 0;
> > > +	}
> > > +
> > > +	if (termio->c_iflag & IXON)
> > > +		nd->cmd_buffer[9] = 1;
> > > +	else
> > > +		nd->cmd_buffer[9] = 0;
> > > +
> > > +	if (termio->c_iflag & IXOFF)
> > > +		nd->cmd_buffer[10] = 1;
> > > +	else
> > > +		nd->cmd_buffer[10] = 0;
> > 
> > What is this cmd_buffer good for actually? Only to let the user know?
> > Then -- drop it.
> 
> Because detailed iterations for cmd_buffer and cmd_rsp with Nport
> server device are regarded proprietary for our company, is it good to
> reveal value of cmd_buffer[] with macros only for upstream this
> driver?

There is nothing "proprietary" for Linux kernel code, sorry.  Please
document this properly so we can understand, review, and maintain it
over time correctly.

thanks,

greg k-h

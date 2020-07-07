Return-Path: <SRS0=ofBx=AS=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EF1C433E1
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jul 2020 06:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064E8206F6
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jul 2020 06:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgGGGhB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:37:01 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:51517 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGGhB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jul 2020 02:37:01 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 015D22800B3D2;
        Tue,  7 Jul 2020 08:36:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C31BF88E88; Tue,  7 Jul 2020 08:36:58 +0200 (CEST)
Date:   Tue, 7 Jul 2020 08:36:58 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Colton Lewis <colton.w.lewis@protonmail.com>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: correct kernel-doc inconsistency
Message-ID: <20200707063658.2xerdixnbd4cb6jh@wunner.de>
References: <20200707044458.235243-1-colton.w.lewis@protonmail.com>
 <22d42b3d-14b7-82e7-1eee-07b7799fac5c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22d42b3d-14b7-82e7-1eee-07b7799fac5c@suse.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 07, 2020 at 08:08:30AM +0200, Jiri Slaby wrote:
> On 07. 07. 20, 6:45, Colton Lewis wrote:
> > Silence documentation build warning by correcting argument names in
> > kernel-doc comment.
> > 
> > ./drivers/tty/serial/serial_core.c:3300: warning: Function parameter or member 'port' not described in 'uart_get_rs485_mode'
> > ./drivers/tty/serial/serial_core.c:3300: warning: Excess function parameter 'dev' description in 'uart_get_rs485_mode'
> > ./drivers/tty/serial/serial_core.c:3300: warning: Excess function parameter 'rs485conf' description in 'uart_get_rs485_mode'
> > 
> > Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
> 
> Fixes: c150c0f362c1 (serial: Allow uart_get_rs485_mode() to return errno)
> Acked-by: Jiri Slaby <jirislaby@kernel.org>

Already fixed by a71725619ff6 ("tty/serial: fix serial_core.c kernel-doc
warnings"), which is queued on Greg's tty-linus branch:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-linus&id=a71725619ff6

Thanks (and sorry for the warnings),

Lukas

> 
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -3289,8 +3289,7 @@ EXPORT_SYMBOL(uart_remove_one_port);
> >  
> >  /**
> >   * uart_get_rs485_mode() - retrieve rs485 properties for given uart
> > - * @dev: uart device
> > - * @rs485conf: output parameter
> > + * @port: uart device
> >   *
> >   * This function implements the device tree binding described in
> >   * Documentation/devicetree/bindings/serial/rs485.txt.

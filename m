Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F5EC3DA7D
	for <linux-serial@archiver.kernel.org>; Thu,  5 Jan 2023 09:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjAEJLn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Jan 2023 04:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjAEJLl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Jan 2023 04:11:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5D15015E;
        Thu,  5 Jan 2023 01:11:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0FD66192B;
        Thu,  5 Jan 2023 09:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7E4C433D2;
        Thu,  5 Jan 2023 09:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672909900;
        bh=3cHS8eJVCNXGhfJuTyX+DjhiPjLixozn7a5qnCV1p6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0+9+fpsEqeL637QJxvWXbEU5isZ8Rv9GKP1Stcika2xSKYslHIWZ0wy73xGjGSnR
         EY7ygROpUf67eUjkeGcKDzF6zxpj+nT4mEKLKmVy1/wg5ndPtKk3VNIp+O0CvwhHiL
         bmuE7w2PwcIFT3AJJ/r0ifAyi/e6fxSYYrLLi5zkjfKqYElW+hwC7F60Lrd9+o9VmF
         CMUPGoyIda/2GtUgvfTR1UVhLjFpCy7xah8Hmm5mPtxAcwWevsLYU2ChjGikHFX1BG
         kcvfMYhc9VYwMWyMg04Hix/P17WXmZf3jBZ6Pp+SB4HgQARduap5xaF+UGkgW82X5I
         zOFyZPeJsR48A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pDMI7-0004yG-Oh; Thu, 05 Jan 2023 10:12:03 +0100
Date:   Thu, 5 Jan 2023 10:12:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] serial: Convert uart_{,port_}startup() init_hw
 param to bool
Message-ID: <Y7aUY9WJdbtyKXm7@hovoldconsulting.com>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-6-ilpo.jarvinen@linux.intel.com>
 <7ecfd7bc-8148-cadc-a58a-a2813b1862ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ecfd7bc-8148-cadc-a58a-a2813b1862ac@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 05, 2023 at 07:05:17AM +0100, Jiri Slaby wrote:
> On 04. 01. 23, 16:15, Ilpo Järvinen wrote:
> > Convert init_hw parameter in uart_startup() and uart_port_startup() to
> > bool as code treats them like bool.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >   drivers/tty/serial/serial_core.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index c881fefa3d97..a0260a40bdb9 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -181,8 +181,7 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
> >    * Startup the port.  This will be called once per open.  All calls
> >    * will be serialised by the per-port mutex.
> >    */
> > -static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
> > -		int init_hw)
> > +static int uart_port_startup(struct tty_struct *tty, struct uart_state *state, bool init_hw)
> >   {
> >   	struct uart_port *uport = uart_port_check(state);
> >   	unsigned long flags;
> > @@ -253,8 +252,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
> >   	return retval;
> >   }
> >   
> > -static int uart_startup(struct tty_struct *tty, struct uart_state *state,
> > -		int init_hw)
> > +static int uart_startup(struct tty_struct *tty, struct uart_state *state, bool init_hw)
> 
> You made both of them over 80 characters/line. Why?

I also still consider 80 chars to be a soft limit to strive for, but for
function signatures breaking that may even be preferred as it allows for
easier grepping. I believe Linus has expressed this explicitly in the
past too.

Johan

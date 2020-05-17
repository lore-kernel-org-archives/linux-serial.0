Return-Path: <SRS0=Hdmd=67=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85737C433E0
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 15:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E222070A
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 15:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEQPEl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 May 2020 11:04:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43306 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgEQPEl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 May 2020 11:04:41 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaKq5-00017L-6e; Sun, 17 May 2020 17:04:29 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH v2 4/7] serial: 8250: Handle implementations not having TEMT interrupt using em485
Date:   Sun, 17 May 2020 17:04:28 +0200
Message-ID: <3036126.9QgpAzkLCg@diego>
In-Reply-To: <ac74f702-9444-f660-974b-85a006805070@micronovasrl.com>
References: <20200325231422.1502366-1-heiko@sntech.de> <12195570.sTQbgxCmNy@diego> <ac74f702-9444-f660-974b-85a006805070@micronovasrl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Giulio,

Am Donnerstag, 26. März 2020, 03:02:39 CEST schrieb Giulio Benetti:
> Il 26/03/2020 01:05, Heiko Stübner ha scritto:
> > Am Donnerstag, 26. März 2020, 00:47:38 CET schrieb Giulio Benetti:
> >> very cleaner way to handle TEMT as a capability!
> >> And I've found one thing...
> >>
> >> Il 26/03/2020 00:14, Heiko Stuebner ha scritto:
> >>> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> >>>
> >>> Some 8250 ports have a TEMT interrupt but it's not a part of the 8250
> >>> standard, instead only available on some implementations.
> >>>
> >>> The current em485 implementation does not work on ports without it.
> >>> The only chance to make it work is to loop-read on LSR register.
> >>>
> >>> So add UART_CAP_TEMT to mark 8250 uarts having this interrupt,
> >>> update all current em485 users with that capability and make
> >>> the stop_tx function loop-read on uarts not having it.
> >>>
> >>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> >>> [moved to use added UART_CAP_TEMT, use readx_poll_timeout]
> >>> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> >>> ---
> >>>    drivers/tty/serial/8250/8250.h            |  1 +
> >>>    drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
> >>>    drivers/tty/serial/8250/8250_of.c         |  2 ++
> >>>    drivers/tty/serial/8250/8250_omap.c       |  2 +-
> >>>    drivers/tty/serial/8250/8250_port.c       | 25 +++++++++++++++++++----
> >>>    5 files changed, 26 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> >>> index 52bb21205bb6..770eb00db497 100644
> >>> --- a/drivers/tty/serial/8250/8250.h
> >>> +++ b/drivers/tty/serial/8250/8250.h
> >>> @@ -82,6 +82,7 @@ struct serial8250_config {
> >>>    #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
> >>>    					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
> >>>    					 */
> >>> +#define UART_CAP_TEMT	(1 << 18)	/* UART has TEMT interrupt */
> >>>    
> >>>    #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
> >>>    #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
> >>> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> >>> index 12d03e678295..3881242424ca 100644
> >>> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> >>> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> >>> @@ -91,7 +91,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
> >>>    		return -ENOMEM;
> >>>    
> >>>    	/* initialize data */
> >>> -	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
> >>> +	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI | UART_CAP_TEMT;
> >>>    	up.port.dev = &pdev->dev;
> >>>    	up.port.regshift = 2;
> >>>    	up.port.type = PORT_16550;
> >>> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> >>> index 65e9045dafe6..841f6fcb2878 100644
> >>> --- a/drivers/tty/serial/8250/8250_of.c
> >>> +++ b/drivers/tty/serial/8250/8250_of.c
> >>> @@ -225,6 +225,8 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
> >>>    			&port8250.overrun_backoff_time_ms) != 0)
> >>>    		port8250.overrun_backoff_time_ms = 0;
> >>>    
> >>> +	port8250.capabilities |= UART_CAP_TEMT;
> >>> +
> >>
> >> Shouldn't this be NOT UART_CAP_TEMT set by default? On all other
> >> vendor specific files you enable it, I think here you shouldn't enable
> >> it too by default. Right?
> > 
> > 8250_of does use the em485 emulation - see of_platform_serial_setup()
> > So I did go by the lazy assumption that any 8250 driver using rs485
> > before my series always used the interrupt driver code path, so
> > implicitly required to have the TEMT interrupt.
> > 
> > Of course, you're right that with the 8250_of maybe not all variants
> > actually do have this interrupt, so falling back to the polling here might
> > be safer.
> 
> Probably here it's worth introducing a dt boolean property like
> "temt-capability", then you set or not UART_CAP_TEMT according to its 
> presence in dts. This way all cases are covered and we can act 
> completely through dts files.
> 
> What about that?

Sorry that this was sitting around for over a month.

I think there are two problems with this:

(1) this would break backwards compatibility ... right now the whole code
just assumes that everyone does support the TEMT interrupt, so adding
a property to keep it working would break old DTs, which is something that
should not happen ... I guess one option would be to use the inverse
no-temt-interrupt

(2) uarts handled by 8250_of are still identified by their compatible
though and there is no generic 8250-of compatible, so the
presence / absence of the temt capability should actually just be
bound to the relevant compatible.


So my "gut feeling" is to just keep the current way
(was expecting temt-capability before anyway) until an uart
variant without temt comes along


Heiko



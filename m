Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424E4C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 08:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDC320787
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 08:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgERIEQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 04:04:16 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47516 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgERIEQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 04:04:16 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaakp-0004qG-Cd; Mon, 18 May 2020 10:04:07 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH v3 3/5] serial: 8250: Support separate rs485 rx-enable GPIO
Date:   Mon, 18 May 2020 10:04:05 +0200
Message-ID: <2693913.H5ugjTTm6y@diego>
In-Reply-To: <20200518045006.s6e5aedgqwreqgd7@wunner.de>
References: <20200517215610.2131618-1-heiko@sntech.de> <20200517215610.2131618-4-heiko@sntech.de> <20200518045006.s6e5aedgqwreqgd7@wunner.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am Montag, 18. Mai 2020, 06:50:06 CEST schrieb Lukas Wunner:
> On Sun, May 17, 2020 at 11:56:08PM +0200, Heiko Stuebner wrote:
> > @@ -1457,6 +1458,7 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
> >  	 * Enable previously disabled RX interrupts.
> >  	 */
> >  	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> > +		gpiod_set_value(port->rs485_re_gpio, 1);
> >  		serial8250_clear_and_reinit_fifos(p);
> >  
> >  		p->ier |= UART_IER_RLSI | UART_IER_RDI;
> 
> The added line needs to be conditional on if (port->rs485_re_gpio)
> because the gpiod could be NULL and gpiod_set_value() doesn't check
> for that.

Need to look deeper at the other comment below, but gpiod_set_value does
check for NULL ;-)

void gpiod_set_value(struct gpio_desc *desc, int value)
{
	VALIDATE_DESC_VOID(desc);
[...]

which expands to

#define VALIDATE_DESC_VOID(desc) do { \
	int __valid = validate_desc(desc, __func__); \
	if (__valid <= 0) \
		return; \
	} while (0)

which does

 */
static int validate_desc(const struct gpio_desc *desc, const char *func)
{
	if (!desc)
		return 0;
[...]


Heiko



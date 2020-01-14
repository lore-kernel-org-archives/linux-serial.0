Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1021FC33C9E
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50AB2465A
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgANRbo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:31:44 -0500
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:48068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbgANRbo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 12:31:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 91A7C180AAD63;
        Tue, 14 Jan 2020 17:31:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: drain93_ead92970f826
X-Filterd-Recvd-Size: 2072
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Jan 2020 17:31:40 +0000 (UTC)
Message-ID: <24455cb643415cf9379bb8343525b844ead4236b.camel@perches.com>
Subject: Re: [PATCHv2-next 2/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
From:   Joe Perches <joe@perches.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Date:   Tue, 14 Jan 2020 09:30:45 -0800
In-Reply-To: <20200114171912.261787-3-dima@arista.com>
References: <20200114171912.261787-1-dima@arista.com>
         <20200114171912.261787-3-dima@arista.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 2020-01-14 at 17:19 +0000, Dmitry Safonov wrote:
> Many embedded boards have a disconnected TTL level serial which can
> generate some garbage that can lead to spurious false sysrq detects.

Hi again Dmitry.  trivia:

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
[]
> +/**
> + *	uart_try_toggle_sysrq - Enables SysRq from serial line
> + *	@port: uart_port structure where char(s) after BREAK met
> + *	@ch: new character in the sequence after received BREAK
> + *
> + *	Enables magic SysRq when the required sequence is met on port
> + *	(see CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE).
> + *
> + *	Returns 0 if @ch is out of enabling sequence and should be
> + *	handled some other way, 1 if @ch was consumed.
> + */

Normally bool functions return values are true/false not 1/0.

> +static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
> +{
> +	if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
> +		return 0;

		return false;

etc...



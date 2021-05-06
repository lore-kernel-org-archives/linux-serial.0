Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FFAC43460
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 07:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FB961176
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 07:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhEFHZL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 03:25:11 -0400
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:56858 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233383AbhEFHZK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 03:25:10 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2021 03:25:10 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 9140D1801C42B
        for <linux-serial@vger.kernel.org>; Thu,  6 May 2021 07:16:12 +0000 (UTC)
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1151D100E7B44;
        Thu,  6 May 2021 07:16:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 3E2642EBF98;
        Thu,  6 May 2021 07:16:10 +0000 (UTC)
Message-ID: <ef1bd57095e941560530be43806791966a6735ad.camel@perches.com>
Subject: Re: [PATCH 34/35] tty: make tty_get_byte_size available
From:   Joe Perches <joe@perches.com>
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 May 2021 00:16:08 -0700
In-Reply-To: <20210505091928.22010-35-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
         <20210505091928.22010-35-jslaby@suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3E2642EBF98
X-Stat-Signature: rqyqs418axej39nobtsrt4bmzzgx3tkt
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/EnO04s/8BpC4nMWNfXmojDlsCpHdghz0=
X-HE-Tag: 1620285370-977581
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 2021-05-05 at 11:19 +0200, Jiri Slaby wrote:
> Many tty drivers contain code to compute bits count depending on termios
> cflags. So extract this code from serial core to a separate tty helper
> function called tty_get_byte_size.
[]
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
[]
> +/**
> + *	tty_get_byte_size	-	get size of a byte
> + *	@cflag: termios cflag value
> + *	@account_flags: account for start and stop bits, second stop bit (if
> + *			set), and parity (if set)
> + *
> + *	Get the size of a byte in bits depending on @cflag. Depending on
> + *	@account_flags parameter, the result also accounts start and stop bits,
> + *	the second stop bit, and parity bit.
> + */
> +unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags)
> +{
> +	unsigned char bits = account_flags ? 2 : 0;
> +
> +	/* byte size and parity */
> +	switch (cflag & CSIZE) {
> +	case CS5:
> +		bits += 5;
> +		break;
> +	case CS6:
> +		bits += 6;
> +		break;
> +	case CS7:
> +		bits += 7;
> +		break;
> +	case CS8:
> +	default:
> +		bits += 8;
> +		break;
> +	}
> +
> +	if (account_flags && (cflag & CSTOPB))
> +		bits++;
> +
> +	if (account_flags && (cflag & PARENB))
> +		bits++;
> +
> +	return bits;
> +}
> +EXPORT_SYMBOL_GPL(tty_get_byte_size);

Perhaps clearer not testing account_flags multiple times.

unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags)
{
	unsigned char bits;

	/* byte size and parity */
	switch (cflag & CSIZE) {
	case CS5:
		bits = 5;
		break;
	case CS6:
		bits = 6;
		break;
	case CS7:
		bits = 7;
		break;
	case CS8:
	default:
		bits = 8;
		break;
	}

	if (account_flags) {
		bits += 2;	/* start/stop bits */

		if (cflag & CSTOPB)
			bits++;

		if (cflag & PARENB)
			bits++;
	}

	return bits;
}



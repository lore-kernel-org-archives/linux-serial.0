Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B6C433B4
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 09:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22766143A
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 09:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhEMJmV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 May 2021 05:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232256AbhEMJmO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 May 2021 05:42:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03E1361285;
        Thu, 13 May 2021 09:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620898865;
        bh=4RCeSG/8I2YEcyfkQAn6l5a3+wVhDU5yuKFCH+BWySU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YeX/Ez60pBT0qXffqd2P751H8nqJGQPO/1UVn5wUnfm8VDyE064sOCPS6faI4Q/QX
         8kpBfFP9feJyYABJzCtGXLm3mpT24nV92bXvTZ0c49/WVVTSGvudd2bSLxET7I1EcF
         7EmwcC+bt7ddvSCM+Hv5ahqBEJDjv+VLF9pN0PY3GgBzIvvKDYuXqptlL11f7DeRhv
         D4HScjopbBu5lMowvYBnG3oSwlfMUuasNXRYiuuUgECxNjItA78nA8MXDi3aWLuOEh
         MxpdmTlm0EPOJFVXgtdVWL6T46Oew9h/qWSY4Mn0kOQO6PUIFj6NESiJjehIiVlnBF
         c1I1MZvnxUm0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lh7q6-0005sk-Es; Thu, 13 May 2021 11:41:07 +0200
Date:   Thu, 13 May 2021 11:41:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 34/35] tty: make tty_get_byte_size available
Message-ID: <YJz0MqOOzrIBjDBL@hovoldconsulting.com>
References: <20210505091928.22010-35-jslaby@suse.cz>
 <20210510070054.5397-1-jslaby@suse.cz>
 <YJkBIm4IiaZSrSPw@hovoldconsulting.com>
 <f8f94397-14d8-60d0-f977-8bc982a00b7a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8f94397-14d8-60d0-f977-8bc982a00b7a@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 13, 2021 at 09:24:03AM +0200, Jiri Slaby wrote:
> On 10. 05. 21, 11:47, Johan Hovold wrote:
> >> --- a/drivers/tty/tty_ioctl.c
> >> +++ b/drivers/tty/tty_ioctl.c
> >> @@ -300,6 +300,48 @@ int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
> ...
> >> +unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags)
> >> +{
> >> +	unsigned char bits;
> >> +
> >> +	switch (cflag & CSIZE) {
> >> +	case CS5:
> >> +		bits = 5;
> >> +		break;
> >> +	case CS6:
> >> +		bits = 6;
> >> +		break;
> >> +	case CS7:
> >> +		bits = 7;
> >> +		break;
> >> +	case CS8:
> >> +	default:
> >> +		bits = 8;
> >> +		break;
> >> +	}
> >> +
> >> +	if (!account_flags)
> >> +		return bits;
> >> +
> >> +	if (cflag & CSTOPB)
> >> +		bits++;
> >> +	if (cflag & PARENB)
> >> +		bits++;
> >> +
> >> +	return bits + 2;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tty_get_byte_size);
> > 
> > This should really be two functions rather than passing a bool argument.
> > 
> > I think naming them
> > 
> > 	tty_get_word_size()
> > 
> > and
> > 
> > 	tty_get_frame_size()
> > 
> > would be much more clear than than "byte size" + flag.
> 
> Maybe I am screwed, but word means exactly 2B here.

No, not in this context.

Some UART datasheets use "word" and "word length", while others use
"character length" or "data bits" (and variations thereof).

> So instead, I would 
> go for:
> s/word/char/ -- might be confused with C's char, 1B, or maybe not -- or
> s/word/data/ -- more generic and generally used in serial terminology.

But "data size" it not very precise.

I'd go for either

	tty_get_word_size() or tty_get_char_size(), and
	tty_get_frame_size()

or possibly

	tty_get_data_bits(), and
	tty_get_frame_bits()

Since posix and the termios interface use "CSIZE" (even if that "C" is
ambiguous) and our man pages use "character size" perhaps we should
stick with that and use:

	tty_get_char_size(), and
	tty_get_frame_size()

That should be clear enough for everyone.

> > I realise that the serial-driver interface only uses a cflag argument,
> > but I think we should consider passing a pointer to the termios
> > structure instead.
> 
> That's impossible as termios is not always at hand. Examples are:
> pch_uart_startup -> uart_update_timeout
> sunsab_console_setup -> sunsab_convert_to_sab -> uart_update_timeout
> sunsu_kbd_ms_init -> sunsu_change_speed -> uart_update_timeout
> 
> Let me document that in the commit.

Sounds good.

Johan

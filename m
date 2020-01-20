Return-Path: <SRS0=xhGe=3J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7360DC2D0DB
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jan 2020 13:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F542087E
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jan 2020 13:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMTya1IG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgATNiT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:38:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40011 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATNiT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Jan 2020 08:38:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id i23so24078445lfo.7;
        Mon, 20 Jan 2020 05:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Rmp6M8pqwaOCr0CQdZ4MTpfCrYUT7wbrwG2fLRW4cYY=;
        b=QMTya1IGwsa/HPVuHv7uzaUAacmOduxdxgcW3fthEz+WhHrDo8q3QhyEiGpAq+/cN5
         LXaiHcx8eQ2DtWTiUou9z0fcOzY1XjOQkhkobdLFdImU4XeX3GemdVhZPpZrBOPx0ncT
         9yWl9x8gTDFO7XNATZC5Tr49ZO/RB51PCbt9+QApMTU+VCJd/X7K7a1ddYqETdnmFT3S
         Gm0CSlZiRD6VMuFA3VFuOxrZJBVB+5N5vS4gYfH+SiLBXbZmUBJlYsEY54zAY0NAlsV1
         LmyypDxvrRXw9mMXXPbgix7GOKCYfJNoEjR4shxIQDXnd+uXU2WwMJNapLzSvrlJrJF+
         6CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Rmp6M8pqwaOCr0CQdZ4MTpfCrYUT7wbrwG2fLRW4cYY=;
        b=jQn3dS1QXEWpHcabGll+sEo2Ei6RdV9znug02T/fdljWJlhBw6FXzleEPQJ+FfIkcu
         fwEE0pYDioxbmdz7UAWqYaftTymYTO9NjiXYiKH85zAlYA8jSpxCcvFuHuPrgAWWRjya
         BhQkZzRmRseJwF/OTkJ93z4m/vape//Il3j86lghT7qqZEFfSK8NnjBiouDZz8AyteHN
         Zdq81YkMIJKDV3h8MHeERFNmajaJRZFWUcAyc1F/LkREX4HjoMrq6O2AWx1/Y39Y7Wao
         Wm0Fa1jRR7s7VbieXGRWHoOJ73DOe9X8ZlM0rT93FF5LklVf+jGuqC9sOYhsjCE5sOhb
         Y3MQ==
X-Gm-Message-State: APjAAAXVLcdciL8MJD4P6pFoWbm7mOyXSqIEEtx/XQvFzIhQOwpFmxto
        ZFseBHZIn9ovNqC6lkZc0SNpUQJj
X-Google-Smtp-Source: APXvYqz5T8tKc1LnEfdTgXsi+YtywuD9Es8VybJLt2HcIlvlJPew9X90SkQT97QUd48OBRsUGA4Lcg==
X-Received: by 2002:a19:ca59:: with SMTP id h25mr13606211lfj.27.1579527497765;
        Mon, 20 Jan 2020 05:38:17 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f16sm16701379ljn.17.2020.01.20.05.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 05:38:17 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: serial: fix Tx stall after buffer overflow
References: <87pnfi8xc2.fsf@osv.gnss.ru> <20200117203414.GA11783@qmqm.qmqm.pl>
        <87sgkak6g5.fsf@osv.gnss.ru> <20200120094551.GA14000@qmqm.qmqm.pl>
Date:   Mon, 20 Jan 2020 16:38:16 +0300
In-Reply-To: <20200120094551.GA14000@qmqm.qmqm.pl> (=?utf-8?Q?=22Micha?=
 =?utf-8?Q?=C5=82_Miros=C5=82aw=22's?=
        message of "Mon, 20 Jan 2020 10:45:51 +0100")
Message-ID: <87ftgagsdz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Michał Mirosław <mirq-linux@rere.qmqm.pl> writes:

> On Mon, Jan 20, 2020 at 09:06:18AM +0300, Sergey Organov wrote:
>> Michał Mirosław <mirq-linux@rere.qmqm.pl> writes:
>> 
>> > On Fri, Jan 17, 2020 at 08:29:33AM +0300, Sergey Organov wrote:
>> >> --- a/drivers/usb/gadget/function/u_serial.c
>> >> +++ b/drivers/usb/gadget/function/u_serial.c
>> >> @@ -563,6 +563,8 @@ static int gs_start_io(struct gs_port *port)
>> >>  
>> >>         /* unblock any pending writes into our circular buffer */
>> >>         if (started) {
>> >> +               pr_debug("gs_start_tx: ttyGS%d\n", port->port_num);
>> >> +               gs_start_tx(port);
>> >>                 tty_wakeup(port->port.tty);
>> >
>> > The tty_wakeup() will be called from gs_start_tx(), so should be removed
>> > from here.
>> 
>> Not exactly. tty_wakeup() will be called from gs_start_tx() only when
>> there has been something actually transferred from the buffer. I didn't
>> want to change behavior when the buffer is empty, so I kept the explicit
>> tty_wakeup() call in place, intentionally. Please let me know if you
>> still think it should be removed.
>
> Indeed it is as you describe. You might add an argument that initializes
> do_tty_wake, but I'm not sure saving one tty_wakeup() on open is worth
> the trouble.

OK, so let's leave it as is, at least for now.

>
>> > The pr_debug() in other callers of gs_start_tx() say:
>> > "caller: start ttyGS%d".
>> 
>> ???
>> 
>> $ git co gregkh/tty-next && grep -r 'caller: start tty' .
>> HEAD is now at 7788f54... serial_core: Remove unused member in uart_port
>> $ 
>
> Replace 'caller' with a function calling gs_start_io().

Thanks, now I see... Do you prefer:

   pr_debug("gs_start_io: start Tx on ttyGS%d\n", port->port_num);

then?

Alternatively, I'm OK with removing this new debug print.

What do you think?

Thanks,
-- Sergey Organov

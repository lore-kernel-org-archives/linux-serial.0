From: chri <chripell@gmail.com>
Subject: Re: [PATCH] max3100 driver
Date: Sat, 20 Sep 2008 16:37:52 +0200
Message-ID: <cabda6420809200737r7750878x3e013e177ca23304@mail.gmail.com>
References: <1221895208650-git-send-email-chripell@gmail.com>
	 <20080920151149.21dbad1d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:43753 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbYITOhy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Sep 2008 10:37:54 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1151892ugf.37
        for <linux-serial@vger.kernel.org>; Sat, 20 Sep 2008 07:37:52 -0700 (PDT)
In-Reply-To: <20080920151149.21dbad1d@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Sat, Sep 20, 2008 at 4:11 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> +#define MAX3100_MAJOR 204
>> +#define MAX3100_MINOR 128
>> +/* 4 MAX3100s should be enough for everyone */
>> +#define MAX_MAX3100 4
>
> These need to be officially allocated if you need constant numbers
>

OK, I'll try to mail device@lanana.org


>
>> +             if (rxchars > 0)
>> +                     tty_flip_buffer_push(s->port.info->port.tty);
>> +             if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>
> If there has been a hangup the port.tty will be NULL...
>

I didn't notice an explicit test for port.tty being non-NULL in some
drivers. I took as an example sa1100 driver (since it needs polling of
control signals too). I'm missing the way these drivers take care to
not cause an access of a NULL pointer?

>
> Looks basically sound to me - just some minor cleanups needed.
>

Thanks, I will fix them and resubmitt


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."

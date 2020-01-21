Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7411EC33CAA
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 06:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477D721734
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 06:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvccFaZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgAUGld (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 01:41:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40183 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUGlc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 01:41:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id u1so1504847ljk.7;
        Mon, 20 Jan 2020 22:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pvRLv/dU9h3HbmHgi9wQkj7OBm+/Qs49ijUJE2QICio=;
        b=rvccFaZ12gsVdzCEFLwWuGEkdKatQ8db3vsWd+VHKTjM1WOSQqQkBtqqPW0kFcrg5u
         ADxXhWjKLvYt1MZXMpG3bqSSsGijud3sjj2zBOcDSD4Fv/oIC8d+U9DqJl3//Rk0ZudJ
         s/TEJY+vAK3NAgrl99iKMTc1WQsICOc19mgbV6lpO4ZNXI4/jsmPjAMnmYx8l4FfWslf
         yP6bb53KltL3H63qTHxKMmI6y4Z5NJFFPYFHDfV4LTZPg2+HZ87OLxzHcWbVl3acEbk7
         98m1Poexp1Ai7/WriIc7OJ6FIwlijGy/LC1XiudxC702ThM+CA1gqU35DjQ6vk7wWOEh
         HupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=pvRLv/dU9h3HbmHgi9wQkj7OBm+/Qs49ijUJE2QICio=;
        b=M8biyxI9prAT0akHWmcAI5LXtBVCMIwscAc0H2a9hLMO9PnO9Q/adyucufukpXOto/
         3FZfGq3wf+pU6GUuWbPGJXvH57GjedZcC/1gXE4LNoCKdhVqfWZVIgFuF3/Y0GY+pt9D
         7YLJ0eX3GUeXB6RE4dfU7PxXsLsz39TDcVjB2KYB6zXd/uXhJXIwQOemYdG7guJ/06Io
         gSF4oGuxdzWYgz0npGdL6Q9/FNMzxg7lJG6JFF7wCmK2Mq2FFTyeW+bRl+Ev1IRfB9RE
         20qLmPV0IFrG4XIGAjf4+/TzO8X1oHymAyi/dnwDhdlBCas2nZJsn0gSMWhxTGu/bz1I
         WXjg==
X-Gm-Message-State: APjAAAUKxs7e1cd0/pp3kmwf8RTAXkrG0lCRljzgK8kQY7o0vb5eYkXv
        bC5NZzeUHzZ06lOPes/yhs1jlWvL
X-Google-Smtp-Source: APXvYqyMayMCVIwf9DZBR2TFEsx+EBJpaAgjmM2Rdfw/EYJEJnE4FhsXpO8zwPCeMbYmfpo7z93RuA==
X-Received: by 2002:a2e:990e:: with SMTP id v14mr14708026lji.23.1579588890049;
        Mon, 20 Jan 2020 22:41:30 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h81sm18334011lfd.83.2020.01.20.22.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 22:41:29 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: serial: fix Tx stall after buffer overflow
References: <87pnfi8xc2.fsf@osv.gnss.ru> <20200117203414.GA11783@qmqm.qmqm.pl>
        <87sgkak6g5.fsf@osv.gnss.ru> <20200120094551.GA14000@qmqm.qmqm.pl>
        <87ftgagsdz.fsf@osv.gnss.ru> <20200120140540.GA31291@qmqm.qmqm.pl>
Date:   Tue, 21 Jan 2020 09:41:27 +0300
In-Reply-To: <20200120140540.GA31291@qmqm.qmqm.pl> (=?utf-8?Q?=22Micha?=
 =?utf-8?Q?=C5=82_Miros=C5=82aw=22's?=
        message of "Mon, 20 Jan 2020 15:05:40 +0100")
Message-ID: <8736c9e2g8.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Michał Mirosław <mirq-linux@rere.qmqm.pl> writes:

> On Mon, Jan 20, 2020 at 04:38:16PM +0300, Sergey Organov wrote:
>> Michał Mirosław <mirq-linux@rere.qmqm.pl> writes:
>> 
>> > On Mon, Jan 20, 2020 at 09:06:18AM +0300, Sergey Organov wrote:
>> >> Michał Mirosław <mirq-linux@rere.qmqm.pl> writes:
>> >> > The pr_debug() in other callers of gs_start_tx() say:
>> >> > "caller: start ttyGS%d".
>> >> 
>> >> ???
>> >> 
>> >> $ git co gregkh/tty-next && grep -r 'caller: start tty' .
>> >> HEAD is now at 7788f54... serial_core: Remove unused member in uart_port
>> >> $ 
>> >
>> > Replace 'caller' with a function calling gs_start_io().
>> 
>> Thanks, now I see... Do you prefer:
>> 
>>    pr_debug("gs_start_io: start Tx on ttyGS%d\n", port->port_num);
>> 
>> then?
>> 
>> Alternatively, I'm OK with removing this new debug print.
>
> Let's remove it. I was convinced that this is a caller of gs_start_io()
> and not the function itself.  In this case callers already do the
> print.

OK.

> BTW, the callers silently ignore (error) returns from this function. It
> might be useful to add pr_err() catching the errors.

... or actually handle the error returns? Anyway, that's beyond the
scope of the patch and my expertise.

I've sent re-roll of the patch according to our discussion.

Thanks,
-- Sergey

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C804C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jan 2022 13:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiAENhZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jan 2022 08:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiAENhZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jan 2022 08:37:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD480C061761
        for <linux-serial@vger.kernel.org>; Wed,  5 Jan 2022 05:37:24 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p13so52892451lfh.13
        for <linux-serial@vger.kernel.org>; Wed, 05 Jan 2022 05:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=yLjpwhBt3mlk8ix3pDGM3lN6sr1VlsM0JLGPdfbG+gk=;
        b=idB4FpHrbB60KthG1l3Lz9X9+/IDpxRhWdWEi+Lvpga75zNr57mRvz+pIY2WrRWA6H
         /XIGaXuH88QQDEsd2ruOFSdXuQ+meR/Yxb0sMD+4AYImMymrlcJh0rlHk+p1EyX8/gQ/
         pRoudthViIuT1j/hx9XqCc320Ci+zTSS+URYvCCGEKgFO+Q46yXQB0/+B6OW0Th0O2Jl
         qjY+iSGhjoEQRzXOG+n3ncmazNxW+XNFILm5Wm1cicGooZKIfMNmTZGUUh27iYjUcR09
         7lqOV0Z3/yI6jpEjnQVzceBxTv5Z23rmr+ByIkRWUFlALCw1U8aQErokJraB3qJ+b0fB
         6VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=yLjpwhBt3mlk8ix3pDGM3lN6sr1VlsM0JLGPdfbG+gk=;
        b=TPCIxsOcvX8av2KQKvUDKvnVA+84bjs28xWaYVLik+0m9w2T8cQrG8eCtCmzpVtnmD
         k5oRoqu0FSq6G90GNVC5c8mlva7TrK6lccEZW1I54EyPFQryari4UuamKWEwR2NZoJj1
         lY5DmKq37dToQFycHorD2pLGRj17NbRsxIDKSJ9uIZjqyDkMIomP9Dx5ksodgMDAI2tN
         yYTdRwBpDcHZJPYuwkoUvUNV5WMKs8OnMuvjlk29DtAq85Upjb78Iezp2nlLGQje4Qkv
         M4xX5oGGiM9USp4y3SXv6X0TfUI0y80ErhCqUDbRZBS/qsu3PJnO22I/T8W5qQhCi72s
         AIwQ==
X-Gm-Message-State: AOAM531glBVpkPxkJkN5scgmyuOaGOXlyGcnerC3B992wehhIxf8HFVx
        zTJGhfJ6oERdEFd733rzDlV1ygED5pU=
X-Google-Smtp-Source: ABdhPJxnXTJRakgxSZ4+FCbQJ67etj9wt10+V3UBHgocnlbdF6yXdbkfplefu8z97UdTtcvW0RwEKQ==
X-Received: by 2002:a05:6512:b15:: with SMTP id w21mr44209206lfu.11.1641389843208;
        Wed, 05 Jan 2022 05:37:23 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y1sm4196824lfd.278.2022.01.05.05.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 05:37:22 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        k.drobinski@camlintechnologies.com,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
        <YdQndwYc9xaauvpS@kroah.com> <877dbe5oct.fsf@osv.gnss.ru>
        <20220105130431.b3vb2icesuedaavk@pengutronix.de>
Date:   Wed, 05 Jan 2022 16:37:22 +0300
In-Reply-To: <20220105130431.b3vb2icesuedaavk@pengutronix.de> (Marc
        Kleine-Budde's message of "Wed, 5 Jan 2022 14:04:31 +0100")
Message-ID: <87pmp64831.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 05.01.2022 16:00:34, Sergey Organov wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Tue, Jan 04, 2022 at 11:32:03AM +0100, Tomasz Moń wrote:
>> >> Triggering RX interrupt for every byte defeats the purpose of aging
>> >> timer and leads to interrupt starvation at high baud rates.
>> >> 
>> >> Increase receiver trigger level to 8 to increase the minimum period
>> >> between RX interrupts to 8 characters time. The tradeoff is increased
>> >> latency. In the worst case scenario, where RX data has intercharacter
>> >> delay slightly less than aging timer (8 characters time), it can take
>> >> up to 63 characters time for the interrupt to be raised since the
>> >> reception of the first character.
>> >
>> > Why can't you do this dynamically based on the baud rate so as to always
>> > work properly for all speeds without increased delays for slower ones?
>> 
>> I don't like the idea of dynamic threshold as I don't think increased
>> complexity is worth it.
>> 
>> In fact the threshold works "properly" on any baud rate, as maximum
>> latency is proportional to the current baud rate, and if somebody does
>> care about *absolute* latency, increasing baud rate is the primary
>> solution.
>
> Nope - this only works if you have both sides under control.... Which is
> not the case in our $CUSTROMER's use case.

Yep, if one can't use primary solution, they need to come up with
something else. Where is that historical "low-latency" bit, by the way?

Thanks,
-- Sergey Organov

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2FFC433F5
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jan 2022 14:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiAEOho (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jan 2022 09:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbiAEOhn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jan 2022 09:37:43 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3114C061761
        for <linux-serial@vger.kernel.org>; Wed,  5 Jan 2022 06:37:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp20so89595989lfb.6
        for <linux-serial@vger.kernel.org>; Wed, 05 Jan 2022 06:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=t5/NVsWW+HYep8WxiVlKj1ccvmsZcX9F48EbbEDJQ80=;
        b=AK/m13lH3EzyHcNNLurvkeiNyqdnrstinP5637TebQtdG5CCRRFfiRAyNT2YuOtDvq
         tZoWMRLm8V/Ku2YIu4PKIdIRIKl1gQEZLMZBbOoqANvhWgfW0f1VHgORMuAuXJTDdMKP
         P3uwYFFEWFq/2j8b/NoOjVdMv7ac7uD4Jy2e7KOh0fmjsIrP2KdnCeY2gezP+29Hid0X
         IjGpOZHQjGNuQdLASR58VhtVtajDIcekPn/rcxFyhlgE7CZ59UBbMmVpd829jwET8gQN
         apUaMWRMqs+DS5qd0e89cJfZLJNJ/Zbj05f4vzqSLnGnRFxwm/xtjRLDT6geneKMQP92
         opVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=t5/NVsWW+HYep8WxiVlKj1ccvmsZcX9F48EbbEDJQ80=;
        b=GCuNhdlTFtMKIwo3W3pR2WOpy4RF1Up7ucSVfsCSjASbTXL/xt7HSErdqOXY5Avt2b
         N7jFKEb9zTiaUtdgI60qyOfPHCBBM+u9BkFECXvufMbSCKS6dc/+VeB1SYbmOLpAk8TV
         +R4K47za7wNM3TfSd0oMYNktUuMzXMYeh8U4H4GfvsumgYMKjWQa4I1sNyDRrRgVkQaS
         sBj/s3BWytc/ruB3NGvMzmbRtr5P163oDMlZJ1DMC3yNZe7yaSkqvpe7ky3PqgpXN24w
         AAAim0JXFCUjyALX67rK4IYEMHS3ddeeoFdCW2tDC5B0qkYBRvYvYKLhFyOo91zBiwnr
         BBaA==
X-Gm-Message-State: AOAM532rlNzScN2m/IN/jo5VHYNZ72dyJgwTy86VF6GuTEPu72ApDE8w
        DuedW9X9vcPneR978F44b1un458ggl8=
X-Google-Smtp-Source: ABdhPJx74RFU4LQKj4uLkIUvUBx4PEPCr7jMXGzFfm2LNCTnlnnDkNledf0+vU5upBk2Hqrv7ffyxw==
X-Received: by 2002:a05:6512:12c5:: with SMTP id p5mr48262005lfg.354.1641393461167;
        Wed, 05 Jan 2022 06:37:41 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u11sm4216800lfl.101.2022.01.05.06.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 06:37:40 -0800 (PST)
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
        <87pmp64831.fsf@osv.gnss.ru>
        <20220105134059.rcvegrjghgm7ryeh@pengutronix.de>
Date:   Wed, 05 Jan 2022 17:37:39 +0300
In-Reply-To: <20220105134059.rcvegrjghgm7ryeh@pengutronix.de> (Marc
        Kleine-Budde's message of "Wed, 5 Jan 2022 14:40:59 +0100")
Message-ID: <87iluy45ak.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 05.01.2022 16:37:22, Sergey Organov wrote:
>> Marc Kleine-Budde <mkl@pengutronix.de> writes:
>> 
>> > On 05.01.2022 16:00:34, Sergey Organov wrote:
>> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> >> 
>> >> > On Tue, Jan 04, 2022 at 11:32:03AM +0100, Tomasz Moń wrote:
>> >> >> Triggering RX interrupt for every byte defeats the purpose of aging
>> >> >> timer and leads to interrupt starvation at high baud rates.
>> >> >> 
>> >> >> Increase receiver trigger level to 8 to increase the minimum period
>> >> >> between RX interrupts to 8 characters time. The tradeoff is increased
>> >> >> latency. In the worst case scenario, where RX data has intercharacter
>> >> >> delay slightly less than aging timer (8 characters time), it can take
>> >> >> up to 63 characters time for the interrupt to be raised since the
>> >> >> reception of the first character.
>> >> >
>> >> > Why can't you do this dynamically based on the baud rate so as to always
>> >> > work properly for all speeds without increased delays for slower ones?
>> >> 
>> >> I don't like the idea of dynamic threshold as I don't think increased
>> >> complexity is worth it.
>> >> 
>> >> In fact the threshold works "properly" on any baud rate, as maximum
>> >> latency is proportional to the current baud rate, and if somebody does
>> >> care about *absolute* latency, increasing baud rate is the primary
>> >> solution.
>> >
>> > Nope - this only works if you have both sides under control.... Which is
>> > not the case in our $CUSTROMER's use case.
>> 
>> Yep, if one can't use primary solution, they need to come up with
>> something else.
>
> Please don't break existing use cases while improving the kernel.

If we aim at strict backward compatibility, the default value of water
level mark should not be changed, and I'm afraid it can't be changed at
any baud rate that is currently supported, as we can't be sure nobody
uses that feature of being "low latency" at any given baud rate.

>
>> Where is that historical "low-latency" bit, by the
>> way?
>
> ...has been removed:
>
> https://lore.kernel.org/all/20210105120239.28031-11-jslaby@suse.cz/
>
> Is there an option to bring that back?

It had different meaning as far as I recall, but as a way out of current
situation, I think something similar could be introduced as an
additional bit for tty parameters structure that is "true" by default,
meaning "minimize latency", and can be set to "false" through ioctl().

Alternatively, we might want to introduce "threshold baud rate"
parameter for tty, for drivers to be free to set high watermarks above
that baud rate.

Thanks,
-- Sergey Organov


>
> Marc

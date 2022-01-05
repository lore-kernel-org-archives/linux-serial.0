Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20364C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jan 2022 13:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbiAENe1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jan 2022 08:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiAENeZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jan 2022 08:34:25 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C55C061761
        for <linux-serial@vger.kernel.org>; Wed,  5 Jan 2022 05:34:24 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p13so52874591lfh.13
        for <linux-serial@vger.kernel.org>; Wed, 05 Jan 2022 05:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=q9np+9SZHoq5le6+gZpOzF/LfF/Xj30NRB3hy44UWAw=;
        b=PKMVai2hfdKg4W9aModpDJeW4cwZFX8JRm8ftrtdct114AZxxP8qDKNgKKe5g6Cjkg
         GnNbf+VamyTf4bYPwE366LhPiqQFp/W5kUBaRp7e3kIyc8rNykX5L3EYTAhQvWsL/Yxz
         36E/pqnoyRjmIPVMXJEqZ0mkZ+agt/a7IXpU+v+oeJ1lO5u50CTw+pC6PnfpRMcocd/K
         Pe43F/7S8HUCR9pJVm5jZCSsitkcdmX3bdzkJJx0o8/ha8YJspAMUuyGc0nLoj072yav
         YNm8xEvNPxZ8T7Ep6+GAlNZ1eSiwlrMPCXhNApliv9iXuGfcuKYk0qL7DFmNvFb/6CNL
         kuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=q9np+9SZHoq5le6+gZpOzF/LfF/Xj30NRB3hy44UWAw=;
        b=PEsGRPGDA/o8DtlJN3F3vgdYQguJtVExE5iqC4pjeP1K4yKSfPm+U0d9jNCr97ABJ4
         Kl+oZL/QAoHEb4Fi5KpRaQcXDBxUf1zGIj1IG4BAESs5ZaA90CvWTutZ5TAFQRoTuYqy
         MIXUr/iT2j8cQadH+HVD0XNa5i9t+ajoG1MhCN61yRiPHmbpYroxAjOC7OHQ+loOmmmx
         +4irHePn24rnyvL450MZmGUvS9ls2hav5y6t54cMMPiSWpDydQiAY2BVn1+GO2ufSk0y
         yEbc6i8Y2jv2I/js1NVed3BTUWoc+3fsEDw9IeOoMKj5XGdIhJ0G4plv5sZ+9QBx0QVi
         EDyg==
X-Gm-Message-State: AOAM533JeLx22PVN7NTryjFFcJbVbiB/qwp+A5X32YLAC7Wfb8Skcm2Y
        umh0FmhbHjMerRuOnVC+wonVCXTo0Ro=
X-Google-Smtp-Source: ABdhPJxDJXsGlXURKK5vmRCIrWfMBmJc0vILdw0+3s3u2EmSBKZ2Y0+9q+gJI1ozTxH2DbB5PNsppg==
X-Received: by 2002:a19:2d0c:: with SMTP id k12mr47285330lfj.224.1641389663094;
        Wed, 05 Jan 2022 05:34:23 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o3sm4201039lfo.255.2022.01.05.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 05:34:22 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomasz =?utf-8?Q?Mo?= =?utf-8?Q?=C5=84?= 
        <tomasz.mon@camlingroup.com>, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        k.drobinski@camlintechnologies.com
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
        <YdQndwYc9xaauvpS@kroah.com>
        <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
        <YdQxmQ+OMCrabg2u@kroah.com>
        <20220104224900.u3omfbilejx2jawr@pengutronix.de>
Date:   Wed, 05 Jan 2022 16:34:21 +0300
In-Reply-To: <20220104224900.u3omfbilejx2jawr@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 4 Jan 2022 23:49:00
 +0100")
Message-ID: <87tuei4882.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> On Tue, Jan 04, 2022 at 12:38:01PM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Jan 04, 2022 at 12:13:06PM +0100, Tomasz Moń wrote:
>> > On 04.01.2022 11:54, Greg Kroah-Hartman wrote:
>> > > Why can't you do this dynamically based on the baud rate so as to always
>> > > work properly for all speeds without increased delays for slower ones?
>> > 
>> > Could you please advise on which baud rates to consider as slow? Does it
>> > sound good to have the old trigger level for rates up to and including
>> > 115200 and the new one for faster ones?
>> 
>> You tell me, you are the one seeing this issue and are seeing delays on
>> slower values with your change.  Do some testing to see where the curve
>> is.
>
> Maybe it's more sensible to make this even more dynamic: e.g. keep it at
> 1 as default and increase the water level when a certain irq frequency
> is reached?

Too complex, and too many questions, I'm afraid. What is "irq
frequency", exactly? For this particular driver, or overall system?
Measured on what time interval? What is the threshold? Do we drop the
water level back to 1 when "irq frequency" is down again? Will we just
create re-configure storm at some conditions? Etc.....

Personally, I don't think this AI is worth the trouble. If at all, this
will need to be generic implementation on upper level of TTY subsystem.
I suspect a lot of UARTs have the feature nowadays, and it'd be a bad
idea to implement the same complex policy in every separate driver.

I'm not in favor of dependency on baud rate as well, but if any,
dependency on baud rate looks better for me, being more straightforward.

For what it's worth, I'm +1 for the original version of the patch. I
work with RS232 ports a lot and always set the threshold high in my
drivers. Where latency matters, there are usually methods to get proper
upper-level protocols to reduce it, though ioctl() to set the level
manually might be useful at some extreme conditions.

Thanks,
-- Sergey Organov

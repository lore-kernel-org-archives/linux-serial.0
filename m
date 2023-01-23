Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE18C05027
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 16:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjAWQev (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjAWQev (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 11:34:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4038228874
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 08:34:50 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b4so15320979edf.0
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 08:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dHio8a3tIrQaWpph9OBwqj4XpRUo5bPq+VspbIj+xTs=;
        b=QhAE20mnYiKKOlJhdSQ8kVPDlDvUjQNa3d25KqW/oAn8ghq5yRQdgPnUe/2lDAO+x0
         kx4Kftcf1MA5y6PDWx0RQvPgZkYY+EtCIswLYZzhq5S0hDQBT3roLE4d4dzlVNv8n3z7
         7WIAHbXBn/O6NQfY+5aNQiIew2tGAXIpdNBexsKOZfCr9mhWBvvvAJKsRrRbXGO3Eqc4
         /6iWNbEzsCSDgt2F5zxU7gGw1G3i5M2PdjXiQV45qfnqtF0Azgz5c4Cxs2JTKmfobGGQ
         CWkMYEeEw9Xga4YfWt+Rag8vTcMcYJ9zdTqf+s2Iy5J2zf6dFxJyXxs1kza/Y9upFmi7
         Yd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHio8a3tIrQaWpph9OBwqj4XpRUo5bPq+VspbIj+xTs=;
        b=N2a51SunhLZAAk8n+JHOO7XCd+eZuF0F8qXmx1WI3eA1xIPKDRT49lO17ycJxfWN2s
         TUByN0dspShcQDs0H2Ug1l0823ZuCRc+QeJbL7+svblWTx/o0g9818X56p+EKFJrNvR4
         rFb9kEl47puZW3vpj6o0mqNCXxQsfInhWM/JUwxQn6e/Yj+2zjty5LohDXH+jXfaHmw0
         Zymcy6c2Jv/eT4KB9DEPC7RrTtuHBa3RAoFvz0n8cE0/H4nf5f+8LTqwfW8Pc6fGH78l
         rvbeJEnpyl7qKx2z9yHjAva3Zsb3B03HBxi93FJLMQHGjeutqZq5Lhd6uJ5rxQc6lkqQ
         S32g==
X-Gm-Message-State: AFqh2kpNIA5A5rnQU4JAC2xDuAOnxNzykhUPD7TOTfWv1jIyJZlFmZVP
        3lNVFZxDcMj+mwdJMqTc8is=
X-Google-Smtp-Source: AMrXdXvAEjqpa5P3+tgI4gAQbvm7ZLRbw4gaKg/RDH9IyV5sJy1FRpBmOJyUrxw8WilY66p6ZSbk5Q==
X-Received: by 2002:a05:6402:cba:b0:49d:25f3:6b4e with SMTP id cn26-20020a0564020cba00b0049d25f36b4emr26145826edb.28.1674491688704;
        Mon, 23 Jan 2023 08:34:48 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n20-20020a05640205d400b0049e4458c991sm8610242edx.64.2023.01.23.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 08:34:47 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        Sherry Sun <sherry.sun@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v1 3/7] serial: imx: do not sysrq broken chars
References: <87bko4e65y.fsf@osv.gnss.ru>
        <20230121153639.15402-1-sorganov@gmail.com>
        <20230121153639.15402-4-sorganov@gmail.com>
        <6dc81996-6ffc-c1bc-6c3f-ca65055c94a2@i2se.com>
        <87fsc3wqdl.fsf@osv.gnss.ru>
        <34438e1a-1978-7c66-26b-311258a86e30@linux.intel.com>
Date:   Mon, 23 Jan 2023 19:34:46 +0300
In-Reply-To: <34438e1a-1978-7c66-26b-311258a86e30@linux.intel.com> ("Ilpo
        =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Mon, 23 Jan 2023 14:38:15 +0200
 (EET)")
Message-ID: <87o7qp43bt.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> writes:

> On Sun, 22 Jan 2023, Sergey Organov wrote:
>
>> Hi Stefan,
>> 
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>> 
>> > Hi Sergey,
>> >
>> > Am 21.01.23 um 16:36 schrieb Sergey Organov:
>> >> Do not call uart_handle_sysrq_char() if we got any receive error
>> >> along with the character, as we don't want random junk to be
>> >> considered a sysrq.
>> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> >
>> > this looks like a bugfix to me. Since the relevant code is pretty old,
>> > i'm not sure about the fixes tag here:
>> >
>> > Fixes: 279a9acc9b72 ("2.6.11 import") ?
>> 
>> Dunno. I've checked a few drivers, and it seems that they don't care
>> either, e.g., look at atmel_serial.c, or mpc52xx_uart.c.
>> 
>> Either it doesn't matter, or a few drivers need similar fix? What's
>> going on here, I wonder?
>
> Usually when one finds a bug from one of the drivers, the other drivers 
> indeed turn out to have the same/similar bug(s).  It's not something 
> uncommon.

Yep, it looks like deriving from the same template, with the same issue.

>
> So just fix them all, it's very much appreciated. :-) I understand it 
> might not be possible to test all such fixes on those other HWs but 
> usually such bugs are simple enough to fix that it isn't be a big problem.

I'm not even sure this is really a bug, as nobody seems to confirm it
with authority yet.

Thanks,
-- Sergey Organov

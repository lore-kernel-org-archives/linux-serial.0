Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05441C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jan 2022 13:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiAENAj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jan 2022 08:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbiAENAi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jan 2022 08:00:38 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1686FC061761
        for <linux-serial@vger.kernel.org>; Wed,  5 Jan 2022 05:00:38 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id r4so45729811lfe.7
        for <linux-serial@vger.kernel.org>; Wed, 05 Jan 2022 05:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UqVe6bAG+AeG0h6+TXigPHoEhXUFUZz4NkPNFzoDjHw=;
        b=ZWICMIn1OBMyBlPrR8bm02QB66hHxMsLZQp3L8CwdXAn+rUKY6L82NweLwE9DmimaA
         foim2bZ/81jBct2z31X0ExpPzzGQDKdrIlpFE1mVK1Sx26YMyokWlWwTc10fRZ6WXqH+
         eQZj+a4V+sH4c7Ac+Jw/qdbU/0KYnfib37UmwBzlPCBSzH7cZOc0RVZWsfAbU5jpASX+
         GDhq7+KaPTQR8vG71h6/9hBpHH20bJmBq4wGaHOhO8IMAJvnPTkBytKMG730D/KEpMDY
         KepxBYZ7Tphj98GK5sg8XFj4HI41wIzjXsGAUEwPhDjrhDW1Xh1VT/HHz7cV/tgMc//+
         o74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=UqVe6bAG+AeG0h6+TXigPHoEhXUFUZz4NkPNFzoDjHw=;
        b=vou4AgyAKEw5NuCQC4ZpUE0xFbOnhzWgOM4vgD03cCAIFPs/YhvCEdcDTYuHJme8Ox
         PQzulUjNnaYCL8gpUpgaj9m1rkv0HtGYDJ+W1tI3D/NWM8dmXdPWjX0xEMtbPKyxyw11
         PZ2zU+ou3BN6IKE9ZvOA+7BKC43H88dPwOs3mNBWiLT0wrJO1CNHr2h//mJm1Ou1CfBF
         n12yrS2mUcNk3ejwp1wBVmd+EEJvXFA7PNBECLgMf8U0jCTusm9Se4IwQJkdFhY0qm+O
         wDcTvG8D4wPNc3HH0alzo8R9ij/c7+wMYCWmPn2dKqdBteKFDRMpXPP5oqWCQS+HFRYh
         e1lA==
X-Gm-Message-State: AOAM530UA1m03I8lO9xuKsZbtTyTatUlYwTeG+a6clhoMTDjVoNIhDGg
        YnIk6Xo7iLN0Dkxh/izbFW0=
X-Google-Smtp-Source: ABdhPJxLanuJXhy+8Ldh0L5SSQaTqFKiFBpRB5fXUSEqrLfX2rwDr9VnJ+nv9nOI6bpaatD+1QzXKQ==
X-Received: by 2002:a19:674b:: with SMTP id e11mr17348941lfj.83.1641387636307;
        Wed, 05 Jan 2022 05:00:36 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q14sm4173661lfu.74.2022.01.05.05.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 05:00:35 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        k.drobinski@camlintechnologies.com
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
        <YdQndwYc9xaauvpS@kroah.com>
Date:   Wed, 05 Jan 2022 16:00:34 +0300
In-Reply-To: <YdQndwYc9xaauvpS@kroah.com> (Greg Kroah-Hartman's message of
        "Tue, 4 Jan 2022 11:54:47 +0100")
Message-ID: <877dbe5oct.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Jan 04, 2022 at 11:32:03AM +0100, Tomasz Moń wrote:
>> Triggering RX interrupt for every byte defeats the purpose of aging
>> timer and leads to interrupt starvation at high baud rates.
>> 
>> Increase receiver trigger level to 8 to increase the minimum period
>> between RX interrupts to 8 characters time. The tradeoff is increased
>> latency. In the worst case scenario, where RX data has intercharacter
>> delay slightly less than aging timer (8 characters time), it can take
>> up to 63 characters time for the interrupt to be raised since the
>> reception of the first character.
>
> Why can't you do this dynamically based on the baud rate so as to always
> work properly for all speeds without increased delays for slower ones?

I don't like the idea of dynamic threshold as I don't think increased
complexity is worth it.

In fact the threshold works "properly" on any baud rate, as maximum
latency is proportional to the current baud rate, and if somebody does
care about *absolute* latency, increasing baud rate is the primary
solution. At most I'd think about some ioctl() to manually tweak the
threshold, for some exotic applications.

That said, are there examples in the kernel where this threshold is
dynamic? If not, then it's another argument against introducing it, and
if yes, then the OP will have reference implementation of exact
dependency curve.

Thanks,
-- Sergey Organov

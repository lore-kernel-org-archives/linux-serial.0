Return-Path: <SRS0=uqjK=7X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837BDC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C64A2070B
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 16:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7cIYBil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgFJQZC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgFJQZA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Jun 2020 12:25:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAC5C03E96B;
        Wed, 10 Jun 2020 09:25:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t18so2972592wru.6;
        Wed, 10 Jun 2020 09:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7MdATQTOMqVdqWwVcwhsiYUCt9se11ZiKZMK8K7BiCo=;
        b=G7cIYBilI7XvkCmFr1RcYL6e4zYFpHIZ+Fui6TE+JRVNwNH2zv5vQSu8BRtPxnIt7C
         vJA+h6aqYIlEFyyN9eAyLbU6G4Rd5hE110kw2icRuIcR/u607F61WcB8SJ23NqURkprp
         MYEO/00q+hnhVypeBkUnj5x46gxYtjKsD2FILL7Ty0WTWoT3/gnjwebcrg+aIJmrftuu
         2O0RZBYLN+aHegRryBKBOadEJKeQyD/yhkj4RhreWaqj7JNHhfFU5vDmYiXpJ2zdT3d6
         UaLFH0zSnwtDezlwQ7fMLd5f2FVohoGZXiXLQ7x0OjgPdLTMJuanoCvQZMcxKSTWHerz
         ryFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7MdATQTOMqVdqWwVcwhsiYUCt9se11ZiKZMK8K7BiCo=;
        b=Vfvdmlb9UMFTG7EArmYHBSpIC8aWYRnmBh/GeAYc4j0d/y60l+fgMPL6+QqRouLGXd
         NT0WrQ1A5rOc6WbRTvlYyZxZwkzh2E0uXDF4evq3R4iQxbw53KDeGSdHI4c2wIv55AV5
         fqMPJplT1d1bbsnEASm3DvNX6X8ktDGp5wn2woGmy0c9S9lUU2pBCeg2FrgjHHkF9icT
         xLzKrpN/QMNgrynhWPOnFH1OaSHfKXlWcS7vEiPHbmWNuwkojGeyx7wOuoMAOXrACqsf
         h8mYcWXkEEK0bkeGv6LMgy/kWu5o87rS36YGP/09JDimu9b0ryX6l48iE/LmtuiwokD3
         VJeQ==
X-Gm-Message-State: AOAM531QHcymcW7NAxrUzZXhic1k0IZOj9/8rGWY0nFCbP0RxL2zpoC6
        7HAMxhzJfkI2jBAY88pO7h4=
X-Google-Smtp-Source: ABdhPJwJUsnozQmJ8rArz+o+VE7Ug+Ogn3pwymbR97IR9oAxEz6MkGrQ1RZU+2WkilkvLYCz//PBwA==
X-Received: by 2002:a5d:5006:: with SMTP id e6mr4869928wrt.170.1591806299316;
        Wed, 10 Jun 2020 09:24:59 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id s8sm458703wrg.50.2020.06.10.09.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 09:24:58 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] serial: core: fix sysrq overhead regression
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200610152232.16925-1-johan@kernel.org>
 <20200610152232.16925-3-johan@kernel.org>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <19008afb-bfbb-35e2-3bd5-e7fd1b7355cc@gmail.com>
Date:   Wed, 10 Jun 2020 17:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200610152232.16925-3-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

On 6/10/20 4:22 PM, Johan Hovold wrote:
> Commit 8e20fc391711 ("serial_core: Move sysrq functions from header
> file") converted the inline sysrq helpers to exported functions which
> are now called for every received character, interrupt and break signal
> also on systems without CONFIG_MAGIC_SYSRQ_SERIAL instead of being
> optimised away by the compiler.

The part with ifdeffing looks good to me.

> Inlining these helpers again also avoids the function call overhead when
> CONFIG_MAGIC_SYSRQ_SERIAL is enabled (e.g. when the port is not used as
> a console).

But this one, coul you add measures? (it will also help to understand if
it's a stable material).

If one function call actually matters here, than should
uart_insert_char() also go into header?

I see quite common pattern in drivers:
: if (!uart_handle_sysrq_char(&up->port, ch))
: 	uart_insert_char(&up->port, byte, 0, ch, TTY_NORMAL);

Don't misunderstand me, but I would prefer keeping headers cleaner
without realization details with the exception if function calls
actually hurts the performance.

Probably, a comment like
/*
 * Keeping these functions in the header improves performance by X% on
 * YYY platform by letting the compiler inline them.
 */
would also help.

Thanks for working on this,
          Dmitry

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4163C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Dec 2021 09:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhLGJWP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Dec 2021 04:22:15 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59436
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232973AbhLGJWP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Dec 2021 04:22:15 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4F5903F203
        for <linux-serial@vger.kernel.org>; Tue,  7 Dec 2021 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638868724;
        bh=mbVZsPIKFmlo4NdLQ32VSh3peIplR0eL3tdmg/4c8Qc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=U6gu73HkHd2dN3Qeu+fI9ZHS1qrwFpu4j1sYz6S/nkjZKRCcgp1oWuoWxJ6qGbdW8
         FziQ64OYfT3Q7qCjvchem2rjosCAFQt4B1URQOpbsdfSbwmr867bnpLIINMjw4lh+K
         Z1iq0dbxlFHJIu+OEcbmg+leZVk15YLa6KOcUdLfygdk5PqQdStHOcSevksDDlP9TQ
         OGaZH4MCrULpJNM9eHFbriEYirgtI7DBr1GaTdVCEU71/5mxTRMixqqXU9DSjhadcf
         QyZKe6AsanRL+69smh3UaIRKGZe8Q8ndhbgww7r6bpKdduquQ874VtWRTcEjl3Wa+A
         in31+sPzOE+Gg==
Received: by mail-lf1-f69.google.com with SMTP id n18-20020a0565120ad200b004036c43a0ddso5061221lfu.2
        for <linux-serial@vger.kernel.org>; Tue, 07 Dec 2021 01:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mbVZsPIKFmlo4NdLQ32VSh3peIplR0eL3tdmg/4c8Qc=;
        b=urZ1pigJDG2H/Mnw2DJd9iLu2XmU+USVFwDK2jJfze0jFDnsrvza6TH/YAD58gFb8L
         1Ity4DjhPp8p5tzQoa2C/71vFpNRUVPIfXg0O5jvFTCejqvbeBd6on3MqiY3WrRfYs2D
         PzgWbE+BDfphw5qTkgs97UafehDA2avGqlA47WtNXsWsWauWr3ZSGbAfahK4A/r2EI8t
         3v07n4AE2NEVwN4L2nda6C/UxwVKzFUA9tk63WhHHxaaigYMLzq1IYuYp6/uhpuV9XjU
         bNXPk7auw+AbUDU9GsH4HDJo0ToTjGiyTQK6lcYqlrXjIJ8uC0sAE/ZuzVtMlUBGw7tu
         kBTw==
X-Gm-Message-State: AOAM5336HzbjBzdqt7Utgm+p5sgZ4e4UYMnJvtldGI3Ca19ALzOaSDgh
        HtZhgWpq6G/iF/DYdXcsoRjInahhAVYNWbzPELgGGL8BFmOSqhQb62VYP1yxYmY5VyOdLE9ih1y
        fVcAXhowiee/tTsoqGo6z51yXhOwPQRhMnZUIWey+2A==
X-Received: by 2002:ac2:46c8:: with SMTP id p8mr40346930lfo.174.1638868723789;
        Tue, 07 Dec 2021 01:18:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwE/X3GbUfZYbh0b1cJH+6HgAy41W8jeJ0LU1fZHzlDTEz3mdy4mHHqcZGQE/cHscY2fRtLzA==
X-Received: by 2002:ac2:46c8:: with SMTP id p8mr40346902lfo.174.1638868723556;
        Tue, 07 Dec 2021 01:18:43 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b12sm1621027lfb.146.2021.12.07.01.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 01:18:42 -0800 (PST)
Message-ID: <78ce61a9-b345-437a-df02-49951eb3f31e@canonical.com>
Date:   Tue, 7 Dec 2021 10:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 10/11] tty: serial: samsung_tty: Support runtime PM
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <20211124073419.181799-1-marcan@marcan.st>
 <20211124074625.182815-11-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211124074625.182815-11-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 24/11/2021 08:46, Hector Martin wrote:
> This allows idle UART devices to be suspended using the standard
> runtime-PM framework. The logic is modeled after stm32-usart.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 93 ++++++++++++++++++++------------
>  1 file changed, 59 insertions(+), 34 deletions(-)
> 

Looks good.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>



Best regards,
Krzysztof

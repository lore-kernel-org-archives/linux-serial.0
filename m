Return-Path: <SRS0=wTQQ=5W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAAEC2BA1E
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 09:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B034B206F8
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 09:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586166846;
	bh=vZYTBj4F9TFPt90fOhfeKUGWkD1ktH4kLtueT7CgHJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lhREusEVDqNzHNxFeF0soTNhVl/m4/3RGczHWS4V6W0uzUtCRnL+BkYHZAAOGwK7P
	 sNEqznaIyDZIi/GDPDbk31ijppbMwwqUXfhzs+3G9awcSqklcDNWO6/D5PkbxBiR0+
	 ryFzRlmzcy+gym9KG16ixpNp0epFKwFpZ64RA9UQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgDFJyD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:54:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36674 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgDFJyD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 05:54:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id i7so18489456edq.3;
        Mon, 06 Apr 2020 02:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eXU3+fS3XAuOGK+yRmNEiF3QUpBoPFYpiOk6EA2d73M=;
        b=VDxqWPoLor8r0JiaNi51BdXn/SD5eM534B1gG1bptqHBQc2/hJmlk3j9nN/sYvwQnL
         N131hgrakRhcqOBmPek3JVgy8G/tvXEKQWQXn0qnXr0JS+ETPSSo+JTPOizqI+LPY1uQ
         NF6jxth92sK/SB+qMNUMdKaTuEgHD+XewrzzizLgVTfcX7oLBEEIpdu2T2RvAsMwb/Vs
         hMKe2hM1H5/8VQrqxU2LXyPv7GfsOLbpi7ug9Yi2qjBoH5tKWUtWiA9gkhN/XWBTI3s+
         Hp4hAFj80zVukQLg4shq0P4XwH/JTjfuz67okxJdn2RTL0QqmdhsuSi7P2FrADnpS8CM
         VbWw==
X-Gm-Message-State: AGi0PuaOZuXhCRq3WxkMl7Qby5kczGqmALOHYvTeXlyRW2vdHpzACdgl
        /pRZhYWys+znYEAB5nPE4Vs=
X-Google-Smtp-Source: APiQypLwepchYmPhiWzn8mb3ybM6Te3z/xGQa8TofYqmH3OjWlJ7E/iHo/IuZQK17kfXiH2YPsukPA==
X-Received: by 2002:a17:906:3788:: with SMTP id n8mr20728327ejc.306.1586166839488;
        Mon, 06 Apr 2020 02:53:59 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id l14sm2851321ejc.0.2020.04.06.02.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 02:53:58 -0700 (PDT)
Date:   Mon, 6 Apr 2020 11:53:56 +0200
From:   'Krzysztof Kozlowski' <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, 'Kukjin Kim' <kgene@kernel.org>,
        'Jiri Slaby' <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200406095356.GA13565@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48@epcas2p4.samsung.com>
 <20200403111511.10598-1-hyunki00.koo@samsung.com>
 <20200403133457.GA7561@kozik-lap>
 <000101d60b92$eb97c050$c2c740f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000101d60b92$eb97c050$c2c740f0$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 06, 2020 at 06:41:09AM +0900, Hyunki Koo wrote:
> > 
> > I got more thoughts... where is the binding for it? It looked like standard
> > DT property but it is not described in device tree spec.
> > 
> > Also, where is the user (DTS) with it? I expect such changes go with the
> > user itself... otherwise, next cleanup it will go away.
> > 
> > Best regards,
> > Krzysztof
> 
> Do you think this kind of change is needed?

You mean the user of this binding (DTS)? It is not required because with
binding comes ABI stability. However it would be both appreciated and
useful because it would clearly note that this feature is used.

The feature brings additional complexity and +1 function call for each
simple register access. Therefore sometime in the future, one could see
it is not being used and start cleaning it up. Cleaning up usually
involves looking for users, then making binding deprecated and finally
removing the feature.

The collaboration between the Samsung LSI and upstream is quite
limited... And it basically does not exist between the Samsung mobile
division and upstream. This means that when we reorganize the
code, deprecate features/drivers or certain Exynos chips (e.g. 4212 and
4415 in the past) we look for users of them and if none are found - bye
bye feature.

The solution is either to participate (but this is difficult for
mentioned Samsung divisions because of internal policies) or just add
the user of such feature (e.g. DTS for evalkit).

> Do I have to make as a series patches with previous patch?

The DT binding you posted looks good. It should go as first patch in this
series.

Best regards,
Krzysztof



> 
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 9d2ce347875b..a57b1233c691 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -29,6 +29,14 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  reg-io-width:
> +    description: |
> +      The size (in bytes) of the IO accesses that should be performed
> +      on the device.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [ 1, 4 ]
> +
> 

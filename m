Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CC0C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478CD60F21
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhINJQn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:16:43 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40554
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhINJQc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:16:32 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 32BC83F33A
        for <linux-serial@vger.kernel.org>; Tue, 14 Sep 2021 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631610909;
        bh=H5D/FfQQgMg0EZ2Qw/2aFXc39r6WsfLpy3vkmHT7Cb4=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=bu0sP7CW8Sg0NSBNOnvUjffSBeaabt2u9qWWFSzvoqlV0rsYH/cPhu94+HWkXjEMl
         7h4hJ1mNdARqy4pzbblyx4EdtkbLYBZOOL3+vfiemYU9aQJ9Mm8L7h3c1imuVGLq/y
         vN24S+ZmKqsxSoeTNMGs0WDCzPJJ7Sq5qWpnTAb2DHplhRmVOJ0LmIMlfmLeg8Zcuj
         688V8OkopDUPrn2v0xMz/tkZm9EkhxlaqLMughQEY+69qIm2eS5SBZJ9WwKaZ2MH0S
         czOZF5XsM7itKj15hBbmWy+5IB+8G9gTdnW5CTgCmrLIfCxBFVgPrWh8cPnDUetFpX
         s9zOs0d2EsA6A==
Received: by mail-wr1-f69.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so3698730wrn.12
        for <linux-serial@vger.kernel.org>; Tue, 14 Sep 2021 02:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H5D/FfQQgMg0EZ2Qw/2aFXc39r6WsfLpy3vkmHT7Cb4=;
        b=GY/W+AhfmbCc0Lgk3iyqv/z1usvB+6VgYUM4nb9bD3W/Heb/6YjfF7xg4os+zjVVlJ
         64pOw0L5aVF6jaWfWZ4Is50Z1YBTza3IGIyrqJc56KBXclfTg+wTEFkMphdfgq6EzAb7
         iELl2GVvnrzjaGLAcmMEk6RxGVqgHut4TDi8aHDoJpm1X+NjOWiQOkFBIwQRO83svO17
         tGkog2XOUpOG8iQF5gTRCr7Z6vdMXkO53xMlZpn6omn8zpgtn2t3QYELcjA26IQbK/J4
         0mMf9ogKz8CjKUy8ABOcUoaEh4i2SWo5GuXOpuiv4m7DunQkNsb385mwg9z3ngjLsxhX
         95Mw==
X-Gm-Message-State: AOAM533BFWWDd9abwCQmbQUilAxpfamArW6ERbA7hlVjjQxQxK5cnSyG
        ODS69uq9Gv5PIt/n1gTuaS/id2m41TiM/i2iBX3H/PfB448NcBscji7zZGPReJkclRRyhZSHZFi
        k0W6L1qezvblO3PyXH0w/6jD++pCEYxv6B99oOwrlrw==
X-Received: by 2002:a1c:9a8e:: with SMTP id c136mr980803wme.191.1631610908915;
        Tue, 14 Sep 2021 02:15:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgOA95mgvqIcsSC1Y5VXovrY4W4xHwJSVK/M2pvFoSEXcBrXA1mL9AdaGoym9QoNfQdtyZKw==
X-Received: by 2002:a1c:9a8e:: with SMTP id c136mr980784wme.191.1631610908759;
        Tue, 14 Sep 2021 02:15:08 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d8sm10448325wrv.20.2021.09.14.02.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 02:15:08 -0700 (PDT)
Subject: Re: [PATCH 06/16] tty: remove file from n_tty_ioctl_helper
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-6-jslaby@suse.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e446060c-4208-cda5-5ac9-5650b5a1e3b2@canonical.com>
Date:   Tue, 14 Sep 2021 11:15:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914091134.17426-6-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14/09/2021 11:11, Jiri Slaby wrote:
> After the previous patch, there are no users of 'file' in
> n_tty_ioctl_helper. So remove it also from there.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/bluetooth/hci_ldisc.c | 2 +-
>  drivers/net/ppp/ppp_async.c   | 2 +-
>  drivers/net/ppp/ppp_synctty.c | 2 +-
>  drivers/tty/n_gsm.c           | 2 +-
>  drivers/tty/n_hdlc.c          | 2 +-
>  drivers/tty/n_tty.c           | 2 +-
>  drivers/tty/tty_ioctl.c       | 4 ++--
>  include/linux/tty.h           | 4 ++--
>  net/nfc/nci/uart.c            | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)
> 

For NFC:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B192C433B4
	for <linux-serial@archiver.kernel.org>; Thu,  8 Apr 2021 15:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B9E61139
	for <linux-serial@archiver.kernel.org>; Thu,  8 Apr 2021 15:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhDHP7U (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:59:20 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:45984 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhDHP7T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Apr 2021 11:59:19 -0400
Received: by mail-oi1-f171.google.com with SMTP id d12so2629699oiw.12;
        Thu, 08 Apr 2021 08:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jtoAw95rvXg1r6cke0J3PIsrEjdw50dBNfyvcmHc460=;
        b=gfI0dWJQtmxZKwtgNOjeldEa2c9HcImo8QYgIT+duU4W6cw4hIcV/Ng7520TNap6y0
         E66nJPEcXyDpC+7wzz0RiWcGvR8T77HVVaN2BHTGE0cOx5oR6wZIookOU3dysuclRKh/
         fnF9EJkUeg7O1YsS6kRwzLKbvB2/HN/KnujaDWyI2ts+MlfDBdi0Hidd6wCK8ZrQJe5/
         xLPJ/30heHE/ndb9h+l6gL/fwpozuZiWGRRXKmBzz49yWYKY/fSP7iq6FpTHPfsmvThO
         3HaL8G2GKYPGj2Vwrf1v66oVqpLahia9QRLZYxa7FMMCPEyArH170jcZ5ZVO1tp/a73q
         z/ZA==
X-Gm-Message-State: AOAM532BBnUEFRomen3l61wXOhCyOb3Bg9VS75i4zjHL4pHvUIfD/z6o
        JzTJFxc3yiRsLxSVT1IT9A==
X-Google-Smtp-Source: ABdhPJx+JWT72oKSZA+LWx7PNFVqKo3fxY81eBJG9HzWXkLOF9mbK8ZbLh65asfWyyJWKv4Ts+ehVQ==
X-Received: by 2002:aca:da04:: with SMTP id r4mr6652760oig.123.1617897548115;
        Thu, 08 Apr 2021 08:59:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f12sm282199otf.65.2021.04.08.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:59:07 -0700 (PDT)
Received: (nullmailer pid 1553733 invoked by uid 1000);
        Thu, 08 Apr 2021 15:59:06 -0000
Date:   Thu, 8 Apr 2021 10:59:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org, - <devicetree@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: serial: 8250: deprecate aspeed,
 sirq-polarity-sense
Message-ID: <20210408155906.GA1553685@robh.at.kernel.org>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-2-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408011637.5361-2-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 07 Apr 2021 20:16:34 -0500, Zev Weiss wrote:
> This property ties SIRQ polarity to SCU register bits that don't
> necessarily have any direct relationship to it; the only use of it was
> removed in commit c82bf6e133d3 ("ARM: aspeed: g5: Do not set sirq
> polarity").
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

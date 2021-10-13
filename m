Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70867C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 13 Oct 2021 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E47261040
	for <linux-serial@archiver.kernel.org>; Wed, 13 Oct 2021 13:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhJMN1O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:27:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhJMN1O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Oct 2021 09:27:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B5176109E;
        Wed, 13 Oct 2021 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634131511;
        bh=UGcV/mUCdeF23MAlNCj+71r+JKJVmreKKnW9gSNVkpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=as4GM+yymmKWnuZa+Cd1AjfwLwOcsyUMmBc+1vYOnm2I2ifZeiOKzUf4QLr/WwZpB
         iCMlEsd6omh7JOqvRZDoCNdNMuFlxEtKqCvVmOCa1Yz+WZKQo+wtKv9mCt10dafUMK
         Gl00v0aOjB8Sgtk+VQn9+1QOokf5GdRvKFQu6JgD1YE9N0i0298WQG861cUJLFR2sl
         NnU1wmKFoTIo7rX9zzDoI3MWYlprfaxaJ0J6shhwyVgFaUEvSeKhAtwaseu2EfUYw4
         R98KQEGXbVowEoi+CD2doEWwJfutvvdpYz3vBjOszdKd2ZemgF0dpLVgwOX+/HBA9/
         zKYIaefy/dRRw==
Received: by mail-ed1-f43.google.com with SMTP id p13so10472972edw.0;
        Wed, 13 Oct 2021 06:25:11 -0700 (PDT)
X-Gm-Message-State: AOAM532gwkvvdj+uTYsSGBiLpqM78gGX7hx5qJHIZg6NPgxfGX2Femni
        A5SwQa8TDvr4SB4jarTGu0QNfJ6t7NLjjfdw2g==
X-Google-Smtp-Source: ABdhPJzaMP5MaQHrWDeZbquEbFJmvW/OITWr+5JKQkAI1+lpde9YiZTx1UaLtUUsXUk9JN9tflZBcGOJOkAkl+A0LJ4=
X-Received: by 2002:a17:906:c350:: with SMTP id ci16mr12012432ejb.466.1634131509092;
 Wed, 13 Oct 2021 06:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211008234312.61688-1-david@ixit.cz>
In-Reply-To: <20211008234312.61688-1-david@ixit.cz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 13 Oct 2021 08:24:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ6Br4S-P65K+n+3wyD4FpXYXDBkeXj+TbgFz8p9hetfA@mail.gmail.com>
Message-ID: <CAL_JsqJ6Br4S-P65K+n+3wyD4FpXYXDBkeXj+TbgFz8p9hetfA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: uartlite: drop $ref for -bits property
To:     David Heidelberg <david@ixit.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 8, 2021 at 6:54 PM David Heidelberg <david@ixit.cz> wrote:
>
> Fixes warning:
> Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml: properties:xlnx,data-bits: {'const': '$ref'} is not allowed for '$ref'
>         hint: Standard unit suffix properties don't need a type $ref
>         from schema $id: http://devicetree.org/meta-schemas/core.yaml#
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml | 1 -
>  1 file changed, 1 deletion(-)

Thanks for fixing.

Acked-by: Rob Herring <robh@kernel.org>

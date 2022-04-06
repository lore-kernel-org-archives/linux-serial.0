Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814DBC433FE
	for <linux-serial@archiver.kernel.org>; Wed,  6 Apr 2022 19:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiDFTpy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiDFTpl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Apr 2022 15:45:41 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFEA179433;
        Wed,  6 Apr 2022 10:54:54 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id v75so3204576oie.1;
        Wed, 06 Apr 2022 10:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wC447ObMJsFX2n8f7dJ0Uuo8JZfPvybMvM0nYJqQlsE=;
        b=Z/HFmr5nIjxMmAcznEgpP4C8cRnq7O9gex0FM4FMoHoIC7Kwk7I4p7QJdaT0I4wHVm
         sB1wqoHL0u8EXrH6VGXg9yP/th/RAb2Moo46m5JjNyds9Qdf8mZk3X7UvLFAAC0juj2X
         FfslbDe/hHDoE3M5PuWaGcTo+Opkd5y+YvoJfwrNFO88JEDMj8qCXjcf2MUM6IMXSTLH
         5jX7NjJc6Qa3TeRd6QpEzG1DxJQKO4gs150pjDRLUvwfOXItxBUnx+xn+HP+j4ufKeTn
         q1JEoE7jo9iHTs2RTEzD4kjknU2e5xIS31ZJOjLVX7jAVg5jXD2QOV4PzVyzdlAEY89e
         Eu1w==
X-Gm-Message-State: AOAM530CrYEkWIStCNH5wOatLoem1Uqu+2vdqHvziQzmTQMHpsjx46Cw
        GtJxZRpU4FNY641CkEKzsg==
X-Google-Smtp-Source: ABdhPJx3MZjf9koEO8rLPvTH8e9/qTugSHX7pwejvjKTqCgni/3MEZuYVXy7E8AoUG8jLjBqjZnuSQ==
X-Received: by 2002:aca:61c1:0:b0:2ec:d091:ff53 with SMTP id v184-20020aca61c1000000b002ecd091ff53mr4238583oib.235.1649267693846;
        Wed, 06 Apr 2022 10:54:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f21-20020a056830205500b005cdb59d5d34sm6974033otp.81.2022.04.06.10.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:54:53 -0700 (PDT)
Received: (nullmailer pid 2495173 invoked by uid 1000);
        Wed, 06 Apr 2022 17:54:52 -0000
Date:   Wed, 6 Apr 2022 12:54:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        giulio.benetti@micronovasrl.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 05/12] dt_bindings: rs485: Add receiver enable polarity
Message-ID: <Yk3T7CBSi72Ce6j0@robh.at.kernel.org>
References: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
 <20220404082912.6885-6-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220404082912.6885-6-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 04 Apr 2022 11:29:05 +0300, Ilpo Järvinen wrote:
> Add polarity property for receiver enable. Some UARTs have
> separate enable pins for tx (RTS or DE) and rx (RE). As most
> RS485 transceivers have !RE pin, the default is active low in
> contrast to rs485-rts-active-low that defaults to active high.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

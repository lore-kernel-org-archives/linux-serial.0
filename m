Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77040C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  8 Apr 2021 16:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F89A6113A
	for <linux-serial@archiver.kernel.org>; Thu,  8 Apr 2021 16:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhDHQAh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:00:37 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37495 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhDHQAc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Apr 2021 12:00:32 -0400
Received: by mail-ot1-f42.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so2771281otr.4;
        Thu, 08 Apr 2021 09:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FJhdNB/Jqtva0JYrfZMbI9rYQop/sljVACwChgRC7N4=;
        b=q+fUE45MSXB67xDrup908jGnFetlt9DlFhaqS05fq8vTeimnf+E4RVsjaDGzowS/bY
         6IwmH3aevZc5MW3OwgGIf1CFl0Z8+6bffTis34AQjyk8fUihPuK6RunMLZJw3ouRnDTe
         jaITVL3Gdaque7z+XPLcdJ3s7Di55snvctBQrqdcu4KM3NnwvzkZ6sTfoo1eso2VsYrA
         t+Gyk/05ugE29CZ2gkcm9OhjDluS+cWjDHuMimIgUsfbWZ4CbZnYm47DHATburzW8PKM
         kbDANde3s950CR9igmLAIJ7GXXqG2Qc53A5Hg5EVR+au6AKw/gT867DqK239S1apO+nK
         cJSw==
X-Gm-Message-State: AOAM532MgoVCtqavZ64g37Zu273w5Px+QF53RFNyuQ1E1MCBNKEd7hzr
        XKEaZpmFfcMVIH1ManuBYU/AnLAcVg==
X-Google-Smtp-Source: ABdhPJwH+MmUiUnKTRh6M/yGWE1b/8MeTFU59jPjnPJKA+PSvg23MxAoNNbcFS5814FWsFsyc7N02g==
X-Received: by 2002:a05:6830:8f:: with SMTP id a15mr8209266oto.299.1617897621071;
        Thu, 08 Apr 2021 09:00:21 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a6sm6251796otb.41.2021.04.08.09.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 09:00:20 -0700 (PDT)
Received: (nullmailer pid 1555457 invoked by uid 1000);
        Thu, 08 Apr 2021 16:00:19 -0000
Date:   Thu, 8 Apr 2021 11:00:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        linux-aspeed@lists.ozlabs.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        - <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] dt-bindings: serial: 8250: add aspeed, lpc-io-reg
 and aspeed, lpc-interrupts
Message-ID: <20210408160019.GA1555403@robh.at.kernel.org>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-5-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408011637.5361-5-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 07 Apr 2021 20:16:37 -0500, Zev Weiss wrote:
> These correspond to the existing lpc_address, sirq, and sirq_polarity
> sysfs attributes; the second element of aspeed,lpc-interrupts provides
> a replacement for the deprecated aspeed,sirq-polarity-sense property.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

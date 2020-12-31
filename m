Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF611C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 31 Dec 2020 20:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF67220888
	for <linux-serial@archiver.kernel.org>; Thu, 31 Dec 2020 20:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgLaUid (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Dec 2020 15:38:33 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:32950 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgLaUic (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Dec 2020 15:38:32 -0500
Received: by mail-ot1-f45.google.com with SMTP id b24so18865135otj.0;
        Thu, 31 Dec 2020 12:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=33mJBDwSaLXSZq9uIF9tHwsSa4/sQ0g8ozhF1F4Sc6E=;
        b=nMKNLOWz7RJaZORa+VGpDjOHTGM7NJ5DUx3fVmYmsxCZQxtktvO7/NT+VmZA4AybcR
         4T49EoLfLCGWHp1kC+B44x/gv+aEoMCHBR1+x0eWfpNe8qEb/0m3nAXw/pYNo7VdOO5L
         tsOUrA/3AlGRTBJT7dWCNPI9CAFy70h7FUVyVZKQX2KeDrI/XaarAN9bxLx+50fyHJfG
         G7ygRGXXNcPoOEcXx82vIY1CtZJTJeVCfAPpK9fmM5Nr0yQFCPMYGSiEh6cwLQVICRMa
         +mulLIYNT5Rx/VVYCAQxmW5HZSl7NSuWBbZZzFputHRuzY8bwr6HJy1Wn1njWpyM3EI4
         1pkA==
X-Gm-Message-State: AOAM532NHyNGxJkQUSHPz6b7FHeG8RZVT8E3DtsFHJ4gSn51Q9F215d8
        yywjnHbRFiD93oXZF0Jb2w==
X-Google-Smtp-Source: ABdhPJzuS6mrQN9/NoCc6lwKj14DfBKazPXicm33pfgZnY6bLolOGpW9iV1iY/aGl6PBWH0MZYg+NQ==
X-Received: by 2002:a05:6830:1252:: with SMTP id s18mr42780191otp.4.1609447071769;
        Thu, 31 Dec 2020 12:37:51 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j126sm11281512oib.13.2020.12.31.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 12:37:50 -0800 (PST)
Received: (nullmailer pid 2321274 invoked by uid 1000);
        Thu, 31 Dec 2020 20:37:49 -0000
Date:   Thu, 31 Dec 2020 13:37:49 -0700
From:   Rob Herring <robh@kernel.org>
To:     Erwan Le Ray <erwan.leray@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 5/8] dt-bindings: serial: stm32: update rts-gpios and
 cts-gpios
Message-ID: <20201231203749.GA2321239@robh.at.kernel.org>
References: <20201218190020.1572-1-erwan.leray@foss.st.com>
 <20201218190020.1572-6-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218190020.1572-6-erwan.leray@foss.st.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 18 Dec 2020 20:00:16 +0100, Erwan Le Ray wrote:
> Update rts-gpios and cts-gpios:
> - remove max-items as already defined in serial.yaml
> - add a note describing rts-gpios and cts-gpios usage with stm32
> 
> Document the use of cts-gpios and rts-gpios for flow control in STM32 UART
> controller. These properties can be used instead of 'uart-has-rtscts' or
> 'st,hw-flow-ctrl' (deprecated) for making use of any gpio pins for flow
> control instead of dedicated pins.
> It should be noted that both cts-gpios/rts-gpios and 'uart-has-rtscts' or
> 'st,hw-flow-ctrl' (deprecated) properties cannot co-exist in a design.
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
> 

Acked-by: Rob Herring <robh@kernel.org>

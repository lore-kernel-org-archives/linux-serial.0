Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D24C433B4
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 21:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEFA61073
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 21:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhDOVNM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:13:12 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:33456 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbhDOVNK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Apr 2021 17:13:10 -0400
Received: by mail-ot1-f52.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso1403255otl.0;
        Thu, 15 Apr 2021 14:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JQ2Zv9KN+sFtm5hgoZ4mlRTwKbTrKF/NDQ8a3eP11BA=;
        b=aRA/gwXOs5Zd7gO+mxfFHuFe62F/L4SGDGoR22nh88U1GI5m2jNL8D2d+g7STOb43o
         mHejnMeFvAzUu9jzxjQQxRjaMYqdxGIeqNXAAOEFw4VwspBIXj+1QCB0vH84cRGHuoBV
         AIY6J8lCVFyC+VaJSa23wCy2pBxdPR2AaDPLXF6LmGqbMH6/kUR/MoJJHIVPuF+Dw3gE
         2lWxiJi22rKOPd8oRI1tFvlDNLfz5VhI7jjflf54mMkmVn9AMp9WXAGt42NB0KsbDMB5
         9END61p9ZboZkp8TLpRCGbauGWVUtgFNoHGs9xfL9eDPxro+NUbZpOV7jhlEg4RAkNe3
         VirA==
X-Gm-Message-State: AOAM53351R2ZEfvdsP77FTgZdYrvbQ66slJTBN6cToO+fl9UVxxpk36F
        xjQ97zWh52fOqurK1/pQVmnLuLWPEw==
X-Google-Smtp-Source: ABdhPJwQtuI68Yw0PKHkGhf6QScMLr5HtMsvZBmENUaHcyxdAy6/E/akiOKRdGyzo/1qXRBt+dzd0Q==
X-Received: by 2002:a05:6830:1045:: with SMTP id b5mr945582otp.257.1618521166394;
        Thu, 15 Apr 2021 14:12:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w7sm881135ote.52.2021.04.15.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:12:45 -0700 (PDT)
Received: (nullmailer pid 1891337 invoked by uid 1000);
        Thu, 15 Apr 2021 21:12:44 -0000
Date:   Thu, 15 Apr 2021 16:12:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Erwan Le Ray <erwan.leray@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-serial@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentin Caron <valentin.caron@foss.st.com>,
        devicetree@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: serial: add RX and TX FIFO properties
Message-ID: <20210415211244.GA1891289@robh.at.kernel.org>
References: <20210413174015.23011-1-erwan.leray@foss.st.com>
 <20210413174015.23011-2-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413174015.23011-2-erwan.leray@foss.st.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 13 Apr 2021 19:40:12 +0200, Erwan Le Ray wrote:
> Add two optional DT properties to configure RX and TX FIFO thresholds:
> - rx-threshold
> - tx-threshold
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F1C433B4
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C71661209
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 14:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbhERORe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 May 2021 10:17:34 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40535 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243554AbhERORb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 May 2021 10:17:31 -0400
Received: by mail-ot1-f45.google.com with SMTP id s5-20020a05683004c5b029032307304915so1470762otd.7;
        Tue, 18 May 2021 07:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8/dUUomjGvbOclUR2QAeFNgczOIsJz86uWLzhgCHwkA=;
        b=DQcHdMI5hdLQopY+VU7j9PFQDCmXn7aVrrPK77W3TGaZ0ed/AaBWq76FIEyT3obzEw
         1+BVP1Jby2X8pCbjTJht+NczieCF1RqdKWVlMDP2WHe+U7gosVHiWj5kaLh8mTxDGNVf
         7SsBDx0YFWtdPktNUj99ijQqDCDV1DiDGp/BnPxtG5XHrRN00TcKeEU1uF9SFDWXlUyB
         FdDnbFZmHQgvbhn97taYkQfXdEB9Uw1mIXzO3/i++Gf+2v2sU6UParuG9lhRK1GeuzTb
         HPASqa7rfEgyxCEf/rZMeh4fkGVkolb9ODJLVgk7qM3KRPGxCOHIoMiKFHUc4yWVJ1Q/
         kedw==
X-Gm-Message-State: AOAM5330SjgU7OYKJnR27JYZx8cxhaiJY67Wyd8/BkQ7z/ekZqqLKtKO
        6cJorT8gD2lC6quoEXmIKA==
X-Google-Smtp-Source: ABdhPJx7x7GxXWPoSEqkaKyzCpwLrsRj0UQrgFsgP6wnfOIrnRXcl0WMrwYUQSSHmmHVlTNRBVlxcQ==
X-Received: by 2002:a9d:491:: with SMTP id 17mr4529640otm.184.1621347373462;
        Tue, 18 May 2021 07:16:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u24sm3874096otg.73.2021.05.18.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:16:12 -0700 (PDT)
Received: (nullmailer pid 611575 invoked by uid 1000);
        Tue, 18 May 2021 14:16:11 -0000
Date:   Tue, 18 May 2021 09:16:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: serial: snps-dw-apb-uart: Add Rockchip
 RK1808
Message-ID: <20210518141611.GA611494@robh.at.kernel.org>
References: <20210516230551.12469-1-afaerber@suse.de>
 <20210516230551.12469-3-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210516230551.12469-3-afaerber@suse.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 17 May 2021 01:05:44 +0200, Andreas Färber wrote:
> Add a Rockchip RK1808 compatible.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

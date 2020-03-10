Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F2C10DCE
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 19:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A1A22525
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 19:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583868778;
	bh=vtoQHm8CwndQqwISuDVBtwkw5F15vfzTipGakLSGCx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MC+i3gs0FJ3b7XhMAeevmg9HHIIjkpHQNkcb/6P4VTAkKApRlafWO8zy5IxbT+E+H
	 J/V1VOmSruu2i9mmWxZ9TUDTFhD/zgKrJFDk+ol0kGLd/WhpfxlEoWr1umXDsi7oxq
	 xfYUY6KCmTiFR7ZcsN5ELkC7yiL6Nj73ED58XyTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCJTcz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:32:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43904 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJTcz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 15:32:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id p125so15110453oif.10;
        Tue, 10 Mar 2020 12:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eIE4b9URO1qb+MxsPOjVs9T43nhsRKMyMwg2+2kf3Bo=;
        b=rPeU/CB7wHyeTsfT3HtSmQcj5Z4fH00gSaDwR3jy2ttNYAJPaav6I1D/IgGTIqb38N
         vwaotwGRao5UQWJQ24BkM1qXcEp4tinVajXdOfXarPiBDE/Qj11o55IuN1GwfnOJtTTg
         2Dk4sC2BF/jUrWsBRYqnDJsUC7uyxzBfqE63AxouIyMONKp/RwysqllfyqCGOwWSP+yS
         2Qm9cKYNWATbPQv/oDnE3YAdeaziZOd5qTZdKPuT1XKpvEuDv6vu4lQUlxrRPIRq9imh
         Ivuimv3VQ7+sIJHtbriwOsrSEJdM6AFU7y4SLnxjfezFseoJI2EuT9TZlflZ6SIDWv8L
         MnYQ==
X-Gm-Message-State: ANhLgQ1V3A2o318Y5gZbqrVUhhvoUvawGo5bJHL7/iNCkwHDhhYfV3Q9
        etSLluE3jvIeTe7ev7jhncL5TsI=
X-Google-Smtp-Source: ADFU+vtyF0UxNd2V5SNDAhbqfD+SoLrFN/9/7Iy1fakA8ZwCLf/fMWqKCvI1jf25Ndt1qbrkinmu+A==
X-Received: by 2002:aca:d553:: with SMTP id m80mr1624311oig.30.1583868774574;
        Tue, 10 Mar 2020 12:32:54 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 96sm16366528otn.29.2020.03.10.12.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:32:53 -0700 (PDT)
Received: (nullmailer pid 23387 invoked by uid 1000);
        Tue, 10 Mar 2020 19:32:53 -0000
Date:   Tue, 10 Mar 2020 14:32:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: snps-dw-apb-uart: add compatible
 property for rk3308 uart
Message-ID: <20200310193253.GA23246@bogus>
References: <20200302133910.10942-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302133910.10942-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon,  2 Mar 2020 14:39:10 +0100, Johan Jonker wrote:
> A test with the command below gives these errors:
> 
> arch/arm64/boot/dts/rockchip/rk3308-evb.dt.yaml: serial@ff0d0000: compatible:
> ['rockchip,rk3308-uart', 'snps,dw-apb-uart']
> is not valid under any of the given schemas
> arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dt.yaml: serial@ff0a0000: compatible:
> ['rockchip,rk3308-uart', 'snps,dw-apb-uart']
> is not valid under any of the given schemas
> 
> The compatible property for the Rockchip rk3308 uart was somehow never
> added to the documention. Fix this error by adding 'rockchip,rk3308-uart'
> to snps-dw-apb-uart.yaml.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/
> snps-dw-apb-uart.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks.

Rob

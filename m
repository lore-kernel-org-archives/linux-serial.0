Return-Path: <SRS0=aTVb=7K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7647C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 20:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1782088E
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 20:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590699042;
	bh=36x+FSxQLLXtZZ/ZrL/q8iSayQDTf9H3L9O43iR4vH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mgOZ2eBrZPspgEOMLZRw5yB4yR4P8UnmwLgH9svZ7KU7428f2ReTbTTQLvh7OL6Na
	 vIkvOgCUY8W6ZvdIXTzClQ+1V2R2xZ0CR1zmnV/Aa/zhwd9dhbKCM289fOLWsrE3ru
	 zMrL/Lby8twD3SoLkGCiPYantArKgw3eNp1H+TdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407342AbgE1Uul (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 May 2020 16:50:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35986 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407344AbgE1Uuj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 May 2020 16:50:39 -0400
Received: by mail-io1-f68.google.com with SMTP id y18so11271566iow.3;
        Thu, 28 May 2020 13:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0gpSBvU7Eq2fXFdQdQngmNs7MJbK+QnxcEs9pUZUM6U=;
        b=tt2ioBPMqBOwQY8IQm2xOjIYeW8lFAmI2/T521eEp6ffC2LoL4n9NiZmq6yACBfZO+
         ZgcjZKQw2Z5BDR4tCfXyYkWHfhHBnmh44di/0mumSXLKHQT9zmXBPtYUFhljsAxAfyEj
         u6yuD+AKF4F5CLxi98hNY1w4cDcwdKwA/HR3ps2EgLCRoEBigVNrbiy5ctWk6xGgaZsP
         Yr1xlJQekclgX14u/C6UuM6MG5tEUly+3Pe9nmTEJD2/AZp67d8Z+vTK8Vq3fvdD7wLS
         YZDcGTdgCMPWHJd+89Xco0i8WlLjXq3BSPMTnwiwsr2oNm0mIojCejQxteVGe1lf0Ia/
         PlIg==
X-Gm-Message-State: AOAM531jUqisZDbliCbc/iBgtch25qGgsCijYySRdP5luDDTt8K32rWu
        U3q1SllihuTUyb+kHaRvDQ==
X-Google-Smtp-Source: ABdhPJyd8/DPXzsxw9RIxmjqQyQZlAxV9pIk6OfK0yzaA7cdcSEsZFdOcAC+qFs8Vp3LgSG0VWobGg==
X-Received: by 2002:a02:3e06:: with SMTP id s6mr4201198jas.57.1590699038478;
        Thu, 28 May 2020 13:50:38 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h5sm3614341ile.35.2020.05.28.13.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:50:37 -0700 (PDT)
Received: (nullmailer pid 653204 invoked by uid 1000);
        Thu, 28 May 2020 20:50:36 -0000
Date:   Thu, 28 May 2020 14:50:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     devicetree@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: Add binding for rs485 bus
 termination GPIO
Message-ID: <20200528205036.GA653137@bogus>
References: <cover.1589811297.git.lukas@wunner.de>
 <4f4411895dc52c846f766e7f7207ec412c4811b6.1589811297.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4411895dc52c846f766e7f7207ec412c4811b6.1589811297.git.lukas@wunner.de>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 18 May 2020 16:45:01 +0200, Lukas Wunner wrote:
> Commit e8759ad17d41 ("serial: uapi: Add support for bus termination")
> introduced the ability to enable rs485 bus termination from user space.
> So far the feature is only used by a single driver, 8250_exar.c, using a
> hardcoded GPIO pin specific to Siemens IOT2040 products.
> 
> Provide for a more generic solution by allowing specification of an
> rs485 bus termination GPIO pin in the device tree.  An upcoming commit
> implements support for this pin for any 8250 driver.  The binding is
> used in device trees of the "Revolution Pi" PLCs offered by KUNBUS.
> 
> [Heiko Stuebner converted the binding to YAML, hence his Signed-off-by.]
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

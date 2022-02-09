Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24F1C47087
	for <linux-serial@archiver.kernel.org>; Wed,  9 Feb 2022 03:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbiBIDDc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Feb 2022 22:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359775AbiBICvZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Feb 2022 21:51:25 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B154C06129A;
        Tue,  8 Feb 2022 18:51:18 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so951181ooi.7;
        Tue, 08 Feb 2022 18:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VO57A+eaNZtnz6wrYVmF9l+Ime3J98JyiSD+FE1Zl2s=;
        b=IxtwRbkbNqTDs7ZOZ0EAnYxdmPQE7juvsvdCsVU944EBA/MxTA3M9HjOX0Znlncwle
         EWv+RSPqm8AyYXFUYapjmQ3gF6hc8hgXHfsLI6NUPgVeDsAZG5TDPrVcXnD06Xrx1q+D
         8dg+mRlFVqWwjPmYHvPqJAzvgJcoO2GyG/vFYI4D+X9E5ei8vtCcGkHFKMFHPDD7WpLQ
         r8bykoDbL9jHKp6/Mpmomvx40Z2YpXZXLD7DcdxYNYda5MT7fe6YfqFkB/xv8aXFgbQ4
         ss3lVhf/qgaekyv130jsXOdNRvduV/t6/QE3U2ZRAjzmf2SJYrydO7MSLR38rtkdAc3f
         NIrQ==
X-Gm-Message-State: AOAM533krJ0qb7gRReQtjvpRZvVuuXN5tCOI04Cs+GGyAbmzk8MnVIRa
        rf426Ox2IMnTQoIc6zqpsQ==
X-Google-Smtp-Source: ABdhPJxvuliPhG9zvYZUYypDptFiBEp90kxcqHXsBxraIopOXa+eDr+9phL24xxz3FeKGwifvVmfeA==
X-Received: by 2002:a05:6870:b283:: with SMTP id c3mr291386oao.196.1644375077341;
        Tue, 08 Feb 2022 18:51:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h27sm5987295ote.57.2022.02.08.18.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:51:16 -0800 (PST)
Received: (nullmailer pid 3521815 invoked by uid 1000);
        Wed, 09 Feb 2022 02:51:15 -0000
Date:   Tue, 8 Feb 2022 20:51:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     linux-serial@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH] dt-bindings: serial: fsl-lpuart: Remove i.MX8QM from enum
Message-ID: <YgMsI4BTbBTR2vDP@robh.at.kernel.org>
References: <20220118135535.2118720-1-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118135535.2118720-1-abel.vesa@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 18 Jan 2022 15:55:35 +0200, Abel Vesa wrote:
> i.MX8QM lpuart is backwards compatible with i.MX8QXP, so lets remove
> the single match from enum. This will force nodes to have both compatible
> strings, since there is alreaady an 'items' entry for that.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

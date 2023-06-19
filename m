Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67B1EB64DD
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jun 2023 11:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjFSLrm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Jun 2023 07:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFSLrk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Jun 2023 07:47:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9FE199
        for <linux-serial@vger.kernel.org>; Mon, 19 Jun 2023 04:47:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f909853509so13298515e9.3
        for <linux-serial@vger.kernel.org>; Mon, 19 Jun 2023 04:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687175246; x=1689767246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JWlJYwdCUfBlFGZKizl0GxiNXteMsT9gcqvTsOApU/E=;
        b=K0yglfGatPbUta8mAHvIga/XRv1NIT5KcaFCvQrQNd/DzfjIcQlCKKMBp/y5CiWzOC
         ERZ2X6vf2klvxBer3CXn1Zy15a5c+RF8wJOpRm1ismrnGpHf1L5v/hsBCYRTgAggpIid
         /9Wf7nQrCIiSXfJr40vd9C4JszeiThmzCELA5sNENfi7NAEvjMlhiJRBY8KapAr9Whcs
         6o2zowGQOTz1qmP8CyhTav8Is7zpBMZNuQEkrIF6iRbk+CNxTFOa2hheIpIEdhnpF9BL
         ZoROaXbnJSemqpiFasuVDiewUHedO+5B7Rl75ltY3Jyh5QmsdkiM58eVGzg4lfn6j/Ew
         kNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175246; x=1689767246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWlJYwdCUfBlFGZKizl0GxiNXteMsT9gcqvTsOApU/E=;
        b=ji3rZcYmp2bt1G0OZkusiTqix2nzN/m6S3nkQjlQJZm2b+6YACVAGPKPGSrG/saBGz
         SvRGd+Vkw8NlRWGVQscgC8zjquktl1GsugvG+w2tr6wVkb5le61KPCss2IQ6tJLj55AX
         PwHNDj+jYzZKxYwp4j5NnnrNgR0iiCtkJot+1ivNMLoE6vHN6QL6X+P/UNF5s05kLWdh
         PhElxqsk0rqz57ygc6PBJypXtQOm6sZJmS3nCtyTGU9/PofHBD8p69zm2P3xL1cvCV8X
         PTpTzUadT9D2rSHJ1yBW1uy+FYeeROm0UpC+x21sPN/HCBNOEWubaumQw/C08javNfPr
         a2Zw==
X-Gm-Message-State: AC+VfDyI5elb7dec6hp/EsoZW1/WNATK1wGE5a7721xBnz7vh/iMIW5n
        QD2v8lq0zOAVcKYsD6/y64c/6g==
X-Google-Smtp-Source: ACHHUZ6yF5Wg+ySHnIbIm3GmKwvUQW1PgUhZnWqi3kkg14VfkIrwyMlupDh3Dc8Cu4G10HmONT74ZQ==
X-Received: by 2002:adf:d092:0:b0:307:7f38:37f with SMTP id y18-20020adfd092000000b003077f38037fmr5678278wrh.66.1687175246001;
        Mon, 19 Jun 2023 04:47:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k6-20020adfd846000000b003111025ec67sm13562580wrl.25.2023.06.19.04.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:47:23 -0700 (PDT)
Date:   Mon, 19 Jun 2023 14:47:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Elen Song <elen.song@atmel.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: atmel: don't enable IRQs prematurely
Message-ID: <0be8c2ad-499a-4cf1-af98-920af542c5b9@kadam.mountain>
References: <cb7c39a9-c004-4673-92e1-be4e34b85368@moroto.mountain>
 <d87d9f00-8d85-6220-43d3-51ef8e793193@kernel.org>
 <c0c661bb-2584-46cd-9c72-8f1d9ccbaee4@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c661bb-2584-46cd-9c72-8f1d9ccbaee4@kadam.mountain>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 19, 2023 at 02:44:11PM +0300, Dan Carpenter wrote:
> On Mon, Jun 19, 2023 at 01:01:49PM +0200, Jiri Slaby wrote:
> > On 19. 06. 23, 11:45, Dan Carpenter wrote:
> > > The atmel_complete_tx_dma() function disables IRQs at the start
> > > of the function by calling spin_lock_irqsave(&port->lock, flags);
> > > There is no need to disable them a second time using the
> > > spin_lock_irq() function and, in fact, doing so is a bug because
> > > it will enable IRQs prematurely when we call spin_unlock_irq().
> > > 
> > > Just use spin_lock/unlock() instead without disabling or enabling
> > > IRQs.

Maybe I should add a "a second time".

"Just use spin_lock/unlock() instead without disabling or enabling
IRQs a second time."

regards,
dan carpenter


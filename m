Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E6DC433DF
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 09:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E583320639
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 09:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlHcNEPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHSJ1d (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgHSJ13 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 05:27:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3955C061757;
        Wed, 19 Aug 2020 02:27:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g15so6634078plj.6;
        Wed, 19 Aug 2020 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/x+ioxj0OECDWfuZ/8cLiBt08ZEEJV9C/RwFT59ZAOY=;
        b=qlHcNEPNB5wNQZEWyxFpsV2++SFSMZh1dkF7Pyba7MLEMg3mkx3NQwLviJdrWE0EPz
         MbV8sUmZnqEOpclkWErN1k6jtF7+iJnXTNBC5aOFOW5CaxPm+wYWXjGYES/peopTxTvo
         sT2R9RjdVTa+xAFWGxTFBMxcaXsXOSf2lbbSNs+D/u5zNzZw9Ejozsg+GBNDVerdT+RB
         6YegFcEtE49I32y9ESkVWu5d5WCvOx+GLXgXA5A1Sg/ULBdPECPUXCpBeDN169pBLUe2
         MzxCR4DWc7g2pCkJ/D5u5CmuhtV14V82NDmFxKbsiMF/zrME9zPFmf0X1FVLe7/OlIyg
         YhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/x+ioxj0OECDWfuZ/8cLiBt08ZEEJV9C/RwFT59ZAOY=;
        b=ssFJFvPVjTBkHDkvHdMVvx8EuytEg+Lvrlr9YoaS6lN8HG5oCQ8Zkk2iUVhFFP/uv2
         n3msHOwQScc5YodSIAZJmyOzu3vqbVhqTjk0uoacQLS2D9/vbogWTzmGwLVkVpwaM7XO
         hw9l65DHXxQPzvuXYsqIMWXruHZdqQSoEg7zmY6vnn+8Xy9nMkg3lOoOwecKdc9gt9bb
         /IAnJyPITGoJeK+y5kb17iuSx0gzgN/tpUKlFk+yqzH9dYfnYKfG7zvoIwt/F2RbKFDb
         BWi9nSv8ZH0payAFrtP+f0rPNGI/4dssnvLTAYlbSDRJZRGHq7go0HRhnuWuZud1f37f
         AWYg==
X-Gm-Message-State: AOAM532kiW2CVPooMdoEqoN5xXLgLyJTa5PQPvIWqYjEcm5wb9obOEYQ
        dLx6V0Ektf2DMXSMr1VdtbM=
X-Google-Smtp-Source: ABdhPJwoeJen/PV/xW1fP54d8Ex6WgD3SAgVdfzKFi8WkN+xy6V2pQqgMCP8FmW+r9hrzRGiROSg+A==
X-Received: by 2002:a17:902:5991:: with SMTP id p17mr18666350pli.78.1597829248871;
        Wed, 19 Aug 2020 02:27:28 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id v1sm1334067pjh.16.2020.08.19.02.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 02:27:28 -0700 (PDT)
Date:   Wed, 19 Aug 2020 18:27:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCHv2] serial: 8250: change lock order in
 serial8250_do_startup()
Message-ID: <20200819092726.GB3302@jagdpanzerIV.localdomain>
References: <20200817022646.1484638-1-sergey.senozhatsky@gmail.com>
 <20200819092106.GA4353@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819092106.GA4353@alley>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (20/08/19 11:21), Petr Mladek wrote:
> 
> The patch is committed in printk/linux.git, branch for-5.10.

Petr, as far as I can tell, Greg has applied it to gregkh/tty.git

	-ss

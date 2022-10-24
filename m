Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8869BC38A2D
	for <linux-serial@archiver.kernel.org>; Mon, 24 Oct 2022 05:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJXFWS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Oct 2022 01:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJXFWR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Oct 2022 01:22:17 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9890647D8
        for <linux-serial@vger.kernel.org>; Sun, 23 Oct 2022 22:22:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso5530052pjc.0
        for <linux-serial@vger.kernel.org>; Sun, 23 Oct 2022 22:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkglCD++rBAhdxJENjRjV84ieq2zA95yE5d2YHv3MX0=;
        b=JiBw3jcj5dZjnLXiFYmma44ug6rDhKqzzO2PeInT/NL0kLYWKOAomexSB2z1lQL+CA
         c+x19Orgq18ANdKDFm60I4FNtW/2TzibSnc/tCubjhP8rVCWMzti4UMe285iZqliuvl0
         udO1sl4xsvMqikTC7S+p1trak7bUt1GuOZ+BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkglCD++rBAhdxJENjRjV84ieq2zA95yE5d2YHv3MX0=;
        b=Iw1yZqSiP6dW0ArPgmVKz1TfUJzrvdRV8x2bc3gEThsvUlJuYcgdIhIaKAxkAxL6qD
         OqxkIK9EdcZ6poc8t5C5lKjo5QlaBDwqVWE9E8EaYtdWx8MsmtELqWxnCkPrXTinyyiZ
         8nH7SBtBZvL8Wb2KcAl7W8NE4oSdsXYyQRbErf0mibGXM8PjZ6HOFbNfPuS6wPuIaHHq
         9SmJInGxF6+gSFBrmcyayLVmF0RcNeYf4QikBhAg2xAJ4b7enWTdmnEg0MfH/Mp2QAfn
         7CDjd0VFyt6FDeda5Jyf3y9p8/VmcA6DPe+rgvW2qMI0T8bHS7a2r0S87PmdtxxgclfR
         p7rA==
X-Gm-Message-State: ACrzQf3HZO5ajFOGvSmGb+GlnFhxI1BL7IXivitinCtCG+G3/qMv+O9z
        1IA3oxVZSQUYBanBYrhOfcUsYw==
X-Google-Smtp-Source: AMsMyM63AapOxi4cQFnaRsxgJpIJLodlUlAw26IgKyPUf7Uk5QLSRVJ5YYvF7MVj77tlMmuvRTVJqA==
X-Received: by 2002:a17:90b:11d4:b0:212:ee83:481 with SMTP id gv20-20020a17090b11d400b00212ee830481mr9470051pjb.36.1666588934331;
        Sun, 23 Oct 2022 22:22:14 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:7f0e:f6a4:8d85:37e4])
        by smtp.gmail.com with ESMTPSA id y26-20020aa79e1a000000b0056203db46ffsm8571912pfq.172.2022.10.23.22.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 22:22:13 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:22:08 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 01/38] serial: kgdboc: Lock console list in
 probe function
Message-ID: <Y1YhAA9T5edwFnu4@google.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (22/10/19 17:01), John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Unprotected list walks are not necessarily safe.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B79C4332F
	for <linux-serial@archiver.kernel.org>; Wed,  9 Nov 2022 08:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKIIXx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Nov 2022 03:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKIIXv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Nov 2022 03:23:51 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B3A5FDF
        for <linux-serial@vger.kernel.org>; Wed,  9 Nov 2022 00:23:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso735154wma.1
        for <linux-serial@vger.kernel.org>; Wed, 09 Nov 2022 00:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1aYtp8rKKFj6AMeEh8TgKPoMz3+QrQuPeMrc+lG2dC4=;
        b=CgVAeDwHGGqjX9pPwdf50j6laHJDZQEpjWOLA+xKGBUAg7h+8blHA3XYE+A4H6hy1I
         +1dKSYtKGZUuAl+U9Z0WfHgdyBZUvv9EzmvnG1ytRtExRhNWemLhbSmYN7VfeAGhepYx
         U7rN1/9hE5+K+sGZigDzLFL7ujbKcztqQxkyIAxYSeQCEq2CWvKXsIfVZ+dzQwytVxHm
         /enmgz1Fm6oegStPmknZqLuUrCtU4jyv1J+g+ubkBgU15W01xBdlc31YPr08Z+nBt3Mh
         umPmuVYBzhjNej5bjPy6kldig6wZnM02W4P2ZIMdQO5MXwK4fBQcYQSJ9CeltH8XObBN
         aWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aYtp8rKKFj6AMeEh8TgKPoMz3+QrQuPeMrc+lG2dC4=;
        b=OtHSi4xLanUT4FE3ymtvMJi8nDknz7iBGzd3vnfMlz2EFmxptQnuI0WmlrqzQKGuvx
         MIrsVlef7iY0lR7NpipWkBApTzTAP1cnuNXlRXpcQDZZ6wKmSp4268VCOc2L4oJ0/6yz
         9IV3cSyNvktMDA64z8i+2vPwgUfoa7a+pVprj5nC0KPvHCoLemgUP++MlZjERL9E0uks
         JqSlfwuNQ8OCwpXgxga/zf3ctOxDaNXMZABfuPXT8RQ9EJ215cOdEAXFHou/77nEvBM5
         JeicOv0pXQsFm+cno+f0RSTpU0Y7o1M2TZqJFUIhHxh8SEkNYXWOEVCYYkYW9fzR50/b
         PiCg==
X-Gm-Message-State: ACrzQf3CJKhW/8MukM7EOu4XPkPg04ncIq3nu7DUiseGVORmL6Nluznv
        RN/ivnG1B2V5MA74nHhi9xhoN+iOXdBFFg==
X-Google-Smtp-Source: AMsMyM7BZMkF3omfYJ0Pcs634CeYkMyiilQRZafhDBqMckyxB1fq4QFZDXT0nt9VVI7CEIw/1HMRhg==
X-Received: by 2002:a7b:c7d1:0:b0:3cf:6b10:ca8d with SMTP id z17-20020a7bc7d1000000b003cf6b10ca8dmr873390wmk.44.1667982228087;
        Wed, 09 Nov 2022 00:23:48 -0800 (PST)
Received: from ash.lan ([167.98.0.196])
        by smtp.gmail.com with ESMTPSA id h1-20020adffd41000000b0022da3977ec5sm12408609wrs.113.2022.11.09.00.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 00:23:47 -0800 (PST)
Date:   Wed, 9 Nov 2022 08:23:46 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 12/40] tty: serial: kgdboc: document
 console_lock usage
Message-ID: <20221109082346.2jtw2i6asli5qohk@ash.lan>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-13-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-13-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 07, 2022 at 03:22:10PM +0106, John Ogness wrote:
> kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
> are unregistered until the kgdboc_earlycon is setup. This is necessary
> because the trapping of the exit() callback assumes that the exit()
> callback is not called before the trap is setup.
>
> Explicitly document this non-typical console_lock usage.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB26BC4332F
	for <linux-serial@archiver.kernel.org>; Wed,  9 Nov 2022 08:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiKIIVB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Nov 2022 03:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKIIVA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Nov 2022 03:21:00 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE1B1CFCA
        for <linux-serial@vger.kernel.org>; Wed,  9 Nov 2022 00:20:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso715854wms.4
        for <linux-serial@vger.kernel.org>; Wed, 09 Nov 2022 00:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQTh+h4wAo4t46Rl+wdOIR7scWoK1pkYjOSDztAOvMk=;
        b=Cpek1q7QSMGXU1gFGsylqWYf0SzpoFAOnziq+0yCk/hPO0U0Xq2kq0DUIJhaSedm3O
         Jol89RRWCiZVRDnFZ/3Odn+y0+oQULQZ4SZh/JYYpFmkt8YPDvvQRSPFMgWtOjxHI4rQ
         pn4K+rQ4VIE7wTJxowiODzKlxgs/+S6PdIRt9mNzyqSq9+lEK6aeyjYrK+16bpfykehg
         +Ag+15KKt5KlviWRBZQh1SC00aHih4RA1FJZ+4Ex0k0dFQsxtWGtjuCVZoLWpcsCv6yw
         4ViyYZVhGSKO/q+v/ZQ+tapEmWuBLH8xHWRfL64tgbCSDpxJeE6xqiCauPfGbW0T8A30
         sdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQTh+h4wAo4t46Rl+wdOIR7scWoK1pkYjOSDztAOvMk=;
        b=sn2M6GZIR5sL1JFA8un2Z9Hi13+ld8zs8oa509n1pdGwM204nGt1d7NuyFVxEu/kfR
         0cshhWAJ1Q9K11ADxvYJVn6vGBwujQUIpwC74cv1qJTk85sTMRRk1hWswBPKwcVl055D
         EBtziTtHtk5IaeMMiXAaYGPah7tidpCy/WKmjomE1jBWi4Z1qVvO+G/NBx3RHg3NRctd
         ilI5qpQMwihX9nSWugW4/ONnqzGNoNsn9JcJL1ROLQ0h6T4fZDEBLgFlIZh0PDxcqRNC
         MATCAs7JzxS0kSb7AgKQuknD/kq34YogI/nJEv4n9rUQcDprcpNmRvUgVN2bcPxkL9fG
         zW1g==
X-Gm-Message-State: ACrzQf3SZsgPIXYlQt4cT+zKROxHsbxD1xxfC1JUV/+AEfwYsxxUpq/7
        yHcm1XwpTYc2thlMjCecfdue/A==
X-Google-Smtp-Source: AMsMyM7a3muG+xctXMNmA6t/4RK9t8xXwL/BnJxGkPaozlKTl4ulPc+VWNiTqriOd50k7tssbwBdJg==
X-Received: by 2002:a1c:7704:0:b0:3c4:bda1:7c57 with SMTP id t4-20020a1c7704000000b003c4bda17c57mr866812wmi.6.1667982057803;
        Wed, 09 Nov 2022 00:20:57 -0800 (PST)
Received: from ash.lan ([167.98.0.196])
        by smtp.gmail.com with ESMTPSA id n22-20020a1c7216000000b003a6125562e1sm699068wmc.46.2022.11.09.00.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 00:20:57 -0800 (PST)
Date:   Wed, 9 Nov 2022 08:20:55 +0000
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
Subject: Re: [PATCH printk v3 02/40] serial: kgdboc: Lock console list in
 probe function
Message-ID: <20221109082055.melzih2jwhwjztam@ash.lan>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 07, 2022 at 03:22:00PM +0106, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Unprotected list walks are not necessarily safe.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

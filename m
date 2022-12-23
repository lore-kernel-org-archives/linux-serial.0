Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE4EC4167B
	for <linux-serial@archiver.kernel.org>; Fri, 23 Dec 2022 02:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiLWCb0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Dec 2022 21:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWCbZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Dec 2022 21:31:25 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Dec 2022 18:31:24 PST
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD901581B
        for <linux-serial@vger.kernel.org>; Thu, 22 Dec 2022 18:31:24 -0800 (PST)
Received: from gw.atmark-techno.com (localhost [127.0.0.1])
        by gw.atmark-techno.com (Postfix) with ESMTP id 7A42C60111
        for <linux-serial@vger.kernel.org>; Fri, 23 Dec 2022 11:12:38 +0900 (JST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by gw.atmark-techno.com (Postfix) with ESMTPS id CEB2260110
        for <linux-serial@vger.kernel.org>; Fri, 23 Dec 2022 11:12:37 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id o18-20020a170902d4d200b00189d4c25568so2529601plg.13
        for <linux-serial@vger.kernel.org>; Thu, 22 Dec 2022 18:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93cLn+LRIp8cfyEt0hoEq4b5MzTpiSYxIJZ4bO6Vpug=;
        b=HIhehyJqUYyrLvU+feA3HmiIUCBrYbNkkH7uIcHW8ERsjvzCHWBzQX5kGObyGTOZPd
         e8o1ff8cHjhTGU9IBDI1E5PhkubOgIxMDMoXdbWIQg8VNkgT84iOxiky54Dk95OlLBt8
         GmTWYUckYWflrMDRhHVRROO5ubr+zba7t0yZOTXmM7LnMHWatQ12OV7Us+T+5NVlag2a
         QX2uOAtvcCOUX7qCvihh5cCggCy4QpfoO8VKICnGmzCBBF4T5JsfCHcCW1sdgSlXueE3
         YOXLR2kGge1PaBNZ2Lst4ZfmSNPUX0+lIuBel49YJAVcgtCD7A+o6ngC3285Q8Y8w6/B
         P99w==
X-Gm-Message-State: AFqh2kpCpsipqT+Rq1lnMd85cmepDtpT/jFcJ26HiNQKNsDeykuvkhsS
        H/5B8USPLAq1jq2J3NEYKU7a3b2ARO4YGzQR9wbvniJG5QkwI/P7TBw5xP2ca4KiLwrK2CvAZ/p
        YuDBfp3KojlC3GU01DcLQAXzuKAR+
X-Received: by 2002:aa7:921a:0:b0:576:de1:cd32 with SMTP id 26-20020aa7921a000000b005760de1cd32mr8819373pfo.0.1671761556920;
        Thu, 22 Dec 2022 18:12:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv5NY5kv2b2FMEzQtFveGRj3mudS9rZ8bcNHH4p882FhazY117d677Z8wksF8JVTkfXujOgdA==
X-Received: by 2002:aa7:921a:0:b0:576:de1:cd32 with SMTP id 26-20020aa7921a000000b005760de1cd32mr8819357pfo.0.1671761556648;
        Thu, 22 Dec 2022 18:12:36 -0800 (PST)
Received: from pc-zest.atmarktech (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id y18-20020aa79432000000b00577617c05ecsm1320774pfo.130.2022.12.22.18.12.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 18:12:36 -0800 (PST)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.96)
        (envelope-from <martinet@pc-zest>)
        id 1p8XY2-00GpKT-2P;
        Fri, 23 Dec 2022 11:12:34 +0900
Date:   Fri, 23 Dec 2022 11:12:24 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Daisuke Mizobuchi <mizo@atmark-techno.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y v2] serial: fixup backport of "serial: Deassert
 Transmit Enable on probe in driver-specific way"
Message-ID: <Y6UOiAt+o7425bRa@atmark-techno.com>
References: <20221220102316.1280393-1-linux@rasmusvillemoes.dk>
 <20221222114414.1886632-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221222114414.1886632-1-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Rasmus Villemoes wrote on Thu, Dec 22, 2022 at 12:44:14PM +0100:
> When 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in
> driver-specific way") got backported to 5.15.y, there known as
> b079d3775237, some hunks were accidentally left out.
> 
> In fsl_lpuart.c, this amounts to uart_remove_one_port() being called
> in an error path despite uart_add_one_port() not having been called.
> 
> In serial_core.c, it is possible that the omission in
> uart_suspend_port() is harmless, but the backport did have the
> corresponding hunk in uart_resume_port(), it runs counter to the
> original commit's intention of
> 
>   Skip any invocation of ->set_mctrl() if RS485 is enabled.
> 
> and it's certainly better to be aligned with upstream.
> 
> Fixes: b079d3775237 ("serial: Deassert Transmit Enable on probe in driver-specific way")
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thank you!
I've confirmed both hunks are part of the original patch; I'm not quite
sure why we missed them...

Reviewed-by: Dominique MARTINET <dominique.martinet@atmark-techno.com>


This doesn't apply cleanly to 5.10 because 5.10 did not get
401fb66a3 ("fsl_lpuart: Don't enable interrupts too early") backported,
I think it makes sense to take as well so I'll send a backport of these
two patches for 5.10

-- 
Dominique



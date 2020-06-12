Return-Path: <SRS0=2C4M=7Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4109FC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 15:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC7C207F7
	for <linux-serial@archiver.kernel.org>; Fri, 12 Jun 2020 15:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6xOidOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFLPzy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLPzy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Jun 2020 11:55:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5A5C03E96F;
        Fri, 12 Jun 2020 08:55:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y17so10217962wrn.11;
        Fri, 12 Jun 2020 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ldBiqxM2Wmph1mzh2p3ETQJ83d3VWY1SMgHR8iuQrYc=;
        b=R6xOidOFM0pPz9ZS39ANsEao0OQnQop+E7f7u0qcjnIGijUNYY5XFjV2zcoijVY3Gz
         zmuOlanzRlUCFX1Ac/4qiwxIWByn7IO8Rh29cO2WGMgbu/Gh9HS9OmsYls6UJfiPQ0vj
         AwaOyhuIJvVkyoTWowjRDPj3djKV/JG6v3FiNvpCA5Z0BWERgVpgXg1Ply/hEecUYjHk
         KKrIOji22RGGmDpjOjq4Tgw8CrcpO74LLWP6FV0Qg2i/BRGBt8LBFM8AOGJzMVYPKn2l
         nnxyXxYEc50L1aJ48MdtA8aW+DhxWHqwlu30blj13rGH4/ELEku6BlnYlZPYbQZSfDCI
         BV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ldBiqxM2Wmph1mzh2p3ETQJ83d3VWY1SMgHR8iuQrYc=;
        b=tl+skNYNpEXha5+yOACJzHhD3IAxSsdKwlQ07SVFiW+Uokh9zUBjMcj3ekCNIZQdQ9
         Bjx7W5Ag2rqKY/Wk2dcTiqbWuJ/4iEfVeEj+tnkBIcYzuY93tUeoxqAOPMM7CPqMkeDJ
         LSdV/V64dndI5WvxHjvGnhhdw85XisX5r1/5UUcimjTg0MFDhFvXTd0NsCo1rP8S9FAr
         sWI2QluDQ0T1ORHd9zrfuDbYLoXfk/h75+QLkGGDxI5+5vFyQ5Fe1Ir0Pe8FYpQSsMWm
         Ga0Y4V2IIWiNKcYyxIgszhYjXMWZaAVnvP0TJ6ER2fIjJW/8GmUalnDLxfTp00/DigVg
         uz1g==
X-Gm-Message-State: AOAM533caC/cy3tFfVnNPbPntjBGb38Lt+3jnJCejKcvtQuE95zvKkYM
        Wtmwhh4JGNxR2PKHRywAuy4=
X-Google-Smtp-Source: ABdhPJyX3+XDeBOBaqJ4BaSkgMLR1RlHfAr0AIwkd9eXOcppi0fg0QDKIXwYk62RmSl68hIoMhN8CA==
X-Received: by 2002:adf:b348:: with SMTP id k8mr17145647wrd.157.1591977353014;
        Fri, 12 Jun 2020 08:55:53 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id a7sm9863329wmh.14.2020.06.12.08.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 08:55:52 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] serial: core: drop redundant sysrq checks
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200610152232.16925-1-johan@kernel.org>
 <20200610152232.16925-4-johan@kernel.org>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <ed1ea947-7c77-baee-95a3-5a9362d64f49@gmail.com>
Date:   Fri, 12 Jun 2020 16:55:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610152232.16925-4-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 6/10/20 4:22 PM, Johan Hovold wrote:
> The sysrq timestamp will never be set unless port->has_sysrq is set (see
> uart_handle_break()) so drop the redundant checks that were added by
> commit 1997e9dfdc84 ("serial_core: Un-ifdef sysrq SUPPORT_SYSRQ").
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks,
          Dmitry

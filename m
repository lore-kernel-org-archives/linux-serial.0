Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E5EDE989
	for <linux-serial@archiver.kernel.org>; Fri, 15 Sep 2023 02:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjIOC4J (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Sep 2023 22:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjIOC4J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Sep 2023 22:56:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C8226B8
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 19:56:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c34c9cc9b9so13512525ad.3
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 19:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694746564; x=1695351364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ML86qDe0AhWIXXN0KvUZJFVRWAhXeILzO6P0niCYCTo=;
        b=U1TzDyvFf0+opYyl3sbOS3MxL6aZ0NB3t73YWQAH1xdZer+SO1IfpMX0p5p1ZhCUbA
         I2YV4/4oVJQIQ9LXJbGFKE+KnkZZ9OLothOb1DGLyvCRPd8F+bwNdbrQ6kBs+h0EHnao
         zzPhz1V/ohGCpEaC8klxfjgs2tjfOmEoA7MNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694746564; x=1695351364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML86qDe0AhWIXXN0KvUZJFVRWAhXeILzO6P0niCYCTo=;
        b=Ppp98GEZfTrUg7FtsJVYGvzhBiSpg50bB8wpvXZokgAgSILWDKpwh78gwZVn19Wlfk
         Cq6YFcYn+oSYecPIguWF89whCO6P6M2vPthVWPHwk3iZg3+/osQ0R1cPGHlUVp4Ql8AO
         5o7fuO/0Tf/bYKb9hR+8DbSg13uyRT78Y8PDjEyqyJ7jRZJ4vkNLb3TPQpfO1XAm3lA3
         SFrnYHZB6ZmJeLY2GNNIYf0cLAO5eG28I9TqbgAjcfrquG2Pwhr5EQK4PNDx9fA3PsOj
         6hXzyHthBJopkPMHaqXpevWnDSrzyf4YyqGokiAggKp1+wbCv0sNtSwtsZRRnrhI7xiU
         fRzw==
X-Gm-Message-State: AOJu0YxuEcmYRTCkzw06/rHBrfzgPfZChonbbEvsC5+Zzco9xWtFK6ql
        g7U7zEfHVWlwZeMlkiIGpLZ4wW1dQoL8pWS6pUs=
X-Google-Smtp-Source: AGHT+IFXm1klVklCUGHFSnCwQsYSebuPaqWAY+e0BAhgxh9FHeHRtyNY0vSeXflj4fvQ+FAzcR560A==
X-Received: by 2002:a17:902:d2ce:b0:1bc:224a:45c1 with SMTP id n14-20020a170902d2ce00b001bc224a45c1mr460931plc.55.1694746564579;
        Thu, 14 Sep 2023 19:56:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902eaca00b001b89f6550d1sm124165pld.16.2023.09.14.19.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 19:56:03 -0700 (PDT)
Date:   Thu, 14 Sep 2023 19:56:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Dan Raymond <draymond@foxvalley.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Message-ID: <202309141955.12923F85B8@keescook>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh>
 <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
 <202308301421.997C4034B5@keescook>
 <aa488b1d-51b2-7b55-7a8d-552306ca16dd@foxvalley.net>
 <202308301646.8397A6A11@keescook>
 <82b80554-2042-7dcb-83c5-6a6b640c71be@foxvalley.net>
 <CADmuW3UUGc_1m+Bcs7YUnp40S+8vN-W8nUQv2-nmj_oTb360QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADmuW3UUGc_1m+Bcs7YUnp40S+8vN-W8nUQv2-nmj_oTb360QQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 31, 2023 at 10:23:10AM -0400, Azeem Shaikh wrote:
> Are folks ok with me sending out a v2 for this with a better commit
> log that explains the issue?

Yes, please do. It should clear up the questions from this thread. :)

Thanks!

-Kees

-- 
Kees Cook

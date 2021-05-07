Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44A9C433ED
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 10:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E126143F
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 10:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbhEGKTv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 May 2021 06:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbhEGKTL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 May 2021 06:19:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D390EC061342;
        Fri,  7 May 2021 03:18:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l4so12774477ejc.10;
        Fri, 07 May 2021 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KpibJZWzZsvmRnCK+Fvt1jWGtKjdsl/Xtu/T/v3Jhfg=;
        b=E+t3AXYNBKsA3Vmr7ECD7f6lV0+aiaXMwBJHXSZ8kfXgN7O5lbg39McQG+CBji+9UY
         b2wVHJT+kAEYUuO3c/iQazz23GeVIo6lSy4zWINw02klaod2xul7TNDk+VqrSac8hGLT
         55AFZbuwaW29eMxN/4jJ256tP0C8sLKnYFBAkqp54VtnNGgc5H9Ke0y28T7nQoaZUr77
         9dNgNXXASC/MhabBow848UpTJzcjrQ44KTToTwxdt0cF/laG5FJRvHttuQQz9acYwC/D
         IHNZelopU1TIqyymDCAKuO7VVnUwk3bjp+hVOv19dxxiw9Tx88ZmHvrViTCzzM5gC8li
         FNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KpibJZWzZsvmRnCK+Fvt1jWGtKjdsl/Xtu/T/v3Jhfg=;
        b=tpOSE7YtHt3G8jtEcd0VYXhsJ2CvnmEB8eKZg1lEN0B6EP1pjDTzbkqCLePY25/32K
         tTygNpUZQPBznL5aLLtWFoGyvuc8O3be2YxgUuZRW0Q8AmfekIRJUcdmLqO4EersJRX0
         wnvUgNT4LGYN079Tu5RgoARy9ASBjdLxnUi/eUFDQElsM89oqI4Fo3ti04Q4o8eWMRzx
         F2rauSG5l8CARq7SXdiqHLK9Ccj4T5AQUUWNnzN63wvtA1X8qK83PIBNcGxQyOboN9vc
         ac82SbZ2eW6RMo8LHTpyMp12NRNWqYINtC+sZ+pFmJf4rKcn5XayjJKrhFfT2GmSz5Xw
         Ll7Q==
X-Gm-Message-State: AOAM532MoBQRj1gvD/vsv1HDtclWbjtvqfIHjUbX2+VxvK4cQck+7ON0
        fXXU5GuXuqEHz05PU5gY2OI=
X-Google-Smtp-Source: ABdhPJz8twDMgGhVFzYKuFafUo914Wz0DyvH71Zyz6dKhQCRDtwvymCrde+g4bCHRLqPHaGTS7jfIw==
X-Received: by 2002:a17:907:7216:: with SMTP id dr22mr9217108ejc.185.1620382688654;
        Fri, 07 May 2021 03:18:08 -0700 (PDT)
Received: from r00t ([212.15.177.85])
        by smtp.gmail.com with ESMTPSA id n15sm3342209eje.118.2021.05.07.03.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 03:18:08 -0700 (PDT)
Date:   Fri, 7 May 2021 13:16:38 +0200
From:   Ivan Bakula <wamreu@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh@kernel.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TTY: serdev: Replace depricated macros
Message-ID: <YJUhZP1FwMlUfWrw@r00t>
References: <20210506183228.33981-1-wamreu@gmail.com>
 <YJQp4W2X/tuvLfVA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJQp4W2X/tuvLfVA@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thank you for your reply.

> If these really are "deprecated", 

According to the comment in file "include/linux/idr.h" (line 318) these
macros are depricated.

> why not just do a search/replace across the whole tree and change them?

I've stumbled across these macros while trying to figure out how to write 
device driver using serial device bus. So, I've decided to change them with
appropriate function calls.

I didn't do search/replace across the whole tree because it's my first 
patch and I wanted it to be short. But now, when you mentioned it, 
I will do it.

Thank you for your time,

Ivan Bakula

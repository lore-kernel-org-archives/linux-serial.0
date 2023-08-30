Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F72DC83F01
	for <linux-serial@archiver.kernel.org>; Wed, 30 Aug 2023 20:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbjH3Uon (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Aug 2023 16:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239915AbjH3Uo1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Aug 2023 16:44:27 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D5159D7
        for <linux-serial@vger.kernel.org>; Wed, 30 Aug 2023 13:32:36 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3a9b342c398so21378b6e.3
        for <linux-serial@vger.kernel.org>; Wed, 30 Aug 2023 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693427429; x=1694032229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZMBO3cq35PjwKKIG6m42W7fw7Uuq0v6gb0qcGM7SrQ=;
        b=NYEEkwb1zY6RLY/ax0PtY7yW2PQ8ILOw0qXvzTuclhX+H3TKjsnDf0+uSTS2BI3vXX
         w1a4yKxexDiJpijHdwGVgvAkSVSLaOO4eJ5pF9Wdk6iapTxn3opbhVjQlnWge+jDEmWw
         HYp1bVqr03Gi/v5mR0gDVqLtJEhUDZQ57F36Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427429; x=1694032229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZMBO3cq35PjwKKIG6m42W7fw7Uuq0v6gb0qcGM7SrQ=;
        b=TCUz8oBeuxKVNnQPj3NZlUDIjAeKL0GKlMla7zseQbeQyEXkziVVmNYEjbVHZ3ZFER
         0D36fCCYLBuk7OxoVypAN2/bpMOnHjTCdTyN5sFRYCmpZFDAo2ojkh3Vq7bmEFWzhN1G
         ujvSfzP3bYYPCbBGYIcesZNZtBc2pVJb77geRtCm+Mm+hA3sddtb0ED61PH2+Hh+Vkch
         JbgzWBam2uuUSsxG5aRJmZ6M6OgRFv5FHIQ75T9r38/+2QrBHbXHAxDqnoLebW0R8dT8
         vkTMpKLgpXYsfjD15o82HeodmC/sjH2GTOBFANMpNRdEo3Gq0Sd1+DPZJyWlAIaC1001
         wwpA==
X-Gm-Message-State: AOJu0YxpinyM+tsG6cDD02H4VbKygn2zxowNwpjsDuVFSk7Cie8ZjohJ
        51QIjisKMcUPer4++sLVSMAL+SvOt3tkj6zbnRE=
X-Google-Smtp-Source: AGHT+IGykiElXISO5VTbxBJsqAwOC0C4+ZKKK6xBNTjZEalBwc53bWlt/bicp+NzrhLj4nYHS0HvIg==
X-Received: by 2002:a05:6a00:1ace:b0:68b:dfef:de8f with SMTP id f14-20020a056a001ace00b0068bdfefde8fmr3255663pfv.12.1693423625426;
        Wed, 30 Aug 2023 12:27:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g10-20020a62e30a000000b00688965c5227sm10324255pfh.120.2023.08.30.12.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:27:04 -0700 (PDT)
Date:   Wed, 30 Aug 2023 12:27:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Message-ID: <202308301222.3BD87A6@keescook>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 30, 2023 at 04:04:10PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.

Perhaps add:
"... and returns the size of the source string, not the destination
string, which can be accidentally misused."

> This read may exceed the destination size limit if
> a source string is not NUL-terminated [1].
> 
> The copy_to_user() call uses @len returned from strlcpy() directly
> without checking its value. This could potentially lead to read
> overflow.

Since the code as written today is "accidentally correct", it's worth
clarifying this: there is no existing bug, but as written it is very
fragile and specifically uses a strlcpy() result without sanity checking
and using it to copy to userspace. (This is the exact anti-pattern for
strlcpy(), and only because the source strings are known good is this
safe.)

> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/tty/vt/keyboard.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 358f216c6cd6..15359c328a23 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2079,12 +2079,15 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  			return -ENOMEM;
> 
>  		spin_lock_irqsave(&func_buf_lock, flags);
> -		len = strlcpy(kbs, func_table[kb_func] ? : "", len);
> +		len = strscpy(kbs, func_table[kb_func] ? : "", len);
>  		spin_unlock_irqrestore(&func_buf_lock, flags);
> 
> +		if (len < 0) {
> +			ret = -EFAULT;

I think this should be -ENOSPC as EFAULT implies an actual memory fault.

> +			break;
> +		}
>  		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
>  			-EFAULT : 0;
> -
>  		break;
>  	}
>  	case KDSKBSENT:
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
> 
> 

Thanks for sticking with these refactorings; we're almost free from
strlcpy. :)

-Kees

-- 
Kees Cook

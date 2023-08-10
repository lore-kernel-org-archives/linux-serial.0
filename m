Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC95C001DB
	for <linux-serial@archiver.kernel.org>; Thu, 10 Aug 2023 09:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjHJJmx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjHJJmw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Aug 2023 05:42:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7A1AB
        for <linux-serial@vger.kernel.org>; Thu, 10 Aug 2023 02:42:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4b95c371so3785015e9.1
        for <linux-serial@vger.kernel.org>; Thu, 10 Aug 2023 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691660570; x=1692265370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPLh7fq/Fe4wDkfylhVKPKRu57n0aHzq3eL6f8DTdi8=;
        b=x3YkisRZJi8cG7KHbh8hFPZOL2XvVpY+i5tuJTpHfBML5g8MXHUHVGDoT+aOQ/10wo
         Cf1S6u/cejfUg+qEz9OV1dGWGuSRv8drvtd8YPmR3/fgIZP45RGhSKaX1pPSE5/Ztf0G
         Xre1hPjk8aoIIzhYfbbJaZaAnzkVesaecjxgg4g5X1B1ADI+NOXC4iEkPXFz3M9p86ih
         B6OZcjAO9gOKsRGGh+Tq/YNPCIjjoz9mU6z3odLraYgpabpn3/L1FEngzZXnOMtwXxuv
         vit2F8aB7xDAunrLeiM70R+igfVSM7yYi5E0SMwGfcBj986bSfGPz/9yvinnO75ceb+L
         AIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660570; x=1692265370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPLh7fq/Fe4wDkfylhVKPKRu57n0aHzq3eL6f8DTdi8=;
        b=dTs7ukt8DDQZX0QahFTtdQMrgrxQBIS3p0bqH5dwsRvMsAe40cXU5Y6/njnTpwz4fP
         HqH6VgTnB/3KbqhIBZWTdChN7K6wTsBCDMpzr8IJSh9dtnlyYR/BlIJU8sGZOigzfFPu
         YO6DXu1dHdnvGRFLu6NtS2I6hy6T9cfjECqAu9SHpc5BX+TJ29niwVBQxCViW94tkyhG
         otX3iNGHku4xNAxzLi7+fkipkwJXiKX/3eFaiz7IVjIUnMXmKQIVNMfFS9c3ZiVGirdU
         IygcHX5qrEIT5Qdo7njSxwwZq1vH70RdV97j0uOQwQSkZDxJKefQ7kQMsFpaaHtIEvQY
         7hRw==
X-Gm-Message-State: AOJu0YwSA2HtXW1rc4QMc4q8A9wfn5Se2DcTrQFt5clTALY3Rw3Z9CvX
        vF2kFQ7ovRomrcP4T63Pn2hs9EqCeGnMURDGQHQ=
X-Google-Smtp-Source: AGHT+IFa9H2lHH95pOGRIga29g+95td9OYyxeM/h02dnxY+xpKy/hZ4gRuWzadHYoTu43p/E6ukmpQ==
X-Received: by 2002:a05:600c:155:b0:3fe:1166:e33f with SMTP id w21-20020a05600c015500b003fe1166e33fmr1266530wmm.10.1691660570466;
        Thu, 10 Aug 2023 02:42:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fbaade0735sm4487947wmd.19.2023.08.10.02.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:42:49 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:42:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 34/36] tty: gdm724x: convert counts to size_t
Message-ID: <ba8becf4-786a-4923-92f7-b4ec3038295f@kadam.mountain>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-35-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810091510.13006-35-jirislaby@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 10, 2023 at 11:15:08AM +0200, Jiri Slaby (SUSE) wrote:
> Unify the type of tty_operations::write() counters with the 'count'
> parameter. I.e. use size_t for them.
> 
> This includes changing constants to UL to keep min() and avoid min_t().
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: linux-staging@lists.linux.dev
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index b31f2afb0286..cbaaa8fa7474 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -17,9 +17,9 @@
>  #define GDM_TTY_MAJOR 0
>  #define GDM_TTY_MINOR 32
>  
> -#define WRITE_SIZE 2048
> +#define WRITE_SIZE 2048UL
>  
> -#define MUX_TX_MAX_SIZE 2048
> +#define MUX_TX_MAX_SIZE 2048UL
>  
>  static inline bool gdm_tty_ready(struct gdm *gdm)
>  {
> @@ -152,9 +152,8 @@ static void gdm_tty_send_complete(void *arg)
>  static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
>  {
>  	struct gdm *gdm = tty->driver_data;
> -	int remain = len;
> -	int sent_len = 0;
> -	int sending_len = 0;
> +	size_t remain = len;

We later check if remain <= 0.  It still works because remain could
never be negative, but now it's even less necessary to check for
negatives, I guess.

regards,
dan carpenter


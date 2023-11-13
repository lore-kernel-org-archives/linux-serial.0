Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E59AC4167D
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 09:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjKMJpr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 04:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjKMJpq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 04:45:46 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD47810D0
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 01:45:41 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b709048d8eso3579208b3a.2
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 01:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699868741; x=1700473541; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzM7qsd4kxlzFFVzlxkQP7hy5Byv9YvRdWtaoTYAspI=;
        b=UqltH1EpYoGnGXOGN3yS5RPQgpiHTS0nhQuJdXpvNJt7zkVNhel7jk6rCYkucw8zKi
         5z+g1k1wcZYfGMYKbW9ecbalq3EiHG/vu4y1QfJD5O9CMndpxxBUEuJ4LnZAiHNt0CHn
         neI56FshzrjhgW4TjNGjo360fcRuPM9atyN58N5P3egwn0PVXPagzSApSAeYSIAIqNEK
         kmkL9yUXgnxzKGxo4OxoIGl9f5p3sDuJ8x6GZtm5uOMVOcEAMfqQdRViQilHmXUNODgi
         kwEQMkflwDbLjzyH6RXRGAr8wihY0RHqnNGu03Xz/sIw89PljoEELdG+y9uX+/5eze8P
         cP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699868741; x=1700473541;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jzM7qsd4kxlzFFVzlxkQP7hy5Byv9YvRdWtaoTYAspI=;
        b=j09B90Fl9z13FrXSYxDk4PPETZGhTqd5BVkZpVRrWIyEpnYqbu+H+UmV7tpZVt0Uky
         fqiT88ZmsTWe+886WtIPPbxTzx2hWBBPZ2kqz4arOm8c4x46TbXi+2UQtksz9zR+wAf+
         FryOVDjc/+R1X8I+AKSbWecCFeibCMSIP6zxics55QxcZz847SUZUeQesftX/6LWib/P
         hi9tRW3fu67y+C7NsJfavhcp/7aIuwN4AqwepSz3bzmTci2L6Bd8cUBfezkiJmIYHner
         /vRgSJC2485MbkAvwPNUa/aW7xE10xSoLBvyqbF9zmoH+avK7hIf46X4y84F3+8goQ36
         Qckg==
X-Gm-Message-State: AOJu0YxD3vAL2PrzmDzgmYPVMD03H3XRBvhfmcEYukWKmH/vD7xQqsb4
        7/JZbiCqyif92PpDdf3qv7t+hXA5WXA=
X-Google-Smtp-Source: AGHT+IG1wFy1xio7JaUU6hUVa0c8LjvOmg/Y99hOi073oUDxSBl7T1/PO8Vs1QrJeMUJvyIqt9Tocg==
X-Received: by 2002:a62:ab0c:0:b0:68e:3772:4e40 with SMTP id p12-20020a62ab0c000000b0068e37724e40mr3655156pff.3.1699868741168;
        Mon, 13 Nov 2023 01:45:41 -0800 (PST)
Received: from localhost (121-44-82-40.tpgi.com.au. [121.44.82.40])
        by smtp.gmail.com with ESMTPSA id it13-20020a056a00458d00b006b58af8aae3sm3544447pfb.77.2023.11.13.01.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:45:40 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 13 Nov 2023 19:45:34 +1000
Message-Id: <CWXL6C3YNTI6.2OBLBYUWUQG3W@wheely>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@pengutronix.de>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 2/2] tty: hvc: hvc_opal: Convert to platform remove
 callback returning void
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20231105214406.3765906-4-u.kleine-koenig@pengutronix.de>
 <20231105214406.3765906-6-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231105214406.3765906-6-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon Nov 6, 2023 at 7:44 AM AEST, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/hvc/hvc_opal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> index 8995b253cf90..2cdf66e395cc 100644
> --- a/drivers/tty/hvc/hvc_opal.c
> +++ b/drivers/tty/hvc/hvc_opal.c
> @@ -232,7 +232,7 @@ static int hvc_opal_probe(struct platform_device *dev=
)
>  	return 0;
>  }
> =20
> -static int hvc_opal_remove(struct platform_device *dev)
> +static void hvc_opal_remove(struct platform_device *dev)
>  {
>  	struct hvc_struct *hp =3D dev_get_drvdata(&dev->dev);
>  	int termno;
> @@ -242,13 +242,11 @@ static int hvc_opal_remove(struct platform_device *=
dev)
>  	if (hvc_opal_privs[termno] !=3D &hvc_opal_boot_priv)
>  		kfree(hvc_opal_privs[termno]);
>  	hvc_opal_privs[termno] =3D NULL;
> -
> -	return 0;
>  }
> =20
>  static struct platform_driver hvc_opal_driver =3D {
>  	.probe		=3D hvc_opal_probe,
> -	.remove		=3D hvc_opal_remove,
> +	.remove_new	=3D hvc_opal_remove,
>  	.driver		=3D {
>  		.name	=3D hvc_opal_name,
>  		.of_match_table	=3D hvc_opal_match,


Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D60C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 09:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjKMJpq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 04:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKMJpi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 04:45:38 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9651810D0
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 01:45:35 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b6d80daae8so1349305b6e.2
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 01:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699868735; x=1700473535; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH0+6wLGxWwjy472SttpQ7v+g/1+3nWfcjmEcwBuwzw=;
        b=a3Sp2TFKQrhowuIg/Lzry+4IaQx23X5wVB7WjWkvvEzNdBteQjdGKdpcgAup45fKd+
         E91ka1H6zbStN9uKgSVYy4l3iAC9pEijnrYjNglHaHblbtlroOKhstaAaFLna/ESF+FU
         jZjzjl8hR9mare4rOfibRHCqCTKQC659ALsEpaPrdxwQgje+aJAsCDQOzOuqrZE1LqLQ
         tTpfNYyJwhFH29meI3vh0UZjZW2rNrTJ5waxn0tHYddwO1/kT671p2uorJwv97FhM6E6
         uDEo1CFpBUe9hcRkHCTqN8hgZyD5OAPwZcEhwVxlbV1aF1huGxxXdKobPS35b1eX3z/5
         tNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699868735; x=1700473535;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DH0+6wLGxWwjy472SttpQ7v+g/1+3nWfcjmEcwBuwzw=;
        b=aHadxyi9GyC23NxlFJGmxZ7Qzpan9/vfVqf3Fvee5GMoWh9N+ABRTaT33vXYdy/M8M
         afWY72nuwEOMrOQUQ7BPReEc8UX4WztJ5zduuBNhTmj6N38id/xaXAgaDHJDepxibu0b
         YLzNPBRDXFMT5gvu8L0NyA4pIBYJx/nTjw4sOM/ihoUMu0URzAIE9hs0alq9YjYQFTCx
         Ry/P2OWgiNQfBJG4aQDMyMH/scWvt/MQsHW31uQx9cQ8xFOrRFKkR/U/JEUVNa7QLj7A
         Qh8suFoueqv3n/bex3yTdYAtKiprIB8yXJtiw6yQVQgILDyuMXSCueOHr9LmxvVwMQut
         0+Bw==
X-Gm-Message-State: AOJu0YwdGN4DyWZ497nquulZI4+56wkxtXF0qqra+X/h4sHOKmTBjL0Z
        bNLw22aqYyBp7ZsU+bQ8j7Si9CXucLE=
X-Google-Smtp-Source: AGHT+IHOUOR//3wC59eMz6lgRIfMMJu55sBtkT65NSJmHTGq2jczN/Y6uSp9M3V/RXvztWc5sOVOLw==
X-Received: by 2002:a05:6808:1a18:b0:3ab:74a2:ab2b with SMTP id bk24-20020a0568081a1800b003ab74a2ab2bmr9435372oib.48.1699868734521;
        Mon, 13 Nov 2023 01:45:34 -0800 (PST)
Received: from localhost (121-44-82-40.tpgi.com.au. [121.44.82.40])
        by smtp.gmail.com with ESMTPSA id fh8-20020a056a00390800b006c03fa6300dsm3523184pfb.117.2023.11.13.01.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:45:33 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 13 Nov 2023 19:45:27 +1000
Message-Id: <CWXL68T68A18.BZ8WHB15ZU2Y@wheely>
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@pengutronix.de>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/2] tty: hvc: Make hvc_remove() return no value
X-Mailer: aerc 0.15.2
References: <20231105214406.3765906-4-u.kleine-koenig@pengutronix.de>
 <20231105214406.3765906-5-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231105214406.3765906-5-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon Nov 6, 2023 at 7:44 AM AEST, Uwe Kleine-K=C3=B6nig wrote:
> The function hvc_remove() returns zero unconditionally. Make it return
> void instead to make it obvious that the caller doesn't need to do any
> error handling. Accordingly drop the error handling from
> hvc_opal_remove().
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

IIUC these are functionally no change, just tidying and removing
dead code? Unless I'm mistaken, then

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  drivers/tty/hvc/hvc_console.c |  3 +--
>  drivers/tty/hvc/hvc_console.h |  2 +-
>  drivers/tty/hvc/hvc_opal.c    | 15 +++++++--------
>  3 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.=
c
> index 959fae54ca39..57f5c37125e6 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -976,7 +976,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int da=
ta,
>  }
>  EXPORT_SYMBOL_GPL(hvc_alloc);
> =20
> -int hvc_remove(struct hvc_struct *hp)
> +void hvc_remove(struct hvc_struct *hp)
>  {
>  	unsigned long flags;
>  	struct tty_struct *tty;
> @@ -1010,7 +1010,6 @@ int hvc_remove(struct hvc_struct *hp)
>  		tty_vhangup(tty);
>  		tty_kref_put(tty);
>  	}
> -	return 0;
>  }
>  EXPORT_SYMBOL_GPL(hvc_remove);
> =20
> diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.=
h
> index 9668f821db01..78f7543511f1 100644
> --- a/drivers/tty/hvc/hvc_console.h
> +++ b/drivers/tty/hvc/hvc_console.h
> @@ -77,7 +77,7 @@ extern int hvc_instantiate(uint32_t vtermno, int index,
>  extern struct hvc_struct * hvc_alloc(uint32_t vtermno, int data,
>  				     const struct hv_ops *ops, int outbuf_size);
>  /* remove a vterm from hvc tty operation (module_exit or hotplug remove)=
 */
> -extern int hvc_remove(struct hvc_struct *hp);
> +extern void hvc_remove(struct hvc_struct *hp);
> =20
>  /* data available */
>  int hvc_poll(struct hvc_struct *hp);
> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> index 992e199e0ea8..8995b253cf90 100644
> --- a/drivers/tty/hvc/hvc_opal.c
> +++ b/drivers/tty/hvc/hvc_opal.c
> @@ -235,16 +235,15 @@ static int hvc_opal_probe(struct platform_device *d=
ev)
>  static int hvc_opal_remove(struct platform_device *dev)
>  {
>  	struct hvc_struct *hp =3D dev_get_drvdata(&dev->dev);
> -	int rc, termno;
> +	int termno;
> =20
>  	termno =3D hp->vtermno;
> -	rc =3D hvc_remove(hp);
> -	if (rc =3D=3D 0) {
> -		if (hvc_opal_privs[termno] !=3D &hvc_opal_boot_priv)
> -			kfree(hvc_opal_privs[termno]);
> -		hvc_opal_privs[termno] =3D NULL;
> -	}
> -	return rc;
> +	hvc_remove(hp);
> +	if (hvc_opal_privs[termno] !=3D &hvc_opal_boot_priv)
> +		kfree(hvc_opal_privs[termno]);
> +	hvc_opal_privs[termno] =3D NULL;
> +
> +	return 0;
>  }
> =20
>  static struct platform_driver hvc_opal_driver =3D {


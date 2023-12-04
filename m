Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBFI4R/E"
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E5D2
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 02:02:31 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cdc0b3526eso34976507b3.1
        for <linux-serial@vger.kernel.org>; Mon, 04 Dec 2023 02:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684151; x=1702288951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iANmKiD/WeEaVkjVKIjuWKw9tVhHc7gkuIVfO30Dm5k=;
        b=DBFI4R/EaHYieoJSxgEapuC+t36NjY9hJ+xyVTQDZLbFNMeC6ITDxkJT3eXP4peJn1
         BhkJUZDzYh9P+SUT9nnRoLApDU7x2xAIX3ln3lfCB1suDfm33TTMBUcR1ivqiBIXFLYk
         xH6q29p0mOUq1I10tBMy+plYgXj9Fv0Enu+dyEeWwDHq4IGkZLPOil1Q8PIVxDb5waT6
         rDGvZJ91kNtKvlPewxi+0TY+RI5XCzfnH73gp70zPBx2rSnxFNNAXVnwulc7tK8cxAs8
         dLuSRdwerQcv6rNmsG3fO94ytD1288TUuZ9J6bPU3PVyWYMoLmR2vuzP0HWkICJpzrf3
         VhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684151; x=1702288951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iANmKiD/WeEaVkjVKIjuWKw9tVhHc7gkuIVfO30Dm5k=;
        b=eqY20KjAEjfvZppPy3KLQJtIJCeaYNFa0d2VLZOzaXJB5rq6UgrW74smVgRBGOrBtf
         hh+fprdy6vcCfJVVTSusxhajGnYqmrHRuoFexVFVhmWdPA+4mbsgV91WEgFjAXBExUrE
         0G2yydf+g9ISWH0pp/Gbw1+lEwoj+iajpvKWHDc+Th33T+iOC136eZgQcNW5EYk1h/rB
         UKWCQ8xWHzHftGuY7hKPfRFHOCHJo7F+rUyjd6xE9VuRj6zY3x4k+LTrGO3bL4KewcUG
         bTYBxqvvfp8gTEiEvboBnoheIW5oSiI6amzFWvZ0HGrHev9HWRQ3o8h8CoCnPKhJeHsP
         xu+A==
X-Gm-Message-State: AOJu0YxC6dAYpQPWCYitEfbiEFTIXlIAeWIh+JWIL7cz8YlUXlCpX+g3
	lo9lohwbf32/4ILJC2FkTQtjAiB7g74oQw0bBYnlPQ==
X-Google-Smtp-Source: AGHT+IGguuMna3XSw402u3oIs9Vv8A8Ohe229VwtxABg9XD2sziLojdlna4ml9wV+RcmWTt0OSCaNX16J2UzwdHr/+I=
X-Received: by 2002:a81:8353:0:b0:5d6:bc5c:9770 with SMTP id
 t80-20020a818353000000b005d6bc5c9770mr2210116ywf.4.1701684151231; Mon, 04 Dec
 2023 02:02:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com> <20231130-mbly-uart-v5-6-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-6-6566703a04b5@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 4 Dec 2023 11:02:20 +0100
Message-ID: <CACRpkdb+Lu7XVAmz+yPVKjdAuQ3yYR_5xZKUBrq6hiB0hi2x+g@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] tty: serial: amba-pl011: fix formatting of conditions
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 3:07=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Fix the following checkpatch warnings & checks:
>
>         $ ./scripts/checkpatch.pl --strict --file \
>         drivers/tty/serial/amba-pl011.c
>
>     CHECK: Unbalanced braces around else statement
>     CHECK: Unnecessary parentheses around '[...]'
>     CHECK: braces {} should be used on all arms of this statement
>     CHECK: Comparison to NULL could be written "[...]"
>     WARNING: Comparisons should place the constant on the right side of t=
he test
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD6763E7;
	Thu, 13 Jun 2024 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311563; cv=none; b=AWmjNda+/xZ8qdlHtKd2fepTjN7gCn7KUJ1/8UYuT0U1ahgBz1bz4pxq0v4NFOCRKIVX/0y/mfOUlrrMk6RYHVQF+QmQHvDjn7Wisp2ZkH1JaZUM8aHa1NDdKimv47Au+nV9UNKMkkL1wmcF8Q30NM1NrzCts51NFwYlGr7w3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311563; c=relaxed/simple;
	bh=/YeoDJ4ubTpxnOiVzJnoQNaME40+TgMtmRtHHm2S1sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIh8N4PZbJpLcai2sb9qHYqk/OhHjyagWswyleqF+wM0TxdToezljCm5JA0FYLFfKYJ+QuEwCHMHWf/M/WdrgQjeevDYXQiFwcH1MaKZZuBdc7dtGwzFWp1ZaTrWzzVCFASoJ+Yf/PlPuxRfzltmtSX38yCgZXC3F6DgD8T8FAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKj1dP2P; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKj1dP2P"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c9034860dso1931331e87.2;
        Thu, 13 Jun 2024 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718311560; x=1718916360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgVMf2K5jJvrV8V3bZZKBGHuhSPmV0sB+QVRlneduio=;
        b=kKj1dP2PFI49Sp49lyiQMOhjpBB+TBa6X7zrKrE145dheujzpyfY4DM4CEyf35pgsr
         FMpV03n1YUlkfDFXtytvlZzRHCcUiQaGtAPXfOtTy9jsDrqz7WXtEmSakNsMzAKkaLiv
         Sg67Lq2QjtgIs6jWP6uLKhFEzWyXrXzABrsyCaelOlAXszr0dy6uF42hm3F9FWyxXKvP
         J5Qq6lCFqZ/mCCBa0G9UpQ0kRZb5ZVrKvETRtNpBj2GNYDQ4UZmuiqTB7aUHxMiMBNaC
         8inNhKLXSqvJdaASlv1L2AteLzGfQXvDOt+3QCnD5j9IUjyNulW7P2+iI2ssk0K0bFhw
         Y00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718311560; x=1718916360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgVMf2K5jJvrV8V3bZZKBGHuhSPmV0sB+QVRlneduio=;
        b=FmNjtYBVKQCF+4lrYMXipLOf3PG8v8gwdBuy55q6A26qA/kTQTw9l8ZdC6y6QSwbwW
         GKEwfnbStwMqOenF2XYQgSqd8xyDv6pYrd7SybzlGVLLPjo4k1DlkwS2yNnx2VMAVv78
         FgjIGwpnEqdZTb2UrHuMDiLSKahbiEn+62pY9TqIVOqoC63hFrNKGm9iyncvYp1Gvewd
         WHkoiQ32pFtsKbkJ+gu4Gp7p17dBWKLlnipZZhKcbd29OaFKiEbCEPC/PjPucSc+Yj7j
         OYR0/aYoqgO1pvwm8igM2AliP6FpUiAjz7XtImlchIDgTy9fPdgDqHLHjmmnCJ+SRNN2
         8BDA==
X-Forwarded-Encrypted: i=1; AJvYcCUnRncJig1mH0ylQcdyXhZg/q6pAHBX8ewpZJBSroZGrpO06X0R3/R8wYH/Lgf/003gfsqkQd0KtT7My91PK6hDtVHc5oBxSC6bResuGJVlYVcACyTsE+pk9JIoTRNgGHsgTreGNyuxNQ==
X-Gm-Message-State: AOJu0YxscY/pBlx39dOz/sUqhJy9KaMjmtYrurBJ0KsB5vBWxaw8rjUq
	O5SwsjUJpzJ2RSQSqOP7Vi6s35WHH3zO8lNFMX0OuChHprdD+bFz239xJYJvZItyWjTPkq23HB3
	Li/Isq8LVmjmY4nAYXz6RHYLvX+114WfKmYWspg==
X-Google-Smtp-Source: AGHT+IG0fCj7Q4iwOfecAT22Gv1icH+lXiO6WPfrvQOxh2zWKoN+YMPwiFQS8HpvwWxOraNmuO3qw+aoIE4HdciO7mU=
X-Received: by 2002:ac2:514a:0:b0:52c:9787:2eda with SMTP id
 2adb3069b0e04-52ca6e9dd72mr532393e87.68.1718311559395; Thu, 13 Jun 2024
 13:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612131454.49671-1-hui.wang@canonical.com>
 <20240612131454.49671-2-hui.wang@canonical.com> <18a1beeb-e45b-4d6d-bd21-74b85c33dc2c@camlingroup.com>
In-Reply-To: <18a1beeb-e45b-4d6d-bd21-74b85c33dc2c@camlingroup.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 13 Jun 2024 22:45:23 +0200
Message-ID: <CAHp75Vdi=EPf1rOw0BVVEbZ4Dd4XG6b==deNgffB2Wg7cLv2tg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] serial: sc16is7xx: hardware reset chip if
 reset-gpios is defined in DT
To: Lech Perczak <lech.perczak@camlingroup.com>
Cc: Hui Wang <hui.wang@canonical.com>, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	hvilleneuve@dimonoff.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andy@kernel.org, Maarten.Brock@sttls.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:57=E2=80=AFPM Lech Perczak
<lech.perczak@camlingroup.com> wrote:
> W dniu 12.06.2024 o 15:14, Hui Wang pisze:
> > Some boards connect a GPIO to the reset pin, and the reset pin needs
> > to be setup correctly before accessing the chip.
> >
> > Add a function to handle the chip reset. If the reset-gpios is defined
> > in the DT, do hardware reset through this GPIO, othwerwise do software

otherwise

> > reset as before.

...


> > +       if (reset_gpio) {
> > +               /* The minimum reset pulse width is 3 us. */
> > +               udelay(5);
>
> Prefer usleep_range() over that, since maximum reset time isn't all that =
critical.

For this little sleep the usleep_range() won't gain much. OTOH one may
use flseep() and let the sane default to be used.

> > +               gpiod_set_value_cansleep(reset_gpio, 0);
> > +               /* Deassert GPIO */
>
> This comment should go one line above or be removed entirely.
>
> > +       } else {
> > +               /* Software reset */
> > +               regmap_write(regmap, SC16IS7XX_IOCONTROL_REG,
> > +                            SC16IS7XX_IOCONTROL_SRESET_BIT);
> > +       }

--=20
With Best Regards,
Andy Shevchenko

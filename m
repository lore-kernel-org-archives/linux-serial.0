Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1491D0787
	for <linux-serial@vger.kernel.org>; Wed,  2 Oct 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877232; cv=none; b=X4HOpilA7mnuBYKZPv4cOHFz4EM+nWHjsNKdbprRgVQUDHf1PtcQafBl4ZGge3qDzcRsBoOgO9KhzyTu2HFurFWfeCcW2Y6PahFrWlRSlrPaZ8cjFIrQ2B1pWjvJC4MyDwTOp/o8jfbCo3CHhSD64l/grMEvfos0PYWiLSZQUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877232; c=relaxed/simple;
	bh=j6xi0yErQ1R9JnzgLN0C+zTW2E96PBAw77wYIYi2zGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwEkr40AU4ZldmNAbZ0jEJx14QJ4rnMLx+T0HH8o/PNlQEg9QTTUsWNdTT3t0/tqcCqHu/y5/Cfra2TBduYYuzDRKeqXqGXSAOW1I08ywkkxl913qXupq/DUKxULj9oLHiQQ/yDE7Atqm/2h14gXePYSmjWV0UfJX2IBlb3hHPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XEKqrHZk; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEKqrHZk"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fad75b46a3so28475571fa.2
        for <linux-serial@vger.kernel.org>; Wed, 02 Oct 2024 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727877228; x=1728482028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6xi0yErQ1R9JnzgLN0C+zTW2E96PBAw77wYIYi2zGY=;
        b=XEKqrHZknefWA6d3N2kVwvX256DlJKf930Ah7NCrJDk20YfcxhYg3m6HznUt8iFKQ6
         4fFFUqHqW5fLOLzWHVF79/9y69eewoFZsEd0DnJumM/WX/VIxbP7qt0XSG70/HJ05FCi
         o2O4nnaAXF3kVuAqI0N8XsFOH74gTDLElAGQHqkMzsKtB5WyAxwh6UgcESq3AnvvK6D+
         6KLM8Z9kTlNw3EjKTpF89RIt2V8krPr/5BpvPjxvPxF1soDFXz2rVjWnTxrD/qdSMKYZ
         iKRJIj15e82Jk+SOJFqg4uTmtFSPFda8V4ba88a/uFw0pGNKTPzUChyk4Vi8I4vH1L0x
         TWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877228; x=1728482028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6xi0yErQ1R9JnzgLN0C+zTW2E96PBAw77wYIYi2zGY=;
        b=Vuubas7T54kd0pQnEd8ZaU4VFDURHVJO+fbPhLKqdNPpqA4RlTvLAe8ZyRHiZTfin4
         jXNXgaqZiZCbTO2pd0R6812WculC7VN2R8XTm4XsZMDqlI7G6FfHU7nDdCJcpyP+eQC3
         ly/HTMymkoNWtjcfgtJLp/9I6jOgRXTMo996aco+LjPCL5yux+V0CiQ2GeeMhHrONG+x
         aQfP7Ed+QXJnVwUHCVB2YSdEzXilDExIDLi3M45ZGnG5LtY2GoUiOXd/cWb+Og2c5oKV
         hAYBg2+gYicKJJ+ZAlnHj8JcJpG7QQ5T0HmwizUwkXOPqi+zFhGRmMpWcXc2iyhD71oe
         vBnA==
X-Forwarded-Encrypted: i=1; AJvYcCVqu3s21tafViHlNyzdcv69ZbYZ8ZcJm+pcXYYjFZqRQUdJBJ5s4lSmx750PXh/Ex3KtHz9uPLcpJxAl90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsVzU7dtj+MtgZRHZ55PFEw3BQm3DOugCgMm9a7qhqXOzQa7l
	Z3GucirNYiwxKn/qrsEBlt3plJPq20bnq40t0OzFxK60ZqWQomWPVo1xIyZ/gbFUCY7GLbDquhO
	wKPq9KwxKSj5k6nUbWdWcO26kVFDR2x24SLXJcA==
X-Google-Smtp-Source: AGHT+IH6J/1hIBQYUuOO6E4cFW0dSWZmODFCQ9NK7J4/38LglqeQ+e19d7bbsLpye8LH/IrpVT7SzxHTLiNIBgM3MX8=
X-Received: by 2002:a05:6512:31cd:b0:533:4676:c21c with SMTP id
 2adb3069b0e04-539a079f587mr2037762e87.44.1727877228234; Wed, 02 Oct 2024
 06:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-test-v1-0-458fa57c8ccf@analog.com> <20240912-test-v1-9-458fa57c8ccf@analog.com>
 <CACRpkdZb6AhxB7XEtOsxV5_oa=c1h2+ZApLFsTS_MQs-cjLmsg@mail.gmail.com> <CAAjXUapu1DBqnk24ng0izU7opn67YxiwpGpFtqrBmqNgyCxRVA@mail.gmail.com>
In-Reply-To: <CAAjXUapu1DBqnk24ng0izU7opn67YxiwpGpFtqrBmqNgyCxRVA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 15:53:36 +0200
Message-ID: <CACRpkdY7jJXOsKwyfbZWGq90jhnufwDeeF3=Dy0Rfps0rxmBGQ@mail.gmail.com>
Subject: Re: [PATCH 09/21] gpio: add driver for ADI ADSP-SC5xx platform
To: Greg Malysa <greg.malysa@timesys.com>
Cc: arturs.artamonovs@analog.com, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Utsav Agarwal <Utsav.Agarwal@analog.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Gleixner <tglx@linutronix.de>, 
	Andi Shyti <andi.shyti@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, adsp-linux@analog.com, 
	Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:58=E2=80=AFPM Greg Malysa <greg.malysa@timesys.co=
m> wrote:

> > Interrupt enable in the direction function? No thanks, poke the
> > interrupt registers in your irqchip if you make one (you currently
> > do not) in this case I'd say just disable all interrupts in probe()
> > using something like writew(base + ADSP_PORT_REG_INEN_SET, 0xffff)
> > and be done with it.
> >
>
> This will come up next time too so I wanted to mention that INEN here
> means "input enable." The PORT design has two registers for
> controlling pin direction, one to enable/disable output drivers (DIR)
> and one to enable input drivers (INEN) to be able to read the pin
> state from the gpio data register. If I recall the bare metal
> reference code toggled both but we can review if setting INEN for all
> pins and leaving it is acceptable as well to simplify things.

Aha so that's what it means!

Yeah play around with it and see what you can come up with.

Perhaps you need to override the input/output enable
callbacks with local versions rather than the gpio-mmio
ones to set all bits. (This is possible to do after
bgpio_init() but before adding the gpio_chip if necessary.)

Yours,
Linus Walleij

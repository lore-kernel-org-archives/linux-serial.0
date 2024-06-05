Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268418FC87
	for <linux-serial@vger.kernel.org>; Wed,  5 Jun 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580092; cv=none; b=jWsrY8HCLnjA0sTj3Cp11htA/sA9ts/bmJn5Mt3LjkNVG0uqk4r9EdJqDGg9Xstq8nHiMKlqEo54Cldzc4KVolwBHzBcckXXDyeCDIRyzzurx5kxdT66DN3Cqba78c7581bdAu4rsFAre/58XY1WRHmm+u3h4GDLFMh3/1dsofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580092; c=relaxed/simple;
	bh=VyMzcl86epfd+4JJGD/brazuobQXR4TW+Im54cfRqwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1ApY4LFVPEha0jNr8oWVU87/K65XvuobbSDwUrUdHBFdpQTU8cWvo7ZAwWi9WxNpM62z7bJsegdjZFhsCgB8mzwTz6uMYmvq1ywPOdQrYKXj6/iYXdASut8pBqUi8gWhkJ/PxxNdmZK86m0bA6HBx0aPEYHYAhGgLZT2rnq0nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dHiEOcww; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHiEOcww"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfa7790b11aso2065097276.3
        for <linux-serial@vger.kernel.org>; Wed, 05 Jun 2024 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717580090; x=1718184890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30NObruWx5GMlzINttF9ReWXSPJzl5BeuLrf410WPvU=;
        b=dHiEOcwwuTLPAfYeOBtsVP/FZJxtxu1GtHzC46rdRec8WsXNQ+14+jYF+g6J3PUFwk
         AnWuu9pMSnqSNg5SV31NNHk0JZqDDvtgyZKc6AyEgoh1ii4sGTkY/Akdt/86Vz6oXrU1
         nYEqKXiAkP55s1P2Me3xjTMOsa8Xw2jzuK6I3FtZLcN9Rd3WqjUMDBhsxKo+D4TqEeQn
         /87PrKq8oPGrixS9WbfIGLGjtmTAkN3MlmPC3zWyIU8wb88rY+W6Sd+87fFaQ1zvrgbu
         l0CFQmQeyw3EDvMbuAIcukPnw0tc6wX7ZTWjlxBbuH1eA3/KiVpM9OQaqsBUv0wgGpuS
         XXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717580090; x=1718184890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30NObruWx5GMlzINttF9ReWXSPJzl5BeuLrf410WPvU=;
        b=T6NQo7zbYXUyir/DmHkf4ZPm8Ybwp8sbcrXtd7qOkpEEJArRBL+06bSvEcuS6N1SiS
         vs2+/v0GRkYloz2cIaDoKU9Y0hh4DIZHgptVkc1ZHBpWuW4K+0Q3gCwgDlY/eqJsejPx
         asGtiiQu1cnHzAVllOw95TPXTujiZ6rFKxosqxldH51ROZw+JEJyZdOR39b4/Duwa4eY
         svvZ/l//a6NT4L5FoT8vPQZstvxXdUDwDhd7kngplBg+x44zTPwPZuuxGKnnvRwBQsvG
         fkn6ZMAJHt5RqovXnOx8iwd3BL/4fSy7h9u3jlD7oL9PhrfPYBix//fPjLgsxsYBAbaO
         0iJg==
X-Forwarded-Encrypted: i=1; AJvYcCWDBdk3qKwkyHwZDqKVeXrXGYtSXcVVECEy178R1yzVzK2DM1DQ0U7TKiI3wxRljl4tMBdAdANieBl7rDuj7MImCz8j4zIcSr8Hf1Es
X-Gm-Message-State: AOJu0YxFfgSyCb+ayBp4KZTRnbAvhbS/DM69UzwRh72oRq05edom68Li
	LW+q7MF8jbcSf6ghnvirIdmdLdsOSpiJF2Evyaw0kS9ZSKfQtxt1gruVs/KeA1t67/Wt3s7vkim
	iTsmgEoJhj2OZnBbfx8/rDqg+a5044vBEqVtq+g==
X-Google-Smtp-Source: AGHT+IENn27TkQR5CPy5b+3mp3LqBCxwf+D6LxicigJ400S8hL5xvE513TM1EYAaeZPC26ci4uwXc/peFjpCSi2lwcg=
X-Received: by 2002:a05:6902:230f:b0:df7:97d4:b790 with SMTP id
 3f1490d57ef6-dfaca9bd66cmr2065639276.18.1717580089668; Wed, 05 Jun 2024
 02:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716811405.git.geert+renesas@glider.be>
In-Reply-To: <cover.1716811405.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Jun 2024 11:34:13 +0200
Message-ID: <CAPDyKFpa4LZF3eN7x-NT+b9=dKB3Oe6RY8RAyetdRBSR1-LQoQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] pmdomain: renesas: rmobile-sysc: Remove serial
 console handling
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

+ Tomi

On Mon, 27 May 2024 at 14:41, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> Since commit a47cf07f60dcb02d ("serial: core: Call
> device_set_awake_path() for console port"), the serial driver properly
> handles the case where the serial console is part of the awake path, and
> it looked like we could start removing special serial console handling
> from PM Domain drivers like the R-Mobile SYSC PM Domain driver.
> Unfortunately the devil is in the details, as usual...
>
> Earlycon relies on the serial port to be initialized by the firmware
> and/or bootloader.  Linux is not aware of any hardware dependencies that
> must be met to keep the port working, and thus cannot guarantee they
> stay met, until the full serial driver takes over.
>
> E.g. all unused clocks and unused PM Domains are disabled in a late
> initcall.  As this happens after the full serial driver has taken over,
> the serial port's clock and/or PM Domain are no longer deemed unused,
> and this is typically not a problem.
>
> However, if the serial port's clock or PM Domain is shared with another
> device, and that other device is runtime-suspended before the full
> serial driver has probed, the serial port's clock and/or PM Domain will
> be disabled inadvertently.  Any subsequent serial console output will
> cause a crash or system lock-up.  E.g. on R/SH-Mobile SoCs, the serial
> ports share their PM Domain with several other I/O devices.  After the
> use of pwm (Armadillo-800-EVA) or i2c (KZM-A9-GT) during early boot,
> before the full serial driver takes over, the PM Domain containing the
> early serial port is powered down, causing a lock-up when booted with
> "earlycon".

Hi Geert,

Thanks for the detailed description of the problem! As pointed out in
regards to another similar recent patch [1], this is indeed a generic
problem, not limited to the serial console handling.

At Linaro Connect a few weeks ago I followed up with Saravana from the
earlier discussions at LPC last fall. We now have a generic solution
for genpd drafted on plain paper, based on fw_devlink and the
->sync_state() callback. I am currently working on the genpd series,
while Saravana will re-spin the series (can't find the link to the
last version) for the clock framework. Ideally, we want these things
to work in a very similar way.

That said, allow me to post the series for genpd in a week or two to
see if it can solve your problem too, for the serial console.

Kind regards
Uffe

[1]
https://lore.kernel.org/linux-arm-kernel/CAPDyKFqShuq98qV5nSPzSqwLLUZ7LxLvp1eihGRBkU4qUKdWwQ@mail.gmail.com/

>
> This RFC patch series aims to provide a mechanism for handling this, and
> to fix it for the PM Domain case:
>   1. The first patch provides a mechanism to let the clock and/or PM
>      Domain subsystem or drivers handle this, by exporting the clock and
>      PM Domain dependencies for the serial port, as available in the
>      system's device tree,
>   2. The second patch introduces a new flag to handle a PM domain that
>      must be kept powered-on during early boot, and by setting this flag
>      if the PM Domain contains the serial console (originally I handled
>      this inside rmobile-sysc, but it turned out to be easy to
>      generalize this to other platforms in the core PM Domain code).
>   3. The third patch removes the no longer needed special console
>      handling from the R-Mobile SYSC PM Domain driver.
>
> I did not fix the similar clock issue, as it is more complex (there can
> be multiple clocks, and each clock provider can have its own value of
> #clock-cells), and I do not need it for Renesas ARM platforms.

I will defer to Sarvana here, but ideally his series for the clock
framework should solve this case too.

>
> This has been tested on the APE6-EVM, Armadillo-800-EVA, and KZM-A9-GT
> development boards, with and without earlycon, including s2ram with and
> without no_console_suspend.
>
> Notes:
>   - This should not be needed on RZ/G3S, where each serial port device
>     has its own PM Domain,
>   - drivers/clk/imx/clk.c and drivers/pmdomain/imx/scu-pd.c have special
>     handling for the of_stdout device, but is probably not affected, as
>     each serial port seems to share its PM Domain only with the serial
>     port's clock controller.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (3):
>   earlycon: Export clock and PM Domain info from FDT
>   pmdomain: core: Avoid earlycon power-down
>   pmdomain: renesas: rmobile-sysc: Remove serial console handling
>
>  drivers/pmdomain/core.c                 | 24 ++++++++++++++++--
>  drivers/pmdomain/renesas/rmobile-sysc.c | 33 +------------------------
>  drivers/tty/serial/earlycon.c           | 14 ++++++++++-
>  include/linux/pm_domain.h               |  4 +++
>  include/linux/serial_core.h             | 10 ++++++++
>  5 files changed, 50 insertions(+), 35 deletions(-)
>
> --

Kind regards
Uffe

Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E52836A0
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766412343; cv=none; b=eprdgSKFBd+MqxtwnoCNgMVcSMxkijZhmlSdUpRIPUWYhTlQC8QIR5pXoTwB6fwTiNNATBqEWg2z9V4lMJN1ae4LSUK7sHTRqWuTsjanRNvDV4Qjvs6iLTuM+Ed3hEAEZ5uD3Kcl65aiSbsF4oChjd4UymidBg1o6ibgYZlp2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766412343; c=relaxed/simple;
	bh=bTIKHcqn0C6gaQNho2yhzTYPlbw5mXBtl6Xpga087bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRT8BZFqDWuQSFuasagBuaX5gupla/kXLH3rGl7tACT+HX9FHeXObbvtysLiytS80lrVLIn/UhdNE/UiILGRbqrtEoa0emgBWw+ObAgp2Ynluy1nsUcpgLhxW2v8xlqtBcq54u8dcGCQUs1YbfJ6H1p8fVcE4OiAnB8Xab9lioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-55b104727c8so1098787e0c.0
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 06:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766412340; x=1767017140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICwOHcWbMK0sAN8WZ7Ku00mtmBrZPHA5/DlsAdljbVM=;
        b=q8Svt2gNpWqOaIApmLS1aARin18CXnmmh0n4nSxRLICK114Ls9/NQYgXmPB+phGQ6I
         wCoQ/iOlfvK/FRTc1QLlDoWREMf9B977A+u5fLAEvA5RxXV4qqjroL4LN0VnSdIDy2VL
         l1OWGIgqUnT2ZXZL+5DHKIGwQfW4cOEu7TuXREYxvbHlvD1msCtsY5xhJHTUF/jugvXl
         5EQHLcK0wbTlSvfY7aih+9yBF0XuTWZTeFFh2eqFOfGvAFw50JCCkLjdGBh1urQVk6ig
         OseDZEVHBqJCHYqykX4lQpho9slCd0OUrk+iQup4/LR9MFGqc3ZrW4oqMxznVZopz9ft
         FxlA==
X-Forwarded-Encrypted: i=1; AJvYcCVp98ekIkkPduv6ZjkCZyrtFSHEM/LmdhpNpchj2RbopQWpvGs70xGiLV1K9lHGWsmvin4X6j1oyelQlTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5VUyf54Y69bbUtUtrNclULue1iHYdR5whazWNbsD0RWB4ZML
	OgTV8G9TGKtnONJDpxzIbaEI5ghHaeWzRdiL8RLXunJVXyeoTumoM6atV8lcH6oS
X-Gm-Gg: AY/fxX49LlCJgqd3DGLPgIvL2cdDtfGomPGI9TEnS/GX4obREP7G+B39QBFboaiqG4P
	5HL7jymnl69oT5cVNoQA3lFNbYihsNVniSqnRjhFa4yjo0mpOqq5bqdjmpCpie+jLRHXLrn69NT
	eARrz+WXivNcY8vzVNBmNZI4RK2V9p+2sRR5LN00WltOTxdFznh7bJ5F8MLj7cX7LzLZcceWJTA
	XHrwODJOGq3f0SiQ3fQGi3YUWWw5CvnWnaSX/DHjCgFvTIp2GAyTEZ1oV3UJeYBAJ7Cp9uWqMq2
	QSx3P0GybC+MbvHMc4XQF0QncGsTrPscaxWDQw1pEqO5hEHPTH3hyU/lrdnAs8srX8pTexs+wxy
	0YPH0J9b7b8R8yJok+UnGBZaMiGUL9dQh28Q+Wi0XvilG6o1sggrQS9GTixLNuYV8TekX8PHOYg
	vHt+W898hBqSoKzW6IXYBNSKLmccpv6AG6RJ8lLd5x70EocUhxDEDx
X-Google-Smtp-Source: AGHT+IHRp3npdiMZHH41aprhKk8gKvfvjxnBxU0TXXfFP8rMoUkyETzcOkqrvaP8QaPWW0C+Qeu68A==
X-Received: by 2002:a05:6122:469f:b0:54b:d7b6:2eee with SMTP id 71dfb90a1353d-5615be02eb6mr3349031e0c.11.1766412340181;
        Mon, 22 Dec 2025 06:05:40 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-943415169cdsm3016376241.0.2025.12.22.06.05.39
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 06:05:39 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55b104727c8so1098755e0c.0
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 06:05:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8/i+CnhpPxFArEJ12gusBeDOQSJKOxelu5YB9ODPHRaMvEakD8S4/VIx9mB3xn+iUT6bj+lKPAl+knt4=@vger.kernel.org
X-Received: by 2002:a05:6122:2a52:b0:55f:c41f:e841 with SMTP id
 71dfb90a1353d-5615bed1815mr3290676e0c.19.1766412338007; Mon, 22 Dec 2025
 06:05:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129164325.209213-1-biju.das.jz@bp.renesas.com> <20251129164325.209213-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251129164325.209213-4-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Dec 2025 15:05:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWpsjQ=cL1z5vMX39TwnfWsfEhMOktBPL-zF0-QJug-Xw@mail.gmail.com>
X-Gm-Features: AQt7F2oETRYAhevlCJEPv5BI6M299_NGlsvNoOTDm0Qmrwm2Eeqa8eGBJP7zVJo
Message-ID: <CAMuHMdWpsjQ=cL1z5vMX39TwnfWsfEhMOktBPL-zF0-QJug-Xw@mail.gmail.com>
Subject: Re: [PATCH v5 03/17] serial: rsci: Add set_rtrg() callback
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Sat, 29 Nov 2025 at 17:43, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The rtrg variable is populated in sci_init_single() for RZ/T2H. Add
> set_rtrg() callback for setting the rtrg value.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v5:
>  * New patch.

Thanks for your patch, which is now commit b346e5d7dbf66961 ("serial:
rsci: Add set_rtrg() callback") in tty/tty-next.

> --- a/drivers/tty/serial/rsci.c
> +++ b/drivers/tty/serial/rsci.c
> @@ -151,6 +151,22 @@ static void rsci_start_rx(struct uart_port *port)
>         rsci_serial_out(port, CCR0, ctrl);
>  }
>
> +static int rsci_scif_set_rtrg(struct uart_port *port, int rx_trig)
> +{
> +       u32 fcr = rsci_serial_in(port, FCR);
> +
> +       if (rx_trig >= port->fifosize)
> +               rx_trig = port->fifosize - 1;
> +       else if (rx_trig < 1)
> +               rx_trig = 0;
> +
> +       fcr &= ~FCR_RTRG4_0;
> +       fcr |= field_prep(FCR_RTRG4_0, rx_trig);

FIELD_PREP(), as FCR_RTRG4_0 is a constant.
However, this can be combined with the previous line, using
FIELD_MODIFY().

I have sent a follow-up patch: "[PATCH] serial: rsci: Convert to
FIELD_MODIFY()".
https://lore.kernel.org/ada3faf4698155a618ae6371b35eab121eb8b19c.1766411924.git.geert+renesas@glider.be


> +       rsci_serial_out(port, FCR, fcr);
> +
> +       return rx_trig;
> +}
> +
>  static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
>                              const struct ktermios *old)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

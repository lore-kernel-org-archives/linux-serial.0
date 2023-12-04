Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7FroEFu"
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9080D106
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 02:02:51 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cfc3a48ab2so44156147b3.0
        for <linux-serial@vger.kernel.org>; Mon, 04 Dec 2023 02:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684171; x=1702288971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHeHXQ88hRKi6Kt+4mUFvWDi4ml4PVcTqzfdXUNFDa4=;
        b=O7FroEFuCRpOSjUkss301/U+nUzr7dxPmqEPV5Q4rdSOS0jwCbPnhLaLxIOILQtrJL
         A7P8B6bH/zdUQSCrR+3vgB8bJHFLs/aJg+0g38e5C0fvpaJ2jlBpZW3K/VxQj+Ly0ojq
         DMZ/PLtsf7usZe5TTwu16WqVNbSpY1hqGAzscEaRkodCNBMbO1e07Cx6xDFykrapOFIR
         JU52346uDUIhRss4lsvb12JoOwEdVB2UWzVkXoeuSxOuu8QELhuCDfupfOoKqlizVS7P
         LdcBaQQOuu+zqsDap/0hQ2TeWzxQ0ZgD5n2v+eyokRQO/Eb+3iXZHMuyvkH9pliswdBO
         lVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684171; x=1702288971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHeHXQ88hRKi6Kt+4mUFvWDi4ml4PVcTqzfdXUNFDa4=;
        b=bni7j89O8s5Ya/biTPC5CojUJnYnOd78tWP0CMGWulJDVuEjZIRZMeWGQjHOLFQJJ3
         Zs1gnjBSJrNRi6FmG6MqA0uRmXM2r94b3VpSjulkjro6PTsCy13T1T+Mo1rdo9IPkT2f
         dr5rcYADPRUKytnzlBl5V6NChdkIAnPcD2bIdzSTH7WwWfsHJ6IujuRVgre3v+gx+A+x
         mVTSdKOSiqNDYdiWV/uVZxrtAZMER4iq3YgFluK1TaSA8ZRHNMYAchySdIcs+R3OOYut
         hPqTK+DTJkQY9aNOsOtU3byp+p3BcaMVs2xyn6kbFDpICsMhR6JmQ3fXNdBQMW1NMLUL
         EYGQ==
X-Gm-Message-State: AOJu0YyI+gJmKiR0tq67K+vhOQ6qXwLBNLvHGKmaTxBMlqMcP4JJRm+S
	DSlO0dxVtnqsDoEbAldeuTrtiqxb5m0gBn5g8gAV3g==
X-Google-Smtp-Source: AGHT+IHtGl7d7t8F+Ugxjb3gUAHpsq3ksAoua4G3E3fpsarBicCY1G24CUHhw6UOMwZ59tqgp31KqEPz/mwrnkbsdEM=
X-Received: by 2002:a81:ae21:0:b0:5d4:2ab1:9f0a with SMTP id
 m33-20020a81ae21000000b005d42ab19f0amr2427769ywh.42.1701684170746; Mon, 04
 Dec 2023 02:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com> <20231130-mbly-uart-v5-7-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-7-6566703a04b5@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 4 Dec 2023 11:02:39 +0100
Message-ID: <CACRpkdZDed3kJn0fC4ENR9U4WPvRnfWzANxxeV_Nd8eEP2JdkQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] tty: serial: amba-pl011: fix miscellaneous
 checkpatch warnings
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

> Fix the following messages from checkpatch:
>
>     $ ./scripts/checkpatch.pl --strict --file \
>         drivers/tty/serial/amba-pl011.c
>
>     ERROR: do not initialise statics to false
>     WARNING: Possible unnecessary 'out of memory' message
>     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>     WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
>              dev_info(dev, ... then pr_info(...  to
>     CHECK: Prefer using the BIT macro
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

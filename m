Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9Z4qpzO"
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF665F2
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 02:02:03 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db53f8cf4afso1938681276.3
        for <linux-serial@vger.kernel.org>; Mon, 04 Dec 2023 02:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684123; x=1702288923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SeMPuNVhMcd+i2tV7F9jz2bOkHeS41/F3Z4FqdTOpc=;
        b=H9Z4qpzOy6oJDjg1tYNhhni9E/+swN+m/qXPt1VtOJlkA/BhXeDhPQ+2kFtG/Yf+EW
         15xvpspm2Ob+URYM+Ta8S0flJ3NKQxY1+yborf0CbXN4uBlRghy9Vem8F0NdH1Dvq/U0
         aFwafjHMoOl3ZvYABglfYJnVgBYwEK1kXgWlL/JV7Sf3PE1XrShTOLNLKxNC1B58cFgH
         i22pq8nsObLfHk6PE2FEpWtOBPGQ02DCmcnsYBs7hEUsxlj2LAEM47LpFeey+GTn//mv
         ytIzuN6Snkm+00X31XvmIWOSz29JE23TwYOXicFFGmauYGRrcqpj3w9s8vGXYR7uGEVS
         1dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684123; x=1702288923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SeMPuNVhMcd+i2tV7F9jz2bOkHeS41/F3Z4FqdTOpc=;
        b=LuYjP8oTsVVLmUUe+k2PdHdxONlC5KjcLh0FBZQnY/CdTFWvrx4R+7hWyzsuOeoB47
         StRhhryxQV9c1rdimpzK9366KN5/4npTMbnLYaWgj/OjzEm/Pp+v1QxxyqG0thDS2Ro+
         2czHneRzoPZVBf8F2SqufODrgVCrQKVhdS4ubHfuEDIfU8vkitLn8WZkqbIt9+osAFP9
         JKJRAdnAe9ZHPo0tyCn+mwIGdSLmmbHzh9mGBQJiFivPrSjeamIgGg+VKNZ0O1ufy+bw
         iGGi591e0j84ltMLBugGA5piTzpfxC2mvBkbhKGt0rrgp4NJ68ysAk24EXr4CfelwrBD
         kebw==
X-Gm-Message-State: AOJu0YyjuKrGa61xhiatlCITwKSLndv1j/Hmc8blTIgKYOM6YxK32HF/
	cRYZmHQTLoYrTjkea7gbJHj91l3E9sETQsxIZuhbew==
X-Google-Smtp-Source: AGHT+IGDPWlnysLzm5EzUFh7UJTkRuai9dGFsoVIWTFX6lFcQzCAL9alL/1PxDiLEf44P7pIIhXKR4a4ne7rrwBReqM=
X-Received: by 2002:a25:40d6:0:b0:db7:dad0:76b0 with SMTP id
 n205-20020a2540d6000000b00db7dad076b0mr1684590yba.76.1701684123130; Mon, 04
 Dec 2023 02:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com> <20231130-mbly-uart-v5-5-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-5-6566703a04b5@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 4 Dec 2023 11:01:52 +0100
Message-ID: <CACRpkdYMKv1EFWZtSe5iya-_gpdr3mVxVv2665A0=FEspGdjoA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] tty: serial: amba-pl011: avoid quoted string split
 across lines
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

> Remove all instances of quoted strings split across lines. Fix four
> checkpatch warnings:
>
>     $ ./scripts/checkpatch.pl --strict --file \
>         drivers/tty/serial/amba-pl011.c
>     WARNING: quoted string split across lines
>     [...]
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E81FA8;
	Mon, 27 Nov 2023 00:35:40 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5c08c47c055so38139137b3.1;
        Mon, 27 Nov 2023 00:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074139; x=1701678939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMBx9bPC6Ke/5JjfdfW+n5UaM35YuZKS2Z2vb1jjpAI=;
        b=siKbYVDKDezZPC3ocGA3Yz2cG8QfHsvmcgPv3vjkpH4BG+L6dctRnjSUo2te/yKwJQ
         kPmwQ+cFvBh22YtEBWx9SB4lPk8CPCdCkyelpOocNqw/fCd0y7WPy4XHgbZspkhDQG5i
         u/FKgFa5Jgqfi1bBZm31ElEy17l/bYdmCNbCVpdxwwp7LWhNMunvFvInqUPSxxhZvFBz
         6wR7da0Hj35MsKVFrDxWh4ViAfCjqacBF/YhGyw+3XJMt2dtVi2sWw7VeE3lFO7FxscZ
         wg1I0XkJP9AJotlDsrn/26+YOB6LcT3T5nobxNvPNlKcMqbEJOGFXnjjRzZucTjYg2zQ
         yhiA==
X-Gm-Message-State: AOJu0Yxu+yVYAJJ91MUfUARC2XbfZ4dkgjXTC6JTs8bZ8Y9vr/cmFhVZ
	jzcti63aEsCc7siDgVXDn+TD+YawrvIIPg==
X-Google-Smtp-Source: AGHT+IGxLiksfLp1RVbKZiIWjPxJXOm3TqnyBV+BDOACFIcjh0fCsaSgi+xFx8CgjDjRbzfrzTkNdA==
X-Received: by 2002:a81:4322:0:b0:5d0:b284:6140 with SMTP id q34-20020a814322000000b005d0b2846140mr917630ywa.51.1701074139300;
        Mon, 27 Nov 2023 00:35:39 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id m1-20020a81d241000000b005add997ae53sm3058220ywl.81.2023.11.27.00.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 00:35:38 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5cd2f1a198cso36551627b3.0;
        Mon, 27 Nov 2023 00:35:38 -0800 (PST)
X-Received: by 2002:a0d:e501:0:b0:5c8:940d:276c with SMTP id
 o1-20020a0de501000000b005c8940d276cmr12293451ywe.43.1701074138550; Mon, 27
 Nov 2023 00:35:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d6773b9bd88dbbbea06bc6d5cd59aa117b1ee2ee.1700416841.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <d6773b9bd88dbbbea06bc6d5cd59aa117b1ee2ee.1700416841.git.christophe.jaillet@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Nov 2023 09:35:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWog5mtxP3y78H8QOT0C+zRihLDDsB+13ZZAyMPiKcNDA@mail.gmail.com>
Message-ID: <CAMuHMdWog5mtxP3y78H8QOT0C+zRihLDDsB+13ZZAyMPiKcNDA@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: convert not to use dma_request_slave_channel()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Sun, Nov 19, 2023 at 7:01=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> dma_request_slave_channel() is deprecated. dma_request_chan() should
> be used directly instead.
>
> Switch to the preferred function and update the error handling accordingl=
y.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> This patch is NOT compile tested. I've not been able to find a correct
> setting so that CONFIG_SERIAL_SH_SCI_DMA is set.

Like arm/multi_v7_defconfig, arm/shmobile_defconfig, or arm64/defconfig?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

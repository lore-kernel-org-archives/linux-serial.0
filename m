Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4078B137;
	Tue,  5 Dec 2023 23:51:40 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5d40c728fc4so5221417b3.1;
        Tue, 05 Dec 2023 23:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701849099; x=1702453899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAg+9BHyrxAyD5/BLtZ2coySzLaaVB1t+5oX942gOa4=;
        b=nYWJP+dVZBMFq+PT1JWjL3kEn6XBr1VOTtIAkzTTl3NFHc28l4uuuR4Khj1eiRGLzP
         tkUP8aLYEuDjUhEAKL4EvrBsTIXeY1B+eLydZMkQavxZigmSOfOizXuYJGfPZbBOIPER
         /FCtW0oZWFcMhAF3eE8UJ3vEFafEMsvDZgXwyTbvmppcRwe2HVKXqOU4c0dH+DvQ0slG
         Z3ilftm5oT1GlPoH5/3PEVgQvo0mKo46lM4JX777K2YSymGlYaSMi49Subse9jutZEvk
         aRVZNSmh0jnpaMSAi6+qT2KXLHos5Grysb++QTBO2Or4bhvokekE5nrfSWXRfGPb8RuO
         hlow==
X-Gm-Message-State: AOJu0Yz86+N+io7kgn6RoLiq5KkzctXwKH2bmp/axK5GBgGbzeQ2pHeu
	Z2OIEfJH8x/PlM99WT8o9jDsVlFT8ryA1g==
X-Google-Smtp-Source: AGHT+IFfvzHO1K/OUOXmq9Uo39/Oh0mcm/9oCYduxSVLB/+ZyeOyIbwA/TkSXE6Esxf+4w30BIsoQA==
X-Received: by 2002:a05:690c:d83:b0:5d9:3d8e:59e7 with SMTP id da3-20020a05690c0d8300b005d93d8e59e7mr2098726ywb.45.1701849099221;
        Tue, 05 Dec 2023 23:51:39 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id s12-20020a81bf4c000000b005dd004432a3sm118089ywk.137.2023.12.05.23.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 23:51:39 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db548da6e3bso539075276.0;
        Tue, 05 Dec 2023 23:51:39 -0800 (PST)
X-Received: by 2002:a25:1846:0:b0:db5:4523:cd1a with SMTP id
 67-20020a251846000000b00db54523cd1amr327760yby.17.1701849098839; Tue, 05 Dec
 2023 23:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206073712.17776-1-jirislaby@kernel.org> <20231206073712.17776-15-jirislaby@kernel.org>
In-Reply-To: <20231206073712.17776-15-jirislaby@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Dec 2023 08:51:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWDzGyfOtfhj5-shCZJZmfZAxiTazUk7Ojt1ZvHFbvzDg@mail.gmail.com>
Message-ID: <CAMuHMdWDzGyfOtfhj5-shCZJZmfZAxiTazUk7Ojt1ZvHFbvzDg@mail.gmail.com>
Subject: Re: [PATCH 14/27] tty: m68k: nfcon: convert to u8 and size_t
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 8:37=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kernel.=
org> wrote:
> Switch character types to u8 and sizes to size_t. To conform to
> characters/sizes in the rest of the tty layer.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

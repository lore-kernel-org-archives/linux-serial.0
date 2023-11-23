Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aOKUW6W3"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC9D44
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 02:38:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso634737b3a.0
        for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700735929; x=1701340729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtWJos9eJonIZMcnZ3qHTztIEX4OrKTTJCiVLASavc8=;
        b=aOKUW6W3A21AW5tgv3wI8uMaVtT978Cb3hBUE9XwGdR/FgGQDXCGGbT7xmqkcAMz+G
         ho5YICq+hTXHgZqv6rKyFcGuDgnXx/lx2OhbPDOsK94KqOgnLwSTy21fjeNoCcfymiHv
         IJ5q7QNg5r52oom0EjOUx27RgbKV2FFSYkjRR0Lcxqa9t5yNK28QI17tqCfNk373VhEY
         ZUqVoYG5BttKcNqO2zlegzryfaSeNKjLxyeuE18fsoQkYoeJhqRY/fB/nQvqJOLPfcW8
         I7ZUg+a2MhdH19owXHXPNrXjQfMnpemB13BY65+Ep5gc5S6lyQ3ZzqU/HCGwowrAZpqS
         xQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700735929; x=1701340729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtWJos9eJonIZMcnZ3qHTztIEX4OrKTTJCiVLASavc8=;
        b=sor3NYcTty+s7koEhG1in1wMCL+Pcui0+orrOVaB85BVc1XsflASbT8UhgisMl14g5
         AeRXojTSAtZ4N2fOtjr7Wutxq1lrzmII+9RXvOqFDqDHHeFBeXpw8Rx4VWi0LwCW6mr0
         3REyDbKX92v2IqxZP7GodSqvTWTdEToU8MTa43gqht5Yn4iEQzU6bw9zPRbMD6frhyd3
         kL9kEro38wkTaFw9QOtknJ43YHIy6wqU54a8/sfxRXjxy3nruHi9M44hGjqq75uFhUwY
         KgPPK6LBKEro5c3giiQDuiWNgFKg7ASdVxY17FH2jAtDXzSTTNDuX2/Lfxa4LwlA5n13
         jQiQ==
X-Gm-Message-State: AOJu0YyPZmKhdbCS6Et7yhMzSlkSVZkOxbRDYWgRTnHA9jAtOSxXKXwf
	8auid+eEkjd+aytZ2SWDvJf+s5/pzNORCmS3YMTlKw==
X-Google-Smtp-Source: AGHT+IHvryOzXWmfb9qEZWfYxLmtqn4CX5rtr/8r6s4TMLtNZgUWu2Uht2WYKwskvoiWScCKfk/YfcsxnyZ6UyDhj40=
X-Received: by 2002:a05:6a20:be9c:b0:187:200a:713f with SMTP id
 gf28-20020a056a20be9c00b00187200a713fmr3721171pzb.23.1700735928664; Thu, 23
 Nov 2023 02:38:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-2-apatel@ventanamicro.com> <70ff59ea-378c-4d53-899a-eafffcad22fd@sifive.com>
In-Reply-To: <70ff59ea-378c-4d53-899a-eafffcad22fd@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 23 Nov 2023 16:08:36 +0530
Message-ID: <CAK9=C2U9aJDDd0JUhRqyLCF3dfyY5QBUrgyH+PKsT+pUKiB1xQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:06=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2023-11-17 9:38 PM, Anup Patel wrote:
> > The functions sbi_console_putchar() and sbi_console_getchar() are
> > not defined when CONFIG_RISCV_SBI_V01 is disabled so let us add
> > stub of these functions to avoid "#ifdef" on user side.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/sbi.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 0892f4421bc4..66f3933c14f6 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -271,8 +271,13 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned=
 long arg0,
> >                       unsigned long arg3, unsigned long arg4,
> >                       unsigned long arg5);
> >
> > +#ifdef CONFIG_RISCV_SBI_V01
> >  void sbi_console_putchar(int ch);
> >  int sbi_console_getchar(void);
> > +#else
> > +static inline void sbi_console_putchar(int ch) { }
> > +static inline int sbi_console_getchar(void) { return -ENOENT; }
>
> "The SBI call returns the byte on success, or -1 for failure."
>
> So -ENOENT is not really an appropriate value to return here.

Actually, I had -1 over here previously but based on GregKH's
suggestion, we are now returning proper Linux error code here.

Also, all users of sbi_console_getchar() onlyl expect a negative
value upon error so better to return proper Linux error code.

>
> Regards,
> Samuel
>
> > +#endif
> >  long sbi_get_mvendorid(void);
> >  long sbi_get_marchid(void);
> >  long sbi_get_mimpid(void);
>

Regards,
Anup

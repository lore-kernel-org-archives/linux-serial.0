Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E054918
	for <linux-serial@vger.kernel.org>; Mon, 10 Nov 2025 03:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762743926; cv=none; b=J3bcMS+NMcIV0FyJO4Z3oXhv/p9ydFN3wIzoXNEU+SNdQ6kwbiXCDT6ZkzK39UUb/im6MD0Ya6NVQ9PC4aEYKPetbEFbdLMZvr4zGaBEOFl+2HvrvqDNw10tKp92lucmVySfZ+y3F6s+NHnsoAKb1ninyE6aGv5Z45U9cV4tPRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762743926; c=relaxed/simple;
	bh=wTJLcSny+ozUUME7E/75yHBuP85KLM3WHxpiqiIjJn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY6B69J2AWsmusIPud6wLirNPhrj2pRqslbjlb9XtOWfFX7nERvFVogMsjHhqOccLXKEBY6b2VWhPFIGg0SeRLBbywdPT4kwANwnc2AROs1Plbr3fovgtbn3zksiMLstJPPHWRzfV9KZhoRkkfPKMZ4DBRB5xItWJ5vUX+25ptY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3N87p9e; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3N87p9e"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b553412a19bso1392935a12.1
        for <linux-serial@vger.kernel.org>; Sun, 09 Nov 2025 19:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762743924; x=1763348724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yYMpclIl4jEd0u1Ey8OQI5PQ64kH+ym08sCMeZtw38=;
        b=d3N87p9emPaBiO2hTk4LKpfvK5ukkzB3sCAn3j15RvTIIJvB+1ZQvHax+TeEu5yiaj
         lpuYeBA0/s/OLCsSc/A3gvFqaOEWZfUcIpvLHqam4IB8XgW3SxcEmX1sr26MsJGVmAU4
         KvfFfmt/ukag2S71EjnXMDuy6PZmJojlE3zvls/qy3PrdGWCnXXr6nfjV4H+7NZtuogv
         Ms2POLN73eUtisX8Y3kfSwgrg/ggxyLZewm8rPE8mnqkZlEk1fpPPvnPpWEAf/nC8wBD
         BVevDJyFSAsIdG685z7tOAZma03t2dXT3kQhkI9MJgGN7+vQXeOvhq0Dk1st2e+986+6
         Jq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762743924; x=1763348724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4yYMpclIl4jEd0u1Ey8OQI5PQ64kH+ym08sCMeZtw38=;
        b=LRopJNGgTZ2sREFWj3okBs1hgqEPvXnzEx+jT/JIajm57xA9Kns+X8huevr6G1qYLa
         nFm6b0aLD563MU2HraTEYYO8E4nHSZ5d/nY59K0HZMMysdF9dXSMnknaOrQ3HdM7lVsg
         BoiN3qvkY+RV2RAEuYMtGTrWsrdcTrbsxEaY7fwCnMZW0/jqpk1XEaRsy1JJRF7waeqN
         moBkpm9X+HcF4LKLojsw6pu4lAGohqkvV4v8f5HQRsIVkE30zKxKpGyt5lNowNzDpAq7
         BcH3hMLqBO13tTcMp/nvEXF7draiUKFoTJrOHZmNCLVFlAxURcjT1P2AZgvHbCSgyDCp
         +K+w==
X-Forwarded-Encrypted: i=1; AJvYcCVxowxcMKKoCbhkIYt4q6SUpiRoTwqRlJ+LPkKRnO3mnuuQETy6JJTid5D+AEDS0FMGYouV/2p4ONIhiIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJsFybjZlD6oFmKHmlE6PL2ielDz7Cf3TIpuOlvkPTI9dXZov
	EYkRxuvt9x5pUgDmM54rngf4BpXmBSLvOFgHuXT12cF14BrXImjNG7yj15YuNQXv5BQDaH0E5or
	eecoBdW7V4dEUzJfrED2zgWPeaJQmwXc=
X-Gm-Gg: ASbGncv7sGA2roTrbpO23s4uoQ8xTcrzT/Qsi80+A5w7q6iUnFIJugnxHQBOChDW7dS
	QmjiUeXmTMNvFpPCg0DyU3IBkexNj4P/6tTIjW2NE3MuNPGo7SO7YffdP2KvqCU8eBDbnZLNyx0
	bCmZy2k26o7Za3ZZeAMMbei7oqR6iaznb11iCSGnvR7RU6hrFyVU041WlnL7MVOc3Zrdop86LTz
	kkXS7X8LOFnBV017gmIYz/yUHd407Dcwnkb7MZ1Nt59LgKu6vMineqtIq5eZTdYP/3keKZI
X-Google-Smtp-Source: AGHT+IG9t/HeeWYayeXm7KhvuvGT/UvEbqynFjT+m1ly5m9KjtfVY7CXLEedW55ZpxYxwEkCH/we+ZEI/e9q7ZnAO9E=
X-Received: by 2002:a17:902:e5cb:b0:295:b7a3:30e6 with SMTP id
 d9443c01a7336-297e562871cmr87238345ad.18.1762743924342; Sun, 09 Nov 2025
 19:05:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
 <CAAfSe-uq6GszSLgtM+UBuwJ6V1Bt0_1Ard8cb6e9MMCsdpJPqw@mail.gmail.com>
 <CAB9BWhdKd93kJxPJv10X5uZ00O8d5NugoehX3_QtjmXQOMhDig@mail.gmail.com> <CAAfSe-sTUC=mW-iO+NK+mq2i8GEv1RaNPvCGgQwb23dOFBigXQ@mail.gmail.com>
In-Reply-To: <CAAfSe-sTUC=mW-iO+NK+mq2i8GEv1RaNPvCGgQwb23dOFBigXQ@mail.gmail.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Mon, 10 Nov 2025 11:05:13 +0800
X-Gm-Features: AWmQ_blFNG8JuiLc6Z-BMdaeb5m-Y-A3PFL8UNxEpciVtO2pvsePFvRy-pkrT-0
Message-ID: <CAB9BWhdHkkm6YYhdZJ2NdaJ6GebZyRi3SN9GLstQv1R7HLe4mQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Return -EPROBE_DEFER when uart clock is not ready
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Cixi Geng <cixi.geng@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:42=E2=80=AFAM Chunyan Zhang <zhang.lyra@gmail.com=
> wrote:
>
> Hi Wenhua,
>
> On Thu, 23 Oct 2025 at 10:10, wenhua lin <wenhua.lin1994@gmail.com> wrote=
:
> >
> > On Wed, Oct 22, 2025 at 2:55=E2=80=AFPM Chunyan Zhang <zhang.lyra@gmail=
.com> wrote:
> > >
> > > On Wed, 22 Oct 2025 at 11:09, Wenhua Lin <Wenhua.Lin@unisoc.com> wrot=
e:
> > > >
> > > > In sprd_clk_init(), when devm_clk_get() returns -EPROBE_DEFER
> > > > for either uart or source clock, we should propagate the
> > > > error instead of just warning and continuing with NULL clocks.
> > > >
> > > > Currently the driver only emits a warning when clock acquisition
> > > > fails and proceeds with NULL clock pointers. This can lead to
> > > > issues later when the clocks are actually needed. More importantly,
> > > > when the clock provider is not ready yet and returns -EPROBE_DEFER,
> > > > we should return this error to allow deferred probing.
> > > >
> > > > This change adds explicit checks for -EPROBE_DEFER after both:
> > > > 1. devm_clk_get(uport->dev, uart)
> > > > 2. devm_clk_get(uport->dev, source)
> > > >
> > > > When -EPROBE_DEFER is encountered, the function now returns
> > > > -EPROBE_DEFER to let the driver framework retry probing
> > > > later when the clock dependencies are resolved.
> > > >
> > > > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > > > ---
> > > >  drivers/tty/serial/sprd_serial.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/=
sprd_serial.c
> > > > index 8c9366321f8e..092755f35683 100644
> > > > --- a/drivers/tty/serial/sprd_serial.c
> > > > +++ b/drivers/tty/serial/sprd_serial.c
> > > > @@ -1133,6 +1133,9 @@ static int sprd_clk_init(struct uart_port *up=
ort)
> > > >
> > > >         clk_uart =3D devm_clk_get(uport->dev, "uart");
> > > >         if (IS_ERR(clk_uart)) {
> > > > +               if (PTR_ERR(clk_uart) =3D=3D -EPROBE_DEFER)
> > > > +                       return -EPROBE_DEFER;
> > > > +
> > >
> > > You are making this clock mandatory, sprd_serial driver could work as
> > > serial ports for logs output without this "uart" clock.
> >
> > Hi chunyan:
> >    Thank you very much for your review.
> >    This clock is actually mandatory now=EF=BC=8Csome SPRD project use d=
efault 26M clock,
> >    some new SPRD project use default 24M clock.  If driver can't parse
>
> Oh I see, then you can set a different default clock according to the
> compatible string, that's saying make SPRD_DEFAULT_SOURCE_CLK to be an
> element of "of_device_id.data".
>
> Thanks,
> Chunyan

Hi chunyan:
   This is not the current issue; it will be considered in future modificat=
ions.
   The main reason for this change is that the UART driver is
built-in, while the CLK driver is loaded as a module (ko).
   There may be a situation where the UART driver is loaded first.
   If an EPROBE_DEFER error occurs, the driver will return directly
and continue waiting for the CLK driver to complete loading.

Thanks
>
> > this clock correctly,
> >    driver will configure wrong baudrate and make the log garbled.
> >
> > Thanks
> >
> > >
> > > >                 dev_warn(uport->dev, "uart%d can't get uart clock\n=
",
> > > >                          uport->line);
> > > >                 clk_uart =3D NULL;
> > > > @@ -1140,6 +1143,9 @@ static int sprd_clk_init(struct uart_port *up=
ort)
> > > >
> > > >         clk_parent =3D devm_clk_get(uport->dev, "source");
> > > >         if (IS_ERR(clk_parent)) {
> > > > +               if (PTR_ERR(clk_parent) =3D=3D -EPROBE_DEFER)
> > > > +                       return -EPROBE_DEFER;
> > > > +
> > > >                 dev_warn(uport->dev, "uart%d can't get source clock=
\n",
> > > >                          uport->line);
> > > >                 clk_parent =3D NULL;
> > > > --
> > > > 2.34.1
> > > >

Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B91F3BA4
	for <linux-serial@vger.kernel.org>; Wed, 10 Dec 2025 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765349333; cv=none; b=a+DJLNVrORJqPbhlrCqtMPeOGBB2vH7+PH+w3vCitjfUzxJcV+Z/p8M9YG2Z/GgUqodHcqPuxtR23ekjfJCyL7DnIRqrYT2ECflOE7RM8YrO74eavPdXdPfFXgbbbYZK/SFG6E9P/nkE8dNDGY5b1AuDu3qt6+97Nxv/KYFNd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765349333; c=relaxed/simple;
	bh=XyFT/ijMOti+AUazOE3sm3jB85WLtoW49LVxRwcq6Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGwsjhVhKyxHuFQ2LASRY2tS/rQZ9TmpwsP51xD5OvnpNB9vXE3LsRA5VqhyxKzOIAnx5qhpGFqQ1o59p/fc+Rts5Z9mtyFaBuWMlK9HpJ2gJhf5JtCoNL9aF5AShtIG9xR12nROoKHpgAmxVOybzxx5r9EKR+qIBbh7Zb8X9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVr6qm5v; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVr6qm5v"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7f121c00dedso1696015b3a.0
        for <linux-serial@vger.kernel.org>; Tue, 09 Dec 2025 22:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765349331; x=1765954131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipxlXAQURz5oB3Z/PSsHI8ypS45IfnNmF0KmJeS0Zv4=;
        b=LVr6qm5vYhXzev2I4MYWSMWiUzeLWhofALgoj72HFao7djV7B2K2T5ExaqUVaH70mK
         oolJ6+7o9s7GQqZgwaX67Gq3u6Drk+v7kAQQAHkTB1QonKZZSHpSDcWAy7uEIPnmi+HP
         LBw11O/miKaPzYt8BqpKa1WPn5Ert1TQoQZqXaNTixFDQOO3rGBt2rkVElJp968uaS6o
         ZhQpQXlh51CI/qWlRMSDnzfvpMW2Un5RkA+y72w+yYrm974BS9qH+6Jx9K9R7ubKANRq
         dm7WxtEOf+X9P4vvNDgNhbnrUwV3pWeVv5yzTxlyoFMw9KRL+bQ1b9zvNmQTryC+Rla4
         kBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765349332; x=1765954132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ipxlXAQURz5oB3Z/PSsHI8ypS45IfnNmF0KmJeS0Zv4=;
        b=Dh2VevJ1wxDDubzd7vlWKOi/7PtbTKvtvja6fz0SOWEP4mBg4GwiySCuRlD/VYN2jc
         Yh58QA35GnRT2QIXxTVnji894gAy3RM4J9scR6GRP+ms0xST35qkMYO+8+xXezmUIvmO
         GORP6Rr4y0D/MRzLYMGemvP1SfoI3xF3UEGNccYCsGpTqqFyAT9Dj+wcG9mHjBElDPQs
         QTwXL6lz/fr0YsdKCUJ0kX9HuPd96EOdtbRKp2pGc7OtXM+I9u6Aj/ktdhTMm+HWUhO3
         Eze6emHJjzy2XGXFibbJ/trdnNOH0ocn/O0eRUnR9IMrSSVgW2M+3iLk6xMSAEqvgjpT
         yeGg==
X-Forwarded-Encrypted: i=1; AJvYcCVjIHJtPv5242sdcAlJzB3doA+6kGnBp4rqWgNYlJ/VeVoYBXPeJ/UmH0kZCz4piOwFFNCbhLtMRw3kB/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36EM8DiQIHRvM47OetbjtkuegQ3DDPiJ380Hlrq20CAfOYkZM
	do31ta4HclXovc7ZDh62cYOrMm+SZq2NOb7KXN5LmzTQs77dJoeXrKhf+caITvsV2yZsT14pW1t
	D0fF6nBaMD6dXHIh68pPAlq3Uml1xko8=
X-Gm-Gg: ASbGncv7vGL6QrTIAJVd131hC6/SghS63UrsK8j/OjGHWNbgL5Bm9yHzU6NHktGKgip
	QmAVx0n19YGbJq5NF0GxxXOQ1cHwW4vraXaxuN7S0exD0MvEC+udLr3A8Yd2eju66SyquWgGgZO
	mCkIr3c+QVlT2AXS5K6DB/OfqyKmhhXxE8DVR+OVUzF3PVe0Lqtqk+5zcBqXDl5EsL/Odr7xNdF
	oz1Hs3Qc37PIli9kT98L0DcUPb6jpWr9l33sJ+L4Js9hdmTL367aX53TwPVQ9TwgOCl1Fv/
X-Google-Smtp-Source: AGHT+IEXn9Yxn9d2+XJEDlQycZcbT8TdJ+jKbsf/w+E0RGrxFAn609NmzJIOLhNKbR5yr7/P9O9yBfsq87lJ0pVg32Y=
X-Received: by 2002:a05:6a21:3298:b0:366:5b6d:ebe0 with SMTP id
 adf61e73a8af0-366e33be43emr1558023637.72.1765349331554; Tue, 09 Dec 2025
 22:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
 <aSb5Q0Giq8p43n_o@black.igk.intel.com> <CAB9BWhfkkssUK7inD1gQA7DJ0YFuXKzboYFQjvZgT9jKSmyZFA@mail.gmail.com>
 <aSgUQvExNY2lCpYT@smile.fi.intel.com>
In-Reply-To: <aSgUQvExNY2lCpYT@smile.fi.intel.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Wed, 10 Dec 2025 14:48:40 +0800
X-Gm-Features: AQt7F2qb39lLzb4HnZaVo64i-LGUQ_Q-s48fJhI061prBpBuO3jj2fRZlB3UX40
Message-ID: <CAB9BWheCDwbS+=pwAK0+HyY+q5=DQ_2tUQXaFoH5-GKtVUDnBw@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Return -EPROBE_DEFER when uart clock is not ready
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Xiongpeng Wu <xiongpeng.wu@unisoc.com>, 
	Zhaochen Su <Zhaochen.Su@unisoc.com>, Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 5:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Nov 27, 2025 at 04:44:08PM +0800, wenhua lin wrote:
> > On Wed, Nov 26, 2025 at 8:57=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Wed, Oct 22, 2025 at 11:08:40AM +0800, Wenhua Lin wrote:
>
> ...
>
> > > >       clk_uart =3D devm_clk_get(uport->dev, "uart");
> > > >       if (IS_ERR(clk_uart)) {
> > > > +             if (PTR_ERR(clk_uart) =3D=3D -EPROBE_DEFER)
> > > > +                     return -EPROBE_DEFER;
> > > > +
> > > >               dev_warn(uport->dev, "uart%d can't get uart clock\n",
> > > >                        uport->line);
> > > >               clk_uart =3D NULL;
> > >
> > > AFAICS this still ignores other issues, what should be done here is t=
o
> > > replace devm_clk_get() by devm_clk_get_optional() and drop this NULL
> > > assignment.
>
> >    The main reason for this change is that the UART driver is
> > built-in, while the CLK driver is loaded as a module (ko).
> >    There may be a situation where the UART driver is loaded first. If
> > an EPROBE_DEFER error occurs, the driver will return directly
> >    and continue waiting for the CLK driver to complete loading.
> >    If this interface is changed to devm_clk_get_optional, in scenarios
> > where dependent components are not yet loaded,
> >    it will no longer return EPROBE_DEFER but instead return null. This
> > behavior may not align with the desired outcome.
>
> No, the _optional does exactly what your code does with the better approa=
ch
> that may return other errors _in addition to_ the current state of affair=
s.
>
> So, please switch to _optional variant and drop all that unneeded dances.
>
>         clk_uart =3D devm_clk_get_optional(uport->dev, "uart");
>         if (IS_ERR(clk_uart)) {
>                 return dev_err_probe(uport->dev, PTR_ERR(clk_uart),
>                                      "uart%d can't get uart clock\n", upo=
rt->line);
>
> this will return an error when clock is present, but can't be retrieved.
> When there is no clock provided at all, it will return NULL.
>
> > > >       clk_parent =3D devm_clk_get(uport->dev, "source");
> > > >       if (IS_ERR(clk_parent)) {
> > > > +             if (PTR_ERR(clk_parent) =3D=3D -EPROBE_DEFER)
> > > > +                     return -EPROBE_DEFER;
> > > > +
> > > >               dev_warn(uport->dev, "uart%d can't get source clock\n=
",
> > > >                        uport->line);
> > > >               clk_parent =3D NULL;
>
> Ditto.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Hi Andy:
  Thank you for your valuable feedback.
  We have implemented the changes in patch V2 and submitted a revised versi=
on.

Thanks

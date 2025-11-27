Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6B320A3C
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764233062; cv=none; b=u0YMIyoYh4EURqvQS0OxtWfdxtgIOLAI2QkS4rfhh/6rHp2c3V0eGePE/9bYJhxETP84CJqLVbSu4CWjIeW6RIRD7tMfW8FY4+wiXRqjctzCY4vAu9yBP255IRHedAyxy6y4tz/A6sZPphUcZ1PbchV0+MCLZBY3E+u65rhzpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764233062; c=relaxed/simple;
	bh=kv3c2FkFzYef/skPOl9VjiUYxUdFfyDXVonv0DlVMQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EU+6dYok6/5APpNzXISD+FZOXM+pgYuX0Svo98dTK7FnCripC25Cka5OW+F9UTIsVFeXCCsA9XyIKebHr/mVlYyQke/THgAYEX7YbrCAMkNuyALizNiwDTZjpa7tTquqOZbZXxYkzU7Gt19lTCrGDF7PiJjWfwhSDt+BLy5gTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8HDByM6; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8HDByM6"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so398364a91.2
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 00:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764233060; x=1764837860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sABHvu0jmtHoEktOCIN2DEc4NUJ9omD6CsiClBMm+YQ=;
        b=K8HDByM6NnQy9C2ySfLk3f3OaaQuHnmm11stl465fBB8V+sZt9PVPpqxO4b80WOLHQ
         wUoGye/Yth80Wi+Z62dA1tXhrhEblv9+xZ8hFf6BT1oYx6Vkf/164AJTFiqZo1FLMf1V
         ldJ7lfHEMY9HjMP8RzxhHD8Y6R9k+XKl0BcVTpnIK8A9pFS0DK1mJfbiHjsjLh19u4gd
         o/c+Fpq+e3aeeOsMzS7HR4KwmoA7FeIcUTFu1RQkXhoPXiT6NwYYTqOFgpoOznICoNwk
         6QmptO0YiJgOkj71Jf5xac4yizaxtiTyTdlJK+rqLHqKVq2WgT/z/yXH9sufVMFjWGab
         cy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764233060; x=1764837860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sABHvu0jmtHoEktOCIN2DEc4NUJ9omD6CsiClBMm+YQ=;
        b=c+0WaU7/X4K8/k8Zpb3722DwXqLqabrxrS5MVBaLRisGRR7AmPvR+ivdM3K3kgYtv3
         i3huc7r8VwhaWqMJn5db1fWtD6eW5EWA24CtgRjhuCCTcWWoMznGiArbSlsFBk/P286s
         U4nkY1pEzZvLt7Gvhs1iZwzaXlq68UfP3FCQFUnH+OWVVU4ce4HO1L4wbqaHJuH89Bc0
         Yk7vOgecJzLN7cAEijBeyJ4Nh4cYzxbEh07P8ieN5RJ3NXsvp00fLoWxs8GcWmuwhTa5
         qGnSFP27rGZpFJrKDQYjjhqB+nmtnjL25kcP1JYIkfIBhKRr12xdoh9mQd5hk2zgEHx8
         BiZg==
X-Forwarded-Encrypted: i=1; AJvYcCVzXXNr7sVrOJG1whreW+wxwRAng2NhdbmbyDv5TZz9B8ZnDvMWIJ49CRvNss6RC1xYR2qkdJ/E0WbV6u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QMOhxeWEf/Lh4lyQWayQa1zVznXTKEg6D8Z6v36G3TXLkHP6
	ywdVMzkVZojBa0ychh724xv5U40VjOC0fR/W39IbVG/4cjxQVKPV3YX85rsETdu0hwiAim+0u0n
	1pLUIN2GdEU1Oz/OAXHYNiClGHoj7XlAMCojwnJw=
X-Gm-Gg: ASbGncs97yNZ+yaYHeIPsj6h2gskw9lDN/O12K8nFc8hzYL4j1mWW4eGfMo4ySARHok
	FryLoJlspJlconaY546+cWAv/jBUKQfYuzVXeS69OJz47Iznuf2TK5cHO+xkvPoAHk+gyWdrtTm
	0kgUsp3x9G5JYSOG+aBwa9eq7smAJcx/AEAvJOTju2PfZ2L8/Q+eOj/OZWisiGRIITheSX37FH2
	nyEmJ+S/NjsqBBSqn36y3sakOmT4lfZr9pQCMMlZ8wWPiSE/NnaEOqKSpdiAocLB4IJYYQJ
X-Google-Smtp-Source: AGHT+IHMlVcTI5n5ONvPpgRfR2zCyzv2bF6V+ZHhjlXJa0nN/Y0xVDigKmJQyMcz8Wv2mTZN2t6O0PH6leEElIwU2Hc=
X-Received: by 2002:a17:90b:2587:b0:340:bb64:c5e with SMTP id
 98e67ed59e1d1-3475ebfa337mr10017708a91.14.1764233059905; Thu, 27 Nov 2025
 00:44:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022030840.956589-1-Wenhua.Lin@unisoc.com> <aSb5Q0Giq8p43n_o@black.igk.intel.com>
In-Reply-To: <aSb5Q0Giq8p43n_o@black.igk.intel.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Thu, 27 Nov 2025 16:44:08 +0800
X-Gm-Features: AWmQ_bk6UGedOdl5FvCIIYuRKJnTbvAXDlqKLOCC2X0XssW3Nuvskv32zUzWA_g
Message-ID: <CAB9BWhfkkssUK7inD1gQA7DJ0YFuXKzboYFQjvZgT9jKSmyZFA@mail.gmail.com>
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

On Wed, Nov 26, 2025 at 8:57=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 22, 2025 at 11:08:40AM +0800, Wenhua Lin wrote:
> > In sprd_clk_init(), when devm_clk_get() returns -EPROBE_DEFER
> > for either uart or source clock, we should propagate the
> > error instead of just warning and continuing with NULL clocks.
> >
> > Currently the driver only emits a warning when clock acquisition
> > fails and proceeds with NULL clock pointers. This can lead to
> > issues later when the clocks are actually needed. More importantly,
> > when the clock provider is not ready yet and returns -EPROBE_DEFER,
> > we should return this error to allow deferred probing.
> >
> > This change adds explicit checks for -EPROBE_DEFER after both:
> > 1. devm_clk_get(uport->dev, uart)
> > 2. devm_clk_get(uport->dev, source)
> >
> > When -EPROBE_DEFER is encountered, the function now returns
> > -EPROBE_DEFER to let the driver framework retry probing
> > later when the clock dependencies are resolved.
>
> ...
>
> >       clk_uart =3D devm_clk_get(uport->dev, "uart");
> >       if (IS_ERR(clk_uart)) {
> > +             if (PTR_ERR(clk_uart) =3D=3D -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> > +
> >               dev_warn(uport->dev, "uart%d can't get uart clock\n",
> >                        uport->line);
> >               clk_uart =3D NULL;
>
> AFAICS this still ignores other issues, what should be done here is to
> replace devm_clk_get() by devm_clk_get_optional() and drop this NULL
> assignment.
>
> ...

Hi Andy:
   The main reason for this change is that the UART driver is
built-in, while the CLK driver is loaded as a module (ko).
   There may be a situation where the UART driver is loaded first. If
an EPROBE_DEFER error occurs, the driver will return directly
   and continue waiting for the CLK driver to complete loading.
   If this interface is changed to devm_clk_get_optional, in scenarios
where dependent components are not yet loaded,
   it will no longer return EPROBE_DEFER but instead return null. This
behavior may not align with the desired outcome.

Thanks

>
> >       clk_parent =3D devm_clk_get(uport->dev, "source");
> >       if (IS_ERR(clk_parent)) {
> > +             if (PTR_ERR(clk_parent) =3D=3D -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> > +
> >               dev_warn(uport->dev, "uart%d can't get source clock\n",
> >                        uport->line);
> >               clk_parent =3D NULL;
>
> Ditto.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

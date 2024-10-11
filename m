Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA31373
	for <linux-serial@vger.kernel.org>; Fri, 11 Oct 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657053; cv=none; b=pWnavVNgoG+jTSaGjbCjNfM2wZcf3Y23+Wm/6UuzrKdpUMB2ektUIBKl6j78rf6kkW82RJG/PgA0GTKAuQ3SftNTK10LcwJNsMocXJf26obu3sKdABaknExEz5wQH0khTV9+q0aeEzkLWEf9qvYCIrVglBWlWv3fe0gZcEm6gvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657053; c=relaxed/simple;
	bh=sk7ig4kmzzR0r3yaD+YqQ9AW4S497HPCFTId5lyO/eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIWWAMGmXzdUPiYVnj+NyTBY+LUY7Z+75v/eJuwNWCs0WIDWn6Q2sS5NXPslENR1TOLANhIrepzOYoxC2AqA6UoD7PTP52IdyI5Mg/MJ7p02FgnZhUSJ5xkODwLuMr+xoDydEtmfqwrQ50vI4gAmbgj9eX21IRum7L9aWQvTGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KnZesr6f; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KnZesr6f"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e13375d3so723596e87.3
        for <linux-serial@vger.kernel.org>; Fri, 11 Oct 2024 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728657048; x=1729261848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BP0XnFYp3SsaSaiTxi9A6dV0XZX880MVcEXNqO2kxM=;
        b=KnZesr6frU980PK3iP+oZ/PFn8i4Zc+q6noTvGiB1ZurwksbwQq3mDvC802Xdbu89R
         u/HVjvbVvpUGSUoLOVDrzEfHcFSp7wdAg6bS/LqvhUvaypN7Q1uwOREIvDjoJCNgxnPf
         cn2UBuvQfqvlnwAE/kcO6dm+I6p4WckRiEqA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728657048; x=1729261848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BP0XnFYp3SsaSaiTxi9A6dV0XZX880MVcEXNqO2kxM=;
        b=SdgxHAdPA9sERMb+5OSiMlrLR3LHdIQIDB/JnhNMSwLaYlWifwv2reuv2MU4Le7722
         ul0ElBObSPhgKQfDaDTVtzC68tcEN95ILXwEo9GvYVtEa3ylN2bxwNvlFUDFC5GrRJF0
         +t1wLmZ6XqmADBAn1YdKKZMxF4o6jTZdPFnJHVms8gEkAp5PYAosUFGlkZtD6FrhKoSO
         KDNlvYKtlJGtBc4owMxClB/nPLry5NjGc5oNJwoMqcVOIxL6qGqrL3F747Xu77PG+TJ6
         g0a3fwYTh3ii/61ovxm5Cjk03Umb/ufxxK3HBTqmVIsbK0i+zE4fd41C0Wic5xIJ8IQr
         bz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdq7Qjvbc6bQh7MDwDa8X9Q2JZrdoNiSL8bFerQ6uSFEEoquA4em8FJXDzzQpQ+b5stZ3oiEX0+24fA9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8TRueSWgrVqrmREFRgK4f+kg3no5jsgx4bAxze8j5hMsB3ds
	KhHTCUeX2W5Y3tIKOYeZZbFOw7ThXrixsmcxLViM2BHrI3P63VvRfe2p1KkzHIyZazDfhVv4B4t
	kkJHJ
X-Google-Smtp-Source: AGHT+IHyUin8EenXyaJWuKE7H+M/m215d90O8dy1pxUb/uzyK0uWHM+sFpQS/ZyOujXpaAvUw3AQoQ==
X-Received: by 2002:a05:6512:3093:b0:539:8b49:8934 with SMTP id 2adb3069b0e04-539da59bf2amr1563655e87.52.1728657048244;
        Fri, 11 Oct 2024 07:30:48 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539e0e6cf94sm170622e87.30.2024.10.11.07.30.45
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 07:30:47 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-537a399e06dso2467107e87.1
        for <linux-serial@vger.kernel.org>; Fri, 11 Oct 2024 07:30:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5anzIncDlLQF5e9YoUYexVQRmzMThXMtPfUdrF1Vrs9YW8y+SlFMWFZmIKKgsAAmIcX4QlaRV44NvFWQ=@vger.kernel.org
X-Received: by 2002:a05:6512:39ce:b0:52c:8abe:51fb with SMTP id
 2adb3069b0e04-539da3c1e52mr1341517e87.10.1728657045305; Fri, 11 Oct 2024
 07:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org>
 <20241001125033.10625-3-johan+linaro@kernel.org> <CAD=FV=UoU5Nd7sW66cjQzor+BP+W_f7uw0MGRaF6y7PH7KRN_g@mail.gmail.com>
 <ZwaO0hCKdPpojvnn@hovoldconsulting.com> <CAD=FV=UZtZ1-0SkN2sOMp6YdU02em_RnK85Heg5z0jkH4U30eQ@mail.gmail.com>
 <ZwjK-s0sMn9HOF04@hovoldconsulting.com>
In-Reply-To: <ZwjK-s0sMn9HOF04@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 11 Oct 2024 07:30:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XuEPGtDCe4ssXPy2avigqviTBAycc0Q_U_Pwi9x6t23g@mail.gmail.com>
Message-ID: <CAD=FV=XuEPGtDCe4ssXPy2avigqviTBAycc0Q_U_Pwi9x6t23g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 10, 2024 at 11:51=E2=80=AFPM Johan Hovold <johan@kernel.org> wr=
ote:
>
> > > Not sure how your "console process" works, but this should only happe=
n
> > > if you do not enable the serial console (console=3DttyMSM0) and then =
try
> > > to use a polled console (as enabling the console will prevent port
> > > shutdown from being called).
> >
> > That simply doesn't seem to be the case for me. The port shutdown
> > seems to be called. To confirm, I put a printout at the start of
> > qcom_geni_serial_shutdown(). I see in my /proc/cmdline:
> >
> > console=3DttyMSM0,115200n8
> >
> > ...and I indeed verify that I see console messages on my UART. I then r=
un:
> >
> > stop console-ttyMSM0
> >
> > ...and I see on the UART:
> >
> > [   92.916964] DOUG: qcom_geni_serial_shutdown
> > [   92.922703] init: console-ttyMSM0 main process (611) killed by TERM =
signal
> >
> > Console messages keep coming out the UART even though the agetty isn't
> > there.
>
> And this is with a Chromium kernel, not mainline?

Who do you take me for?!?!  :-P :-P :-P Of course it's with mainline.


> If you take a look at tty_port_shutdown() there's a hack in there for
> consoles that was added back in 2010 and that prevents shutdown() from
> called for console ports.
>
> Put perhaps you manage to hit shutdown() via some other path. Serial
> core is not yet using tty_port_hangup() so a hangup might trigger
> that...
>
> Could you check that with a dump_stack()?

Sure. Typed from the agetty itself, here ya go. Git hash is not a
mainline git hash because I have your patches applied. "dirty" is
because of the printout / dump_stack().

lazor-rev9 ~ # stop console-ttyMSM0
[   68.772828] DOUG: qcom_geni_serial_shutdown
[   68.777365] CPU: 2 UID: 0 PID: 589 Comm: login Not tainted
6.12.0-rc1-g0bde0d120d58-dirty #1
ac8ed1a05abcc73f4fafe0543cbc76768ea594e1
[   68.789737] Hardware name: Google Lazor (rev9) with LTE (DT)
[   68.795581] Call trace:
[   68.798124]  dump_backtrace+0xf8/0x120
[   68.802025]  show_stack+0x24/0x38
[   68.805463]  dump_stack_lvl+0x40/0xc8
[   68.809265]  dump_stack+0x18/0x38
[   68.812702]  qcom_geni_serial_shutdown+0x38/0x110
[   68.817578]  uart_port_shutdown+0x48/0x68
[   68.821736]  uart_shutdown+0xcc/0x170
[   68.825530]  uart_hangup+0x54/0x158
[   68.829154]  __tty_hangup+0x20c/0x318
[   68.832954]  tty_vhangup_session+0x20/0x38
[   68.837195]  disassociate_ctty+0xe8/0x1a8
[   68.841355]  do_exit+0x10c/0x358
[   68.844716]  do_group_exit+0x9c/0xa8
[   68.848441]  get_signal+0x408/0x4d8
[   68.852071]  do_signal+0xa8/0x770
[   68.855526]  do_notify_resume+0x78/0x118
[   68.859605]  el0_svc+0x64/0x68
[   68.862790]  el0t_64_sync_handler+0x20/0x128
[   68.867218]  el0t_64_sync+0x1a8/0x1b0
[   68.872933] init: console-ttyMSM0 main process (589) killed by TERM sign=
al


> > Now I (via ssh) drop into the debugger:
> >
> > echo g > /proc/sysrq-trigger
> >
> > I see the "kgdb" prompt but I can't interact with it because
> > qcom_geni_serial_shutdown() stopped RX.
>
> How about simply amending poll_get_char() so that it enables the
> receiver if it's not already enabled?

Yeah, this would probably work.

-Doug

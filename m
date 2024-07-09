Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A2144D00
	for <linux-serial@vger.kernel.org>; Tue,  9 Jul 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567868; cv=none; b=hIaxTdubrE8I6hk+i0HtbS6gktVQPIVDxs/4qg8qbwzzHocEb8xOV284qOcmLINXpogjRouiD9njybvfJyi8+Z52VbUuGF7UBq5iL3OnCsRXzINVUni9W0AkIzXfomWYOvWTindW+b+WQPSa/TDd/A7+QxOk8fBPlJuW9tXvhfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567868; c=relaxed/simple;
	bh=FAmfLU3iQFSgoCdv6EnHXIwlHcCQMJUyMdiu+4TZIZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhmsjpHy5AF6eVkHvhS/1WLORzeJjTOIaUkwGzYD5DLgqiFxgPTUff6QTSs2qtdKbbcTB7cyBU1b0zLhZsYgae9TLeKkCF/o57M93y6MU5AMT9vI9TU5p+nuJ/eaurwtEK+enRNAo2SWz6CvcddlTkOyLFbhJoK8Tt1dh/SCtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CuyFg2By; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CuyFg2By"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79f1828ed64so119950185a.1
        for <linux-serial@vger.kernel.org>; Tue, 09 Jul 2024 16:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720567863; x=1721172663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZFheUR/qXoImqQXtjj2taFVa+bsRTO/bNKZR5rHkB0=;
        b=CuyFg2ByteNaLGT7XsjEEMyD5gz5II2N/c6o/pYENQ9EyoOE+1ZFf1SmVw/K1rK231
         yF2VxBouhNOfIN5kM2cDpUMi5B1zRHri/TkESFD4BwECOlV1QoAPtTgB7EvSLBm9YuXi
         weNMSPM8S0Ztaq+kAEtxXHHPrYwuxkeP2El2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720567863; x=1721172663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZFheUR/qXoImqQXtjj2taFVa+bsRTO/bNKZR5rHkB0=;
        b=Z2ZPSu6Ca5FXQszIlrt2XLSrIX8QG7OFj4H8dS9oWlHFvMpUpGJV9QHo5lyUpV5qXt
         Lo5tDxxfS0BuQCiWYRpe4FLi5sCurCOCL4ZnoutMcf0h/ckDQ/QMwovmYwXP5yvROFff
         L5jU5xSQayw1qPEIwTMJu+campbW+k0DaXumo8NUBDNqW5Lqgq/YJvZPdjWy6eHr6vMa
         +Sh2O2eoAgSV2laN78nB5Ci2GjAcBvJH4YY4Fj4STVN4rR+n2rPJPzi51iAGySIzTWVZ
         2j/P9sbWP/jhJ8biXKAS8ejcyhzSRMhio7kyHVeg0pKLCqlFfLk271oDlGb4JDC3zg2m
         zjBA==
X-Forwarded-Encrypted: i=1; AJvYcCWLNLw31w9xCYZZNuqrPl0h4lZeLh7V3S9qRQ4i26UzQc39jOZEodP2tLrPqHdG/AKUyayI32jHDVC9Q4+PKh6+v1G8h0YS99o0sAkh
X-Gm-Message-State: AOJu0YzwV+szhu4Gx726K7fYV60VoJ6aUmP1dxeR8X0XLoFR1/r3QHKH
	msFY6EiC4ffIFuSMvYcuwnWOHoGvEwwSL2upJgaQAezHdNiZI+DNpdpEWbS1FeEdRn69E8/3fNc
	=
X-Google-Smtp-Source: AGHT+IH+HW1ApUNOLtDZqTIuXc5x1a4XmioMGoE2n98msGEeAVa8SYQ48nZzCX7uz7ErGDuaA4j1YQ==
X-Received: by 2002:a05:620a:178d:b0:79f:14ef:40cf with SMTP id af79cd13be357-79f19ae53a2mr491027385a.56.1720567862970;
        Tue, 09 Jul 2024 16:31:02 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190a9746sm141935385a.113.2024.07.09.16.31.01
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:31:02 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44a8b140a1bso116211cf.0
        for <linux-serial@vger.kernel.org>; Tue, 09 Jul 2024 16:31:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUiDFRFKq7z5R301qS3Yg7d9DKzef7qbJxPy4BG81UT6O7Fg8pmI+W+xPJvre+iD0ZIQ4qTMqVd06NBC4J4AvzC2D0flaKZdVyuwCB
X-Received: by 2002:a05:622a:6dc3:b0:447:e423:a463 with SMTP id
 d75a77b69052e-44b16e711afmr680531cf.3.1720567861417; Tue, 09 Jul 2024
 16:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704101805.30612-1-johan+linaro@kernel.org>
 <20240704101805.30612-4-johan+linaro@kernel.org> <CAD=FV=VHOTQKNNbkWX17o57weP_wTm__MCSGPhFHQ+uG1CD+Bw@mail.gmail.com>
 <Zo0Gco1igkL185US@hovoldconsulting.com> <Zo0zJ8icZO9VFG8h@hovoldconsulting.com>
In-Reply-To: <Zo0zJ8icZO9VFG8h@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 9 Jul 2024 16:30:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WR=iJ_3eDFm52GhmMTMfB3qQE_vhCqPs=EcT2DkebgsA@mail.gmail.com>
Message-ID: <CAD=FV=WR=iJ_3eDFm52GhmMTMfB3qQE_vhCqPs=EcT2DkebgsA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] serial: qcom-geni: do not kill the machine on fifo underrun
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 9, 2024 at 5:55=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Tue, Jul 09, 2024 at 11:44:18AM +0200, Johan Hovold wrote:
> > On Mon, Jul 08, 2024 at 04:59:59PM -0700, Doug Anderson wrote:
> > > On Thu, Jul 4, 2024 at 3:19=E2=80=AFAM Johan Hovold <johan+linaro@ker=
nel.org> wrote:
>
> > > > @@ -878,7 +878,7 @@ static void qcom_geni_serial_send_chunk_fifo(st=
ruct uart_port *uport,
> > > >                 memset(buf, 0, sizeof(buf));
> > > >                 tx_bytes =3D min(remaining, BYTES_PER_FIFO_WORD);
> > > >
> > > > -               tx_bytes =3D uart_fifo_out(uport, buf, tx_bytes);
> > > > +               uart_fifo_out(uport, buf, tx_bytes);
> > >
> > > FWIW I would have rather we output something much more obviously wron=
g
> > > in this case instead of a NUL byte. Maybe we should fill it with "@"
> > > characters or something? As you said: the driver shouldn't get into
> > > this error condition so it shouldn't matter, but if we have a bug in
> > > the future I'd rather it be an obvious bug instead of a subtle bug.
> >
> > Yeah, I've been running with a patch like that locally in my tests, and
> > went a bit back and forth whether I should post it. My reasoning for no=
t
> > doing so was that the bugs have been fixed so we don't need to spend
> > cycles on memsetting the buffer to anything but NUL (I used 'X' in my
> > testing).
> >
> > I guess that can be avoided by only padding the buffer if we ever hit a=
n
> > underrun, but I still thinks it's questionable to spend the effort as
> > this is not something that should be needed. In any case, I didn't want
> > to spend time on it to fix the 6.10 regressions.
> >
> > Killing the machine is perhaps an effective way to get attention to an
> > issue, but I'd much rather have an occasional NUL character in the log
> > *if* this ever becomes an issue at all again.
> >
> > > I'm happy to post a patch or provide a Reviewed-by if you want to pos=
t
> > > a patch. Let me know.
> >
> > If you feel strongly about this, I can either fill the buffer with
> > something else than NUL or add error handling for any such future
> > hypothetical bugs. What do you prefer?
>
> Actually we just need to clear the buffer on entry, which would do away
> with the unnecessary memset() that is there today. This should also give
> you a printable indication that something is wrong in case a similar bug
> is ever reintroduced (e.g. the last four characters would be repeated
> until the transfer is complete instead of a fixed char like '@').
>
> Perhaps that's good enough as a compromise?

IMO initting 32-bits of data should be fine to do each time through
the loop. I've sent a patch:

https://lore.kernel.org/r/20240709162841.1.I93bf39f29d1887c46c74fbf8d4b937f=
6497cdfaa@changeid

-Doug

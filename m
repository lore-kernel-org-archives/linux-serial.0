Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750FC12F37C
	for <linux-serial@vger.kernel.org>; Wed, 10 Jul 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633658; cv=none; b=MLcDWhxZD4tVxo5RDZ8Sn2dHt46Kl9PLEj0PJ1jbX+S2Eg3wNgdf+wSJeVHi9edmlnCb2Ow232gI08T1Bz1qSeLj2ecKVfzIJwaSlg0zeCq8e/Cv2FeF9FbucKICw8csAuLbEdSqL+8XdoDaalpDLtXCd1ilvg+ppXGdJOgKfa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633658; c=relaxed/simple;
	bh=i389QRnHQ6ZZ2nt5lo9H1WmPvVCNnVqklYtqUudIKXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISUd1DLjpEVyCAWm1Baa8a/fsuKa9nK1i3a5kSvhKPwrgzE/j2UbyBmVK0ThRi9PjjUTtLPPQQ2vCuzGcPc4Q0CrRH+p1Jwb3LmAQsNvDRTdE2+K/er5suDTShUUkSeXcUwLTiB74qugfTNXzIFjQGRjlzi3L73sSupqMGVHZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WBDtHJfb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WBDtHJfb"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79ef8e0c294so77912185a.1
        for <linux-serial@vger.kernel.org>; Wed, 10 Jul 2024 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720633653; x=1721238453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i6GGvi4N+b60jAHl9CBW1IjNhXewguKcPzleEMnR20=;
        b=WBDtHJfbbiLScuyTJ4xQAprnzGaSzOowCjjE5WhuD4s98p9hrl3975LRDINRMsh0bP
         bYVeHBIhRrHz+wFO1DMxatEcW79C+78/O1UUut+lijEpDXhD8vqpM54spDGMts7l1V87
         KdssxxPt+0fBMuXqfkze47B14oKlRpWdoygRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720633653; x=1721238453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0i6GGvi4N+b60jAHl9CBW1IjNhXewguKcPzleEMnR20=;
        b=ZLvE/4tp8/HyMnUORIc2kLUdYgxU/rOlFIHOI7zDFLRplXdLh7rwZL1hb3CN8Kvj2X
         q+zYA7pI/uPqm4qbd7dP9cvLxcBe50sQX89UAOd8WnjApEDA7z1zmS3TJh6jyjGDd769
         3wv1QNe+kUdPuAHSGAGv0NOQ+Md0GO1Ny8cI5VvF0p7CZvYCqpVszXP0XbqdVHbvLMTK
         Zx6lxBkq096Ib7v6qNIg3psOAPZM5Ok4/u+/jiKv4ZkYu9oq/qM4zXU1lytbcynP3Ybq
         NYH/ONi77xMYeC/tI4JZBmMzSaajMPM/R6ARcKfANiPaRrgzU+K7jHKyjgUQBv2qWR74
         MXpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx9GcC0MDeDSkfWvxUvjv+CUHD0RPn2dsxp7AHsu8b5ugkgSuQ0YM2aOTa8o8V9BvxwDf/tnBJ3lN7s3vGMaBWh5iPzduiXG809qvx
X-Gm-Message-State: AOJu0YzYy5zPKgy1IaWlofYJw941FqfuU+DwtK8cIlpBuOBSBV4rw5LP
	OOmKrKa2+WQHdUAw8ukDfjy4zSNYhcGNH54yDuWKgyXjPg95nZh59bm/SjGUUplxXf6l4PXzs71
	8Ng==
X-Google-Smtp-Source: AGHT+IHhROpcEfTc7llZtunwrhToN6GDSnNJ+skNWHYHOw5bPeBfSS4vubV8so3a6ErcgKxP+wV3qg==
X-Received: by 2002:a05:6214:240f:b0:6b5:8d15:d139 with SMTP id 6a1803df08f44-6b74afae6e3mr6525536d6.28.1720633653536;
        Wed, 10 Jul 2024 10:47:33 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61baa2e43sm18780736d6.133.2024.07.10.10.47.32
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 10:47:32 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44664ad946eso17001cf.1
        for <linux-serial@vger.kernel.org>; Wed, 10 Jul 2024 10:47:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAOjAXGbzKb4KQ5nnCZEW+k9lrZiDaKy2sELrcXumiwne5nMp5wbGTacWD+FLHoe/DGa6DyNBzTtpzCPl+iz7EERY//I/7Gih5RoTa
X-Received: by 2002:ac8:5843:0:b0:444:dc22:fb1d with SMTP id
 d75a77b69052e-44d0aa44e97mr150461cf.12.1720633652080; Wed, 10 Jul 2024
 10:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709162841.1.I93bf39f29d1887c46c74fbf8d4b937f6497cdfaa@changeid>
 <2024071001-justice-catfight-37f0@gregkh> <CAD=FV=XX0+jE28CRQmWu9Q09KRf5ZbqLYizmem8kk6ajX05qfw@mail.gmail.com>
 <2024071035-prize-puppy-a288@gregkh>
In-Reply-To: <2024071035-prize-puppy-a288@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jul 2024 10:47:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQ5Qd1VEcM30ztLY2e4mjTg4Ft6pJt=o-By38eNrtW=Q@mail.gmail.com>
Message-ID: <CAD=FV=XQ5Qd1VEcM30ztLY2e4mjTg4Ft6pJt=o-By38eNrtW=Q@mail.gmail.com>
Subject: Re: [PATCH] serial: qcom-geni: Show '@' characters if we have a FIFO underrun
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, 
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 10:28=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 10, 2024 at 09:01:10AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Jul 9, 2024 at 10:35=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jul 09, 2024 at 04:28:45PM -0700, Douglas Anderson wrote:
> > > > As of commit 2ac33975abda ("serial: qcom-geni: do not kill the mach=
ine
> > > > on fifo underrun") a FIFO underrun will no longer hard lockup the
> > > > machine. Instead, a FIFO underrun will cause the UART to output a
> > > > bunch of '\0' characters. The '\0' characters don't seem to show up=
 on
> > > > most terminal programs and this hides the fact that we had an
> > > > underrun. An underrun is aq sign of problems in the driver and
> > > > should be obvious / debugged.
> > > >
> > > > Change the driver to put '@' characters in the case of an underrun
> > > > which should make it much more obvious.
> > > >
> > > > Adding this extra initialization doesn't add any real overhead. In
> > > > fact, this patch reduces code size because the code was calling
> > > > memset() to init 4 bytes of data. Disassembling the new code shows
> > > > that early in the function w22 is setup to hold the '@@@@' constant=
:
> > > >   mov     w22, #0x40404040
> > > >
> > > > Each time through the loop w22 is simply stored:
> > > >   str     w22, [sp, #4]
> > > >
> > > > Cc: Johan Hovold <johan@kernel.org>
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > >  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/se=
rial/qcom_geni_serial.c
> > > > index 69a632fefc41..332eaa2faa2b 100644
> > > > --- a/drivers/tty/serial/qcom_geni_serial.c
> > > > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > > > @@ -872,10 +872,10 @@ static void qcom_geni_serial_send_chunk_fifo(=
struct uart_port *uport,
> > > >  {
> > > >       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> > > >       unsigned int tx_bytes, remaining =3D chunk;
> > > > -     u8 buf[BYTES_PER_FIFO_WORD];
> > > >
> > > >       while (remaining) {
> > > > -             memset(buf, 0, sizeof(buf));
> > > > +             u8 buf[BYTES_PER_FIFO_WORD] =3D { '@', '@', '@', '@' =
};
> > >
> > > Why is '@' a valid character for an underrun?  Why would any characte=
rs
> > > be ok?  Where is this now documented?
> >
> > '@' is arbitrary. If you have a different character suggestion then
> > I'm happy to change it. I'm mostly looking for something other than
> > '\0' to be printed out in the case of underruns, which is what happens
> > now. Printing out '\0' is much harder to notice but could still end up
> > causing problems with file transfers / automated programs trying to
> > work with serial data.
>
> Any character is "wrong", so picking this one feels odd.
>
> Do we know when an underrun happens?  If so, handle that error.  If not,
> well, something else is really wrong with this uart then

It no longer happens. Johan's recent patches fixed it. Quick history:

1. Pre-kfifo, we used to output stale characters (ones that had been
dropped) in the FIFO underrun case. Nobody noticed for years.

2. After kfifo we got a hard lockup.

3. Johan's early patches to fix the hard lockup caused us to output
'\0' characters upon FIFO underrun. It was not obvious that the '\0'
characters were being output. To make it easier to debug / see, both
he and I locally made it output some other character which was more
obvious.

4. Johan fixed the FIFO underrun.

5. Johan added a patch such that if we ever get another FIFO underrun
in the future we'll output '\0' characters in the FIFO instead of
getting a hard lockup.

If we're really confident that we can't get a FIFO underun we could
just revert commit 2ac33975abda ("serial: qcom-geni: do not kill the
machine on fifo underrun") and we'll get a hard lockup if we ever
underrun. IMO, though, it's better to output _something_ in this case
to make it more obvious. If you hate this patch, though, fine. Let's
drop it and we'll hope that either we never introduce a bug causing a
FIFO underrun in the future or that someone notices the '\0'
characters.


> (why are people
> making new uarts still...)

Yeah, tell me about it. :( ...and doing a bad job of it, too...


> > NOTE: this is not an underrun in the sense that we didn't get an
> > interrupt fast enough or that we couldn't keep up. This is an underrun
> > that could only happen as a result of a bug in the driver. The driver
> > should not ever get into this situation.
>
> But obviously it has otherwise you wouldn't have seen it, right?

Right, because there was a bug.


> > I have no idea where one would document something like this. Do you
> > have any suggestions? I'm happy to add a comment in the code saying
> > that the '@' should never show up but if it does then that's a driver
> > bug.
> >
> >
> > > And shouldn't you use a memset to get the BYTES_PER_FIFO_WORD amount =
of
> > > '@' here?
> >
> > That feels like overkill and results in much less efficient code, but
> > I can change it to that if you want.
>
> Are you sure it will?  Constant memcopies should be really fast by the
> compiler these days.

Fair. If we care to keep this patch we could just change the memset to:

  memset(buf, '@', sizeof(buf));


-Doug

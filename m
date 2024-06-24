Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B768B45010
	for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262731; cv=none; b=gbjaM7oMdlso54XBelyGagkZmg8GSi4EFUVTfR3a1EEFzfNb6egiyJ+yTRMKmzWqqeZHAJlN159b8u+IuqRNdIQsOFSfScWrc77R9QC7gDZrGeBDjOLlzmuIDlj+1NR20FdSFGSzJGd5Z2qBX8x8K3gQP9hMzwjHzBGC3F4ZzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262731; c=relaxed/simple;
	bh=rc+uf24RV4wU1ZmPVkashso27WnRydS2+EKRJ3fw3uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqEeZRwvwE8e02Hd8JniHG1ZTiE26JgNZfX8nLy9s6/KM2l6pZD5g9km9TH+Yp1/Bk21ZERkP/KTC+HfUNI15L6qARYCOp9EfJpqECp4BMrj38QDjit/uoUA2U69w9RTXJp6yYAXnox9K4Ro8yr3R8bELNLboH+My1ArNdAd74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aaq6yggM; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aaq6yggM"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-440581d6a50so23145151cf.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 13:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719262728; x=1719867528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F26ETBZiZjhwFkvNSbxGcmTBqIZI6iLTpohts+kXXh4=;
        b=aaq6yggMnmm0yitIXZRAmvfEdQsYysRVY2s3RnVI9fMu0fwBpdWosKKQK7qq/ELqjL
         zO5DBFjsqL7qtIwZLmMNOaw9dNDU3vF5fzEx+O2xjYHlnSSBhVKcR8TUpvQRX7ae8dVs
         yaVfejsT7duydt/mgemvj30BrifBgaEEBjMVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719262728; x=1719867528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F26ETBZiZjhwFkvNSbxGcmTBqIZI6iLTpohts+kXXh4=;
        b=Anu/7rPGvGRGFmJeSRBtulmojLyqY1aaWvR2quTi9GOLXSRWXpiL7ypHNmuolkjgRk
         bmKJS4MpnV/6lcOtkcI4mmtugivJXaN/4YdfHpdcgP5S/XBAHIJtq4WwTDQ1lgmMvOUO
         RE5YeaCFO3irGkNELPJai1D82jgyC5A56/LtGrtqA9xRy+pWRhJchvkqpG2xbCdNU7AI
         0h7rBIyxXSnN43zWf5YoXPayD5pU4QcdroFh6JJJUFTRcfIJ0f1ulWpBDOeUqZZMFop4
         KeHaz0Eu4IlTDWENzC+8SGYnK+i9C/Igi926dDwWt7VL3/ZOhG5I27G1whsRY7cqPdWC
         LT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYl7PpBGRXPBwpLxF6DEE6J2bFLcSDB+Oqv0Kxm5myLNo292sV5Rs7IYDprKHgTLFCiMnua165Tk3e43tSH+X2/JaZpi4sFHs1trHf
X-Gm-Message-State: AOJu0YxseaFUYoxcWbShxNQRHw2Xn52Gisy1GYcQfXOSWiy/PhynejiP
	h+Ec9kk6h/5bYZ4S64FvMj8he1kfq4jVgIOxMjUWRIjbykuuNw5Kjy2qcKGTionbQqphX3o8Z2c
	=
X-Google-Smtp-Source: AGHT+IEZpJbtdJmI63b2VKtuYyE4xXrAM2cahr59ertvsIxUVzNyEVCFLtLcwSmhLgS+sS30tXeSNQ==
X-Received: by 2002:a05:622a:650:b0:441:1452:1321 with SMTP id d75a77b69052e-444d9219454mr81603801cf.23.1719262727603;
        Mon, 24 Jun 2024 13:58:47 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b36822sm46327761cf.18.2024.06.24.13.58.46
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 13:58:46 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44056f72257so27751cf.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 13:58:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWv/UMqbQucRy8wHOCVPWwYpSKYBDjdr0sn4UvKSye9KF1TWxBCBgQ4iNkKKWaHOOVx4Zm/CwnJay4gu/5RaTQeXFNAgAnHE72qdXf8
X-Received: by 2002:a05:622a:283:b0:442:1bc4:8fb2 with SMTP id
 d75a77b69052e-444f2566f1fmr919771cf.20.1719262726353; Mon, 24 Jun 2024
 13:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.7.I0f81a5baa37d368f291c96ee4830abca337e3c87@changeid> <ZnlilDj5UrvrVasv@hovoldconsulting.com>
In-Reply-To: <ZnlilDj5UrvrVasv@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 13:58:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=C+Myrb4cpGyV-J=RHn39C2aF1WT_Xt5M2vczbZ-AbA@mail.gmail.com>
Message-ID: <CAD=FV=U=C+Myrb4cpGyV-J=RHn39C2aF1WT_Xt5M2vczbZ-AbA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] serial: qcom-geni: Fix suspend while active UART xfer
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Johan Hovold <johan+linaro@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 5:12=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Jun 10, 2024 at 03:24:25PM -0700, Douglas Anderson wrote:
> > On devices using Qualcomm's GENI UART it is possible to get the UART
> > stuck such that it no longer outputs data. Specifically, logging in
> > via an agetty on the debug serial port (which was _not_ used for
> > kernel console) and running:
> >   cat /var/log/messages
> > ...and then (via an SSH session) forcing a few suspend/resume cycles
> > causes the UART to stop transmitting.
>
> An easier way to trigger this old bug is to just run a command like
> dmesg and hit ctrl-s in a serial console to stop tx. Interrupting the
> command or hitting ctrl-q to restart tx then triggers the soft lockup.
>
> > The root of the problems was with qcom_geni_serial_stop_tx_fifo()
> > which is called as part of the suspend process. Specific problems with
> > that function:
> > - When an in-progress "tx" command is cancelled it doesn't appear to
> >   fully drain the FIFO. That meant qcom_geni_serial_tx_empty()
> >   continued to report that the FIFO wasn't empty. The
> >   qcom_geni_serial_start_tx_fifo() function didn't re-enable
> >   interrupts in this case so the driver would never start transferring
> >   again.
> > - When the driver cancelled the current "tx" command but it forgot to
> >   zero out "tx_remaining". This confused logic elsewhere in the
> >   driver.
> > - From experimentation, it appears that cancelling the "tx" command
> >   could drop some of the queued up bytes.
> >
> > While qcom_geni_serial_stop_tx_fifo() could be fixed to drain the FIFO
> > and shut things down properly, stop_tx() isn't supposed to be a slow
> > function. It is run with local interrupts off and is documented to
> > stop transmitting "as soon as possible". Change the function to just
> > stop new bytes from being queued. In order to make this work, change
> > qcom_geni_serial_start_tx_fifo() to remove some conditions. It's
> > always safe to enable the watermark interrupt and the IRQ handler will
> > disable it if it's not needed.
> >
> > For system suspend the queue still needs to be drained. Failure to do
> > so means that the hardware won't provide new interrupts until a
> > "cancel" command is sent. Add draining logic (fixing the issues noted
> > above) at suspend time.
>
> So I spent the better part of the weekend looking at this driver and
> this is one of the bits I worry about with your approach as relying on
> draining anything won't work with hardware flow control.
>
> Cancelling commands can result stalled TX in a number of ways and
> there's still at least one that you don't handle. If you end up with
> data in in the FIFO, the watermark interrupt may never fire when you try
> to restart tx.

Ah, that's a good call. Right now it doesn't really happen since
people tend to hook up the debug UART without flow control lines (as
far as I've seen), but it's good to make sure it works.


> I'm leaning towards fixing the immediate hard lockup regression
> separately and then we can address the older bugs and rework driver
> without having to rush things.

Yeah, that's fair. I've responded to your patch with a
counter-proposal to fix the hard lockup regression, but I agree that
should take priority.


> I've prepared a minimal three patch series which fixes most of the
> discussed issues (hard and soft lockup and garbage characters) and that
> should be backportable as well.
>
> Currently, the diffstat is just:
>
>          drivers/tty/serial/qcom_geni_serial.c | 36 +++++++++++++++++++++=
++++-----------
>          1 file changed, 25 insertions(+), 11 deletions(-)

I'll respond more in dept to your patches, but I suspect that your
patch series won't fix the issues that N=C3=ADcolas reported [1]. I also
tested and your patch series doesn't fix the kdb issue talked about in
my patch #8. Part of my reworking of stuff also changed the way that
the console and the polling commands worked since they were pretty
broken. Your series doesn't touch them.

We'll probably need something in-between taking advantage of some of
the stuff you figured out with "cancel" but also doing a bigger rework
than you did.

[1] https://lore.kernel.org/r/46f57349-1217-4594-85b2-84fa3a365c0c@notapian=
o

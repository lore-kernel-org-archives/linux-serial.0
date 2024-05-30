Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B65117618F
	for <linux-serial@vger.kernel.org>; Thu, 30 May 2024 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717109466; cv=none; b=NgCEWJ7vl/L1QBWcn8/1x07Q+KblmaOtVKMVERFjPKZgr6FIrMugAR9OoNF/m/bGmatB2Y54ouCLSW+5Xb61bj1iq6bGt8fsyFNGcF+nWk1dKgIuX2qbWIlgTIHqHE4M79wJFtpngtYqNVFFYg7fPuoWDR8Cog0P5Ejp9b06yyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717109466; c=relaxed/simple;
	bh=33aiZOcyTr7wjCXj4MkSVQHEobDBn6/UxXRCxIgAnUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYnU3olyvA+nUOvh/spf71ZihkwuRuzOQ72nBgZw6OSiA2v64CyZ3KMzZQ/+JkCV6buqAry8H+9MamITc79uqA8XcfPoBI9kucCfoX5kOZaTSZ45IRBt5oqjlsyhVsSWbkeCo9W8O2J2rkHTnEnnFlZJqub1cCbjGsNcH97tlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jxXmydaU; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxXmydaU"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d1d78b7418so830058b6e.1
        for <linux-serial@vger.kernel.org>; Thu, 30 May 2024 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717109462; x=1717714262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33aiZOcyTr7wjCXj4MkSVQHEobDBn6/UxXRCxIgAnUo=;
        b=jxXmydaUgpRYFtRRbvzuCOTGgyIua5SvfQ0imqM/BXOlP6/GeM9KZ65IZsODoYRoRI
         /LFv0+rFLzHP8DK9kq8Eba7u6Mcb5mg+wIay8WFimV1/Y2KGkAe5c7MSSURDn9IPOIFq
         SxO0iehbyNFTvw85wSPTkn1D2mdCBJvtp1qe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717109462; x=1717714262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33aiZOcyTr7wjCXj4MkSVQHEobDBn6/UxXRCxIgAnUo=;
        b=Ds4KyykXJ7gZxWs694LlIUonpDJtACTTWLBi3Ksf7K6BYwVFxkyUVoF+yH+yYg6738
         4NsaHPKPZMDZp4xZEuNOHk+BRqVMyos+Ru5byslL15cgQQgHH/EweTwwvfiaiZczsyV/
         ea0NlUbNBZNK/h+M3xIjhgYwhQPOY86w3XyRfqbq3qVNAN/K1qcHSk4q8AYXaGoUzcgT
         hU0ZKYWKpouP98oLg8CEBmItbca+G/kTspJpzxp6xwXN6soTHmufQWP15vC/3I6S/qA+
         x4qNh+2BZQzjFQkmRSvRY8UUBSzX3jJilTZg8LqS7igv395wsRg8iB8HpKeeTCpkm6YG
         EMGg==
X-Forwarded-Encrypted: i=1; AJvYcCWgEvX4ycXCQGpucZAN0p6An9iLccVUE01SDYF+qQg58plTtSQU9giquve9rxAx925hQbwvVpSyAQURPiOr5uLcvkCvI3KZCr4oqi4w
X-Gm-Message-State: AOJu0YzfQx5haHxERno8ypn5ew1bSyNWs/Q/EW5SbpoxhsJH8Sj9CO45
	/QocsIWENiTVaPzb15/27hfezeOh2W3+Mg8fJNcU8VlhHX2fdw820epJOqwrFRWT0lbvHcqSzDK
	Apg==
X-Google-Smtp-Source: AGHT+IEBXeDiVDIOEX5+u07sQjm4r9dfxvoxVDzvjLkElfIkh4hUx5akOE+1FXXCVevE5wNGFXdjZA==
X-Received: by 2002:a05:6808:1589:b0:3c9:9294:8d8a with SMTP id 5614622812f47-3d1e35c14f2mr147303b6e.36.1717109461575;
        Thu, 30 May 2024 15:51:01 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a74d6fesm2247236d6.55.2024.05.30.15.50.59
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 15:51:00 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43dfe020675so121221cf.0
        for <linux-serial@vger.kernel.org>; Thu, 30 May 2024 15:50:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw2QLkEzMH/8dXuEg1aqKPDSpUj7WG6ML5OTPzEMXArmAbsHClURyAlbUKkpvdX/vYSCneDHSSma8KGHSyJJSATyB6Yl5wT8HvgOV7
X-Received: by 2002:a05:622a:1b03:b0:43f:db90:2557 with SMTP id
 d75a77b69052e-43ff4f8d821mr207311cf.21.1717109458702; Thu, 30 May 2024
 15:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523232216.3148367-1-dianders@chromium.org>
 <20240523162207.2.I0f81a5baa37d368f291c96ee4830abca337e3c87@changeid>
 <CAE-0n53F3Xg2vOdgy-Vpjw4Kirdgi6B+BnO51fd6qOtDu0iXCg@mail.gmail.com> <CAD=FV=VeKiiHeOwmt_6uf7OSoGvOJLrLLMULVERubU1ut-=WqQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VeKiiHeOwmt_6uf7OSoGvOJLrLLMULVERubU1ut-=WqQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 May 2024 15:50:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJ6oyhbiY89MDbJkq1q1UDwneJ9p+9PVY6ZHdAg==rng@mail.gmail.com>
Message-ID: <CAD=FV=WJ6oyhbiY89MDbJkq1q1UDwneJ9p+9PVY6ZHdAg==rng@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: qcom-geni: Fix qcom_geni_serial_stop_tx_fifo()
 while xfer
To: Stephen Boyd <swboyd@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Ogness <john.ogness@linutronix.de>, 
	Tony Lindgren <tony@atomide.com>, linux-arm-msm@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 24, 2024 at 5:17=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> 1. It appears that M_GP_LENGTH can still advance after the FIFO
> becomes 0, which is extra proof that the transfer is still happening
> even though the FIFO says it's done. Presumably we could keep track of
> how many bytes we have enqueued into the FIFO for this command and
> then compare. As I was trying to do this, though, I noticed another
> option...
>
> 2. It appears that instead of "cancelling" the current command we can
> just issue a new 0-byte transfer and wait for the 0-byte transfer to
> be "done". This causes geni to give us back a "M_CMD_OVERRUN"
> interrupt, but that's fine and we can ignore it. That interrupt just
> says "hey, you gave me a command before the previous one was done" but
> it does seem to properly accept the new command and it doesn't drop
> any bytes.
>
> ...it turns out that we (apparently) already have been using option #2
> to interrupt a transfer without dropping bytes. When the UART is
> shared between an agetty and the kernel console this happens all the
> time. In qcom_geni_serial_console_write() we'll issue a new command
> before finishing a current one and then re-issue the current command
> with any remaining bytes. So not only should this be safe but it's
> already tested to work.
>
> I'll need to spend a little more time on this to really confirm it
> works as I expect and I'll send up a v2 using approach #2.

Just to connect the dots more, I did more testing and option #2
totally didn't work. The console/kdb stuff was working mostly through
ugly fragile hacks. Polling GP_LENGTH seemed like the only option,
though when I dug more I found that this wasn't the right place to do
it anyway...


> Also note that while spending more time on this I found _yet another_
> bug, this one more serious. My original testing was done on kernel 6.6
> (with stable backports) and I just did confirmation on mainline.
> That's why I didn't see this new bug originally. ...but this time I
> spent more time testing on mainline. It turns out that the recent
> patches for kfifo on mainline have badly broken geni serial.
> Specifically, if you just do "cat /var/log/messages" and then "Ctrl-C"
> the machine will hard lockup! Yikes! This is yet another side effect
> of the geni "packet"-based protocol biting us (so related to the
> problems in ${SUBJECT}, but not identical). Whenever we setup a TX
> transfer we set it up for the number of bytes in the queue at the
> time. If that number goes down then we're in trouble. Specifically, it
> can be noted that:
> * When we start transmitting we look at the current queue size, setup
> a transfer, and store "tx_remaining".
> * Whenever there's space in the FIFO we add bytes and remove them from
> the queue and "tx_remaining".
> * We don't ever expect bytes to disappear from the queue. I think in
> the old code if this happened we're just transfer some bogus bytes.
> Now we'll loop in qcom_geni_serial_send_chunk_fifo() because
> uart_fifo_out() will keep returning 0.
>
> I'll try to take a gander at that, too...

I spent _far_ too long poking at this and I've finally come up with a
v2 that _I think_ fixes everything. For reference:

https://lore.kernel.org/r/20240530224603.730042-1-dianders@chromium.org

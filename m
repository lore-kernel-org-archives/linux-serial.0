Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8949656
	for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264142; cv=none; b=evhqx/wIdlhclXIykfwUkvLpGwivOzrzefHkePHvJyxGV+89XEN2EYs+dhJLd4kXoNbo/fjExY+yRlFXKv+8JdROCnf00VwWdYtv15qdcQlvRChLUzDzn2++O5zxHK6wWl8TGCbgLi+qKpVRFfZLaoAOWtV7ZXhf6Zow84cBL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264142; c=relaxed/simple;
	bh=1aS1C8+rNiEE9y97Tf7/4pGGQHLNNIZeCB3/TynbVHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d09BW9aicOrnx6m4OMmmk6mmfZxTv4u8YcqeiuoT35fntgcHyhcpf4qmNFhVWaS0CdbVYwrhAHelVKxmEQ3b6if2me7rsrYh5oMOXBj6kaivLTgAPOH0kRl66uP+Puj+yJbPAxBjoO64o1hYsf4/gt3vQ5knkcHi56o086msKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bXEu0L6l; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bXEu0L6l"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-440655e64bdso21666701cf.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 14:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719264140; x=1719868940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/CQWIetOrwwmsDk4Xx3Bzc7g2Sp+y6oh+LBYo/o6no=;
        b=bXEu0L6lCT4juBDnXJkPFFZEuZc9PmJelRSuIuIaTonrCW2FzISn9qOv53ZuJeBfUo
         jHHbdXgqTeaEisOfiZCzh2eEUoSyy0/XLnY8dBi7uZPEeKZ266WrXEtv+nDbWdsY7QN0
         XOy5wFkHDoB4TQRCxXi7TH0Is2yJ7X9FIXBzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719264140; x=1719868940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/CQWIetOrwwmsDk4Xx3Bzc7g2Sp+y6oh+LBYo/o6no=;
        b=BwI8UxXfleC0sXMiXicTJizDO1D3J/M0tR1DbMcH5M140hJ7pe6g/cD4jFdU7hvvGe
         Pa1qxc11STptIkPBfQxJDpeMykLB4Pa6RA4Guudz8AagrEc12bDEze9yjmMVGjmAE3D9
         6JJv7c8KZFlHdvxP1tGkyoYE230SfTujTB/fhwySzFKEKxk2Or4kvxbzeIUYzjnQbw9X
         eh/4DVeaysLpkFC8WY7Bq99Y3mmEDcqm++XSqhTJ8zLa0cd/0Vww7xSS0eymywgp9ZeV
         Y6itZrBg6HwqI+kc+hcVSNnd0n1AA7eyqk+mNijGcPavmvLJOTDWReNhGl6axPVaE80x
         U7oA==
X-Forwarded-Encrypted: i=1; AJvYcCUVQsD/zygQ4LODmHaqfHeWoKAAGOuE2X/BnwdcEvUdXfMaNAsU+qGqtGGMdK4+dt5daouz8gvAeMQp9dqB39hqlfiOYSvt5jQ1AGxk
X-Gm-Message-State: AOJu0Yw0DZxYnKUgcKJebJWVQd0tR7SW3iiNjrpEJT5dxgdg8gDsAO6+
	kXWI9H2K6dqJ4BdVI2p7mrEXiDB3PQeMM38W+mxuKw//Ar4/f5HWvzs7PfLyUVwQPEnJCPqEOWo
	=
X-Google-Smtp-Source: AGHT+IFsl3dzYUl1H8m4amh5+m03jUZF8yeHkQQb9ZYpJiOVNrlMQxJzeBgBjr62Gd4BAl0eOcWDFg==
X-Received: by 2002:a05:622a:4d3:b0:43a:dac9:d9b7 with SMTP id d75a77b69052e-444d921bfa7mr51736051cf.39.1719264139608;
        Mon, 24 Jun 2024 14:22:19 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444f02d909asm5288851cf.5.2024.06.24.14.22.19
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 14:22:19 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44056f72257so35611cf.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 14:22:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUoacMnfECC8jYD20qmdRBC0O+1rXDIU4amBaXpmAUV3xJqRbjKTqY2DVHwLzXZ5PFOZrLjj6kdMBEszeqgcQur9Yyj3Lupysm37AJ
X-Received: by 2002:a05:622a:1981:b0:441:4920:1fc4 with SMTP id
 d75a77b69052e-444f256621dmr960771cf.28.1719263719282; Mon, 24 Jun 2024
 14:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.8.I1af05e555c42a9c98435bb7aee0ee60e3dcd015e@changeid> <Znlp1_F1u-70D3QQ@hovoldconsulting.com>
In-Reply-To: <Znlp1_F1u-70D3QQ@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 14:15:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XmuKUKvCq7gG+wM-jAAgHLHnYw4NteFEKz5Fmczd=U7g@mail.gmail.com>
Message-ID: <CAD=FV=XmuKUKvCq7gG+wM-jAAgHLHnYw4NteFEKz5Fmczd=U7g@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] serial: qcom-geni: Rework TX in FIFO mode to fix hangs/lockups
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
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 5:43=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Jun 10, 2024 at 03:24:26PM -0700, Douglas Anderson wrote:
> > The fact that the Qualcomm GENI hardware interface is based around
> > "packets" is really awkward to fit into Linux's UART design.
> > Specifically, in order to send bytes you need to start up a new
> > "command" saying how many bytes you want to send and then you need to
> > send all those bytes. Once you've committed to sending that number of
> > bytes it's very awkward to change your mind and send fewer, especially
> > if you want to do so without dropping bytes on the ground.
> >
> > There may be a few cases where you might want to send fewer bytes than
> > you originally expected:
> > 1. You might want to interrupt the transfer with something higher
> >    priority, like the kernel console or kdb.
> > 2. You might want to enter system suspend.
> > 3. The user might have killed the program that had queued bytes for
> >    sending over the UART.
> >
> > Despite this awkwardness the Linux driver has still tried to send
> > bytes using large transfers. Whenever the driver started a new
> > transfer it would look at the number of bytes in the OS's queue and
> > start a transfer for that many. The idea of using larger transfers is
> > that it should be more efficient. When you're in the middle of a large
> > transfer you can get interrupted when the hardware FIFO is close to
> > empty and add more bytes in. Whenever you get to the end of a transfer
> > you have to wait until the transfer is totally done before you can add
> > more bytes and, depending on interrupt latency, that can cause the
> > UART to idle a bit.
>
> As I mentioned last week, the slowdown from this is quite noticeable
> (e.g. 25% slowdown at @115200), but this may be the price we need to pay
> for correctness, at least temporarily.
>
> An alternative might be to switch to using a 16 byte fifo. This should
> reduce console latency even further, and may be able avoid the idling
> UART penalty by continuing to use the watermark interrupt for refilling
> the FIFO.

I'm a bit confused. Right now we're using (effectively) a 64-byte
FIFO. The FIFO is 16-words deep and we have 4 bytes per word. ...so
I'm not sure what you mean by switching to a 16-byte FIFO. Do you mean
to make less use of the FIFO, or something else?

Overall the big problem I found in all my testing was that I needed to
wait for a "command done" before kicking off a new command. When the
"command done" arrives then the UART has stopped transmitting and
you've got to suffer an interrupt latency before you can start
transferring again. Essentially:

1. Pick a transfer size.
2. You can keep sending bytes / using the FIFO efficiently as long as
there are still bytes left in the transfer.
3. When you get to the end of the transfer, you have to wait for the
UART to stop, report that it's done, and then suffer an interrupt
latency to start a new transfer.

So to be efficient you want to pick a big transfer size but if there's
any chance that you might not need to transfer that many bytes then
you need to figure out what to do. If you can handle that properly
then that's great. If not then we have to make sure we never kick off
a transfer that we might not finish.

I'd also mention that, as talked about in my response to your other
patch [1], I'm not seeing a 25% slowdown. I tested both with my simple
proposal and with this whole series applied and my slowdown is less
than 2%. I guess there must be something different with your setup?
Trying to think about what kind of slowdown would be reasonable for my
patch series at 115200:

a) We send 64 bytes efficiently, which takes 5.6ms (64 * 1000 / 11520)

b) We stop transferring and wait for an interrupt.

c) We start transferring 64 bytes again.

Let's say that your interrupt latency is 1 ms, which would be really
terrible. In that case you'll essentially transfer 64 bytes in 6.6ms
instead of 5.6 ms, right? That would be an 18% hit. Let's imagine
something more sensible and say that most of the time you can handle
an interrupt in 100 ms. That would be about a 1.7% slowdown, which
actually matches what I was seeing. For reference, even an old arm32
rk3288-veyron device I worked with years ago could usually handle
interrupts in ~100-200 ms since dwc2 needs you to handle at least one
(sometimes more) interrupt per USB uFrame (250ms).

...so I'm confused about where your 25% number is coming from...


[1] https://lore.kernel.org/r/CAD=3DFV=3DUwyzA614tDoq7BntW1DWmic=3DDOszr+iR=
JVafVEYrXhpw@mail.gmail.com

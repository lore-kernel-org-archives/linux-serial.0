Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507845010
	for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261941; cv=none; b=DoOQIJH6+RIw9jNsyAx2jsPXvAhgbDRLyoSQAOo75Hm0eVjXjzOZWuQrwor3N9PCm0l7tU1bfLOQVMRqJ+8knnaOO74I9nM2BMMOSiSV7hGBPizyNB+JdkFPraw+qHkRH8y6Z5bEDabPNEjPa1D4rX5aqMEa2UBJaNhWjN715MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261941; c=relaxed/simple;
	bh=Ofe5Udbju62wIPycBMd9BKkYVB1oN6NMkyEzC9dWzk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6RQNKGdSXul8r8FMtmvoEIj6Jio0avrFkrniLJlhq8fAJMIxjUdBFFsq6cy+OU0DV9Okfa+VPCAMTyk1cIJZNCsK1QnF96O/RAGUS2l3Ho8rhHuRMfUnVwN9SkNHxfY+xBbuzloX6YE71E2vBXTN6RkXmw0S9aj6115nbdiEIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SjK5BkHH; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SjK5BkHH"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b9776123a3so2162406eaf.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719261937; x=1719866737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTharbi6ZPnC1Zed84UrT9QU8P9auaSnZ5aSyQ0TZ6o=;
        b=SjK5BkHHc65brFskRSyt+n4DIicZp+KlRY09/CNGwHjk5LZa1ECNHlkXUgfdtJJRur
         isdTUyRJY3bVImH/SB3M2TP2RhoDwlnSO4Y5zuRfGr6xPz2jGem2eDPQ6limxUT3PUdN
         rVP98scW+aB01svD7dQeazDYhfawjQYd8qHM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261937; x=1719866737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTharbi6ZPnC1Zed84UrT9QU8P9auaSnZ5aSyQ0TZ6o=;
        b=BDZYUbanRaByum9YC+7fi4syxkFIJGbESOIQWzV8xpe6mCgkfW/CkNukBZGYMrAtXz
         aDw42s/B/UY3a/uogLJXsaGVka1fyLpXwrV2FgkP/FhHt/q3d0Go/3lELvI4TStGWNQE
         gvwroqNMWorCqzFHQJMhoagjBgdWbHhDvIKp1HT/Xxpz3TK/0UHd8Je/W7DNIIC4UtZh
         0sA10R+QUZdoMg+Ut0QQA2GYIGzFotIt9hmuljDKN7Rj5QX61WSSZMXv48EydRiY0zoo
         TT5qmcQjzeVMeVE6iWdVoPJj39Dd9zVrfaE12JGilUWJdiHsadsDYe6m5FutCKLPBusV
         A80Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGPxr/dJVkMVjr4iG46VY6Te6j4WIWayGsp5Af7ZzXsLZrNWdpiZEQZB4YcpHQ7+c/SkwTZZmQRd88sl79qFlsOIkvcsmdWEKLB0LT
X-Gm-Message-State: AOJu0Ywwn6BemYxEBSrPboIsrYoybnPCdtY0CBgRiCcZRmeVKZXNArNj
	4yLj3LYTtVCK6T1OD6YjBbQgZZ05zb6uUlP9sodpw3wckSF2Iev6/pn9+LftehQXWWJL59kcIIY
	=
X-Google-Smtp-Source: AGHT+IGiXMjXQ5OjRMhv4NXy2Mj5zeAdARbuZPR5ovun509Qg60VcPYXq6rdkuTYLn6uKj/Uuy/lQw==
X-Received: by 2002:a05:6358:e485:b0:19f:4be7:435a with SMTP id e5c5f4694b2df-1a23fe0f613mr679076855d.25.1719261936853;
        Mon, 24 Jun 2024 13:45:36 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed3ffc5sm37498456d6.49.2024.06.24.13.45.35
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 13:45:36 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-443586c2091so27661cf.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 13:45:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkLhbhwW3+vRz5h35JwYD+u1dZLagjpmicUZQERHSvs0wY/xPhoSJWXObqfy5+6ip1P5uh3GQ2NiDfYgRpw77OiLCF0QZR0NEa4ax8
X-Received: by 2002:ac8:5f0c:0:b0:43e:295:f160 with SMTP id
 d75a77b69052e-444f2520a22mr883301cf.24.1719261935354; Mon, 24 Jun 2024
 13:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org>
 <20240624133135.7445-2-johan+linaro@kernel.org> <CAD=FV=VZXnnbwTNc6dSqZvyCUc0=Wjg9mvBYsA1FJK3xR6bDEg@mail.gmail.com>
In-Reply-To: <CAD=FV=VZXnnbwTNc6dSqZvyCUc0=Wjg9mvBYsA1FJK3xR6bDEg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 13:45:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UwyzA614tDoq7BntW1DWmic=DOszr+iRJVafVEYrXhpw@mail.gmail.com>
Message-ID: <CAD=FV=UwyzA614tDoq7BntW1DWmic=DOszr+iRJVafVEYrXhpw@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: qcom-geni: fix hard lockup on buffer flush
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 10:39=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel=
.org> wrote:
> >
> > The Qualcomm GENI serial driver does not handle buffer flushing and use=
d
> > to print garbage characters when the circular buffer was cleared. Since
> > commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo") this
> > instead results in a lockup due to qcom_geni_serial_send_chunk_fifo()
> > spinning indefinitely in the interrupt handler.
> >
> > This is easily triggered by interrupting a command such as dmesg in a
> > serial console but can also happen when stopping a serial getty on
> > reboot.
> >
> > Fix the immediate issue by printing NUL characters until the current TX
> > command has been completed.
> >
> > Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> > Reported-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I don't love this, though it's better than a hard lockup. I will note
> that it doesn't exactly restore the old behavior which would have
> (most likely) continued to output data that had previously been in the
> FIFO but that had been cancelled.
>
> ...actually, if we're looking for a short term fix that mimics the old
> behavior more closely, what would you think about having a
> driver-local buffer that we fill when we kick off the transfer. Then
> the data can't go away from underneath us. It's an extra copy, but
> it's just a memory-to-memory copy which is much faster than the MMIO
> copy we'll eventually need to do anyway... This local buffer would
> essentially act as a larger FIFO.
>
> You could choose the local buffer size to balance being able to cancel
> quickly vs. using the FIFO efficiently.

Also: if we're looking at quick/easy to land and just fix the hard
lockup, I'd vote for this (I can send a real patch, though I'm about
to go on vacation):

--

@@ -904,8 +904,8 @@ static void qcom_geni_serial_handle_tx_fifo(struct
uart_port *uport,
                goto out_write_wakeup;

        if (!port->tx_remaining) {
-               qcom_geni_serial_setup_tx(uport, pending);
-               port->tx_remaining =3D pending;
+               port->tx_remaining =3D min(avail, pending);
+               qcom_geni_serial_setup_tx(uport, port->tx_remaining);

                irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
                if (!(irq_en & M_TX_FIFO_WATERMARK_EN))

--

That will fix the hard lockup, is short and sweet, and also doesn't
end up outputting NUL bytes.

I measured time with that. I've been testing with a file I created
called "alphabet.txt" that just contains the letters A-Z repeated 3
times followed by a "\n", over and over again. I think gmail will kill
me with word wrapping, but basically:

ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVW=
XYZ
ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVW=
XYZ
ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVW=
XYZ
ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVW=
XYZ
...
...

FWIW:

head -200 /var/alphabet.txt  | wc
    200     200   15800

Before my patch I ran `time head -200 /var/alphabet.txt` and I got:

real    0m1.386s

After my patch I ran the same thing and got:

real    0m1.409s

So it's slower, but that's not 25% slower. I get 1.7% slower:

In [6]: (1.409 - 1.386) / 1.386 * 100
Out[6]: 1.659451659451669

IMO that seems like a fine slowdown in order to avoid printing NUL bytes.

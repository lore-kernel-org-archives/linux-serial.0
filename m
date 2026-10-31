Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793469666;
	b=itiAowj4wmEFv5M4FWOB0jJIAIEsQNQsylNFZXKiUgaya102a9OzH81orEP7jmir7U64
	 slkRHWK3bJGYAS2CRDFtysYy108vmAvo32yxfKDBvejj7bIxVvbAz+mn7d3saaUJpibUP
	 H4UWJf1FKOmPW2FxcDZEO50fafJNGbfD1CeCcI+wD6LoCAU/OicEaGQxjiUgJKsoadIca
	 /GFF4nje4Bi/rlk3EJgegxsqU+xE5W4tXtb2/TD8q63WfcrUGK5L8O4ADn4gCo96e9nvy
	 H0erPzXg3J6HzmzzKtk02OM0i7rSnNQAeJYTEN90hYvxj6yRA3Zn01fzks2LpCM1DrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ztiV5c0DfuFx8uDKCLiUp5o+ivOB8cWRN0pJNXnNfZU=;
	b=M9HW/tsiAL6feUOEJbmNQG2kLAJkgmyfCeXk6JyebLwOVXCjiaNi0Rs7yLhlEbzpnjKy
	 2uJd7wWV8Exf+FRxzA6UGDx25QVXvsXnPvF3E0A+3tIv2URgM4VNqsD725rcxRAkXrQ9Z
	 TBlGUWork2oRG7G8aT03oo9ZBDh/Kb2GTO6QayVeKxzVJsng+c2guAt82NahihPomIAp+
	 Va9Uj37rOJCs9SJRkslC8e5ixDJ/oPwMzUkhLUQ2CGoZrSykJqKmQsZi1+/7Li/0qyZoJ
	 OuRUa5ZeSa5/2gKNeBUcdl81I9Bml9AZ2AiD4jQTsdcs08clEwWaWUR4jAA24CtXyUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fcezRNle;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595B606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 18:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9595B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fcezRNle
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-99071945aa7so1049742241.3
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 11:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793469664; cv=none;
        d=google.com; s=arc-20260327;
        b=okItQN5DcNGHCZ6ox9/IEq/489GKx2Pkn6WbntL2FeENJ7xtOqlFESHY2Yn8BBM/wM
         0dWQcIiz03Pem4A2CsuzbaIAVkfCl4oGTyLh71/0mrjVtrBLRXZMhsv31YiPr+p5wLqI
         tDFy/YpEYS0ilTbTCe/CE0lMS/nk5Xz2h5Atf5szBQY8plyZN6iMqoB6zlBQ+fXu6Dpd
         QGt3chEZ5tsVgOgiT+VPBfVkhIbXp8Q29ePpnrr6FgyTldw2zk/4jCNfe8Dt2eGcutkd
         QC5x5V4ICeDpPTilLsaO3FOs2mfVCmDxGGXsK//7AWmWEZaNXQWLJobot+8T+nhBLUzX
         cv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ztiV5c0DfuFx8uDKCLiUp5o+ivOB8cWRN0pJNXnNfZU=;
        fh=hXsec7dEqvVM2NhL7KTiIXfplzdLmN+YfBW+TRKhjS4=;
        b=PA+MQsn5K4iHoigAPawJ6V4zZTH8NlaIOQB93HBVwgKv2/monaJmIZx1nGNnQjx+sR
         71Ph9uSHZTtxiWxiEgjdLGgp5AUJ5snLu7f2nE95eN63NxA4XyijeVfszisNoY44zn7w
         KWcuvOUBepemU+YeXgCXHC3vG0ILJj1hYvZrGfyjQm+n3yx7/BtEqQkuTneFXnvEEpfG
         JCsa/+aUzCYaJTq50wK7aogLL700lgSFN1QntJK2Ov/l2btD7Y2muuE3w2S0QGyGiCel
         7kN8XCuU6Hdq5B39Lyrq6al4qgooky4ZrhukQxue5R5tQKY4S8rcPlaQLSiETT7EgtX2
         8KEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793469664; x=1794074464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ztiV5c0DfuFx8uDKCLiUp5o+ivOB8cWRN0pJNXnNfZU=;
        b=fcezRNleFwQLsQP0vHkl4QkmgRVIOhYlQ7PHKc6NtKPoclI8wrL3lbtK8q8YsVu+MC
         vyj0HJ79Io7x/KYMgl9+6wrVW2f/Wvcgz1UCQ9400rBT5HlUAfrAJxgeAiYbBO93kvYZ
         Tez4bl3MQwACTSDfKHYvuUGwS0DYcIynYEn94fuhXwiitJS/0WDhAlCPHZspbagSU8s+
         AFTK+kq9LcJ8qJXMe9uO8kPNPyXWoZlfKIoSPJsxkbo0APhaBABxsN3piKhSrKEnEqaE
         /FKpso3T3KhCH6huO/pti1AtLT8rbsWnrMibVjnCT0omPdZWiy0AsZKmA2GUFsBsWc7V
         i1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793469664; x=1794074464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ztiV5c0DfuFx8uDKCLiUp5o+ivOB8cWRN0pJNXnNfZU=;
        b=n+IbRqC+MNx8Gsm4QJIWzAzBf2/7aB/1Bq2BaHwu28/f1rEZEmmnMirb/KMkenkxHx
         8vtNV1G7+8saRFHhZxesXYR5PGbR72OJze1xJsyH2MdHZL0mLiFEPeRjTv6F9/bjZSOx
         xaG+Kdt0/RzdzN24jlRru/rQY7ONoMZspMZk21LGX57BFkxGe3W0Zv9mRaaT64gow1zm
         9EbdpkrvA9o4Q1cyQJqxeMWo4hKZ/spdg+DsRPcw8SV1UN+q3jgCSxNcTjxjiuV+5noU
         GkLhvCT/O9V4i7spdW9w4VtSmfYLz6/NBPaVl4l2EB14u+Ml1RO4HMDQXc1gtWcVBenm
         MYJA==
X-Forwarded-Encrypted: i=1; AKwUvBxBvw4/t3KI4WJZdUg0ecygnzOG8eKUElLOFnwLjq5BvslHnyTjEwEizlV1BTBY1NneucO7CGp2tAyvbKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+tganksYwgYFe7VSEzVesAKIP6X+gXQwETy2geJgwivCHlK2i
	iTkKnDmR2bJuE7FBLD91Uuv7YbHJrKiiKcaqM1IHYRb61VghlLDgkIh5AKzmLfAuzsyo+517gWH
	ycVQ4JUoUgW3yss+5qrBJFRgvADFLR1E=
X-Gm-Gg: AYBFou3W3pa3DjaOdD0gMsgLGs8eSlwIC5PcZ9l939aeGz5mz+LrhGWRCUPCOWW1Sq6
	enpRxnP1sfOGiMgI+xwISHW1cZi80oEN31aCjGH/kRcBzt+leYhXPcswfbK2h0caZZw5R5+Y3vj
	ULs/WWO6JMASptsr8IZAOdEmZ1iO0V+ghA+VzKqa1nRTqlXTtNNEZ0YNIm/1XegakE169QC5wc8
	Ob6ISZLvUBPXD/1ytlaqm6twi8e6o9iPvVw1X2GemjCIAAT02S8np9v6obK0LIAassuYjeQ63x7
	dgZvVjcQtt/Duyxd5DQBSGdtDdjaKGcvTUyGmH6XHNDiH/+InLC1MKjVTdUhh7yagsnmNKdGsvK
	L5Ro/gtpNSwUMRaRJqOfcxMoywlgiMsokEQtwkwD0+i1S+lfai2gbRmXvCfMOvkrdalvbEAP0Oq
	I49r48Zhai90A3sJGJ+ssWhjkRPW7rbMHUe3rG8DqkZExzpT4XFLsfo6RZ/msNt0p4fuxCNZ5lC
	eYkL5Lr4eIJJ3/07wX1b7TgnzTw2w==
X-Received: by 2002:a05:6102:c4f:b0:7cc:3eb0:6ece with SMTP id
 ada2fe7eead31-7d072d53fa3mr3076240137.33.1793469664332; Sat, 31 Oct 2026
 11:01:04 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
 <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local> <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
 <auRl9ztbav4nHi7U@ashevche-desk.local> <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
 <auTZtteCFnuoMD3p@ashevche-desk.local> <CADvTj4rXXAEnTyu_AzpF41a2YSHHG1ANozCUSePBoH3QZYbBQg@mail.gmail.com>
 <auWqUIBUs0_7bnGU@ashevche-desk.local>
In-Reply-To: <auWqUIBUs0_7bnGU@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 31 Oct 2026 12:00:51 -0600
X-Gm-Features: AclHuK8CrIpMhatn91Js9Zu09dawz3gtrtGWd_ctbAp5jI12V9IMTbfHBekYVDc
Message-ID: <CADvTj4rej-zOtwwN8CtchQ8A9L-fdG0dL_XwBb0zTFv5m=+j4Q@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when
 termination fails
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 2:44=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 30, 2026 at 12:08:52PM -0600, James Hilliard wrote:
> > On Fri, Oct 30, 2026 at 11:54=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Oct 30, 2026 at 11:09:53AM -0600, James Hilliard wrote:
> > > > On Fri, Oct 30, 2026 at 3:40=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Oct 29, 2026 at 11:19:59AM -0600, James Hilliard wrote:
> > > > > > On Thu, Oct 29, 2026 at 8:24=E2=80=AFAM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrot=
e:
>
> ...
>
> > > > > > > > +     while (rx_ret || tx_ret) {
> > > > > > > > +             dev_err_ratelimited(p->port.dev,
> > > > > > > > +                                 "DMA termination failed: =
RX %d, TX %d; retrying\n",
> > > > > > > > +                                 rx_ret, tx_ret);
> > > > > > >
> > > > > > > > +             msleep(100);
> > > > > > >
> > > > > > > Huh?!
> > > > > > >
> > > > > > > > +             if (rx_ret)
> > > > > > > > +                     rx_ret =3D dmaengine_terminate_sync(d=
ma->rxchan);
> > > > > > > > +             if (tx_ret)
> > > > > > > > +                     tx_ret =3D dmaengine_terminate_sync(d=
ma->txchan);
> > > > > > > > +     }
> > > > > > >
> > > > > > > This is unacceptable. Sleeping is okay, but value should real=
ly match the
> > > > > > > baudspeed and other parameters of the transfer.
> > > > > >
> > > > > > This sleep is backoff after dmaengine_terminate_sync() has retu=
rned
> > > > > > an error, rather than an estimate of UART transmission time. Ea=
ch
> > > > > > retry asks the provider to stop the channel again; elapsed time=
 is
> > > > > > never treated as evidence that the resources are safe to free.
> > > > > >
> > > > > > The particular 100 ms interval has no hardware-derived justific=
ation.
> > > > > > However, I don't yet see a sound way to derive the retry cadenc=
e from
> > > > > > baud rate either. RX can be waiting for input, TX can be held b=
y flow
> > > > > > control, and callback retirement is a separate requirement from
> > > > > > moving bytes through the UART.
> > > > > >
> > > > > > Do you have a particular provider failure mode in mind where re=
trying
> > > > > > termination should follow the serial transfer timing? I'd like =
to
> > > > > > base the interval on the condition that can make termination su=
cceed,
> > > > > > rather than substitute a wire-time estimate for an arbitrary de=
lay.
> > > > >
> > > > > Termination of DMA sometimes require to clean up internal FIFOs a=
nd other state
> > > > > machines. That's what happens on HW side. In the software waiting=
 for too much
> > > > > may lead to the very big undesired latencies. The value of 100ms =
sounds insane
> > > > > to me for the HSUART cases (megabaud range of speed). Also note, =
not every PCB
> > > > > design uses HW flow control, so this may be even worse for them.
> > > >
> > > > The 100 ms interval can add unnecessary teardown latency if a faile=
d
> > > > termination becomes retryable much sooner. There is no hardware-der=
ived
> > > > justification for that particular value.
> > > >
> > > > The FIFO/state-machine draining is part of the provider's stop sequ=
ence.
> > > > For example, DW performs its FIFO-empty polling inside
> > > > dwc_terminate_all(). If termination succeeds, this patch proceeds w=
ithout
> > > > the retry sleep, regardless of baud rate. The sleep is only reached
> > > > after an error during DMA release, not during normal RX delivery.
> > > >
> > > > Baud rate can influence how quickly a transmit FIFO drains, even wi=
thout
> > > > flow control. However, the termination error does not tell 8250 whe=
ther
> > > > that drain is still progressing, how much remains, or whether the
> > > > controller needs a different recovery operation. That distinction m=
atters
> > > > when choosing a retry interval: a shorter interval reduces the adde=
d
> > > > latency, but does not establish that retrying can recover the chann=
el.
> > > >
> > > > There is also a specific API detail here: dmaengine_terminate_sync(=
)
> > > > returns immediately if device_terminate_all() fails, without reachi=
ng
> > > > dmaengine_synchronize(). Consequently, an error leaves callback dra=
ining
> > > > unconfirmed as well. The retry cadence can change, but resource rel=
ease
> > > > still requires successful termination and synchronization.
> > >
> > > Most likely this is AI slop. I can't see the justification for 100ms.
> > > Can you explain that?
> >
> > 100 ms was an arbitrary backoff to avoid a tight retry loop if
> > termination keeps failing. It was not derived from the baud rate,
> > FIFO depth, or a DMA provider's recovery timing.
> >
> > That motivation explains sleeping between retries, but not choosing
> > 100 ms. I don't have evidence supporting that particular interval.
>
> Yep. And that's what my point is about. Any big sleeps has to be explaine=
d
> and justified.

100 ms was an arbitrary backoff for what I expected to be a rarely
exercised termination-error path. It avoids a tight retry loop, but
neither that nor the expected rarity justifies the particular value.
Successful termination on the first attempt adds no retry delay.

The constraint is that failed termination does not establish that DMA
and its callbacks have stopped. Returning from the current shutdown path
would let the serial core free the TX buffer while DMA might still own
it. Retrying preserves that ownership, but a permanently failing provider
can block shutdown indefinitely.

Would you suggest a different approach to handling termination failure
here, or a better basis for choosing the retry interval?

>
> > > > > > Regardless of the retry interval, shutdown cannot release the b=
uffers
> > > > > > until the provider establishes that DMA and its callbacks have =
stopped.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

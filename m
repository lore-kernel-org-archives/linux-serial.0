Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033169;
	b=xftHCEYNUKu97eIjh58GA9mc5KGr2ZRSzdmt9uQZvORFnX+p7PzLxYJZX/Cu9uKIsIUe
	 v/HnRPH7j/c03ZO4NLjuxukCMk/SpBwqbKcBl6pE+blEXEQLFnBc86kliR9GlY9MQwb+w
	 NM2NjyBRBO6/tiE2xX+I2pKhCisJcQSG2c/Xx9y8yn3gZfOBI337kZmzLfrxWkq524N9p
	 U/a9xDYhaMbgIb0R/6bhAV/gI2XDD03MhUkRrEWujDo7t1geY65PL7TJIHIfd0XJOX7z+
	 wy7XqI6vPtgyu/1IWLYe+s/M4kOPq1iykWCvOjiwpkqG367Wc92s3KYSYSBAFNqoCtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sbR6KDZ54pfKvX4mBD6E1CqiOyZSCDGH5Y/Tf8ZG/yY=;
	b=QjCvZkwFPpDbsu/wd34ZHaI3PjkKrKo9NGWGT2gkM+92KwXu5D+H9CXgpcQpC2CeDhjZ
	 45mEvcKyWQS0ayVpI2ec5/2/tdBu7EWwPTLnTuf/AcnrToFS5xE+TJ+JzK4ibAP27/F0b
	 KaxrJEScU8lzURnCLkk1H3J8Wte82MSAqjzXb9iDimV75AEKe2jtJIQDDErcH3ir2rqpW
	 HiboFUvf+7+a9Vm8xVFmlw3n2oL/jaJG2tG0CpJKXrLdQAftdgaFuCCeNIlySWAYSa/sn
	 0Wq23jT7HB/GQka8rhNThSYiMvU+6Th9ls1nYG/tS/e16705kyiosH0d/COZKMsMskA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AX0BSiXa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680F606A31E
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 16:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8680F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AX0BSiXa
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so4168621a12.3
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 09:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793033168; cv=none;
        d=google.com; s=arc-20260327;
        b=NYJzmWvYAHvXEJlTUVdkIQ/3ax83dhkdBfhQeWcX5EHHi/LG0sSMKtjyIYd2pwrj9f
         ONrFXPHGamLPtvbynkQcUI2ONDnoWr2NV32f5Z37n29sTA8DTyhd2OKvMOKDDkkE16/J
         E5uphw67AUcirhCVX0JnptqqTfq0JvBtwzUHCNK30aO0r2qxKuHVl2CNVSjRis9IZQBh
         MONkvarv0qhM9KfTWAesTfLSfJnJIB3cI2SR/cjka1L9tsURGBanAcBULRL9vNWgoNLn
         eRmIAL3BDnbzFAmVl3J50zxrV80IFPxvGcfEwOy7WFeEWpQ+dr4KcZrG6quReQTPs2Yx
         Tz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sbR6KDZ54pfKvX4mBD6E1CqiOyZSCDGH5Y/Tf8ZG/yY=;
        fh=ee5WToLNkUl2BQrXjcqGlft/n1i2e29N68eOOLhI1Mc=;
        b=ZltDM50C7MxeqxkQriuC3VSqjR6iNnuXEWQMzOlAup8VlZ88hGfj88KZcKqRcqHYnW
         RdQdMqxYcCBa0hoyD21evJqQmujYV4Oitk7SYI7DCOiJcmoiFQAePLIHaqg6CWPgFMDv
         7VgHVxSWxccdAlDGfCRoO0ACDnrBWicT33kTaF3nSy1O1/XU4Mvc8m2eZ5S5rr98FUru
         jKY40Vo3T0rSBXfwR+WdfIIw45580in/9Kmx936DHcOdkI/Ugomlb6LFNgShO0w152il
         CdwJRia+VzAvOLimGIDanmMLgGxlEir2KSEhXIzbTREkvZTRRq1ZXxoPGF3Fjeko8qxi
         YQkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793033168; x=1793637968; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sbR6KDZ54pfKvX4mBD6E1CqiOyZSCDGH5Y/Tf8ZG/yY=;
        b=AX0BSiXa2lBj27xGT3tpruTLaYnPuIGiwcRr1OoikuMPFqLcU/g1BaPP9mqV2J5fRX
         E9epG5PZ29IlPZSnWMT1X7cLDLRBDuEOwaLIzWTzLV7OEDv00QF5qUxVjdvlnACt8ocM
         FHGCKL0vcy5Kn0brK7JX9F3uhYq/vgh6FPhBZ6XqDe19mVIHykSRSz5ECzajboHSAA5o
         qUsLj58ajQ1DsHtbum134asY/tyVmq1IdSDRPIe2dzvU8XZVgR7W1mXnQVUmPDxw28n1
         z5iCsI8t5KO8U6e6paH9wR+VWVkXJB1pq/goWdBs9FlAfc8sN0xzo+H8Z46V+ezYckhN
         GfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033168; x=1793637968;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sbR6KDZ54pfKvX4mBD6E1CqiOyZSCDGH5Y/Tf8ZG/yY=;
        b=Cz2sXDEZRUIYwZLEgKrF7FZtJA6iiic6OHuY+i94TH8239OfDQ/lqzxjZGGK93WDDt
         GV+1m+6TqaL0546ueIIBIOZFdFyfGTrNdCpKFhK9kpdx7iS4AeevmHIJfaQZQBxaU21q
         wdXImh5ZYBpySkUTrZRSpFViVCgpXmaPkgiMLLZQuv7BJHwivsFH1mBO1enhPhbT9OpN
         2+fRB4Qd4DRo1zeANibOgQicp6lYMhUMVXBbgQoeSrQdCsAoTk1eBMjlR5teEH7xRn5L
         8D+BhOs6x4RN4IjK2kmfaXcnHCFFiJbFrpm5bYL0XJd8wknuzUyhospnJgWqPjrVk3ge
         dNtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzB9Md/Sqeh+ummgDUyDfu7BMy+UA3nMOats+5A2Ivb6Ddp7z+rUetLbHe+UuDRuGaeZ8ua8Wb8qts7X+Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNclCiB1U7ieqbDEbP+8vlXVnTEAECOrkMmgBHV0x4jK+4yLyA
	2mojhw5q8njoY+hiCiO+/dIPRoO9SZXAHmrt6CmjApFCzGXTeRFsuQnmsufnhJA7n0KBc/PJg0j
	TacZiwFfFOnq2CEOvWKIqOPipN/+F5hY=
X-Gm-Gg: AYBFou2c6G+9uey11fnmFBie+jNzlBA1KGCMCCEK8h3vuETtey8nzN8EdqTUblBwc9q
	LpWNg/TmBUveLtCsAMplAECubnVgb9W8iozvxIKsr2yfCdQOamKMbSpLlbOZFOifB9Y1HJM5Ge7
	hQhgEY8NGNGpCCziCvOpLuzp/UJa87bLbyQhdV5WR5T9GttUniqaG3kMqXQtmI9TvDGTxUSYpxm
	s+bJpQNiCg91fYruWP5cBabEjADMUsWDjwxp51YkX9+SGGvtjd/6dEJ4BpoJjTGwqmShvSr5MZY
	x1Blf/WPIocNnZLQTIk/AbN1igx1XgSeEV4WNl/RJDic2SMWs8mN8hNVz66wJxouM4/9YljvFq6
	0arnw7eQPjK9O63y2LYaR2q0OiWGUki9ATPE/Alfq/Y1kn0ipa+Y2PYPJmjAqti30G3WBYt2Fnn
	61Hg3vofOuzFljKrnRyf7AXodf29fx1y4odMCpsvJJLgfFrLc3VwOdq6NixT9tnm5FTM3ooenJv
	IjKPrmlLoPU5j/OLmcQQNfehX9++blMymZzeGyLve0i0zSXJkY=
X-Received: by 2002:aa7:ca44:0:b0:6b1:b611:a2af with SMTP id
 4fb4d7f45d1cf-6b442ff2fd3mr6024136a12.20.1793033167557; Mon, 26 Oct 2026
 09:46:07 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk> <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local> <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
 <at8eDFj2WNaXDaot@ashevche-desk.local>
In-Reply-To: <at8eDFj2WNaXDaot@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 10:45:54 -0600
X-Gm-Features: AclHuK9i3gJhID1qYhY2EyC-ofDyvA_hJVRAckf-dNWT3ME93Ru8v8ikGWkk384
Message-ID: <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:33=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrote:
> > On Sun, Oct 25, 2026 at 2:44=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:
>
> ...
>
> > > Some people might want to test the stuff. And sending too often you a=
ctually
> > > will get the opposite results, people will be tired to even start rev=
iewing
> > > and/or testing your code as it's changed way too quickly.
> >
> > My thought process was that people wouldn't want to be testing code tha=
t
> > had known bugs flagged in Sashiko reviews.
>
> Sashiko reviews are not visible in my or any other mailbox. To see them I=
 have
> to go to some URL and so on, meaning to waste time to see why on the eart=
h the
> new version has been sent.

Maybe the Sashiko reviews are getting caught in spam filtering or something=
?
They are showing up for me and on the mailing list[0] so I'm a bit confused=
 why
you aren't seeing them. You shouldn't have to go to the web interface[1] to=
 look
up the reviews.

[0] https://lore.kernel.org/all/sashiko-outbox-183574@kernel.org/

[1] https://sashiko.dev/

> It's better before addressing Sashiko comments,
> reply to all people involved and to Sashiko's original email, so it will =
be
> visible in the previous version why you issued (actually about to issue) =
the
> next version.

Hmm, maybe it makes sense to enable recipients in the reply_to config[2]?

[2] https://github.com/sashiko-dev/sashiko/blob/v.0.6.3/projects/linux/mail=
ing_lists.toml#L290

> And before even issuing it, wait for a while, people might
> disagree with Sashiko judgement or your replies on how to address that.

I was assuming everyone was seeing the Sashiko reviews getting posted to
the mailing list already. The are ending up in lore so unless someone isn't
subscribed to the list I'm not sure why they wouldn't be seeing those revie=
ws
already.

>
> TL;DR: this mailing list is *not* a playground with you and Sashiko, the =
whole
> community is behind it.
>
> > > Settle down first
> > > with something, put on the cover letter the answer why not all Sashik=
o's
> > > comments are being addressed (for example, due to amount of patches o=
r the
> > > series being focused on a certain issue).
> >
> > So, in general I've been always attempting to resolve known Sashiko iss=
ues
> > in every subsequent re-spin, so that would be a bit tricky since I woul=
dn't be
> > aware of the Sashiko issues until after the series has already been sen=
t.
> >
> > Usually the subsequent issues that get flagged are new issues only disc=
overed
> > after each new re-spin.
> >
> > I do have a bunch of UART/DMA related patches that don't have flagged S=
ashiko
> > issues so it probably makes sense to try and review those first while t=
he larger
> > series that have Sashiko flagged issues are still stabilizing.
>
> Yes.
>
> > > > [0] https://github.com/sashiko-dev/sashiko/pull/389
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

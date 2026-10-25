Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792959959;
	b=19pqOGkH3ZXGDq4zzCJR/VmsX6TI3hpvGAYm2noU/Z7YwCgk6DHklrM1DylRfirke5fJ
	 tg94RUkSrWxdLluQjYgP2Xjm6aCQ4pBrFM5sywOonI/9tvI+0PLW5lqvbeHU4rKgYYjm3
	 Y0CAahyzIEpwmPnqfTVnGP9JCnABvMMhWMDfv2cPcicrAJ8Euz5wSQcLWnXl94O/WvZss
	 6qlaxYg3XoZ7+S/EMt5l1lLZNemEBVCLq5X0TldYCrUymu/z6HBIVRPFv+zS0QbCjo9Rg
	 PWg3/kAsuP5qQD43g/Xw7y542Zhnm4q/AXOPI5UW71F4Ylj63H99+R5QDc79hLCg5Sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C/RThAUA8B7cnZs887BkMxa6IkSw9Jpa0pELDADdrhA=;
	b=SZM70isv3LtXDyRm3YPwo6JAIy/yQh7k9hbKDseu36OEQu/zNxm7c9KdIZsRxuN2n6t4
	 +v4oxCJfb7yesBE1jbclNntiVvr5EpBs5+4CfCrNhafUMsN3k8NW1Ywwlyi7fKTpPiEK4
	 pSEXb2dbXrbrVUBdUKjvzdegaWwsr5MR1f8SgI1yroEW77N6GzDQWIKJOrt/5Z2GxNL0y
	 Nq7hqBkWYH4oOYNeWJDwjLpsw6zvvv6mEV8KTExX5LdHNdad2ostgVoj9/2yUnM7slWVF
	 zWsjKx0VbUbbULCZW0AfXlwF1Dt9/zLTMh84aX/w+SslQI6x89N17fa+K5uTgzkaHKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ch7l0h8g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB3606A31B
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 20:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3EB3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ch7l0h8g
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eae12762c9so1094847e0c.1
        for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 13:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792959957; cv=none;
        d=google.com; s=arc-20260327;
        b=qKQLg8hAM7zD13HG2VTH/NLYJ2xbcktH9+PBqO//uOSPMRFFeMsLZoU6P2AyNty/iM
         hOhfXsliQy8CrG0fgqCHdUCRF1iMAWjERQmd9IRU7CSIhP3tERiWzuVeGe08dAm3UgLT
         S8A7yL639j5DmfSfK1TNh28pVCg0CwInwO6PSEMFkVxWBnqPYQKwiTqJU5s2JAp6ikjj
         NzBe3OT/d7HxBLxbuHRbWI/QvOndUhFw9atgV9sSVkNSpNAU//JTErZ2wYiwJUEEDebi
         fwwyB0jMmauxSXshCX3tJXGiyiVDzLutE0Cx1IbgxS9R2ux5Wk10UsBGbhif1xIrP0cJ
         ulUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/RThAUA8B7cnZs887BkMxa6IkSw9Jpa0pELDADdrhA=;
        fh=eNts8nMZJsN40szkRMSsip/Ez0DElkFsALPb1GkQ+2g=;
        b=NpSMVJy34aLDl+r7uWjfq/zYQB+zzTiVyRkIi2bjgZQbwVT4uoQbb07HLmJj6gal3i
         Hhk7W8gCLSo/7q0kGKQcJRYxnvTP/iiSCxpNa1RKUkZFtFGNIjoYasmSD71xGj8qXn0i
         w/cG1Ca9bN98z+R/3XqhhMk1Rk9Yg4JtPp2EI/wSBGg9u2ZpTxzKqj0eNgBG5DuEEl3F
         q+v2ktPgRoUEc8IXzjxR+NVOv5alnQHasdUJmt0FuaNXmbH7EVJBjVJjs0FSQ7iS87l2
         5pxR9iVlqnI3P7pzeq+VupmrYcwpGBsFG2Ji401yEKozw94WF4NN75LYY5cKTZE8X6R9
         xg4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792959957; x=1793564757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/RThAUA8B7cnZs887BkMxa6IkSw9Jpa0pELDADdrhA=;
        b=Ch7l0h8gZZLQtaVyD/x/SnDeFWAhlvqHNhtw91SY7a670GgzUlF43VyYylVlpdMXUb
         bJCz5CQ3mLM6o0F9NfkZr4VNj189ngdFRsj/RmUx4NEXPBcUWii7+nkRHa6oSLWKHlmY
         rGcnL6UcCygRCwmSWn3nb+LNdcCjBKT7V8FYrf7xgA0IofiNJAdBfBRXQshvaIHsG3qN
         2nrj8RlqHwDWtowWp8seSIQj7BOUx3TcvO9ZorLYUQ5zaVFU+a1y9xmSjD+H61SSDSa4
         Z7qQYY1ynxcv1uIlTtP5ixYdJ2NX8yN3Te5Gc0ZaCeryz3nK2ZFKQ0xOeLgSybbpWkLr
         ZU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959957; x=1793564757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/RThAUA8B7cnZs887BkMxa6IkSw9Jpa0pELDADdrhA=;
        b=hERR6yQqTXSudZKYD9rjKth/YsC/eaLQ4eW9wduZMevLgtJBS6wCJCtAxIWojWOFJJ
         DeBZoXZGTQ+BPLQXd1fiIALmRhR3zH6IyQXAb7/N2u/BVOuCw4+Pwr/XlaaQe8YG39lc
         L9ymU8D4GsEoPa9vucyqzbfaCqtMPZnuNlgybyWUMYJ8tk4XlWxqbYQmFxa4HNSoyy0+
         +gry8IaF5fuEHz6VZ4eyayo8iMXnlb8SyOz0hSGxD9dIB5DtgsoANHM1w7IFv34vaKqC
         NLcoYdubAfvpfeBA9sciBxjWCGh6ylCm8dHKa5eefGtnPWBg2mxFIj3n6PvYN/In2kLW
         laUg==
X-Forwarded-Encrypted: i=1; AKwUvBz6pRd3meKRvYtdzclI9P8YLzPpZKd5OTBtZS+FY2qIpoHYGY6O93TaapL+7h2vRM1cpEuMtcOh9gGKOQ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcNlkoLEIn/bb1Vw/t1zEJzOjJLmZIJVgNyIxKMYsFBHt0jPs7
	eNQI1SYffqh2WZ1ysGF7DFdfC2RIa4lOKcDatoZdxKzYVXS2Ug7RZEELmXOpJV8uUjfY3t0GJyT
	fxli/NYfrO+Qu5GsHs4LaQMG2cshoP74=
X-Gm-Gg: AYBFou2ospamGEmX94NEYgY6kPxZvVctKuvWEB76x+72SvaC4hfDECBeZf4NwCBH0QI
	u9HlE7A2hpepL+NZXBBu+r4TUyUNWN0tKst4VI0tNY/HRrUkZMT5UlLCPb/3fpkX4DvCL6WfOC4
	mB5DKnczmN8yiM8R95N/q+2TYFjanh3SqOqFPaKTFQqkYZYPDC9HzqT5ucuCEOk/4SukvOgWXdz
	+cWwpPgmgH+hIiUlq5KCFaM40ZH0mVwQYo1H8nE41XxwX5QRJ2NyTpbLuV/nDN7dZEio2fHWw14
	0uEppaPxY+YXR1GaD0njqadPqC0AKHQU+mCH6N/ppLkMar2DD5niWjx4FvLRpYfA6m50OvIYV70
	lpxUF/D5YDmrOGO7DLbGUbCGYRfrg1d6fEAMx6qeSAMs5wKiKZaBc7tjkYOvNbcVmK8xnXhCMpY
	nj2EETS/FbHOJuLNAyjEQehbc9TDrkYkduIMyaKmcmwD+WBiJqw173/abh387l2VAE5k4e6nMIM
	XeRHKinQIELBxt7erE3MBBYQNAf2w==
X-Received: by 2002:a05:6102:a213:20b0:7ce:645a:13a4 with SMTP id
 ada2fe7eead31-7ce645a802emr619643137.20.1792959957403; Sun, 25 Oct 2026
 13:25:57 -0700 (PDT)
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
In-Reply-To: <at4bw-G8czG-G7Wl@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 25 Oct 2026 14:25:46 -0600
X-Gm-Features: AclHuK95EKPTnWE_5NOhWBwYmgu-dizSaKFvAkW3Q_P3x_TD5WYGvbT2T9PcLnc
Message-ID: <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
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

On Sun, Oct 25, 2026 at 9:10=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Oct 25, 2026 at 05:10:03AM +0000, Maciej W. Rozycki wrote:
> > On Sat, 24 Oct 2026, James Hilliard wrote:
> >
> > > uart_write_wakeup() expects the UART port lock to be held. Several wo=
rker,
> > > DMA completion and interrupt paths call it without that lock, includi=
ng
> > > indirect calls from uart_handle_cts_change() and the transmit helpers=
.
> >
> >  Fair enough, and thank you for the cleanup and spotting the issue in t=
he
> > first place, however...
>
> He already issues a v6. I think the tactics against AI contributions shou=
ld be
> to not answer for a week or so until there will be a quiescent week.

At least with the workflow I've been using, a good signal for quiescence is
simply whether or not the Sashiko reviewer found issues.

I am feeding the Sashiko prompts into my local agent but it seems to
sometimes miss issues that get flagged by the public Sashiko reviewer
still.

I've been attempting to peel off independently reviewable fixes where
feasible as well to minimize the amount of patches/code during respins
as well.

> At least that's what I learn from this patch storm.

Whenever my local branch accumulates significant refactoring/changes
due to Sashiko or manual reviews I generally try and send out the new
revision fairly quickly in an attempt to avoid reviewers wasting time
reviewing code that is obsoleted by the new fixes/changes in my local
branch.

Locally I actually have far more UART related patches in an integration
tree that I've held off on sending for now since they are dependent upon
the prerequisite fixes I have already sent. My unposted patches actually
have an even larger amount of code changes than all the UART related
patches that I've posted so far, at least when measured in terms of total
lines of code changed.

The large amount of patches I ended up with seems to have mostly come
about due to the AI agent identifying most of these bugs while iterating on
and debugging new features(most of which are still largely unsent so far).

The strategy I've been using is to send small isolated fixes separately and
then reference them as needed in the larger series that depend on them.
I figure this should make the changes easier to review than having them
all in a larger series. I contributed the changes[0] to make this compatibl=
e
with the Sashiko reviewer actually.

I also use a custom AI agent controlled hardware in the loop test harness
which makes iterating/testing changes much faster since the AI agent can
autonomously test and iterate on changes far faster than is possible to do
manually. This test setup also allows much more thorough testing as a lot
of error handling or uncommonly hit code paths can then be tested using
AI generated fault injection tests on real hardware tailored to the specifi=
c
fix being validated. I manually review the final changes before sending as
well of course.

I'm constantly refining these patch development/review workflows as well
so feel free to give me any suggestions for anything I should change to
make review easier.

[0] https://github.com/sashiko-dev/sashiko/pull/389

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

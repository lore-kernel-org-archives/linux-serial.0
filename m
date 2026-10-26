Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793046312;
	b=5LqM2+8VEqh8MoHqoVhoCLHnsDCX6JziuetuGLlgcwYvZLM1Wge/hy/w0toEi1JB0msw
	 1eipc7hM0aQ1WZeX0D3dOL/TzQMNlEed1vPJYcSZoEf4hJe8Xvp4/z/nb5ojMCump31dr
	 RCbK0grZv7Ws4CqAGCVgo6jNef3hC07BZvglYXSdUIPaSyYHQiAOm3ZWbIJOPrxB+y1km
	 5W8Ywrzl+oISBKfyinu1dmWuxvfFWm4lgxGn13Q0hTf8sYzJoeORsnocBXjpOM13BJ8IS
	 WokdQqBegJkScNazmnmqZqCELN61lX5kOiIj3mMHTtcdEK6kR5zKsVLoYch9AyUbbBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pU0NwAlmN/1H5GxbKnpqpM7HbDpz94JrESY0WvDe6G0=;
	b=47Z8SbW2z1CKPqQ2ahM4R6hqiGOFnG+/ckPl113Q1DuTmzeoEusjIiYAn0SOlWO3z8pA
	 L+DHdAWJZP9fdmkk2VAYAzQJyQtjLbJL4mKwxDv4m4fZ8uYVDj+2nlutZf3mGuD5zZ57J
	 T/zrysOpSYCT78MmD2rt86OUWeMyRYb76dkkAZkP+Lc/Z03A7F2LlDT4A+K3uCNJcU5ei
	 1/jzOd7YT7asogzuATIeWQsrV+no7RMN16DUxGFW6yLLKvJ0EqQj5WhLRM7H7h3h+z8pn
	 SPf3VCZUns1GVJjhAc9TCpauVixTEmPXWZbPSq1ogB6qPe5rQCK1Gix+B95aAEuo+Dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ORp1ZIDT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBA606A31D
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 20:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DBA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ORp1ZIDT
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-99061e2171cso853795241.2
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 13:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793046311; cv=none;
        d=google.com; s=arc-20260327;
        b=f/sxBnqKiiGBk9LnMKkYn9D7OzOJvzNlf5789nwnNc8rseXaRXDKMWMNrGfuBv5EpS
         Hok9UXKTrTKL2/fNWX4Eh04Zr1PlgUu9eIqhuVhUTyLDn5dHbkY0BYqfB5GjgUCVh70a
         vlNrj91k25oXPiUfXiaAAr9wTTvCl+Shz84trp60eWt/jflMqoa/21s2vevwGxx4MOsH
         HdmLYCDHiNr7NyYkb4+0PeVqVGsnqLZWbx0GMe7iBizrWGlsTWQ6UXq3og2QXwtc0KXp
         sGZGLLYBCbhusemK0Drya57/qttwgdNx00HYmwllbJ2Cbii9YdFbmy/DvLbaQgis3OsZ
         re6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pU0NwAlmN/1H5GxbKnpqpM7HbDpz94JrESY0WvDe6G0=;
        fh=Au4OsMuCVw3IvJtfCCyGjphfSQILGuxKKTnBYkIG+Jw=;
        b=MT1IA8GthDaVi9jF/wmpvKX6RNVPhgCg7LgN6PP224LFq5rVE/1xRHPeo5mMwor8IC
         cG8dVJsoFPmcHXUrzCkmlZi54BR7KD0SSZ1DVlLtg//06LWuM1iem6A+Jn0F7UkbaFA+
         jBX2MLUdOsdGaklY3iTCBj2Lqo4kNL1XbNGDpziPsDzUUUnUkb9y8gYfyqa7H3nVdXXp
         igAaT9PNLCPj7A1Pmf5a7BzxmDoCOWGAKrEJ1Yn1Nxni9Fobxwg7rj2ZwBmGXjSAPK/T
         izgwcSJJP2IRuDzbd2QA+oN8aJ2n2+aLOorrMlAn7d5XZe34zmODHZbi/Dr2NrT2eZEH
         zqCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793046311; x=1793651111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pU0NwAlmN/1H5GxbKnpqpM7HbDpz94JrESY0WvDe6G0=;
        b=ORp1ZIDT3pwLo29WJw19zJ8UskOADber0JYzgo+Y8E+0ygR7BOElNkC/7/+l8GF20p
         clQlZI4h96RGkUBvHAm70jqi/487aN5YBrySbLP/gipBJbtyz3ug0467jdJpYPxN51pB
         jcnDOyAltJAkXGmTlIZ3rcrXRIpAIaEgBcL/I+J9QIbHatMnmdyqm5XP0OgKSnA2qhAt
         lQfnqizWf2Mw9/Z/Q9d7Nxuxr9bDTPEulrNB84JWRUZYygc5D69POQWnf1PKCjjun3r6
         wiCW+O3fF7q+PTgwDMCC3k+5KOMP2HCP3uc4UKb1kgmPIe/XqPheoVqKFqwQ7t/4yngB
         F5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046311; x=1793651111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pU0NwAlmN/1H5GxbKnpqpM7HbDpz94JrESY0WvDe6G0=;
        b=LUhZT15aM4NORXtSBnlBIdIo6vRTsneMtR0U7u80uxLTzQrSSrDPCWF4aXDfUo1bWL
         Kp6ae4ekCOZQ7cbjUQmGTyZkZlp2icjqcgCqysMD05MOdwCqew8GxHrfJcUGUskDnEkS
         LPLzXzmDLOH5Q615QCl7DBrJVp3vxH9dei2p7NhPpEonyN+kVxHkeiXyNwrKF5Co2ICD
         oj4AqB27FfGvQVjxETjYmE1mRelUUBgUTULJyt//4oXjcRhwEud3Gk71rFiEWarE+uFg
         CrI53LCk5mRpZicFO9Wem3GpVORALIYpzjc30NNKosU2xQRR0WHGMoE3fpTkhF6yFUpY
         SkpA==
X-Forwarded-Encrypted: i=1; AKwUvBwXngxjKBOWlYJRI3sc6sGXZevTxDYJ3zKPrhwLUrr7+aVptnz914/7ZipPzjiC1fWoNu1ZNgKUroTqEds=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcCMd/bG9jUnhzZzSNUD0Ci7I1QibocZw101lfBuQLeYlo4m3e
	ApKS6sCvT+o0ds/0zP1ocUkKn2tAMWwJmrMH8obUvRH5vCKpalPs2Ah5SW4QURGFU4FI0Rsdacw
	bkrGuhfv8Z5veZOeD2tA8wFWXfytJI/s=
X-Gm-Gg: AYBFou349ExF76E5oG6ir99Hy9nlwL2mDIaoWEq0njrg4u0atQ6KsxMhyhYK2a7HhSY
	J42DZvgOKvkXWKPsrdSMAkFfJfQriddT6MHltHu4MCn3VHqiFFMSyueyze4k8/+XG+AxwtjkSk4
	exdiav9yvWwQ4zIAJYupHd5yEe0VCDlcW/b0hgpVgtcm3hT5XQF/PWEvOGkIYNLiyPux1wBBdYJ
	Ck2oqTFbEFIyDcDi9zEzdQJyudP5wTrBQkvrx3QWiJxhGTfHz9QLvVTiJTS4Am1eJnOyM5xXokR
	z6a4U8Z3rJLBDAQuolBCeivZt4aaAwVFtPWNnCdcQkxwXAQNE1l6DbYLyG/+PCVTUoKnqXy8I+L
	ksGHs3a7rDqe2OVeC+uyT7PvGK1Mudw6QfrUgLu0ocPs74RomQ/kSenptdF5JACPp6q8WG5G8TN
	4KIsHCU4XmIV2/eYUHr4FndkBccUX6WJTFRgfiR4VG8FDAADUSwTCGNHHABR2JKsRIfISPMRoQG
	v0z/U2wxFNLVDMr2b5+gmrhd9sSig==
X-Received: by 2002:a05:6102:83cb:b0:7c1:6de4:9f67 with SMTP id
 ada2fe7eead31-7ce5ca62390mr2075068137.2.1793046310592; Mon, 26 Oct 2026
 13:25:10 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk> <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local> <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
 <at8eDFj2WNaXDaot@ashevche-desk.local> <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
 <at-vyZ1sDhYPu0W5@ashevche-desk.local> <CADvTj4o_CENc3i92OQEZudOErSKPUptT4t2CCqDaGbseuK0QcQ@mail.gmail.com>
 <2026102631-stove-preview-b534@gregkh>
In-Reply-To: <2026102631-stove-preview-b534@gregkh>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 14:24:58 -0600
X-Gm-Features: AclHuK-jg_V963WeCj8dDZYyLMETxUQLvBlHikJJBrwQZYN579iKyQfuGLYZuh0
Message-ID: <CADvTj4pCnnzx4B28H_1BuY4gm2fh_8HYL9jLpsAoJcWfiUXOHw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
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

On Mon, Oct 26, 2026 at 2:17=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 26, 2026 at 01:59:06PM -0600, James Hilliard wrote:
> > On Mon, Oct 26, 2026 at 1:53=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Oct 26, 2026 at 10:45:54AM -0600, James Hilliard wrote:
> > > > On Mon, Oct 26, 2026 at 3:33=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrote:
> > > > > > On Sun, Oct 25, 2026 at 2:44=E2=80=AFPM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrot=
e:
> > >
> > > ...
> > >
> > > > > > > Some people might want to test the stuff. And sending too oft=
en you actually
> > > > > > > will get the opposite results, people will be tired to even s=
tart reviewing
> > > > > > > and/or testing your code as it's changed way too quickly.
> > > > > >
> > > > > > My thought process was that people wouldn't want to be testing =
code that
> > > > > > had known bugs flagged in Sashiko reviews.
> > > > >
> > > > > Sashiko reviews are not visible in my or any other mailbox. To se=
e them I have
> > > > > to go to some URL and so on, meaning to waste time to see why on =
the earth the
> > > > > new version has been sent.
> > > >
> > > > Maybe the Sashiko reviews are getting caught in spam filtering or s=
omething?
> > > > They are showing up for me and on the mailing list[0] so I'm a bit =
confused why
> > > > you aren't seeing them. You shouldn't have to go to the web interfa=
ce[1] to look
> > > > up the reviews.
> > > >
> > > > [0] https://lore.kernel.org/all/sashiko-outbox-183574@kernel.org/
> > > >
> > > > [1] https://sashiko.dev/
> > > >
> > > > > It's better before addressing Sashiko comments,
> > > > > reply to all people involved and to Sashiko's original email, so =
it will be
> > > > > visible in the previous version why you issued (actually about to=
 issue) the
> > > > > next version.
> > > >
> > > > Hmm, maybe it makes sense to enable recipients in the reply_to conf=
ig[2]?
> > >
> > > It's up to the list owners / subsystem maintainers.
> > >
> > > > [2] https://github.com/sashiko-dev/sashiko/blob/v.0.6.3/projects/li=
nux/mailing_lists.toml#L290
> > > >
> > > > > And before even issuing it, wait for a while, people might
> > > > > disagree with Sashiko judgement or your replies on how to address=
 that.
> > > >
> > > > I was assuming everyone was seeing the Sashiko reviews getting post=
ed to
> > > > the mailing list already. The are ending up in lore so unless someo=
ne isn't
> > > > subscribed to the list I'm not sure why they wouldn't be seeing tho=
se reviews
> > > > already.
> > >
> > > I assume you already answered your Q. mailing list in this sense does=
n't mean
> > > recipients. I think it simply goes to the mailing list without forwar=
ding.
> >
> > Do we want those reviews going to recipients as well as the mailing lis=
t?
>
> For serial patches, we decided to only have it go to the submitter and
> the list.

When it goes to the list is it supposed to go to list subscribers as
well or only
to lore?

>
> thanks,
>
> greg k-h

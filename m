Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793044758;
	b=jZptOu0gjvJNQlD47lqqY7dYGcxR1yFeTsArwfaQ/KesrJCTz4P8drq90ENNCGbArT6O
	 xK6y0VE9rfIDnWPPBk/IiU9m32FgMB+wG1rjH12UIxj3wC4A707cBDLXi4fHd/iwG6Ia2
	 diZ9Ipq2D0KXZ0bfdWxyLJJxgpcQhH0G/TqH+bRkoOgINIrrGBfuNmmSsz1GsimXyWiIS
	 EOyS0QVqi0fytjmSejBdX+uj18aVF7cocFOvROb/LkGMPRTA7idZ351U91DRSZmPZxl4b
	 rU2BCMYIJpPk3aO81aJfqjvnf6w8qhy8nU75PtPKksUV8CkPHrJzciJvDHx/KRuTUBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5v98+mkBPyKcXGGfAa45H0MLFavlwhFEg5B6g7hFf9M=;
	b=Qr7ubOZsJVtLeWmKaDP8r+V/V6POvcoYfh7Fj0fOiz1zQx7Z07Tam5kARkcA1b5LKg2C
	 y8vvNVE6fdgftETIKNh4OweCco3ze4vjppfDyk3QOu3J3avdwBPeh1u+PsmVu/RxiXWxr
	 OPfjLy0HJbjXECZtoqpSmnyiG/WDN1LrIp2c/WPeKCW8Ywnc8QWl5MNUjnaiJpieH5eyc
	 zWQMryNrwEayswbiy50SC/WW8bQxKlWKChAxGWyX2TGKlflTXYr5BBJxkE3JYa6MSXupT
	 xVifVthW7NaTlM7wqcKLotAotAZ2XGUsuLfxNY+IlApMpEF0vUFhx/+CqE4w79dWMjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cvBRFKlI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A9606A31F
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 19:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 561A9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cvBRFKlI
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7c33cc572e6so226677137.1
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 12:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793044757; cv=none;
        d=google.com; s=arc-20260327;
        b=VPO7MslQN81jvZ3KlTfOPV6o9I+cE1B3/xsJTx2pydL2LpBaWJEV0NmeFX7GmTiTiK
         FUAk2I6VhHFADvEEcFlqhBMuZersKwMw/Z00crQantEL7+leEQIDd8csQ3Kh8ieTarPD
         XihUK/0AotwuTfkmeX4z9cLLijrNzcJcLxNFRGaaAuU6J4sZM5QKxSaNK9At/lGOJoqx
         BEHOHIEQQsi7sqVkzEJALo9GPHEI/2GnoDr0SZ/j2Hi178R+FKLuDyy59ypTL2OIHQg8
         n4NLx7sr/ard1xiSML0o5iNwzCN9Rmj9MCfStM2dEJNs5yiSSpm/TMCrGT33/ZwXNYVS
         1ryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5v98+mkBPyKcXGGfAa45H0MLFavlwhFEg5B6g7hFf9M=;
        fh=y0QjbZChjBXFvlLbsbzvrSXoUP5tADMqm4j7T9xTmsQ=;
        b=IiD1i2knsx4yFxDWEGEU0Et7akz26Urdgs3cpI/k6bEw/RjvZyG/GZQesJsXf9SH8D
         H1umBIKkuEfIop4yG7WQUZmGHrxh15kFGhO7ROd7oyEO/btSPtfN3KC6x4ymg3+p/JNd
         LU4Tf0enRCKwYSxZN+NmyF4oabIgL3GyvHYT5jkzr7yLe2PzwdLPwlBY9bJbR5DoPyd2
         ZmH0v3ZemeLdbr1b5+H38tEPBfSLu5skSg9msvioX1TgpCP5mmuPKZa4o4C6MP4SBWr5
         7uxx/1GANiOIrNSAmJrrleF3MpzOisjcKegPMt4uLdpOSFR43JfQhRBY0uaLO/7zrGBn
         jirg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793044757; x=1793649557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5v98+mkBPyKcXGGfAa45H0MLFavlwhFEg5B6g7hFf9M=;
        b=cvBRFKlIcZfiZ7VSDj5XLvmoB/dHtec9fZhh+Wwhpjf87UlUf5tT44b9nbh/sUFxCz
         yLMWg7WvvmAPW+M0Ad/S1UXKtNGcC+8YZoEisoTHMhjdAwGxk1gPTlq0tilDc14XmEMg
         NCb5SWjJFBUUXqj+ty/FZBKVEQqciLJyZTQWBpNAMVE75SDxT0Nh7dZJPrd7rsnktWUx
         Z3YF9ISbvYbFI1+cPAgm9vPZz03DlOQ8dT6F4F17XV59JvnyFzq3UOeocdY4kNQkcNbD
         //Urs26nlHi9M+mnnxcYbVCabq5BUbYdiqFwv/Ye3tCeH/vys3mzngTYRbNlBety99ES
         RX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793044757; x=1793649557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5v98+mkBPyKcXGGfAa45H0MLFavlwhFEg5B6g7hFf9M=;
        b=uTaaFQDz9ypjJrJ2hhlcyJhtPL1638vy/54LvtLGE9Z5IB1iAA5/m2pv3F3JkncJp1
         u9rgortNik5m2cor4Medj7UPs1HWAS4Zr6+4JBTeiJkgGKoCW/Qxzy8pjr7+gDvzJLm9
         cNxT2/GrIs3yCkp2RgN4EKX2Y/G+2I7/m1pISCP31iKLuRwE7VZ5TNbo/L7wIqHeQjMO
         0xoeLpCdTEYySgwk+YO+C5wCsk5YRDEFSU57YXcx59ngXRgQo+/T4RdLdsWXUDG6cK7/
         Ya1AaVTy/Vxl5CyAJPv/8m3j2vuRc8yhJPywAhVu7dBJpa9Y0n5oCxn92QLRRG/qEVeM
         wing==
X-Forwarded-Encrypted: i=1; AKwUvBxKBHyJqOaT6mC5HeTVR//c2y2mYR3bXGthX42cpAarZttknW9xqvLWEh/J09LQakKYSNBUCQIdJI0m9oQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPfhWn9WZ1065SOmD2cMmV7NNnJ2jscuNhqOaG+GzyNJ/n7FEw
	w9FGWyjG+/QAuXUsdCm7PgQTVzOBB3NoIpIcpLTpNOWOEIxJhVnbqnTxxQC811M0dlerXDWWVms
	bfFgwQ4IEQyyrwVK2O+U7xpZRUELDwIQ=
X-Gm-Gg: AYBFou0zW+NzA5jWtd3YJct1+MCgbu3hUpIpNCFZbFYC01G9oXb213IGLCW9//7iLt3
	9/uGnm2RFhtQhKS2BFdBXZDy+17RATBdEdNq+g+1zp0v12bt0KDBmiFvAakwR4PqEtFsSRubDQh
	GzZmyyrC2Zv2cyqTatA0Jr9XpUU62+IAXBlWFJB1uc+WMiJZdLrTY2/oVcFDJf4M6/JI5lADN/s
	QwBPmSiNU2fzTDyVCLFdOr/9jwURGUaxC59FVM2sM2wyxQnOqyzbu/S7cUwNt9D5V9AneV9nMe8
	KL2RnyAEQ5ezIbFLFm1tr1/R9q18GE8nZ6OYbsotZStar9pMa6qEywgIa/+3ucsrfdpAXG5/0FX
	4omgHRWO/2nIOX3hw+alM3Mn0e9rrZ5dNivJjJTuddj3HF6uLaGwVrWQvJAp+f5SFeYIYiDg0xv
	Y3QxtIuelIVH6CYcav8B64y+k4kYAwoJURykqIE/lRuJ9sv1QeBYr40wXfWV5B5MHbNS4AG3MoX
	FnbDIiivcMBesWaGpcj9kFHf4yp3Q==
X-Received: by 2002:a05:6102:3e8f:b0:7cb:bd9b:4873 with SMTP id
 ada2fe7eead31-7cea14fad38mr297588137.21.1793044757153; Mon, 26 Oct 2026
 12:59:17 -0700 (PDT)
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
 <at8eDFj2WNaXDaot@ashevche-desk.local> <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
 <at-vyZ1sDhYPu0W5@ashevche-desk.local>
In-Reply-To: <at-vyZ1sDhYPu0W5@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 13:59:06 -0600
X-Gm-Features: AclHuK-pkQBp3tukGM9FdJ8ekfrjzUqdLwbnUIKbAlyu-Q9paOfNaII7ApJtovI
Message-ID: <CADvTj4o_CENc3i92OQEZudOErSKPUptT4t2CCqDaGbseuK0QcQ@mail.gmail.com>
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

On Mon, Oct 26, 2026 at 1:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 26, 2026 at 10:45:54AM -0600, James Hilliard wrote:
> > On Mon, Oct 26, 2026 at 3:33=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrote:
> > > > On Sun, Oct 25, 2026 at 2:44=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:
>
> ...
>
> > > > > Some people might want to test the stuff. And sending too often y=
ou actually
> > > > > will get the opposite results, people will be tired to even start=
 reviewing
> > > > > and/or testing your code as it's changed way too quickly.
> > > >
> > > > My thought process was that people wouldn't want to be testing code=
 that
> > > > had known bugs flagged in Sashiko reviews.
> > >
> > > Sashiko reviews are not visible in my or any other mailbox. To see th=
em I have
> > > to go to some URL and so on, meaning to waste time to see why on the =
earth the
> > > new version has been sent.
> >
> > Maybe the Sashiko reviews are getting caught in spam filtering or somet=
hing?
> > They are showing up for me and on the mailing list[0] so I'm a bit conf=
used why
> > you aren't seeing them. You shouldn't have to go to the web interface[1=
] to look
> > up the reviews.
> >
> > [0] https://lore.kernel.org/all/sashiko-outbox-183574@kernel.org/
> >
> > [1] https://sashiko.dev/
> >
> > > It's better before addressing Sashiko comments,
> > > reply to all people involved and to Sashiko's original email, so it w=
ill be
> > > visible in the previous version why you issued (actually about to iss=
ue) the
> > > next version.
> >
> > Hmm, maybe it makes sense to enable recipients in the reply_to config[2=
]?
>
> It's up to the list owners / subsystem maintainers.
>
> > [2] https://github.com/sashiko-dev/sashiko/blob/v.0.6.3/projects/linux/=
mailing_lists.toml#L290
> >
> > > And before even issuing it, wait for a while, people might
> > > disagree with Sashiko judgement or your replies on how to address tha=
t.
> >
> > I was assuming everyone was seeing the Sashiko reviews getting posted t=
o
> > the mailing list already. The are ending up in lore so unless someone i=
sn't
> > subscribed to the list I'm not sure why they wouldn't be seeing those r=
eviews
> > already.
>
> I assume you already answered your Q. mailing list in this sense doesn't =
mean
> recipients. I think it simply goes to the mailing list without forwarding=
.

Do we want those reviews going to recipients as well as the mailing list?

>
> You can ask at helpdesk@ how this is configured on the kernel.org side.
>
> > > TL;DR: this mailing list is *not* a playground with you and Sashiko, =
the whole
> > > community is behind it.
>
> > > > > Settle down first
> > > > > with something, put on the cover letter the answer why not all Sa=
shiko's
> > > > > comments are being addressed (for example, due to amount of patch=
es or the
> > > > > series being focused on a certain issue).
> > > >
> > > > So, in general I've been always attempting to resolve known Sashiko=
 issues
> > > > in every subsequent re-spin, so that would be a bit tricky since I =
wouldn't be
> > > > aware of the Sashiko issues until after the series has already been=
 sent.
> > > >
> > > > Usually the subsequent issues that get flagged are new issues only =
discovered
> > > > after each new re-spin.
> > > >
> > > > I do have a bunch of UART/DMA related patches that don't have flagg=
ed Sashiko
> > > > issues so it probably makes sense to try and review those first whi=
le the larger
> > > > series that have Sashiko flagged issues are still stabilizing.
> > >
> > > Yes.
> > >
> > > > > > [0] https://github.com/sashiko-dev/sashiko/pull/389
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

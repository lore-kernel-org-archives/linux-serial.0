Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77F396B77
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680251; cv=pass; b=iVn0cuu2vFr9cv4rNq9dj2YT5jRcHhXe6/WG/PaKBV+xDqFbqxgVtAhP2AjorzpUT/UYQVql8xKxDXF2vZ8ut6pfzmyt7TnXN/Yzlu+E9V/aVpFouQPEKmmWyZbgKSnk5eaq/gPWjF+X18Ct6p9V951i1Tirehk+AoSnK2zzkvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680251; c=relaxed/simple;
	bh=EKtOGuUsAk2ocNugxSmAHlHsvs650h3PEkOtSPfgiLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXoEolmEln6qojA6JS5x4aNE1AfdZApFuKjh16SaUv9rnwIXWwmqNIbXRS/N6HzQt5K3Di7HHYJk2xH700yGF6gvFvooiyrjg/dD819ecjRhUHGmWAORixMG2D5NVRcqRN+oJ5VH3ssnFI4gJWUcHZaZKJDPORvDl2DqFhTu2a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDm+JKsH; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDm+JKsH"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso353285766b.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 03:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776680249; cv=none;
        d=google.com; s=arc-20240605;
        b=huJh01+g0CR0Oo/o1NYdEd2DSzN3/X59UROTUaBmXbnw/Xyl1roCeKVspP77t2YzRB
         WNkP5wodgU/jAnxqcwkk8fyXY6GaRwoGSZwtkRVjJ6i790mU+7j0V7/H74T3nei1Ud7d
         1DnVFrC7GJAt1I3Ks/y0q+JaodfZSoN/+hGnX9nlybzlN5hj3zefot2SsXmFVfKAohO8
         qb7jmSfgwz+MzAKt5OQsqAonkc0QAm1o6dLvYTXNL3wxRpbpXx+F5P9vixWUn+OKTCw9
         aqIenxHssKvK3uWD1o1oEX0eA3q0LEXb6ogp0eOmL+Bu8l/F/DCmCrGnFGx+bC/R/pHS
         VvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EKtOGuUsAk2ocNugxSmAHlHsvs650h3PEkOtSPfgiLY=;
        fh=Fz0LKCjy/CNL/u6RBwWTHg2x9RTqEmg2V7lnl163zso=;
        b=DY78o9/4npKRkhTcVvhryfpb6sdBFh9hypMStgrvLt5nIaC7J5jlpbdl6GypZGHQ9n
         TEePX5xR9hI8cN8laXREpHX7dGLlzXaUriFdI1zeZxCd4uF3NgV1rEFIYNYuANUTOMmX
         Yp5kvxq0bRzohuPS+suHWIpciXEUOW//GfpZSCoJ5AnzjNctsVbPSdfBMkDZg56MOlze
         mpDW/unAsyVDh9+mmKu/jJ4dRhk4UEUlneR/E2ciqAYvm3mYCt3lpUE628gDCHZAQA20
         /7ZlJRPP+w7OpMJP/0lwa/Q8eYDUq0uQu9g9I/Dm2WGvXbRc9vtuJD8bkXLAON2LANBM
         aTpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776680249; x=1777285049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKtOGuUsAk2ocNugxSmAHlHsvs650h3PEkOtSPfgiLY=;
        b=qDm+JKsHmc+s5iaHQYSAlWB6sUsAloZAQkETELXHFpaOEWP2bLTkaaZ86IIsDuX690
         WHeQYRoignUUQRU9+1vknxv1Qd/Rcgwa6TiJB45J1tFbrDwBkEKfQStn7izkzhDbdkYr
         Oh/k2gsHK7RD6KDCdOXM8Ico9UPdVsXNVinqVx4kPNAroVdBE2/91swBafExPCgzxj8o
         dDnp2FY9dLRO/lUxWT4XlSo8qOMafZH2+NvFKUg+j61bpo4JpjVOuE9w1hV38fh1rTz5
         BA0afMVY7lbWkO4qzKI0srcsmg/Rp2iJ+fxiQYkgFDa6f8dzag7CDBzuMRBhycJ4IN0w
         wHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776680249; x=1777285049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKtOGuUsAk2ocNugxSmAHlHsvs650h3PEkOtSPfgiLY=;
        b=eXjYui9kcwBcoHxXF0e3fqd5f1uL0c0HDGdDWiTWegKVDTUBAVtbUCxE2uKwKXpdyU
         4XmzKruWcNSpIKhbSFfwjb5FT/SDVkk+RNqE/ILob5QK7ZJnrslp2+lYVcd7I3VwUlyJ
         5WSuojsbShcdQ9yz/7VGiXTQnj5SifmDBWfzTQMEV5ILFDLppQE7cBJvavOY3p8WgOAE
         oKG+ziFjCDhVivptGGw/PfzMb28BQ374fbRAy/W7/LVs+Js2xf5DPzjc0jV1HdyvXyes
         BP0fR56qlo91GnNS6IvZqrDsU8fz/iSkLVrjnNDhV4KpdovzgWtUYVYuKzte/LwFMYNX
         EvGA==
X-Forwarded-Encrypted: i=1; AFNElJ8cZ0nIvveR8cb59dkD690yCcQgapDnl4ZNwmqytcH7YRVq6F+8id0w9NCC7Mvf6NDtoNoxtO/hsEUP294=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw2Z60FGWLuk+vrqPj1v8nTyRvo3A6sTjoAb+Z0kG5NtC7wp4h
	okYOhctwZEjwS50GttPrU1IbNlLoisWX05PsZHM7aO7YzVdvzb8F1LeKdRU82c6/+33Bf5Xoerd
	w5Q5UT97ljZN7U91QnfDA/NTR0tbZYUg=
X-Gm-Gg: AeBDieuX3jKVy4HOM/BcrqXa780MwEhA5Ga8snMZY9Yzxy7HgiKKSOkD91SFSCgahxe
	fQYFXrOCuZ1xFCP5uGDV2Zr3blsxpdCxWLyNfd4rl4LL8kieZKBGMDl6DFm3bfGdIILQjR0/CbI
	BsUQ5ZUMdcaKtsnZV2eDVPb3yf/PNZUiC6D7zRkstNRy2ZmrG1nJOSvZqB+po8kO9DoW+WNUhnn
	WY4VaAnq0BpoxDB+2DAlJZ9PLFF87O0dLfLFOqz0PQmo6/aGNKi9Ov2byJyene1pGsdmxIW+8rA
	CMpOBwZnVQC4MIsRQN4jui3CkTscFjKRSR2lqw2lblB34PnMs2enmLe6Hv81NdnS1ooHc0yRaGn
	p+DgGSsEQ+9CUSoUuNw==
X-Received: by 2002:a17:907:c9a2:b0:b9c:ed9:50c8 with SMTP id
 a640c23a62f3a-ba41a91e1b9mr451634166b.26.1776680248462; Mon, 20 Apr 2026
 03:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417102423.40984-1-john.ogness@linutronix.de>
 <20260417102423.40984-7-john.ogness@linutronix.de> <CAHp75Vf4YZVqXa7eH-RFeVsycdzoHijcWFnUbGv2PSmtPya1-w@mail.gmail.com>
 <87jyu20x9e.fsf@jogness.linutronix.de>
In-Reply-To: <87jyu20x9e.fsf@jogness.linutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 20 Apr 2026 13:16:52 +0300
X-Gm-Features: AQROBzBpWB5UgUFegmYGcbYsIvZQk8syidEg_UNxjETHiGX2iOeoEwPwpkIdSUY
Message-ID: <CAHp75Vcdu3vcPzgHhsdReMB=WK50wuTjy2PKC4gvEhW8i1Vhqw@mail.gmail.com>
Subject: Re: [PATCH tty v3 6/6] serial: 8250: Add support for console flow control
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Osama Abdelkader <osama.abdelkader@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Gerhard Engleder <eg@keba.com>, 
	Lukas Wunner <lukas@wunner.de>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Joseph Tilahun <jtilahun@astranis.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 12:57=E2=80=AFPM John Ogness <john.ogness@linutroni=
x.de> wrote:
> On 2026-04-20, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Note that this comment actually applies to patch 1 of the series.

I only received this mail and cover letter. Also at work I saw your
mails dropped into spam (by some corporate filters, not your fault
:-), I don't see the content. In any case I can grab the mbox by using
`b4`.


--=20
With Best Regards,
Andy Shevchenko

Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090E341074
	for <linux-serial@vger.kernel.org>; Fri,  5 Dec 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921836; cv=none; b=dNCJoW3Xuj1jVfqhSHgUJWzmiJ1EpxKM+pSpBqUfpJmnPBYja2vC75A14rdx6SwkjiBevliZ1tyyVdD4sVi/UhZf6hHl/QBkzwKGiISzfJhy+ifqOggKi0el2L42DoN9MTBzJeB+BhW0PhRvnP/RfH2YFMsjUbjlYqKErlNTE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921836; c=relaxed/simple;
	bh=zaHh7yvSdJI2H/8ib+aZ5nZYFXCujSm6qKZIrrtiYxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8LjNEuGF0uwLkCVvttZE67I0YpDyAbeTUMjkJI0l8/aKr2jaAN6iIK9iES1s9/MTMesCu7vqdmUIA0TWIGy9GGqIf3hs2xKK0Ugss8v86DF+d5l6Rnb3Oa6R4a+/kIMGqvfGPOWQInliYrTZSN4ufbV3kK0/SzdxCJg5MUcNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgurxqEQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgurxqEQ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79e7112398so317963066b.3
        for <linux-serial@vger.kernel.org>; Fri, 05 Dec 2025 00:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764921828; x=1765526628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBAN7Ourdci5rucT1IiGjhFbIbc6AYeVQHJo1Y8/ihw=;
        b=DgurxqEQJBBsCarZFLUUTsXV0uaEZ2TCg+P6N+F9XPM2iRMjXy3CdseCLaDlrqwian
         Qj8yqRVvGPUwFA+v5jELbzR8vVyuBSHfVeHPZ4WtMPv/ipMI0FYFT2EXj4csWYMFQIOX
         bJbvwW0I/vA0Ha6PudIqzDeRuZKxfA8PNb76nxGQgwOjJNHO/SrpPvY/Vd6PKib7qHC6
         awRU9qpCDii6XIo0hc4x7RCRqCESY0plnMf3/n+usTOSgd1/8IGMIMpVuKT6+ThWjHpv
         qj1wlJskfJrcqSEH7k9AK2Uto8O8lhefZaT4xGqwfCTJRzibmYIUVmf9GiIHbCaHJf70
         +RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764921828; x=1765526628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBAN7Ourdci5rucT1IiGjhFbIbc6AYeVQHJo1Y8/ihw=;
        b=W6z1CEvEd3QeVDEgLYeo8Ndyh5LyJsR7t1olhoeBKgSuJ3Gd128l5ZAWkw74CWTNS/
         WepoS8+F3L2qa/B4YL+gMRw4pN1UuPuA8wA+4mjt11t8wPzGZJV7VMbtDayox3urMuJg
         yCoOFB2e6Vmng5kcUDu9qAF5K8AKzMRVoZPEUTS9IcjBDUnM2ZBb3FlOqLmGqOg0wAa4
         wQdOZNcQVGdr+y1sdq7YYnopdAwkvPU93hG14hEnhxpv72HbuVdOuXMxu9VQ6AI7o2ch
         CwT1QrtZlj7WRFgHxpkQmAWY6Lh7KnAV1+8NRsruW81xXL8RbrrkfV+EA59q6EHQqm0e
         c+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW2lbIwFEwDBHjpZ/Hiq88NH7T8s1eBPGMiWY2M2yKfniOkl5bjojj6n5J1HVUlZLA8YL65eQrTZD3i288=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYoCW9YTD4mFBrySFS3WdnisIF8EerrhhkyzWb7H9ZMv/uopJ
	Ov47Qfos6fNc8zVhAsQNgbfpxTmwqy8ty0+mx/P2w/dc+s3vZkLUWHeF8RWQNASgMxLZ2Wu9gIN
	nnZ3a2t+jpGiC2poFzCkRrgDGdkQNxJ165CT1uFY=
X-Gm-Gg: ASbGncsvUdHEGGh3HLqb6N8O5ncWwldFHYAEbfICD81FaJu9UL5DxSdgJla3Nfrqlht
	Rdgqph81x2sEDzkVIrIrqnBgCNBmaytGtHCfTrEgD44KTr1zGm6lT1IbRWyEVajzn2P+NWH7CFN
	Gujn+MNddnBv6tTkjfZMh6uXZsyD+FWP+HGzunL6JM1kDEPnyUOqFucmigHURQ06dWHS6ga7PUW
	doFz2oF0inhNKtyA9L4NxTmE7b8A4UqOdiXx0cB+0zdWwOXKAeugrLjyRA7faLOXyQsnvzUQ+9d
	7odOGpJOZw4WNP603k8IojjMsJq5deKAHgSRXWE0Yydvu/3nHSq187c+h5UATGqfwaRK6Kw=
X-Google-Smtp-Source: AGHT+IFlZDTmIbzkH/cBBBK730a4KdlEk6ejKIYFMCVD3ud3tgd4+rGXnsStcGv7DkwzFgqQtGZcW48f4Fn2kMHs7gk=
X-Received: by 2002:a17:907:3d87:b0:b73:870f:fa2b with SMTP id
 a640c23a62f3a-b79dbea68d2mr810148266b.27.1764921827670; Fri, 05 Dec 2025
 00:03:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
 <20251130104222.63077-8-crescentcy.hsieh@moxa.com> <CAHp75Vex-YzE-0PydYcSZGd24hkmbBanVHRTSsWQ_X-bc8kW9Q@mail.gmail.com>
 <aTJVz-BZKUjahVSK@moxa-ThinkCentre-M90t>
In-Reply-To: <aTJVz-BZKUjahVSK@moxa-ThinkCentre-M90t>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Dec 2025 10:03:11 +0200
X-Gm-Features: AWmQ_blCJkmpHl4eaf7ZrCcq3TDkF7rYmO8gnaLFrYV6qM2UsZ6aocIFYxsga5E
Message-ID: <CAHp75VdmzMCicN2FFoW3ANJYj2SDZBW9pbWkRm_knOgg8zQnHw@mail.gmail.com>
Subject: Re: [PATCH v1 07/31] serial: 8250_mxupci: add GDL-based Rx routine
 for 8250_mxupci
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 5:47=E2=80=AFAM Crescent Hsieh <crescentcy.hsieh@mox=
a.com> wrote:
> On Sun, Nov 30, 2025 at 07:29:47PM +0200, Andy Shevchenko wrote:
> > On Sun, Nov 30, 2025 at 12:43=E2=80=AFPM Crescent Hsieh
> > <crescentcy.hsieh@moxa.com> wrote:
> > > -       if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx)
> > > -               lsr =3D serial8250_rx_chars(up, lsr);
> > > -
> > > +       if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
> > > +               if (lsr & UART_LSR_BRK_ERROR_BITS)
> > > +                       lsr =3D serial8250_rx_chars(up, lsr);
> > > +               else
> > > +                       mxupci8250_rx_chars(up);
> > > +       }
> >
> > Oh, can we reduce ping-pong a bit (the modification of the lines just
> > being added earlier in the same patch series)?
> >
> > I think you can create a helper to wrap 8250_rx_chars() with split
> > version of the almost unreadable conditionals, this will also remove
> > the skip_rx variable
>
> I want to confirm whether I understood your suggestion correctly:
>
> Should I first introduce a small wrapper function for Rx processing,
> move all the complicated Rx conditions into that wrapper so that
> handle_irq() remains short and readable, and then, in a later patch,
> introduce the actual custom Rx routine and update the wrapper to call
> it?

Yes, something like

old_rx() {}
new_rx() {}

if (foo)
  old_rx()
else
 new_rx()

should be in the result.

--=20
With Best Regards,
Andy Shevchenko

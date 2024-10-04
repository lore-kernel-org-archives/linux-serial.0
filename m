Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242854767
	for <linux-serial@vger.kernel.org>; Fri,  4 Oct 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063958; cv=none; b=kOu2/u7aE7+PWD3t2/57aluFO/HfYtXecplzNUG04ji8FEoi1ioBUvqI1AeUrizHf0Hrr4K8AHI8tLfAejmmupYGuqzXjgooqwNVmeVxZgRfAT1sHmdbicOfUSQDoP0o5BpOLn8MKPmXu6cEn4A47gOf22ApsFGVbb/4KGvndKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063958; c=relaxed/simple;
	bh=TI6mcXb4V5s95OY28ThDa+Nttx+DA0b7i9XYbIv6P9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aqirug9KAOXXZHXezhdW7jVSee5Wyvd6aqSIaKU1I3BfRCA1dWwq8xyPd8jpdAnnBBY8aKM7S8r7YgrbIMzEcchABQ4sq4sBbWkJcgwDpKhtCHbdjgEUGWolPPoo/ST15STghAcR0+Khl+NRjkodXmz2ulA403yN2DdG23EYYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XUVrqwQ7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XUVrqwQ7"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso1749098a12.2
        for <linux-serial@vger.kernel.org>; Fri, 04 Oct 2024 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728063956; x=1728668756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hTEi2pGCxMRGUpF5+1bzMouLoBbQyVgP6nKgujfGZc=;
        b=XUVrqwQ71xfWtyrURKkM2S/CkVr1OI6s/zA24zO1EN9F6sppGPlvRBvq20B51s55Zx
         0GmFz+NcMX5ThEAEfsMPAfyA4owZHuzJEHJWd+YQfm6LJLBC9mICCgmDmYPeKAcEpNTV
         rRJtsZbUIDD6JADlFdrfVKYOGMwvqMlth+MSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728063956; x=1728668756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hTEi2pGCxMRGUpF5+1bzMouLoBbQyVgP6nKgujfGZc=;
        b=OnYi9oTHe6mJiyhkjazn63zCAXcCR1qZigVqlFmAMFLgflgda9Af0FN9Pv4XH2LrMx
         7zXDKD2K9psuTlEg0ekMfiZ9xmhTwK+kvlDOOuMsPJ6+8H+xxfKyH/n0rqay8xj7tz2l
         xvRmfs+qnrzuBznYgZsdeqmv4TJPzNzWJLayhYjk34pE94pR5/8STwVff822h7PTjMHq
         9HS6Zf7ItecPDvL6/YkRblYECzRLUmTJuEwL2ZsNWc7+vBWvAWTPv4LFp+IqQs2XaxuH
         DJjCKqLt17YEv0Gz3NzBALPI0whQAwxNiyhDYMLozAPPufZg1caYBSRQGqIakaha4QGc
         QQxg==
X-Gm-Message-State: AOJu0YzHVxsdsVRwZNzhavHrlqfuo/MQjyO/m3Pqr4cssbvQbROxKSQ0
	ejcoXqnJTiEeJxi1WsmkXdU0g8oyvrhpyigbZ9wTJcc7fukcPt50Y1ln09JrWm16ivaNRvGD/HI
	=
X-Google-Smtp-Source: AGHT+IHKfB5RBNG892KluPnNY2awuHuyxUs79lXdV76TWiytW399NS6rRa5JdZXYwR0DXyOZb1vE3g==
X-Received: by 2002:a05:6a20:c78f:b0:1cf:23cb:b927 with SMTP id adf61e73a8af0-1d6dfabacc3mr5892431637.34.1728063955740;
        Fri, 04 Oct 2024 10:45:55 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c35e68sm219665a12.65.2024.10.04.10.45.53
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 10:45:54 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e9ad969a4fso1473441a12.3
        for <linux-serial@vger.kernel.org>; Fri, 04 Oct 2024 10:45:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f8f:b0:1d2:e1b5:2b51 with SMTP id
 adf61e73a8af0-1d6dfa1e516mr5534269637.8.1728063952820; Fri, 04 Oct 2024
 10:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid> <CAJZ5v0hmf55OA1f4egzE7F0ET+7af_+pcxmnOSxO5Snd6L5CrQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hmf55OA1f4egzE7F0ET+7af_+pcxmnOSxO5Snd6L5CrQ@mail.gmail.com>
From: Raul Rangel <rrangel@chromium.org>
Date: Fri, 4 Oct 2024 11:45:39 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CRYoH_-rY7hMgasbkyqEBpgVfH6PZRzuaU=2g4S_oGtA@mail.gmail.com>
Message-ID: <CAHQZ30CRYoH_-rY7hMgasbkyqEBpgVfH6PZRzuaU=2g4S_oGtA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: SPCR: Add support for rev 3
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-serial@vger.kernel.org, pmladek@suse.com, rafael.j.wysocki@intel.com, 
	ribalda@chromium.org, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Sep 12, 2024 at 7:39=E2=80=AFPM Raul E Rangel <rrangel@chromium.o=
rg> wrote:
> >
> > Revision 3 supports specifying the UART input clock. This allows for
> > proper computation of the UART divisor when the baud rate is specified.
> >
> > The earlycon code can accept the following format (See `parse_options`
> > in `earlycon.c`.):
> > * <name>,io|mmio|mmio32|mmio32be,<addr>,<baud>,<uartclk>,<options>
> >
> > This change makes it so the uartclk is passed along if it's defined in
> > the SPCR table.
> >
> > Booting with `earlycon` and a SPCR v3 table that has the uartclk and
> > baud defined:
> > [    0.028251] ACPI: SPCR: console: uart,mmio32,0xfedc9000,115200,48000=
000
> > [    0.028267] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '1=
15200,48000000')
> > [    0.028272] printk: legacy bootconsole [uart0] enabled
> >
> > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serpor=
ts/serial-port-console-redirection-table
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> >
> > ---
> >
> >  drivers/acpi/spcr.c   | 5 ++++-
> >  include/acpi/actbl3.h | 6 +++---
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > index cd36a97b0ea2c7..67ae42afcc59ef 100644
> > --- a/drivers/acpi/spcr.c
> > +++ b/drivers/acpi/spcr.c
> > @@ -209,9 +209,12 @@ int __init acpi_parse_spcr(bool enable_earlycon, b=
ool enable_console)
> >         if (!baud_rate) {
> >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, ioty=
pe,
> >                          table->serial_port.address);
> > -       } else {
> > +       } else if (table->header.revision <=3D 2 || !table->uartclk) {
> >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, i=
otype,
> >                          table->serial_port.address, baud_rate);
> > +       } else {
> > +               snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d,%d", uart=
, iotype,
> > +                        table->serial_port.address, baud_rate, table->=
uartclk);
> >         }
> >
> >         pr_info("console: %s\n", opts);
> > diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> > index 8f775e3a08fdfb..afe45a2379866a 100644
> > --- a/include/acpi/actbl3.h
> > +++ b/include/acpi/actbl3.h
>
> The part of the patch below is outdated - SPCR v4 is supported already.
>
> Please rebase on the current mainline kernel source.

Oh awesome. Should I send out all three patches again? Or just this
one? I think patches 1 and 2 can be merged.

>
> > @@ -92,10 +92,10 @@ struct acpi_table_slit {
> >  /*********************************************************************=
**********
> >   *
> >   * SPCR - Serial Port Console Redirection table
> > - *        Version 2
> > + *        Version 3
> >   *
> >   * Conforms to "Serial Port Console Redirection Table",
> > - * Version 1.03, August 10, 2015
> > + * Version 1.08, October 7, 2021
> >   *
> >   *********************************************************************=
*********/
> >
> > @@ -120,7 +120,7 @@ struct acpi_table_spcr {
> >         u8 pci_function;
> >         u32 pci_flags;
> >         u8 pci_segment;
> > -       u32 reserved2;
> > +       u32 uartclk;
> >  };
> >
> >  /* Masks for pci_flags field above */
> > --
> > 2.46.0.662.g92d0881bb0-goog
> >

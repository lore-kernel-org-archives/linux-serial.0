Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9714F9E7;
	Thu, 16 Jan 2025 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047667; cv=none; b=bsICiqFw7+BEw9x58YwaNnvTFUB2/5U3wen77I2+aaU8USm2cigEuem4ybxxZtpirV+Q/C6X+CZP3ch007QsKgxw4bX5Y+wRd7eepYmKIU5zkHkTajAxwoeRQTKo1zEpHkgxMbyYVd803+G3cY7pT5OF5CSdMR9uT7PZa3ekNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047667; c=relaxed/simple;
	bh=368rv5UrHh14KNEsa+F5OP+FALIJ9EvCMgKrFaIGojQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IueS72f1G6hHSvzIlpPKpaZMSwRGgqCliVmpFzgihEJg6Y6PolCGt5zTwesKAto57Om7A5EO4TLY0ZysL6h3Y4TJNZSSjzite2u+cOOWqlPCNXjnFAM9D7zEqDny7c5m9h+cRAv1qMH3UEm+JjQMYSS2vB1D4d8KzwfoT4u8KSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buaWGgKg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buaWGgKg"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa689a37dd4so249873966b.3;
        Thu, 16 Jan 2025 09:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737047664; x=1737652464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=368rv5UrHh14KNEsa+F5OP+FALIJ9EvCMgKrFaIGojQ=;
        b=buaWGgKgE1kwvt66+kqKL2c+wFJTsZ1jhPyDMK4H+Fu2QurmVNJaZ85EMFPC3hM7Am
         2vJIsfkRAoCEgAqIoFYxXDLBNBzesLzllqCqq6F0oeZMw0N0dSalIGiOMm5eiRqY43nh
         oGsMJdJFvu147VFnlz9TPiC1uv3BnxWcJGSn/m/Ig2x0NbnANe6y1/RIfG8tWF9ZbFEB
         sgaLMv+0ENoeoyK3YuRZMZXu9Et0Wo698pE1J6dNLS9sEx8VGCMTQiQYDpcVUez5vXtL
         Bmn+11Dm2neUfFe2z8Ut4Bsnu8Bh4vI1Q4IaFu/XZh9/jpAhQhsN/ppx/Va0VB32KlRl
         4btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047664; x=1737652464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=368rv5UrHh14KNEsa+F5OP+FALIJ9EvCMgKrFaIGojQ=;
        b=JFpK75gHWttRJj1AXA5Pub1OBkStCfRvkBU/xBWsn0dRWt4Xvkd2nsv5X2l2JkqK9U
         uxw7v4IN14+dW8dJwCZV2/irW7NxCss8XbTE/VySKrNDQhRxc+ClPH3jk3q/T3FjesEf
         aWYfd2INm8/xdf0dMaBDtxNTE+o1sL1K3YqXEGbPU7qXE4ZkkvEE3gzCIshGbiEDO4SZ
         vhVvX2bZtzQLwcM9DIJj7uwBWEad5c5GHF5yvQvLlfLHTwzDPvnASex8H5HEu6kd5aHq
         r6vLeiUEu4iil6cMyfPi2BZbIwL5fPndOiB9Ov95FNtT8i/FtDjBAxr4EfsnxuVhdmkO
         ZSxw==
X-Forwarded-Encrypted: i=1; AJvYcCVcBBjGOpFWMB/cEjHi4/tG4OWxLekUc51KlxBIMSQGIPyQWPCqBLacjIH27tkCe78vOblP0F1DaDmiNnfy@vger.kernel.org, AJvYcCWDJa8DapprzcKn/3Hj1CiqSHspiprSuUK56T+LxAsW7kN7bGfquCtG83IX52+mvOzJFEu8HTYW/XcJECU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynyNJXl/T8laS6gXYJy6XqliCtHxovsRvsKcP9Y+FLSgs4wO+p
	7Y1tAco63d+CZojRYHRPgz+XF+8ikznCWjmTXGmP/qeFnJZXmTDIPCxLKZVxuewdhkElGBZ1mx1
	5e1T5rKaAGpcfK30a1u475QD9uKo=
X-Gm-Gg: ASbGncuqWyb/UxLaRyud+HIE+89ldPGWFz7xNrxYwI4oEHbFIMryeUhuq2lNfrlVnQM
	g574+RdGwOpvP8ElOnmi0Rv1OZP1JuLJb6wPuNnbv
X-Google-Smtp-Source: AGHT+IFmpu9D5PwB4xpvE5Hz6iPNqZaoqTD2s07bqglD4lKPZWCCzoylOo1+DWvTnZc7180DCKptlA17bI1qE+Ck+JQ=
X-Received: by 2002:a17:907:c03:b0:aa6:84c3:70e2 with SMTP id
 a640c23a62f3a-ab2ab6fe0d9mr3026777566b.20.1737047663998; Thu, 16 Jan 2025
 09:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z4jLU75SU53VGsRU@smile.fi.intel.com> <20250116093203.460215-1-andre.werner@systec-electronic.com>
 <be1bc254-da95-47c2-b81c-e630c0f924b2@kernel.org> <Z4jW_TUQ8RNr1FWX@smile.fi.intel.com>
 <834d7b6e-27a4-41e9-b36b-2bcbd0504bd5@kernel.org>
In-Reply-To: <834d7b6e-27a4-41e9-b36b-2bcbd0504bd5@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 16 Jan 2025 19:13:47 +0200
X-Gm-Features: AbW1kvYiJenLQ0QEkWD9c27njPAMj_E3BXY5dAC-Ov9MLRT4UCTEMvy5iBavw8E
Message-ID: <CAHp75VfFyOChqNEtdot0_Pzb+E2EFjGPuJPjvpL-UW0_FsB1Kg@mail.gmail.com>
Subject: Re: [PATCH v1] serial: sc16is7xx: Extend IRQ check for negative valus
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, Andre Werner <andre.werner@systec-electronic.com>, 
	gregkh@linuxfoundation.org, hvilleneuve@dimonoff.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	lech.perczak@camlingroup.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 12:02=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> =
wrote:
> On 16. 01. 25, 10:53, Andy Shevchenko wrote:
> > On Thu, Jan 16, 2025 at 10:42:14AM +0100, Jiri Slaby wrote:
> >> This is threaded weirdly.
> >
> > Yeah, new patch (version) =E2=80=94 new email thread.
> >
> >> On 16. 01. 25, 10:32, Andre Werner wrote:
> >>> Fix the IRQ check to treat the negative values as No IRQ.
> >>
> >> Care to describe on what HW that can happen?
> >
> > But how does this relevant? The whole idea is that neither I=C2=B2C nor=
 SPI
> > frameworks do not guarantee the IRQ field never be negative. This is
> > the fix to the previously submitted patch.
>
> They do AFAICS. Could you be more specific?

Hmm... I have looked into the SPI core and this behaviour seems quite
new. Documentation still says the same as before where it's not
guaranteed.


--=20
With Best Regards,
Andy Shevchenko

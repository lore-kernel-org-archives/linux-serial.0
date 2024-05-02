Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2673143AB3
	for <linux-serial@vger.kernel.org>; Thu,  2 May 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643423; cv=none; b=DnMcM7hUzvJYbaaQOXJScP/GLccCYCHB0ExqRDFYYieVhMYwRSH2qmDk+fRkYWyHGwX2ivYMDzm9/0D37gbhMCbo3vxNY17TvTZ/bwQfuzdcW39O5pq3qeNxOoQ7NVr0kHKM+VvA4psWvHiO4PDQXCAyoqOn0mYd4WFcOKcSveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643423; c=relaxed/simple;
	bh=0JWiyOm7Ozvw+jRdtZ5s7Kqw86qKGc6L0YC4qTgpF0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwHpnQtgbWxHN173CH43epyRt80YIU/IZViC6+oCmiFh9SL0MKvmtv+IRVAPninnj0Qr4P9WD0R8j0OQ8E7AdNz03HwzBt2H4nsBnG0zpRfR9g5YJcC6oPPuhftlRETnILzlZPJgXnQf3JSPe7jT/6wsNtSp7SF7ZLhed4ZrSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZGqYpXF+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZGqYpXF+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ecff927a45so2222845ad.0
        for <linux-serial@vger.kernel.org>; Thu, 02 May 2024 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714643421; x=1715248221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0L3flH7yZNX51bFJ6y3B+1+jhZGz/TS681Tx1TYzzOY=;
        b=ZGqYpXF+nnoJEhgTquFu/m98uKm0DoxPbnU1x7kf2a1dRapq4ze9ky8B5iGgloKyOl
         RcmMGe7abWMqC7X+US4brJGhTTDfOA3A7JPx1DDAC+k217xfSkrDnyCjxOkK+FaP97qJ
         82SVkZuGISn3IGL+dylMsPyHz9I6KtdWveWddk/JhprQdbxwBy3LZLerNkmtgg4Qtiy9
         3YQbgcRndZUk4fiDYlsR8bJWYhqXhyjsedfcWExo8OJH837A6OWSMjsSoikTkyDaXZE/
         eOLt3putyHsYIwcn1O0YXIZhJz7dE2muEOklbkcoy3fV6jvkfnLXKkiT5two+n1n/yk+
         Zk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643421; x=1715248221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L3flH7yZNX51bFJ6y3B+1+jhZGz/TS681Tx1TYzzOY=;
        b=DfqNR7+K8kfByE2JvI43AvcHzNoJYp0OcStfSp9piHMq8X3wJXEqpz8bofDMJfXwQ1
         Oh0sdujCGtFkR8J7KWVhM9x6oFXrimBUHKUcK5XL9nC9L34tf83zA5BIJ6IoHn1gIrok
         Ga7v0bHMQLnuPpL3kp1QO2yjFY86Jt7Eq/TyRy1VSpUzUEG5i+VnGZsrQrw+nxCfWUFz
         pvteG5J+ags5/ofN9UhFM37BoiEeLwL7zLOEZpinWksf3j4DbILlLswUL38YgpbVjFuP
         n8p+uP7sf73E8GCCEljWPGYhHpFeABuXZTCFceCwgu6DpKoqC9Y8NKY8BPBmufH3/d1d
         B0RA==
X-Forwarded-Encrypted: i=1; AJvYcCX3PN9H1THAR1KwStWogs1UOOHY2v6+sddVsffDa1WWI+abfMwSvOccSQ+KTojvLK5mXqBQnj93QutEewLRzFrXBh4WA82lp10n2pqs
X-Gm-Message-State: AOJu0YytGpSZAqvRm1zqo2v+7tw8mXOA+dO6wZG47bt69b7V3oNjq0nJ
	6xWcY84q3gQkMgdhZb6GSSHPQ4w+etvFKdUJPZ5d185k3TjtbRpNvyJUSrAotgQ=
X-Google-Smtp-Source: AGHT+IF3qps04ERKWX4kOxvSEDon6CGWqD+FZR4lIipoIhxGureiukZlSMZ76xOlV5hwocc8u3+KoQ==
X-Received: by 2002:a17:902:c404:b0:1ec:3f2e:d8e2 with SMTP id k4-20020a170902c40400b001ec3f2ed8e2mr6671474plk.15.1714643421414;
        Thu, 02 May 2024 02:50:21 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090341c200b001e5e6877494sm852994ple.238.2024.05.02.02.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:50:20 -0700 (PDT)
Date: Thu, 2 May 2024 15:20:08 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 17/17] serial: 8250: Add 8250_acpi driver
Message-ID: <ZjNh0Llcx+0VHevy@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-18-sunilvl@ventanamicro.com>
 <ZjNaR-YtVTm4pbP7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNaR-YtVTm4pbP7@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:17:59PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 05:47:42PM +0530, Sunil V L wrote:
> > RISC-V has non-PNP generic 16550A compatible UART which needs to be
> > enumerated as ACPI platform device. Add driver support for such devices
> > similar to 8250_of.
> 
> ...
> 
> > + * This driver is for generic 16550 compatible UART enumerated via ACPI
> > + * platform bus instead of PNP bus like PNP0501. This is not a full
> 
> This has to be told in the commit message. Anyway, we don't need a duplication
> code, please use 8250_pnp.
> 
Hi Andy,

Thank you for the review!. Major issue with PNP0501 is, it gets enumerated
in a different way which causes issue to get _DEP to work.
pnpacpi_init() creates PNP data structures which gets skipped if the
UART puts _DEP on the GSI provider (interrupt controller). In that case,
we need to somehow reinitialize such PNP devices after interrupt
controller gets probed. I tried a solution [1] but it required several
functions to be moved out of __init. 

This driver is not a duplicate of 8250_pnp. It just relies on UART
enumerated as platform device instead of using PNP interfaces.
Isn't it better and simple to have an option to enumerate as platform
device instead of PNP? 

[1] - https://patchwork.kernel.org/project/linux-pci/patch/20240415170113.662318-14-sunilvl@ventanamicro.com/

Thanks,
Sunil
> ...
> 
> > +	{ "RSCV0003", 0 },
> 
> Does it have _CID to be PNP0501?
> If not, add this ID to the 8250_pnp.
> 
> ...
> 
> P.S.
> The code you submitted has a lot of small style issues, I can comment on them
> if you want, but as I said this code is not needed at all.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

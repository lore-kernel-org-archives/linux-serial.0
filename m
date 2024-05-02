Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B985644F
	for <linux-serial@vger.kernel.org>; Thu,  2 May 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643718; cv=none; b=gTLdJBNzpA9NIUPX7F+piebi7fQo2y1ndsj/If6pe6hlKh3SeXE1WRe0Ckky3GY5SizDpx6GsI2b/JtRKlw4EQ8CnXGtFWm6BUJeT0bRQFAdO96iY+mwhhM4HNz3u4VgdrN/9HxsPGFm7YnKE0IrQYZOIr67Nc0grtPHR2ycwg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643718; c=relaxed/simple;
	bh=qRdP1MaAcqny7WVri5XKFV3uC/ES+lwc76NtRhAJ63U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7GJynq6P0yiMjsgonXK+Hyxn7cdPEjgOXQBkszqH+t/jmYZ8aEPn5kP4FKUQ+EGSC62UCR4GJu12ZpqKWVWBq0uUQ3Q4ZX8eqxpaLXv/O5UUteWX6f+g/C6DhosHNdT5U3q9JMs5XVK0aCaBUzhJHjfwqN09iOcd448LBhWhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WD6C0WeX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WD6C0WeX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eca195a7c8so12240485ad.2
        for <linux-serial@vger.kernel.org>; Thu, 02 May 2024 02:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714643717; x=1715248517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NL6wf55BXPa+yyuBuN45neIFKGEebMs0pSULB1fzRIU=;
        b=WD6C0WeXH6sRZovf9W46qUF4W2Ncg5Vw+flKXSqE3F/7A+DxQ8ICk7VFG7pscqYqc0
         qmZ9tg3TwJCwg+IaKxASoOyqdwZG4r17JzQ2o5ezDZ6MqavkBPV8FdMr6S8/DmKggJO/
         pPv2eup29iAieYBWyd28ZP5HsXwqYtUzVkfSmjOI/3wyBJNGu/StALD/K2hr55OrZIRV
         j/4wmo3AVJ7G29eO0ixgQadmF439ZZ1i0q5muCUQCJ0T2O1c/Nqubi57pIpLiFeNM+MH
         ztDuzJUwSnA6vreLH3rkphKejTs0PlOrWv8lIwlM7UFsKVPcm6P5/vmbEyaryO3Quuu8
         4lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643717; x=1715248517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NL6wf55BXPa+yyuBuN45neIFKGEebMs0pSULB1fzRIU=;
        b=ZCJMZwTp43/2lXGlFScNOUPbBa3BqPd1QJFuo91iuU2mHX4ydzAWeNOxyF6aRX+D1J
         8elMTGITG+wy5ipRlvK4y3CTvFT0DPClzQBpL5/Jecq10BFA2rmNHVECbRWPYC7MAtD1
         JY5r+OVHeN3yMMXqFuvKLwc3mKCj/iGOs0Zhalz6Ete0mzfzM4rmi3DFm949KGfIJuz+
         evfYUQqVoP4+Ipo7tzcDv/buzxqM5zBn2Px33NbkYqYp35iPKsl/i6LMTYC1QQWTCpzr
         flKW+5rn8CUUNP2+b+t3lnQyC8rUo0Y+LLykuSSXf7lNNmUqq19kE8piwUy1dEEeCV5C
         kaRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBtuqdkVLIIp0ztyQb60ZthzDIZtnC96ovWnQkMpJ8C/1Sjt+BgmO4css8k8MWGUSqZQW2DVxfObLig6BbIh1fz2XA9dkTpbEOUorz
X-Gm-Message-State: AOJu0YzwmH3klyxpdNQeK0ZtkRH6jYF7DXvfLyFjE/2hn66Ib7jUk/Qc
	zWh/HVZpQKb3Z9vtvcWVSnHFb+0WBEfOFoab7/SRC+rdgp1pGynMxx6Hw9ujWFM=
X-Google-Smtp-Source: AGHT+IFpK3bIq8mezuHv2XyP6jnQjh19B8eyQtbmKS7Jf/SgRv411rIyzxq+sdALFrGRrZq6EWk8mA==
X-Received: by 2002:a17:902:e80b:b0:1dd:c288:899f with SMTP id u11-20020a170902e80b00b001ddc288899fmr5793344plg.18.1714643716808;
        Thu, 02 May 2024 02:55:16 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id jv21-20020a170903059500b001e0e977f655sm867362plb.159.2024.05.02.02.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:55:16 -0700 (PDT)
Date: Thu, 2 May 2024 15:25:05 +0530
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
Subject: Re: [PATCH v5 04/17] ACPI: scan: Refactor dependency creation
Message-ID: <ZjNi+QaVZUX0Ntiv@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-5-sunilvl@ventanamicro.com>
 <ZjNaxvh2ZSfDcTa8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNaxvh2ZSfDcTa8@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:20:06PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 05:47:29PM +0530, Sunil V L wrote:
> > Some architectures like RISC-V will use implicit dependencies like GSI
> > map to create dependencies between interrupt controller and devices. To
> > support doing that, the function which creates the dependency, is
> > refactored bit and made public so that dependency can be added from
> > outside of scan.c as well.
> 
> Side note: If you haven't used --histogram diff algo when preparing
> the patches, do it from now on.
> 
No, I didn't use. Thank you very much for letting me know. I will use in
next version.

Thanks!
Sunil

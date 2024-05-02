Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86357888
	for <linux-serial@vger.kernel.org>; Thu,  2 May 2024 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644162; cv=none; b=BYIELT3RVI9zxlROOtUUMMVPRMKfsknAHzCOYn0l48Y1MM2ZlaD7Klu2Dlov00ABlysm4cyvFvJiwpaS2iyf49xjuK9fux81pVc6Bohr8j9zeIoovwWGQIUopu6xUeEbJvpMrFexfdou+KHdZbdcoyRaQv0FDGf0nKaxjeO4kto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644162; c=relaxed/simple;
	bh=Jyakk2Re/yXumSvffFIqIAQUyky6V4gBP2YcQa+LJI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHGcNltu2y/fu+ryPutdOcpbuiSdU2JnBCWFbFZ0Pw0ht14BoPnq7/dYOx97LEVgKv/7IT+4NlVs6+PKwFNzEVGH+7q2acsi7qnAazys967uvMfY7w8gdL4mfLhl2OWvVhRkX+1GlmVtge4yqFL2YRlMrihUmkZjdbn9qTZ3F58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DQqmBh4m; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DQqmBh4m"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso7983845ad.2
        for <linux-serial@vger.kernel.org>; Thu, 02 May 2024 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714644160; x=1715248960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+kMTT3PzTLyPVaeH+DM1bYJEhGQDgrI4wH+0p7ikXNM=;
        b=DQqmBh4mp6/pzjPZTKqH0p2FqsO02oCnzubXyzXAeTGoYGfn6wHXxecXlsfx1ltAHY
         TTeATZziUIZhC3Y4NurLD8gWd9QT5KBP7KZdJnwyeZrkrxgy6rQPWcODJEzP3QOhji94
         qafZmuoJnnwLvtKssFFMf/FsYoGTgwUz0GDH6u04iyPkccTBg4WXd9fO8YfL+8YtkVHP
         ZJakestkypepSyAfoIhJRJ6vXqhdDeL+G6D6aukxxv6aK1sUZNyNa4LbWsoNjNFmG3L5
         IhEtUmEQGoR4ZoM+OkwUcyGbEFQSPQN9GRGf4Nw1gv3oWOJDtPWDajn1xdO4AbPHqIBs
         9kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714644160; x=1715248960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kMTT3PzTLyPVaeH+DM1bYJEhGQDgrI4wH+0p7ikXNM=;
        b=Li5MEATEW3fGzqrPgnhYz75n+qhyQXOGl8fPsSvCHyKclyNAD+gjdy9kIv9kx6Bd0p
         QNxtxQ/dNdW0W2PSOkHwRekTg/6uloNPXj9cXfS8K0yrJAljWDt9PFPfJbJMo5QUsN3F
         npe1lwpNedSgyAwdJRgfXoMqFJQcu3XnrcTL3qcleqSMjOI7hRuAX3dYdgRfVhKLdtla
         JzFYXzgyWuYkcWbeZZ0XBhak2t04Noo7mdVtW1oSTRriVYkSRGzgcG3XAC5nSQrIHad1
         e7fi7uUji9L8CX812ipecBiR2aZYHdWL/3E2TQvO+xy4oiwpGcTI1V9DYGzpu0ozXvVl
         IH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKZhA1ovaHUcR3VsaGiC116tTS3BpkrBQg9kT83rh5e2hu43V6gxESJh0Kq3vLSTsfkBzSn0jga4I8Z5tIJGnAYU9Gcg4BWVQ/qGbo
X-Gm-Message-State: AOJu0Yw2fItsjryHmxHj7hv49ISKnGtEObhnqiHtCV31Cuf1qQtm4wFa
	1ewLbzVoycpBA/NE1pUSC54DCke8o+Do5ruki7IzNODK5vX6v9OKPaY1pzbEids=
X-Google-Smtp-Source: AGHT+IFMGhdu0SIDQn/0fGRllf2r0ZaqwxTF1S1fhXPFoF9kfSM7pOtZuP9eC/v0lBtCNsAcHvZnOg==
X-Received: by 2002:a17:902:ce8e:b0:1eb:5323:c320 with SMTP id f14-20020a170902ce8e00b001eb5323c320mr7103763plg.56.1714644157999;
        Thu, 02 May 2024 03:02:37 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b001e604438791sm896026plk.156.2024.05.02.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 03:02:37 -0700 (PDT)
Date: Thu, 2 May 2024 15:32:25 +0530
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
Subject: Re: [PATCH v5 03/17] ACPI: bus: Add acpi_riscv_init function
Message-ID: <ZjNksbTQF1lMQ0k0@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-4-sunilvl@ventanamicro.com>
 <ZjNbvlUoCfa5UUHF@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNbvlUoCfa5UUHF@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:24:14PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 05:47:28PM +0530, Sunil V L wrote:
> > Add a new function for RISC-V to do any architecture specific
> > initialization. This function will be used to create platform devices
> > like APLIC, PLIC, RISC-V IOMMU etc. This is similar to acpi_arm_init().
> 
> What is the special about this architecture that it requires a separate
> initialization that is _not_ going to be in other cases?
> Please, elaborate.
> 
This init function will be used to create GSI mapping structures and in
future may be others like iommu. Like I mentioned, ARM already has
similar function acpi_arm_init(). So, it is not new right?

Thanks,
Sunil

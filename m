Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909D1F7089;
	Mon, 21 Oct 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513431; cv=none; b=pY2B8XmyNQGfBSM784i890Um1mm5j73wi/OaF8YNS3cbQxvWqxU+3s+fGAV8/Wwgxc2ft/0fSW8v9kvDQCvvXmr7jyTwYbMdf/WCHUeh5YEDKWI5mBOM4O0w0hJ1yeme8dT3yPQVJveqtGiG5kaI8AFdRKESahVLv+eE4/FqAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513431; c=relaxed/simple;
	bh=x9slBDnJ/jFLTcaoGTUOyBDa28EHs3QGP8fa7TcQpqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jhpe2dmLQaPOigmA37qv5G/6sGM/LUkKoVgnIGqhJ2jcqRRn02VFEMR3q2aSrZ6mY43l/071ML2Hkc3R/YZdSyZ/U03bF4xeKf6AG9jhx7sBOXOZrqC0bpybtgfzZkzeZoJ2gHM/5mfP5Ot75Rqqeq3SIyZ8cqQvfKGcJ+G9d/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ler/M14P; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ler/M14P"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e602a73ba1so1471170b6e.2;
        Mon, 21 Oct 2024 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729513428; x=1730118228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgXSaFGWlsNd0CbHWwjqIDW8aVdA/ighcZzKc7cVXd0=;
        b=ler/M14Pvr+PqN1I2le5IzHjACmFeDxPSgKIPZiJGiAJfKSrp4AxqBsdT1kyg8apW1
         m7CfvcP0lm3LwOK5zeBhfj4eRO7ZepC+5MZYVFF/uLiIIesLtQPfpKyBIM4sZ0IevhLk
         v60ZG8NSsrLZqp29wzrFElVeYQ3VM0l9GOGqE43Pe2P0de0K9uTJ7SmVqUY3+T4sLGOg
         yhNqrZem9K/LOL0J/Is62HRic9Vnr0WE2NJHg0l6GJh6EcwdpU8Zi1vb7EvMkD1LjNmM
         5x8fWR6JWQ0A4nEt/HsoxF2oFJCKONNFXOmKh/Vm2mp/Go+uCedUkKBxjrUEGyu6dmgK
         E9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513428; x=1730118228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgXSaFGWlsNd0CbHWwjqIDW8aVdA/ighcZzKc7cVXd0=;
        b=X174Us7KiX919R1N/e7Drh/4Yp3t5BLVai7GLyy3uSZae0CHxVkpjJyYzvshidTPuQ
         F+HU1tfPpRGY+M0eT2QfG0Pdib674Sxa4s/uoZh8yyEyfWqNnXVytqf1IE3I0oO1NPC+
         WbWUR+eTawIlv5Amv5EeV5DZSrFfe7LHF5414hY3X5lNOfmh5tFJsYU88ZpWNKQuIH3V
         i4yesS642nQzNCSEubQCnPG3OJ4fY3o4/tWn/HhYhM0h4Hh6LsdamhbN/t3lmW/EW42C
         j1mN9h3juxnWxP0HabGnAVTvoibhtBLskfYUWr1XCQfMeMtyamLby7rFNcCrAijmWbHR
         uboQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZDsaNsYfbSZTFSKI015scFl+1MvJ9RNUIl4EIcJwMEM78BjvbCNQJCQ6Mejqt5jmnpEGHAgpDsas@vger.kernel.org, AJvYcCWj5qMpWRGdh2KDNGzskPWspcfUuambngDWosYLm4v0FpVkwUSDna6W6RzDqJ09J+0mdoAtFuTGm+1T7VCu@vger.kernel.org, AJvYcCXSrCCvAwqthx6vw9SPsTht5/hcfOimJd4AlpNDqCINuTSSx36aaTQKtzsA5OejJrb55gnM9xs9LOBqqv0P@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUmjeJfRv4BVDwwXH27nRj/Q/AGVBugg1Wj5aN8DUbMbfse2S
	dCxkXvyXv7x9s8Agb+tOUBKu8NDZi1kg/7QNoddGQY3k66mA7Pm6
X-Google-Smtp-Source: AGHT+IG6AbXnc+JnTbQtqAFHScJgxFYihFzpe/ayUKl45Zmwl2fKaZXsfhokHl5gSrgPWj7HcVOoDQ==
X-Received: by 2002:a05:6808:2f0a:b0:3e6:1170:a58f with SMTP id 5614622812f47-3e61170a67cmr3003068b6e.5.1729513428463;
        Mon, 21 Oct 2024 05:23:48 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaebd061c1sm2332892a12.19.2024.10.21.05.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:23:48 -0700 (PDT)
Date: Mon, 21 Oct 2024 20:23:30 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Inochi Amaoto <inochiama@outlook.com>, 
	Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo
 SG2044 uarts
Message-ID: <2zawe64brm3sfuslh443352wfupgnhb4xw7jragkzxu6kgg6t7@b4qiya3jdij4>
References: <20241021072606.585878-1-inochiama@gmail.com>
 <20241021072606.585878-2-inochiama@gmail.com>
 <20241021-outlying-washday-8f171dedc703@spud>
 <r5ngs2j776jcy6sfirwzmtsoljotatfvgmlmv4sj4xksye2bff@xtn7adafbpfz>
 <20241021-rosy-drove-1ae3c8985405@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-rosy-drove-1ae3c8985405@spud>

On Mon, Oct 21, 2024 at 01:21:58PM +0100, Conor Dooley wrote:
> On Mon, Oct 21, 2024 at 08:18:58PM +0800, Inochi Amaoto wrote:
> > On Mon, Oct 21, 2024 at 01:10:52PM +0100, Conor Dooley wrote:
> > > On Mon, Oct 21, 2024 at 03:26:05PM +0800, Inochi Amaoto wrote:
> > > > The UART of SG2044 is modified version of the standard Synopsys
> > > > DesignWare UART. The UART on SG2044 relys on the internal divisor
> > > > and can not set right clock rate for the common bitrates.
> > > > 
> > > > Add compatibles string for the Sophgo SG2044 uarts.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > > index 4cdb0dcaccf3..6963f89a1848 100644
> > > > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > > @@ -58,6 +58,10 @@ properties:
> > > >                - brcm,bcm11351-dw-apb-uart
> > > >                - brcm,bcm21664-dw-apb-uart
> > > >            - const: snps,dw-apb-uart
> > > > +      - items:
> > > > +          - enum:
> > > > +              - sophgo,sg2044-uart
> > > > +          - const: snps,dw-apb-uart
> > > 
> > > Why does each vendor have an items entry of its own? Seems like needless
> > > clutter of the file IMO, except for the renesas bit.
> > 
> > I just follow others when writing this binding. I think it may need
> > another patch to fix this problem, right?
> 
> Yeah. But I'd hold off to see if someone gives a rationale for it being
> done this way before sending that. I've not deleted this thread, and
> will send an ack if someone justifies why the binding is written like
> this.

Thanks.


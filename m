Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EB9DDAD;
	Wed, 23 Oct 2024 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729643584; cv=none; b=BUG8TBuIkoDT2Pr0DRQwbn/k2ippffgqWFUkaNDEUH9XzpI7lpegsUBEYRTAIHd/tXXBnEdHlt53RCtRAMPZFGEm/UxDQHvIX4cK/tHu8TG3LjFaj7fAeRKnVd4rMaohvL9SRJk5mdBS2WmVNZ5AogxdQeFlKJNt4lQvMbq96iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729643584; c=relaxed/simple;
	bh=orW1M1HCJnfVDdum5Jk/N9vrFVJJLM+CIBZgcfA68UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAxhSqvnW6UUnXYSj1UX/72JlxYEhmrPQ2NAIiXEsCpTKBuBa19+XMxNb3Df9+jslNOctbq5SCGKSwDr6/wLxCbAsKkrpZnlg/lLJg47Kd2luuFchSGVu8F8/mvGTQqh7KZeglWnVaIXbeu+EdGYQkKb/ENK2eyWqHElmooGrAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9K4/1Ce; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9K4/1Ce"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdda5cfb6so64497605ad.3;
        Tue, 22 Oct 2024 17:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729643582; x=1730248382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GwFa/KXD9udMqNOk/17VTw0JX40rEFnM+9r84c/Z+c=;
        b=N9K4/1CePPy3rhkt1KEP/D2EbZzyrsuc317GYP4vxgsIzjiiz7UDZjgaPn7KcM7EP1
         gQm5P3ZnCYLJK6d40rLkeyFNSdoaXyorPiF8ROWrC6GS7QNBMZJcxGkdxEBdQbOYdMC3
         dbtx8M7Yw0qI7yrLbH1oaJMW/iEtaw8mKG4YU3HjTAb3ElWA9hLocXG+ca6hrBhe1ICr
         Ac1rnTPABXq/X+6WypAWVqOIPEVyD/T8+hVuL0XcNdARIfAV+Ld0SMxryvhw4i7lZOS9
         8C/r7TLX+QotHNHh2IK3KKs40q6Zkgqw9Wq8adRGryA4NPFy+8ybMP8hGfYIxH+ke744
         +EYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729643582; x=1730248382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GwFa/KXD9udMqNOk/17VTw0JX40rEFnM+9r84c/Z+c=;
        b=DCPpZKdbHWBfpXhfeLb2FRK4ymIzV5PJ3cYTnyGdJGqfOy7gfYgjqP03GCmcqNqccg
         L0o6NDHQ9d7oFGyVzo/TMFwuLr7k/Y3GcQqM6v2GrfRuf3LLGFl6fFvf0EMwrHvfC0zj
         iPDpoPm03d9z9ID0Oz+JEODY7RW53vs2kFIIiP7s67TrvNVO3pnXmvUWDSVRcBdjzwYa
         Vo9cPBaePEiyx6kQ/WbMoH7/pIfrndR+4hcNgF6HteBQMISo29Yq+aJdxUtRIsuV3LYR
         OfRfNDf1K8r6x11JgIeRNYrSx1oMFpgtYu6g5T3eO7Y7L29kJRAULbBKiDA19Otthfu8
         P9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUKAX9PsU8a6liCW6WdpH5cL3LYW20X47h6I/cVK1GBVI6WNGz5day8YeD08k0Xst8UTEyUH3e+E2oD@vger.kernel.org, AJvYcCUPzwwTOEYFd1nwjpzEZrJnOfEbDAeqNlfhZ8O4wjW4loPpCkd0Ye/VWv5Xkow/gMnVHa1K5k6Ex1A36Iby@vger.kernel.org, AJvYcCWDSnuVn05wGIxRa4mqwbPCkk0e9UQkb86r1ELtrBAIJAlsaFGcU0YpJpQeUwRByDQZW67zOJgA/u9hMQgy@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3GLn0QVAyFSgXh/otggYg2Cf1Qgj/kbNwfShaelnpvmOSzQP
	YLBvs53f9XPXW/xggCEgMCagqJn0DcTmqm5WXZMB4uZMYUqTGjXj
X-Google-Smtp-Source: AGHT+IHAY4TNmt69KkJHUwnXiPYb1f/Y1IUPucStfdWvNs0yInAp9Vjs+QAiNb2Jmb4WvpYofxCllg==
X-Received: by 2002:a17:902:fc4f:b0:20c:a7d8:e436 with SMTP id d9443c01a7336-20fa9de929dmr13076305ad.4.1729643582441;
        Tue, 22 Oct 2024 17:33:02 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee67b7sm48341985ad.41.2024.10.22.17.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 17:33:01 -0700 (PDT)
Date: Wed, 23 Oct 2024 08:32:42 +0800
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
Message-ID: <e32xi34m4lubrquluk7uu6nvqgarnxtmj57ricxg2gv45xpgcs@x6t7itvwng4h>
References: <20241021072606.585878-1-inochiama@gmail.com>
 <20241021072606.585878-2-inochiama@gmail.com>
 <20241021-outlying-washday-8f171dedc703@spud>
 <r5ngs2j776jcy6sfirwzmtsoljotatfvgmlmv4sj4xksye2bff@xtn7adafbpfz>
 <20241021-rosy-drove-1ae3c8985405@spud>
 <2zawe64brm3sfuslh443352wfupgnhb4xw7jragkzxu6kgg6t7@b4qiya3jdij4>
 <20241022-washday-glass-3db9f6a2cd27@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-washday-glass-3db9f6a2cd27@spud>

On Tue, Oct 22, 2024 at 06:25:00PM +0100, Conor Dooley wrote:
> On Mon, Oct 21, 2024 at 08:23:30PM +0800, Inochi Amaoto wrote:
> > On Mon, Oct 21, 2024 at 01:21:58PM +0100, Conor Dooley wrote:
> > > On Mon, Oct 21, 2024 at 08:18:58PM +0800, Inochi Amaoto wrote:
> > > > On Mon, Oct 21, 2024 at 01:10:52PM +0100, Conor Dooley wrote:
> > > > > On Mon, Oct 21, 2024 at 03:26:05PM +0800, Inochi Amaoto wrote:
> > > > > > The UART of SG2044 is modified version of the standard Synopsys
> > > > > > DesignWare UART. The UART on SG2044 relys on the internal divisor
> > > > > > and can not set right clock rate for the common bitrates.
> > > > > > 
> > > > > > Add compatibles string for the Sophgo SG2044 uarts.
> > > > > > 
> > > > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > > > > index 4cdb0dcaccf3..6963f89a1848 100644
> > > > > > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > > > > @@ -58,6 +58,10 @@ properties:
> > > > > >                - brcm,bcm11351-dw-apb-uart
> > > > > >                - brcm,bcm21664-dw-apb-uart
> > > > > >            - const: snps,dw-apb-uart
> > > > > > +      - items:
> > > > > > +          - enum:
> > > > > > +              - sophgo,sg2044-uart
> > > > > > +          - const: snps,dw-apb-uart
> > > > > 
> > > > > Why does each vendor have an items entry of its own? Seems like needless
> > > > > clutter of the file IMO, except for the renesas bit.
> > > > 
> > > > I just follow others when writing this binding. I think it may need
> > > > another patch to fix this problem, right?
> > > 
> > > Yeah. But I'd hold off to see if someone gives a rationale for it being
> > > done this way before sending that. I've not deleted this thread, and
> > > will send an ack if someone justifies why the binding is written like
> > > this.
> 
> Well, Rob doesn't think they should be separate so please add that
> additional patch in your next version.
> 
> Thanks,
> Conor.

It is OK for me. I will add a fix patch in the next version. Can
I add you with suggested-by tag in this fix patch?

Regards,
Inochi

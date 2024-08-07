Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428643B7AC
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 05:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010115; cv=none; b=jB6NW0DauV9weRCeaIRQpIP2QHMSZA8BO4WBr+/Xyddrsm15wbsmt3jCdUBVIDj539VmueST77h9y3Zi6rfXEaErkZzMKPPOo5ehs4T4piQqzr0AjD+m1diYHBYo/ttXkJdQyiapxUnm2t11c1q5aq0K3Tb/0DOTWiQsdA/lQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010115; c=relaxed/simple;
	bh=2gw9QvYRqtRBab+OFV4Rp2ouTr5WjKwto8HWoLp1gHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+wZ2fF3OdcpToiEQ36oqJhNOWcx/VK5NeHCXYydiHObOBZrfXPKN5D8vr2bLtKdbjL8Jyz7AF0SC6JyVJyg2E/FYMuiotzNSID3SmIM3lfsKVeSy5BuSvq0F7nfxWi1W9SgHJoEldcMGkqIE/vkWYPuwLdegwnufDAjKQj6y+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gtLS7Kil; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gtLS7Kil"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cd48ad7f0dso1075933a91.0
        for <linux-serial@vger.kernel.org>; Tue, 06 Aug 2024 22:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723010111; x=1723614911; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GdVhyQpyLYOhYB5fvYOMRnbsJ+Bwno+rZr/gxKeR4t4=;
        b=gtLS7KilbwMSVzZAx08WPkJMl53I5MiDgRRR4EqQWaiaVCRbE/3uMj+kYEl65lExsq
         /a8a2LsOjEbTyU/G6oV1w/Aqi+D1zWsbqplHl+Pxgur5swgRIIwMIOEMbNvNLWGX/wcY
         +2wtBNx5kUIOGU8s8+moYIn69HT4e5h+shajxb607S6MDf7qeVNRp8gleo63SIXk0Z5C
         VGCplWAX6LCovlpZn16BMA6CsVECzScf3nQJZmqqK300yEXHr3f9QOWFrqYuwB5pmbFv
         QN46fbDceuTLNg6jtL0HUOnJGhHPtRqzrLAd0pTZw+g1w8jX7h5TXenuOUrx0aUTjAiP
         10IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723010111; x=1723614911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdVhyQpyLYOhYB5fvYOMRnbsJ+Bwno+rZr/gxKeR4t4=;
        b=NaPEB3Jj4U31g8xRfGO+Dw+uTyv8/00STYCwOiaBnvI5TDSufx5x4TxbP/9Vxb1Rwg
         V4CAy9rsZwpA5SWAJH2X3PofFd4LW9uJDY43fvx+6WZwUrQKVj+W66Dy34IIYTxaMYRL
         2TCU0AUrJsef/RiaZIz2xekayBC3S7aM5WZHo8mRum+aDzwSBRC+btqYFiJyIwDx5P0r
         52yvttRY1/4CnZR77uTg17c+eR971Ku/CVGFQVTfiaYzSB6BRMYV3J3PiyPZX8KzixoJ
         GVM0A1aBQ2MbczeGLDGXNc6T7OVd+HD4Hx99y0CFYpwgbkHlTsPldYSNn2ZzuvPtHKcH
         mfWA==
X-Forwarded-Encrypted: i=1; AJvYcCWn9H17bvS5O1tfDJJz0NU49EeA/VNHYz+4q/1z6k4NsANsPDOWEDbyGbYAuSdVUwgXcQ9Hb+6wJ280/P5bnRup2cXejioDUsNHkMfx
X-Gm-Message-State: AOJu0Yxg4Gkn6hrA8Pqi7ji/AMEeQx1ub8Xk6lQ2DlOgFxSEWA5/clDF
	JLxvy5sqWOlqV3oQI60qXW6VFnoJHfGUlVAetq0cJmSque5Ac9qM/EhqFhCMIJU=
X-Google-Smtp-Source: AGHT+IG5FVREIdIHSi/wo1FCywKpZy8w67yn4WoUxHxc1JlUrnptnI7pZdmoWoIbFBNgDuYFpMEoYw==
X-Received: by 2002:a17:90a:3fcf:b0:2c9:e0e3:e507 with SMTP id 98e67ed59e1d1-2cff9148c7cmr21053224a91.0.1723010111638;
        Tue, 06 Aug 2024 22:55:11 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b1144bsm555615a91.34.2024.08.06.22.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 22:55:10 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:25:05 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] serial: 8250_platform: Fix structure initialization
 warning
Message-ID: <ZrMMOUQai27N-W3T@sunil-laptop>
References: <20240807042210.1608026-1-sunilvl@ventanamicro.com>
 <20240807151352.3d66afe8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807151352.3d66afe8@canb.auug.org.au>

Hi Stephen,

On Wed, Aug 07, 2024 at 03:13:52PM +1000, Stephen Rothwell wrote:
> Hi Sunil,
> 
> On Wed,  7 Aug 2024 09:52:10 +0530 Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> 
> > diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
> > index bdfb16bed4f2..d8c3c169a620 100644
> > --- a/drivers/tty/serial/8250/8250_platform.c
> > +++ b/drivers/tty/serial/8250/8250_platform.c
> > @@ -108,11 +108,12 @@ void __init serial8250_isa_init_ports(void)
> >  static int serial8250_platform_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	struct uart_8250_port uart = { 0 };
> > +	struct uart_8250_port uart;
> 
> Does just using "{ }" as an initialiser work without warning?
> 
I tried that and at least on this architecture/compiler combination, the
warning is gone. However, I was not sure about it since gcc man page
indicates such initialization is valid for C++.

Quoting gcc manpage:

-Wmissing-field-initializers

In C this option does not warn about the universal zero initializer ‘{ 0 }’:
struct s { int f, g, h; };
struct s x = { 0 };

Likewise, in C++ this option does not warn about the empty { } initializer, for
example:
struct s { int f, g, h; };
s x = { };

So, I thought doing memset is probably safer which should work across
architectures/compiler combinations.

Thanks,
Sunil

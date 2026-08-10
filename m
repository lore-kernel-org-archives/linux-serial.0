Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F02DA74C
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374501; cv=none; b=bpo96qxHC8Q631Cz0EWIN+Q/IJz3KdoZpMsabEzfeDu/r6UsjEet33jPWTDGwZKzwlUmJSxdTef7MLsb/9ocR/nYQOeDlNApd+ym90Up0Ir8pe5BZ5k9qZxqhqgI7EFIoqhOdvMg5MyO2zxeXtSSFqD6xwr2f81A4TUOQ7TTzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374501; c=relaxed/simple;
	bh=jtiRNjP6pzKEg6mH9UVKn5p6c2otQpub8B1O2WWHOr8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkIsup/cdXD9jP9IxfGnu8HeISBPe7RjQtrPKcAkN77JONlDY4JdT3UouyRkw79/nvAv5quseEYxcHsjS+oGGdTO6dZIXM9GyqsojeaRryN63ctaoMhSS19VIFitQwYmqdO2EPqatMxIbo11B6FRGJhaBEja1kdbQVKX88OLY5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz2srSOR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz2srSOR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590dde14so25105195e9.0
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786374498; x=1786979298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ebQk+CorC9WkHJnaMmCzEoXkD9mmuaev36oaO9xUg6w=;
        b=Jz2srSORKX97Owf6rx2BQvmc/D7kDk0ckZQpzH2OKi6izgx2K9SqOBvK0U8J2RKU2z
         NvHRc6p0Xc6Vvdj7isPzIyEuDUdL+zrWugvHgG2C0+ShzrgnWW0/St21S/u2lE36+Q+8
         AggQB6ov5icCNhJqChSb0HaDwxHLT6meoQvw5suxVsJQJIzOM8IRgDo/myW3VPBHTvQY
         ILT9eM/62bLRSwLQsrDNOVNb6zuYizytnc5eDjuNMp0pn5F67UQNeDTbY1afkHHz2OEQ
         x2x7+tZOTy9NMFZOIM58qPSqaqROFYBEU210YjxVoRNfUBbhg1uJYRr4JjynGkAWCcRS
         6mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786374498; x=1786979298;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ebQk+CorC9WkHJnaMmCzEoXkD9mmuaev36oaO9xUg6w=;
        b=IOXSSuKgyBHCZVCv7VCJEJbY4ZFv0qUpKpAd0LstpukhDlV2VlUIbB85FJjrt0BajT
         dyxqO/PieNgh9pGzttKCopiAaPyRHNU06eK4vYnhLe264HrAOoD6U4NkElqTTglwAn79
         hz+JsFl4SwA07ffNMOK8cr9geo5gk6BMGfVu/jEs3/LDsralSxTgvZ1798fcjbk79f6p
         dQuqVYmXFnjde4Jddd6MgbLPfyCbaLdOVHXja8S1eEt3YySCGGKErOEUc6gcvsmdUuqD
         Gxevdpq0BbOsmB4eSkUHjS97jlEGWEdK/VQIdDFksTXadLTLbFgWXIMwY64rpIZx+TDO
         e9fw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+yuRC6e9edPe15pIbjLtMToUrUEGPPhsYU2yc93w5+/IbWKkibH8tdOTKeG0S2WaktRRFA5vg1TnAz9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2xKxhlxohMmz3cd84QnXfx+8qLIkXk1wQPPF4hWm0hgFfLvhJ
	UYGbfpmfwmTzuOvjietvLf50Xz4+pCvAaGuxFzpOg+E7nJkNzKWWl6/g
X-Gm-Gg: AR+sD13KSqwiELcgauJ8yeOoj761jnyR7ZJhMe/ASamd1YgPCQCIVd36qf13/FpFBBO
	g3YCdoiyZCzm5x16z7v5aAmFXC7o/ADWxFdk7RH+cYeSaeal7beECh21de8re7Jy2rE4AxAUYB8
	r4fcnVDaQpt3+1TfQ642yqLZWsG43M4TLkkwUo1UonK23GJ2yf2VAShuVP1H447+4SaMpL7yvxw
	ICK3PU0uQdQ/SkrQQJ+I1hiD5ndvSN/HzldNVgPpXYPDQa4ZO4bQSlRNrmuAEAPogwcyWnwLTZQ
	bYux6iTKDlZ7MZzvcnMXhm7DXanREsvHtqcTaHBFrUIE06F+OoYhp0HTBiWGlomkqZt6HNLfAMn
	uj+0PQ5MTHyM5fYLT6Cb9r45mEJio8Yi4Tuo7KSfOzLTtpot43ZLdCx8hXJP08IMPWDT1WnCSyP
	rWceliD7ZZ3Do09VJHn/jXc9RCVlA4+Vt17rlNlMIeZwqxHAw2283285phJ4XvfNwDDHDH4YZqL
	MdHwX5Kc5ZXT6zvaQDBZ2YULjIef5yh0l2Kzoc0fg==
X-Received: by 2002:a05:6000:118f:b0:47f:9de0:c27f with SMTP id ffacd0b85a97d-47fec4e41c7mr50878167f8f.1.1786374498127;
        Mon, 10 Aug 2026 08:08:18 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm33874307f8f.22.2026.08.10.08.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:08:17 -0700 (PDT)
Message-ID: <6a79e961.9099b29d.285f89.0e7e@mx.google.com>
X-Google-Original-Message-ID: <annpXTsB71zL2oSu@Ansuel-XPS.>
Date: Mon, 10 Aug 2026 17:08:13 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Manuel Lauss <manuel.lauss@gmail.com>, Jacques Nilo <jnilo@free.fr>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gerhard Engleder <eg@keba.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
References: <20260809121449.574277-1-ansuelsmth@gmail.com>
 <20260809121449.574277-2-ansuelsmth@gmail.com>
 <20260810150221.GA1621358-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810150221.GA1621358-robh@kernel.org>

On Mon, Aug 10, 2026 at 10:02:21AM -0500, Rob Herring wrote:
> On Sun, Aug 09, 2026 at 02:14:46PM +0200, Christian Marangi wrote:
> > From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > 
> > The Airoha SoC family have a mostly 16550-compatible UART
> > and High-Speed UART hardware with the exception of custom
> > baud rate settings register.
> > 
> > Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/serial/8250.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> > index bb7b9c87a807..b6f7e093d8d7 100644
> > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > @@ -110,6 +110,11 @@ properties:
> >        - const: mrvl,pxa-uart
> >        - const: nuvoton,wpcm450-uart
> >        - const: nuvoton,npcm750-uart
> > +      - const: airoha,en7523-uart
> > +      - items:
> > +          - const: airoha,an7581-uart
> > +          - const: airoha,en7523-uart
> 
> Don't stick this in the middle of a bunch single entry items (which 
> should really be an 'enum' if you would like to clean that up).
>

Let me see what I can do... Seems this schema really needs some love.
 
> > +      - const: airoha,an7581-hsuart
> >        - const: nvidia,tegra20-uart
> >        - const: nxp,lpc3220-uart
> 
> >        - items:
> > -- 
> > 2.53.0
> > 

-- 
	Ansuel

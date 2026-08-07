Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3104C3DDB1E
	for <linux-serial@vger.kernel.org>; Fri,  7 Aug 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091852; cv=none; b=PUi7GNcQ7A7dgV336cmHBLgjxzOTYUvyuOvtkoAeD5zzMDZ/ccbO+37y6Wuot6yWUVAOKa9d4EtHl21BoLcsd6AMHbco2SD06JV5BXZIQ3rpUuEaZ7poKXnKwd9bdj1eG5ihoy3oPWe4CRrXwbh7XQmd1Z4r+iBCGG3swdvkwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091852; c=relaxed/simple;
	bh=/UdSyTf9Swt5Ml5qDkK3fqt0U1o1wltMS/fTtppqJ+4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=CW4h4iFCRMQuOJTcF+hQc49gOVs6fTV1pG2sPZYzsKu97U4xhFSTlaVl4MG3GFagTRTfZ3MtJG0J4cixLOULpPMoYyLf5kQvaxsv8aO7kfHXrlH5HH+o7FTWvrNLx9D8FxJTcbEAYmUJTp56MeKmIBWVQAg+xdZ7UH5cQxTgkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=bjf9LTfe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="bjf9LTfe"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4994c49f588so17723465e9.0
        for <linux-serial@vger.kernel.org>; Fri, 07 Aug 2026 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786091840; x=1786696640; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qa/2IU2RbAAtb2QUYjZKVHQ104XeXVbZBNjUDvADO9U=;
        b=bjf9LTfe3ZbLy0YUfOmjCm5sIjoRu7V7U+sgL5Tb2LKbPYRvWPUyPG4JIBeSuv6Opw
         iruoVk/cHY1WFHqzyh+4wt6Ad298cW2c/5O61Vu0x5oS5+/vzy0jtr/+jW+bubbpoBre
         2mmflEWdKGL7csSAvRWiPVskwSjr7yIRtXqyP/UqCmi1/s8XVTg/3Za4Ras+o8MPbuQb
         9IsuJZH/iJN7ga1rwUmm2EyhUF9K+XeGGPlF//w6DHMLjNtOpMSWvoivQI/Rjhn0KqBZ
         RV94Q7WfigLnD8jcdhrrTFJRb3FDqk6wFfTPnWcLTbQy4OY7mRYyVGtuLAOww+BQ/I1y
         gPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091840; x=1786696640;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qa/2IU2RbAAtb2QUYjZKVHQ104XeXVbZBNjUDvADO9U=;
        b=WZfv6Dd4kX51bl7Wzj6Jw3fJMg86022JO9uKpmCCulNMnBTGnE85IXxa9xKpj4iIY2
         plp2JigNq1HC29YoyYgxtPi90GzgzfERqXQaAHueK5uqd8jwSaJr/cMi2tdrb4yzUI7j
         r6HnqVnkpednWlxs3z0YucKlNCOgu4TfjbtnZ7I3R+ZAR8I9ige6KW47YQSIMCgoSv4P
         /PkQkbd8eFZPytMaKE80OKqAoK66pFL4GEBEENg3mMqZAp7dzpEp5QOklHpsTq0euJ0f
         avHdWKBC5V+CNCbMpSQ9gMuRFnnMDf+EkgWImTtStMYHoOELXRhInwXLVhBYy2RWnGzd
         Elpg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/bV6ZHUpVtDZesm4Vwuw3TDnjLwK7/FUMfKz8APhRK7WE+puEXxKDE7Q0xROKeeCxfF0HKkr4YSe1m2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdVsnE3RtlNv9i0OupwbdW+U8LE1BORCQ/Owdj26gzLPBTXUT
	tW1qe2E+bMO3v4i2767bgNlv4DiQustRoGPqv1I3uSwk1WkBpY8ssNfgjSMxI4dAbfk=
X-Gm-Gg: AR+sD10zZjsIepE4V2WkNtFz7U6uqss22z4QlvdQKWpoCP1hfHi0kTpHl/irA2KANoR
	W1IL/CWzl/D0tQsQIhKl2K/RVrfbnqDISlx2gQf2gFg4wMeeJmxO4QAziAou+vS/p6bu3Z2oEMi
	6tEdfR7otW2DMvHFJslRyNGiJPlaWcmT+ruvey3LzKYubo0WMCOFtlhwrhGvb5VeqpH/Qh+TiOM
	OA4ZPKIyt9R47RwTo+9ZzLAq6ppRGMzjge6vF3njCJyUtPrljIn8p0geXYjo64bTz92l+T3YK8O
	4YMkFRafljlheH73lp4PUJ9erQxOzSkaSrjEL2D+9gnJA7Id0KTeabiu2oG1NddiGW0AAA7cFyY
	H6yrw09b3csAlr+kw25b7XPowYL6UQexTWqumOvpyMU264mIZ88O0xEILwiKg/QsztCD+/lIGbu
	6dSlGx3iWH7UxwE3PZtfW2I6Opm3nr5GnXvRHu6UY++BVIrBJ623MLvqbBllfCVkLURpqsnlpRq
	Et3q/GqMQ==
X-Received: by 2002:a05:600c:19c9:b0:499:5f80:83ac with SMTP id 5b1f17b1804b1-4995f8083c9mr1877075e9.7.1786091840306;
        Fri, 07 Aug 2026 01:37:20 -0700 (PDT)
Received: from [172.20.10.3] ([2a01:599:843:2744:7f5d:3df0:76c1:3705])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9e7171sm17795195e9.1.2026.08.07.01.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 6/6] ARM: dts: aspeed: g6: add aspeed,vuart-over-pci
 prop to vuart3 and 4
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, lee@kernel.org, andrew@lunn.ch, 
 jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
 anirudhsriniv@gmail.com, tan.siewert@9elements.com, 
 linux-serial@vger.kernel.org, mfd@lists.linux.dev, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <8d24d424b3504105394055de268e0a11515635a9.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <8d24d424b3504105394055de268e0a11515635a9.1785932211.git.gregoire.layet@9elements.com>
Date: Fri, 07 Aug 2026 10:37:09 +0200
Message-Id: <178609182924.193353.1528505361399129387.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091831; l=2379;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=/UdSyTf9Swt5Ml5qDkK3fqt0U1o1wltMS/fTtppqJ+4=;
 b=Td0FBVHZjwGzgXbgiKllL4oZyf/Dbkogo3BlU9t3xclOt5YoCOrEbt8mL9QHVk7XLfkFRJ7Wa
 6EY3etRH2R9C3Q3YQKlDY8mjaPAEc28k3jIyzjAH3Oq3M2RB4ymHQFB
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

> The VUART 3 and 4 are VUART over PCI.
> Set this flag to indicate this information.
> Also set the syscon phandle.
> 
> Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index 7c02633f2bd6..fbd7ab6332a1 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -722,7 +722,9 @@ vuart3: serial@1e787800 {
>  				reg-shift = <2>;
>  				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&syscon ASPEED_CLK_APB2>;
> +				aspeed,scu-syscon = <&syscon>;
>  				no-loopback-test;
> +				aspeed,vuart-over-pci;
>  				status = "disabled";
>  			};

dt-style check fails with:

    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:723: [property-order] property 'interrupts' out of canonical order (should sort before 'reg-shift')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:724: [property-order] property 'clocks' out of canonical order (should sort before 'interrupts')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:726: [property-order] property 'no-loopback-test' out of canonical order (should sort before 'aspeed,scu-syscon')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:728: [required-blank-lines] "status" must be preceded by a blank line

>  
> @@ -742,7 +744,9 @@ vuart4: serial@1e788800 {
>  				reg-shift = <2>;
>  				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&syscon ASPEED_CLK_APB2>;
> +				aspeed,scu-syscon = <&syscon>;
>  				no-loopback-test;
> +				aspeed,vuart-over-pci;
>  				status = "disabled";
>  			};
>  

Same here:

    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:742: [line-length] line exceeds 80 columns (92)
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:745: [property-order] property 'interrupts' out of canonical order (should sort before 'reg-shift')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:746: [property-order] property 'clocks' out of canonical order (should sort before 'interrupts')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:748: [property-order] property 'no-loopback-test' out of canonical order (should sort before 'aspeed,scu-syscon')
    arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:750: [required-blank-lines] "status" must be preceded by a blank line

Tan

-- 
Tan Siewert <tan.siewert@9elements.com>

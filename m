Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C242364049
	for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013271; cv=pass; b=FH5kU0cvyhX9wu11R1CYaxk3Ml87zAh3IvY8AfYGC8locA5B+1HQfb5OB3V+DSbAge8rmujTdoncQkHVydMWhS+rOCfbC8bHjv2OyHWrum3Lsj8/OLhi1WuAwjiVqN/FdorQD1yTmz3LD8j8BxGx+R7DIRsPANMTG23Ym3gx0yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013271; c=relaxed/simple;
	bh=dn7IW7f8g4oFd9sIoeJ6OCN9TIFKIj/He1K2oNRFlRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqsOBxiqNusLgOdLWsq8HWJvhwCnx3R5no/xclTG72H6DpKQZrjGzAWlI78UvwnJeIGbwilvGHCFqZZObZZHDM4Wzrst13yHK8IGfc4/50vUBxPdpyaL8LoFe3NAp9rKwTkJvPlKz3jOqXZCl3DiVeNR/BNzCBF9d/7Cfj5CWeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=cJDKc3He; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="cJDKc3He"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15c257a488so502793066b.3
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 00:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784013268; cv=none;
        d=google.com; s=arc-20260327;
        b=TlfoPeZ+HyvMcCJ8NJBObQg0ZCBQ1l/TszTcuTI+/R0WilbZhQMS1hrH7//GAlVdc/
         AgIdJzg1uYf4ohtLtowTwSRwysYUcwg0aVEtW27wlnLIDiXzo2UJZsNNkwe/U+K5Z1Q7
         Q1ZafPVD20GBGOMDv3RPoPEG3RpEL3ETN7xX4stKtubVxi2jl6HHsPMxXIl9a+G2cvVY
         cdBlZaKbLymmXTA/2s5+4PS/o2d3K2bPJNGrL8TA/2ywBm0t0eLVM/zODD/GjnnFWH/e
         6Iyn4nQYUq066Zd9NcVm10guNzssfbOoohczCac49eUi7svZ0rMUKxmGz9wzL9vwCNtp
         gFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGRru2gQA+Baamgw+dIgFvngJo1yoHHQsL5cdXvYIZ8=;
        fh=4pDyEWm6+xkhU5Tq/Z+PwAxMBkAVbTp0l59MufIJRss=;
        b=XOi0fi3DJKiIWTSdLcbpdy+o7zpavoD+6z/P2BwUxd/BFPcZEOsHBtEa9bxNfU6o0t
         Q7+YHPumgJrPDhf1CQl0OQYZcX9opmq/Km9vzwD/+AjsOpEYxWkq4P/b+KcpBZMdghW0
         WvVNeRq5Z/sjZzmnYJ37C+9iB9aEuw6wBVeD9NDzABefxuQSC2F/t5nXBHI65PZTYKLF
         ldeEh8w14NBE85Q7j3ZvGefNv0E0pRV4NhE7mvVrct0VrHhXIvjxX50VpSJj0wc1eCdL
         GXSg2QPGCbI7PcjaJYG6pzWUcYSOmf23Ta0HLg43x2ak2LkwICOSfst5xH4JdkreYANM
         yPDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784013268; x=1784618068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZGRru2gQA+Baamgw+dIgFvngJo1yoHHQsL5cdXvYIZ8=;
        b=cJDKc3HemVX7jhAZisoNdP3xH5opCV90joefkqzW+HHkFe+Jt+cWe+tQLnvgqQCM2/
         FQXZYrJX+2SRqaBtT5bRjXbyDtr+f/VtFCnyz5AYEdS0xK6P+1pzro2XyfVKEQ3RVCXa
         +CKTGk8fTXtmnORuNWtL7+JnF/4+j5jXqsw6bHLxNRYGK7wI0GuHvZu09dKDkHPKSbFP
         ezs7yCfkpcbNNkrKl9tTOK/rwvn/j8NE3Zq3Pa52xRtVOgN24ls2arrTK/Cf3czp2VYl
         qtIUVoLD+r021WytKO20Jrw6RseRp/VMigfTwGdpgaKfW4n0pUFMLI9va+8PksYhEV9h
         Z8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013268; x=1784618068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGRru2gQA+Baamgw+dIgFvngJo1yoHHQsL5cdXvYIZ8=;
        b=A7QczL2IXtiFqhrP9Z9Ss+P6nCUlLSWxdTcX3bULbg40Mr9MuqTsgRugHycb+bS9+z
         pGxwCjs07TaGpwObGxOGq9uZSosuurLGjg4sCZLv21eur2SUX/jxvC4a4TbtHnD3Sdxc
         Bj+/k/54DoZm7+RbDdo6HUaDVkLDqov5AkZisvCfh3OQsILF8XuiZybYlAXQnPQBMq1F
         SI0YUkBtTSuJjqhiIwdyLd1b+KbWzNMA7Fm8qHHRt/dRCoVPAFx3zkFvGRNT+StSY5hl
         lanbgO59xGD8sFXaxzsz561XTUaRf0AH+jOEbk457A9CkGyXRZI8pWiA4lr6o376zWpU
         8ojA==
X-Forwarded-Encrypted: i=1; AHgh+Rr40IVkqIDP3+bwgUN0deZ5gIGe1sgVQ2Wr4fvVB8BECFKaP2l1ZQkZJ8OvUaw0liX+3R/d+muF3446Or8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZr9M/d98jn++samP82wFNd+3NaYDw+/Z0XjOOFTWAVWWJCV8z
	Q5l8qcEpzxS6EKh/6mq+Dk6RQBrdfpXDyMWkiLbmECoYW6I6JGVewvKfy4UQkkBLluenwCwiJfS
	rMst/Txob3qAwFyIoGJ2iJcvGOUt3Jj+tzEnHPL3P6w==
X-Gm-Gg: AfdE7cmbdwtsRXkD91fe4RWU29KPBmX/VZzGKSGEfw6MzCTFLV4j2bPn5zN+oHjWGCj
	b0kGnMF/bNfaWWw88gkwKKg642Ne9ojnyjzmzZ7dzK9h74QUuFQezX1v3QrMzk8AZmJTvoByQKO
	3joJmIMB4c3rdsHyjDkuE6fQQcoKiRO/y18YyKcjEP78HYOIX+UWcB8AQ0ON2NSpb08Ur0MXklf
	MxcKy4IrNed/gjJWeEUU4Rca+bahTz8ezDDu1iSd93KdvQWFoTQMrc+7qiqxWFVtfnzK1j8i676
	QLzi15qz9XfZTeAYxXxZ8VczpdWUGIs56rA19RMneq6vkZzoC8CjWsavJo14iwzKCwDl
X-Received: by 2002:a17:907:934b:b0:c15:b368:28ba with SMTP id
 a640c23a62f3a-c166196554emr121126866b.56.1784013268492; Tue, 14 Jul 2026
 00:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <501428d6a6cb1548bf357c25313dbc319724ead2.1783524645.git.gregoire.layet@9elements.com>
 <20260709-shaggy-discreet-dodo-e5ffbb@quoll>
In-Reply-To: <20260709-shaggy-discreet-dodo-e5ffbb@quoll>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 09:14:17 +0200
X-Gm-Features: AUfX_mw1ITD-w1oVJUIDHcxSt_M9AD3AkUSAllXjq-zp-XksDV-7pwC0diYVWEo
Message-ID: <CAFi2wKZqHsEa3B9KMDyVk+1Ef42u4TqWzqf6O4SXtamRnWD8Yw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: serial: 8250: aspeed: add
 aspeed,vuart-over-pci bool prop
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof.

On Thu, 9 Jul 2026 at 10:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > ...
> > @@ -27,6 +27,16 @@ allOf:
> >              enum:
> >                - aspeed,ast2500-vuart
> >                - aspeed,ast2600-vuart
> > +  - if:
> > +      required:
> > +        - aspeed,vuart-over-pci
> > +    then:
> > +      required:
> > +        - syscon
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: aspeed,ast2600-vuart
>
> else:
> ...
> disallow new properties (see example-schema)

Yes it was missing. Acknowledged.

>
> >    - if:
> >        properties:
> >          compatible:
> > @@ -223,6 +233,12 @@ properties:
> >            - const: uartclk
> >            - const: reg
> >
> > +  syscon:
>
> That's explicitly forbidden by writing bindings (and mentioned as the
> antipattern in my older talks about DT).

Missed that.
Should it be named to 'aspeed,scu-syscon' as the aspeed SCU is used
for all the peripherals.
Or should it be named to 'aspeed,pci-syscon' to specify its purpose in
this context.

From what I have gathered, current convention would use the specific
name 'aspeed,pci-syscon'.
Would like some feedback on this!

> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the SCU syscon, used to enable the VUART over the BMC=
 PCI
> > +      device. Only applicable to aspeed,ast2600-vuart.
> > +
> > ...

Thanks

Regards,
Gr=C3=A9goire

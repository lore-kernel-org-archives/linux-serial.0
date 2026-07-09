Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39AB33A702
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606895; cv=pass; b=aGSuSj0GtD/MYrFZCS0MfSz78wCyUpmAei3fAaEEihFIGYhPN/pEAzMFbh5NRd4UVepMAFyOeJGRC/jRv6YoEJyZEIsVbJV3zWdCdD/pUWSQOaYeFc+2ZpYzO4VnHZ+/fULZDE0yFEQ/eJBYgHEB0T9Q7Xd4HZJEkwaepk0wHKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606895; c=relaxed/simple;
	bh=1LFi/C2g955kXJ/o/L4vV9qdHPO2Wk9Vvl9Gbcga3LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQgHif6RmvoXuyNIdewVQLW3SAkmb0SwBHF/nVaVV8WxshrJmDLUoH99Rxk3Ry9IhmIpjnWP09ewpjCIUgL2nUeiJASsew/3ZEq9TD1Fl3qNgTgZIbAmf+TTEQA24oSSqR/4UAQcJGkQU5hcI29SPm9nQJjPWGPR3s9CO6PXz2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=RxiDQrM+; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="RxiDQrM+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47640541585so1002618f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 07:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783606892; cv=none;
        d=google.com; s=arc-20260327;
        b=Fu2BABMF25J902PfvzlZLIkvtONAFJ1Jw5bEGTxRpbckNlJOb2nzOXYnF48Q7y9d+b
         LUi6Sm6TiqXomzHL1mYJvf5KAa8PzgiCchjnYGYfpZZVQAufxURj1BBM6eWsxWMF8jtz
         WgxBQqoK6H/JcEZixzvthluchONQixsQkdFV+psOusHTevuXsuQUHRXMDew7K1ILQfLv
         IhY0Gpk7ySP1BJdyExoRMcc7/eRr/5ZeK4GVmInbMMPdw2Zq/fFzoFCSSKhBFWnxuj16
         UsPNar0T+KgufmFiQd2cPzsMUr8OS2lJsovVcwFxZuuL2pxut5xdYaq0Axn2fc42YVIo
         RJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PJC4lX0tZTp50J0S7on2pHdgb/jZHm/OiyTuKIg2KPY=;
        fh=C784wsvuB6o5HDgpj+WciKWsUj0mBg2lWsLOn+D3P7U=;
        b=qUMbnn4Vi60WkGH24sC/TGkXKSj99vx8xs8qjiZ9+f2g1D2kYDkMOftmFwQG76Ym+9
         RSsiHXD7LxDqcIcOS/Fr7DUzJ1eXo+jnUvSD7RyUNHNhAJwrG5WRJkvjTjSEkVMGOM+7
         3qnEYyzkJ9v+sgXRN8/pVinRrqJG8k64hu9xnYu3XiLHs2+NspeI1B6dIFXw/hlXPrn3
         WaMLOISuuZvxaXZNBLt5+0DQvcVltQ9bTFCwgty2eS8b4Fb5nEa4DeibGNbBqpX8iD7O
         RjkB2QOVu0dDw6prqUcT716Afd9hwNqXWEUCnLvIlfg6n2YvEiEltoHdWj1HMxqcMGD2
         OoZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783606892; x=1784211692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PJC4lX0tZTp50J0S7on2pHdgb/jZHm/OiyTuKIg2KPY=;
        b=RxiDQrM+/nel+al0V1Yt8xIPucCgxXSo8TzCvLkb4XHIgAD0zYBlDnoLxFbB7sKNKL
         tYmzUKu7hhJ7gtVbqp7bJQ+Vy5KmVCBhODoYK/vzSrNe5zODVPcsC1vvaX8yGwz/d9TD
         mKrAAo+Ohh+gCv9NOzcUzX4xgoB26D6Nfd/unSnDnSuwL8ZWKuowZgar1RthPeRdfqwR
         n0TL9PxkBWcVdYgSK2XRMtxO8GOOuWBbawDkNQ46pMuopjd1vGeu3ktIcjlMuOCF/JmU
         NvUT9slLQqvAzx0TIsDHGTdfIdCBBe/LeoIDb6G6SAT9Jp8X/HOCpTXDRZO4O5E5WTPi
         KL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783606892; x=1784211692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJC4lX0tZTp50J0S7on2pHdgb/jZHm/OiyTuKIg2KPY=;
        b=LkqgzEPn7zOFtFfj1TFIe7YWGNNeVIHf/F1yD8T0wymzwnX9BuNIoKr/rXaWLrcVD6
         XlM5zpsbOnx8yP/55htAJcqJrup56oR5uv0pbqLMGptnA+CNOc6eG+4BunX6kgQO1++N
         aA/0eX4zrOs1VBFqdxPX3jsN8KxiSwQjaF9PeJPKkVmnCouXNSb3h49O3WveAR+L8HCY
         kV7ELz1bkf3zB+1y6aSBEotXjJodf+k704Ys1L0P6mAH6gwGX4WjJ98KIhmCCQtxM4Fn
         pKHHqAD3K02ZG4mOsGa1YrfIimwxH0MUnKoMGXF0saCzGJ+5X+shwfCeoFv22rUViqb1
         /4sw==
X-Forwarded-Encrypted: i=1; AHgh+Rrq7jAMJiZog6KajE9h8f6r5gL/dagXxuuQpAGx4yOLsM1zFjFNVbJOlTyT+dZ7cG+laVWlpL46tUaoWOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+Wlscxc9O/ZG8j/7DfjcMHG+EpDnNlOQMHEQQV68PeoIaJb4
	2QEXf/dtTs/gIlGN8DwXd1nI+i93Qx/3TBlyvs23KYAHxYbXD2wIWSd3K4iSQGmVo/71HqvMEtj
	lZVCI7lB8A3tM/Xxh2DpIwRaJq9Qx/dt3vspLpbZthQ==
X-Gm-Gg: AfdE7cldADhAvpoj4dO1XsDe0x7mQ/gaD25dPqN0umyMtdQt2/vjEUwR8KmlDH+JuFk
	k8Egx0B9+xHQG/gQjezV10Zx62Pm09zhTkHnjMa56AAabSHwbZfJPBX6n9OuQd/3X3iJl1311sc
	QXVdX4o7AQnV8h9U9jOLmSZ2/l1IDL3D0UMYVvErA9Ho0zm01U996Hu7vPKRv7zwarzoQZft9P7
	1ANKufTna7KGcOI1U2K6hBBHmH5/lK39130CY5V/1GdKjS9H+GkhhRil9Pc/G1NGPs5IuFpY8ew
	d8uLb8b/dRQ5zx1kY6o1hX563xoezcBVEqlx2Tp+YlhooxgYp6BeYeICUfTNd5awQusS
X-Received: by 2002:a05:6000:25c7:b0:477:3986:9b54 with SMTP id
 ffacd0b85a97d-47df07390e5mr7576513f8f.20.1783606891990; Thu, 09 Jul 2026
 07:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>
 <20260709-convivial-classy-mouse-db0b2d@quoll>
In-Reply-To: <20260709-convivial-classy-mouse-db0b2d@quoll>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Thu, 9 Jul 2026 16:21:19 +0200
X-Gm-Features: AUfX_mxl9lcJsse3vhAYFsJh4Ndo0WrxC586WRK2sT65vAOI74m33ywGfCLJYeM
Message-ID: <CAFi2wKYXVoBRHOCgA_6F20F2Wm4Z2wVz19+XRE9dH=gP3X+i_A@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: serial: 8250: aspeed: add compatible
 string for ast2600
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

Hi Krzysztof,

On Thu, 9 Jul 2026 at 10:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Jul 08, 2026 at 03:35:53PM +0000, Gr=C3=A9goire Layet wrote:
> > The ast2600 was using the ast2500 vuart compatible string.
> > Make it possible to have ast2600-specific properties.
>
> Then add these properties here as well. Adding a new device is one
> commit: its compatible and its properties.

I thought it was necessary to split the two. I will squash the two
dt-bindings commits for the next revision.

> >    aspeed,sirq-polarity-sense:
> >      $ref: /schemas/types.yaml#/definitions/phandle-array
> >      description: |
> > -      Phandle to aspeed,ast2500-scu compatible syscon alongside regist=
er
> > -      offset and bit number to identify how the SIRQ polarity should b=
e
> > -      configured. One possible data source is the LPC/eSPI mode bit. O=
nly
> > -      applicable to aspeed,ast2500-vuart.
> > +      Phandle to aspeed,ast2500-scu or aspeed,ast2600-scu compatible s=
yscon
>
> This is a deprecated property, so it cannot apply to a new device -
> aspeed,ast2600-vuart. You cannot use deprecated code for new bindings or
> device support.

True, I'll remove it.

Regards,
Gr=C3=A9goire

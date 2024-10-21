Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1E1E7C13;
	Mon, 21 Oct 2024 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513160; cv=none; b=DdstkqL35uAnvCF3ARS2euAqwp6sI9fbEBq/k/TIux4W44njZnuY8B5LIUGgv5+Evq+CHirWuxV8yllEB0VEgIbm0MLFcOYpcEZeD+ROWKYeemtj5K96IUHfVmfhRa1cnvL8CVditzJVPaFPKqLoUg5n4Jt3cjBTY3xPTxW1HLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513160; c=relaxed/simple;
	bh=7mrhqlzLU/8yE2Bl6++pdNx3AsmIHi/tmHTMQIHyy7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9vZooA/v3ckuzsa54fo1cDJcdHh26kmIiaQDh1B639hVUA25JF2qplaKskfNi3q84ZXDQAF+JbNuYLJQtWCbq+PehNgLrH6L0TmppAQvLV/8pKGuD+Q06vAo8Mfs/hHFc8aNL6VfXzHm9Cpex6fw9xyjNXtCU05Tx7zQsCM5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJQ6lwLU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJQ6lwLU"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e4fa3ea7cso3370975b3a.0;
        Mon, 21 Oct 2024 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729513158; x=1730117958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GzXAN/kGFLyZ6KoxQYaMyN8WIW7O/chKPrM0YUwT+2Y=;
        b=YJQ6lwLU7n04PJmAJNZ/HtMDtWl4vYmqS9qQDCtE1imYoqsVVwSooUUiUWrRDLcgkq
         64DXxemN+fnA6FTWwa57Y2N/o9pf3WcJUYV34lkG9v6qUrIU2KSvJqXEAejAN7Jz4X0U
         pfp+UbBwpUZdwMwl35tXPTh1PxZyRJjZWGfNaAgDg2UPXccMKKyS8qEgdWtwOUYaIab9
         eH+KrtBGNf8M4IStTKJrYolbf9C7ImzFHsy0Mho4IWqkwkSM6VqBijLn+d0PSXPeM8Ur
         26+l6vnvwUuccRHb3IF3J1/4wW98wM8Uz5LsVY4gROHM3VKurENv4RjLmRH51WbJmbJk
         xR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513158; x=1730117958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzXAN/kGFLyZ6KoxQYaMyN8WIW7O/chKPrM0YUwT+2Y=;
        b=iO/mbJA9DqUJu0NZJUa/HbBCgFz75KVXgALKVIvKEHvlqQr6gL+9IlkrZzf/CylIR+
         x40v/5sRZo3odwKaQq6je4QlT73hLV1Mi+rHQr2z4f8lhxm5FxPMm2Lnt88TSkG80LSt
         LVh6wwWteDRgkuK+6QqATvnvQyf1OlI59tvJQ+ihyNqh7dxV0LXwK5UXGq/4ArKT4W0x
         GS+U0dx6bFz2vHLfJ1/BiCMeiI3sXw5zQxXFxp3DH/0ukzLxeD8GpZGlKyQ5gDRtDOaH
         +2fQG1oxqeQV3c8EDZV7QCvCLgTOejpsD71+R6uriSVeU6RqivxxbIAkkkkoWQlL2iEC
         fvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2u8IB+CEWNjZXq69QGd9cbB3MgMO/ZwidZLl00BapSKKwQTV7N9tGTf6YmuViLnBoSv+z6WyVsXnlVQJ7@vger.kernel.org, AJvYcCU8HDKqd5RlfWHNXsRsWIGcpKH0vKhJKdFdhxAVhj4HifrS4IT9M6toswtFyc57vKLHSt+N7J1Ny9HzTVn0@vger.kernel.org, AJvYcCVoscgNohim02VHjrf146jF2/QOoHdFANrtuF5d9e4vw3TugQlpCOJQNIZwaoCWiP46WOVKupZA1qhU@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpVCxpqxpMCwL3TRsTY2h6p5BOkCvCjWGJ0eZKMzv+oaVeDI+
	GGTx/OKDto4h65QlzZpxSGx3m2qqZlYgpeTgGEt96INKazF9m9bq
X-Google-Smtp-Source: AGHT+IG3E9DRACYh7UWi0DZZrBl+qKyuSDA06T/8MVTylVvYqdgNfbdh8aJBhwejFWfecdHUmg2QQQ==
X-Received: by 2002:a05:6a00:98d:b0:71e:1201:636a with SMTP id d2e1a72fcca58-71ea31a5886mr15484512b3a.1.1729513157747;
        Mon, 21 Oct 2024 05:19:17 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabdb75esm2907976a12.89.2024.10.21.05.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:19:17 -0700 (PDT)
Date: Mon, 21 Oct 2024 20:18:58 +0800
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
Message-ID: <r5ngs2j776jcy6sfirwzmtsoljotatfvgmlmv4sj4xksye2bff@xtn7adafbpfz>
References: <20241021072606.585878-1-inochiama@gmail.com>
 <20241021072606.585878-2-inochiama@gmail.com>
 <20241021-outlying-washday-8f171dedc703@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-outlying-washday-8f171dedc703@spud>

On Mon, Oct 21, 2024 at 01:10:52PM +0100, Conor Dooley wrote:
> On Mon, Oct 21, 2024 at 03:26:05PM +0800, Inochi Amaoto wrote:
> > The UART of SG2044 is modified version of the standard Synopsys
> > DesignWare UART. The UART on SG2044 relys on the internal divisor
> > and can not set right clock rate for the common bitrates.
> > 
> > Add compatibles string for the Sophgo SG2044 uarts.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > index 4cdb0dcaccf3..6963f89a1848 100644
> > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > @@ -58,6 +58,10 @@ properties:
> >                - brcm,bcm11351-dw-apb-uart
> >                - brcm,bcm21664-dw-apb-uart
> >            - const: snps,dw-apb-uart
> > +      - items:
> > +          - enum:
> > +              - sophgo,sg2044-uart
> > +          - const: snps,dw-apb-uart
> 
> Why does each vendor have an items entry of its own? Seems like needless
> clutter of the file IMO, except for the renesas bit.
> 
> 
> Cheers,
> Conor.


I just follow others when writing this binding. I think it may need
another patch to fix this problem, right?

Regards,
Inochi

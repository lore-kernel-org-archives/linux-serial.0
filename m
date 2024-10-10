Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B811CCEDB;
	Thu, 10 Oct 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548598; cv=none; b=LpQHGRXUh3FygHTeXis0H+mauRRQhVhVIu6NeHWQeAzI4+8mxVDmMyrrh5g5R+rh8kNdrRqM5/QxcoScl8Z5+hcQegslK2DDG5r8ZtW6Eaf6DBYUxTKC7ZTSJn8DJacQ66SYy7uuNkesXWPyjeKbtoOQyspfdeg/6vP4YXHNXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548598; c=relaxed/simple;
	bh=Hyt9tUhyvPpV9HjxpvdqApE6hevaQk0eU2o9K2Y9L6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUNKYlHlXzWb/VWcmhjH7KV7PzqzS4Sfdu6lN8xvsnarXawgKOWhIdtNvYDWza358zGuWstqVKeXBOuTNMwBF6U/OXqO0DZhgSWLTSYAN4az3ZukGg9Gt1h6xOvCmJ/gmU3vvhyKqizA+PfAaxPmqVBwV4CW/agHlWYx6DJadQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB7fMUjB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB7fMUjB"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e02249621so535543b3a.1;
        Thu, 10 Oct 2024 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728548596; x=1729153396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9ae+E6I1o/9YcKGY7pVfcBgL0XOF7rD+Bry9l6DIFs=;
        b=VB7fMUjBfCortyheTNXzxmuSOH4nKVAaotH2FYXcPX1R8FUO3gOFmOGOeEl2LOsW94
         S+hW7oGfMTB/D8opzlLuLL5iH/FRhMBW9sWyqCCuoF4pKz197a+jY/Vi/kfVMpdUCYEd
         9eW9PAZF9JP4Uq9aZPH4CLkLHEFNi3Euw0NNgl/4t8LnGm3LmgBe7pDLO2RW1hI2oelW
         rG9fEZ7vWG/PUvK3aLmbyl1pj1dCgYwO1cH+GySDKfyeOriSjdDw8wCnB4nWPmyTvUpp
         VeLylrVtwgIoWL5DznYOErbnjZIEAWGaoP0+Lo5pi6e5Us40ucGuqMeIbVdEJlDaW3jx
         rt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548596; x=1729153396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9ae+E6I1o/9YcKGY7pVfcBgL0XOF7rD+Bry9l6DIFs=;
        b=xUtGNqG1xzHD8ZhDp7sUNvSWmlyvMaPzPdSGj4NZr1csv/HC5pA8qznfbvY1M+NeXQ
         X8AYfiUW2RDX+6A7+1JiRUqdZNNhRXnkAiKQ9i94QfDWfYbIqgOjM/AuIQq9MCfMYue+
         hXo1ptM9CXoN35gNpUDiw3nVOSr5yk0sBM2qhlxuN3+oDcRI0jXoB8H9Fh65wUxblfHB
         Gw7m9cVfNAvu1yQv5ZdnofTzr+4xdxsOTw3MmUBq2L+WakfwqcWDE5hUSktur7ls0S8S
         HIcPvl3YiRq74wXdKvSPcXi1Bu8lU2n9gqnnF7neJhkNJN7MRzXSybzf8OKaAWG2d/Tz
         rqIA==
X-Forwarded-Encrypted: i=1; AJvYcCU3uvL4/0hY7Z+HNKc3CWGtaaC5wFlU323eu3efLL61Tam3T5/ylYlYlNX6YltxvugWfCgAuAt3izh+5RnF@vger.kernel.org, AJvYcCWFYa5gGe8MiT0aq2F+u3c+Q5OMVVdFoRfS5fHh1kPpH50w8iGDMBb5fbgCT6X8ESw1So6Vsy6A7n/0ocp4@vger.kernel.org, AJvYcCWZmFSV++TvBm9WkWj3Ss+lG/GmqPbICL4nJHLayw2DkfA8Gea7uGmUE/Tmqk2k1mN3+ETu5K2ikYmA@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPASsJVZ3zA0R7cwpH2KsXRsmLqHAzK/1npvm4loDN1IZaZWI
	3xH0bE05bxjDwusQc2q1+Hlmn0/diEA84aDEzm8Tt2XCRmI1jzQr
X-Google-Smtp-Source: AGHT+IF+ABFFDVIysog+ECM1hPrRK2sdF4oKlO6i+zlPKD326M6dvSUGzGyER0bQYlnvZfAEhjKCKA==
X-Received: by 2002:a05:6a00:1a8b:b0:71d:f821:1981 with SMTP id d2e1a72fcca58-71e1db64904mr9432588b3a.4.1728548596384;
        Thu, 10 Oct 2024 01:23:16 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aab9b1dsm587766b3a.148.2024.10.10.01.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:23:14 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:23:05 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo
 SG2044 uarts
Message-ID: <muz6ze7cxho5niz67agoxwnaowumzlcto2vwydmxs2yzdjmisi@symog2asftmv>
References: <20241009233908.153188-1-inochiama@gmail.com>
 <20241009233908.153188-2-inochiama@gmail.com>
 <oyvqsywyznanpx5oflnemcsrk7r7nnhvxl6ly7b55oan2boi5d@kobrtldqbj6m>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oyvqsywyznanpx5oflnemcsrk7r7nnhvxl6ly7b55oan2boi5d@kobrtldqbj6m>

On Thu, Oct 10, 2024 at 08:12:41AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Oct 10, 2024 at 07:39:05AM +0800, Inochi Amaoto wrote:
> > Add compatibles string for the Sophgo SG2044 uarts.
> 
> This we see from the diff, say something about hardware.
> 

The reason for this compatiable (and the hardware) is mainly in the
next patch. Will it be better to submit a new verion with improved
description? If so, I wonder whether I can reserve your ack.

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
> 
> I would just add it to starfive enum, but this is fine as well.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Thanks.

Regard,
Inochi

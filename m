Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9D1EA91;
	Sat, 12 Apr 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744461934; cv=none; b=X+6zFXP48fFle/DZKo1UInCgw6xNh6Ldl+//wLybez9t8Nkw2BkF7xDVeLvvOKUF0e4/OSdvoOuwwW5eAuj3xdslMrXow568nEQ76eFMCGxyWM93U2XEhs3b/pVv2E7ElgeRT3YjC/wZgXGkAYgDSeTmPOz1F4aAfzz1y/crg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744461934; c=relaxed/simple;
	bh=BlqjmiCO5gHfE6pk+/2AbOLM/Pn18+xedndRW8/FHps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbo5pzNCsk5Y1l+1FaeEipceb1Wrh6uGZ/WVjSwz/+OFYAkoY47aeHYDMB9UwhpAZMF/6UKfdc+mfEqpV20Y3oiNYUR0nbPu6CJAC1bih8Xb7P619jVCna/wNlcENKZd6reqqv4n77JfykwPmAPNOtmtNQZdBIPwf8K0fTxJNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/mpMaOo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/mpMaOo"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so490271366b.0;
        Sat, 12 Apr 2025 05:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744461931; x=1745066731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CSIu8JpD+88b1gGZOa4ZQUcLcr8nrVGNpfocXHyTMo=;
        b=F/mpMaOo+RCC8WVQuwSHQTmOSqFHHjmjPz/qgBMmUjashF5wlUiD6wyk8q3KYXhF/t
         kKw7sTDwHZb3Fnlmep0368F8/V33ap2ia2vLWGLcsntCpYr4kAxUKUSuGsqt/sXm98pA
         766rrEtlrAmaiGJhOdZ0DzTlxsIwS7pU2Od0e/ei6drJNwhceyunPKdIRhiC9zfH5Qax
         ljB0X8cOwz+eSDEwA3tMXeoB9ak/bSD2yVU64WxAC3H9tPth5ofS2Ie2AHwIqaWwHzFl
         ltVZlh+E/mkehP070k26hAiuBgRPY3EYGhhOkfzO5C8t3j7UCtEbib/cp4Bj7Gh08JKN
         8SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744461931; x=1745066731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CSIu8JpD+88b1gGZOa4ZQUcLcr8nrVGNpfocXHyTMo=;
        b=QLLuSildGFJAYVdbUlNaDZb4YSK235Y74UFWvWyIR5XHnyKsyzXZGrINtPf9fDxA5u
         V2Xb1dymZ2jSnx9yiTeknHMsWCR04Ub4OuSVtwJiObzT84XBpymXI/O6WZai5x3iTBKH
         nk2XMO7+YOB19KS4DRPo4cR/ow8ciVigY3JhNZ7y+86G8rjjFXFKxvN/LSRw02xzU6lK
         F2ZiWMEzKGrqiUEBJI0gkFnB+FB1fQkLWiZvpOsriKx/XHa9v58ZICXIK7kZDssf9Ych
         5hypgstbc/Sa9UyWC1wGn64TJ1dtx0jAnXWNZQjHLGkIPC+fJXldTm9bHC6dJiHJ25JA
         Uoyg==
X-Forwarded-Encrypted: i=1; AJvYcCUvWQH1Jq/J0F2fnkSKTn8/Bng3ad4RMknh6/5WXt/SAw5fJV26Ukkpj2T4FIj0xmRPWXMIcVXEtpKX@vger.kernel.org, AJvYcCWL4Lqesacs+rRw7B3yBPM7YRaQZdENAdczO1srfqjrLUh8ivwc85NHmDw4wRVSjVdoxxRccn4PKna0drJq@vger.kernel.org, AJvYcCXuRWM2JSpYzs4GjQ3rNG1pHpzwb633KQrw9luQHCdfUPzg3fcf43QS2gQbQpxqsu0t01x99Yj10Ftmr2bh@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWjrmT44FceK/mmyYiBmb5GAOOysHGwZixnaDPta1a4GyJIPR
	2q+q83Cz51ljVp/bSbKUhoyCloMCGrUCz9cAW+gJkhWf0zibIuFpaqDwd59K3GmfwN9I+wNkub9
	aJwksFl5oHApqv7CnVa+gIzpyfs8=
X-Gm-Gg: ASbGncvgyL02NjWnAUVs2mLs6U5DUKCAbwwEC84whgNQOLSHMSDu9Y8tPxvfYmX5L2q
	7KOCeUWgllasupACj9g1vIPaxgAqC2+Q/L7f6ICr/dXNAHN7pw6eSAHrTxa4iaNas4A5SuT6pT4
	e63MVrt4bDMcklORDFPUE+bQ==
X-Google-Smtp-Source: AGHT+IGfC+z/RHEDg/9TFMKy1xjqNYqDOuAW2IXR4RFyolm1ffVLC2JPi9pavWhIuEFFaxynDwZ5//r4gGu6ZPYkfY0=
X-Received: by 2002:a17:906:6cb:b0:aca:d861:877b with SMTP id
 a640c23a62f3a-acad8618795mr365643966b.49.1744461930521; Sat, 12 Apr 2025
 05:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411203828.1491595-1-elder@riscstar.com> <20250411203828.1491595-4-elder@riscstar.com>
 <20250411220425-GYA22939@gentoo>
In-Reply-To: <20250411220425-GYA22939@gentoo>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Apr 2025 15:44:54 +0300
X-Gm-Features: ATxdqUGjS7K471piTwxJCgQ1FPFGZOtwP3hjSsRZXjBRtkjA83KwOfmLPX4aRGY
Message-ID: <CAHp75Vcmhp4rOSETAvM1u0UV5ejxbSniuwocMBmUd0DrO1Jp=g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] serial: 8250_of: manage bus clock in suspend/resume
To: Yixun Lan <dlan@gentoo.org>
Cc: Alex Elder <elder@riscstar.com>, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	benjamin.larsson@genexis.eu, bastien.curutchet@bootlin.com, 
	andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com, 
	lkundrak@v3.sk, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 1:04=E2=80=AFAM Yixun Lan <dlan@gentoo.org> wrote:
>
> hi Alex,
>
> Glad to see first 2 patches already accepted
> This version is better than v3, thanks

Exactly! I'm not sure this series can be applied due to that. You need
to rebase on top of tty-next.

> On 15:38 Fri 11 Apr     , Alex Elder wrote:
> > Save the bus clock pointer in the of_serial_info structure, and use
> > that to disable the bus clock on suspend and re-enable it on resume.
> >
> > Signed-off-by: Alex Elder <elder@riscstar.com>
> Reviewed-by: Yixun Lan <dlan@gentoo.org>

Code wise this one is what I have expected, thanks!
Reviewed-by: Andy Shevchenko <andy@kernel.org>


--=20
With Best Regards,
Andy Shevchenko

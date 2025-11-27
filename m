Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC52D0C98
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259990; cv=none; b=NK1zFIxziEVbp2tRVX/oMO34O1ryltIj0Slgu9NGlkv/SowjelfluNi6ePUd+ugDvneYS9aLEesXI5d3NmAz+k1Mq55SunTxMLeogBmmBoWZaWohBO4uUye4XyCgL3OTnYX7I2uybjKz8XnihlT8+aFK2QGX89TXlvgJdLDnwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259990; c=relaxed/simple;
	bh=vHkgE8J7FmhstuADR1oxca5gWYlZxfEf1EiRPemtMDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1zI2IcsV+vDm1XeeQZRR6MDC6kaq9E3l7OJF47sLEqhr16oloxk91Ugh+UU4S7WewTMOz57w8dTi5JWZQqiVQ5456l4iEXz9mWF2XwpsfhFW5sF1KhWRDRFPaPRBUQY9wNeBShukSrk4PbgYu6KE/PINrtqhqwyrHGNmkW38No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILUboCil; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILUboCil"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b76b5afdf04so185965666b.1
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 08:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764259986; x=1764864786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHkgE8J7FmhstuADR1oxca5gWYlZxfEf1EiRPemtMDo=;
        b=ILUboCilhRu7W2l5uL+twL13aTtqP0MhjgKRRx2EMIflWnKm2tTIgbXCp9YjNKx4uu
         UsKxTeNgyxoxqMXz3Cf64Of7brK0+IiX8CjgvisY2mcFDpRTG2JO2Le9mJDH3klbrY5N
         C/OCOysbYHIDDRPNHlyvUxA0eu+ypLJ3qSI0cw3KEbK3SzDI9oRyX9AvAq4QGNRy+d0K
         A1XUYALNm8gGVaBIqY93OILPgJ06q2xrQDn/ZR5NDnlmBPM2gk+t8BFZQI3+vNP+GF+B
         LdNWFf+5jS1NyT8YJ4G6rJmQd1u6PAQeU5jrjouOzp+aQCxDSNr8Q9J9Nj42mPRCY+rn
         HFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764259986; x=1764864786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vHkgE8J7FmhstuADR1oxca5gWYlZxfEf1EiRPemtMDo=;
        b=WDHkc62jVUflQqBdukQVHbBKVWXkIK0zKCdTOfF02J+zO4mrL8kflIbuWmmI3GUxW2
         9QS9uv/7e05mVXiBhJxOiUwnVw7opHSVGGLpY4xIBipCxa2qj7y/m6g8adU2Gh4zC2hp
         0ky6qkmxwDDj7WNofWKvcOKKx3//KsMku6D8S8nCP3x7b3BbAnPOaqas6nVAWfb0XQjH
         l0FBlg9DlbvFDE9jDJ27p9KMIyJYsu9R/Eg57rzxPu0ABAeFHO0nQ/c8d3sW4gmr5kh3
         7L7QAN4zlI3ceepbdr+tDichexn9cY5Qs80Xyly0PWUKyP1ruFP9Ni+w9+hKruaA5Pxv
         +xuw==
X-Forwarded-Encrypted: i=1; AJvYcCWvPd7nY6Ny7uqZJxpU6tfDUeVzIba1wUV0lO/5Y8wavgMKFEOInuNf7mqnJzkJmI9py1dFJZU42huTPyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCSOqgcNAO97PXEm+EY3L2wR/aAUi1en+jqxGUmEjnYw3L3Bj
	GmqNRp1j+RMmFoMNfYJawYQ3KpZZxopl05TnSRKfeQYpvsMp5/u9tTzJlctApDhvRHqRmqxGL33
	Yl6yEMQwe2ImzYghzEXLvH9+MaIzBZro=
X-Gm-Gg: ASbGncv+0thfn/ofi9B714VdxCCR8HStsICuDH/5IQ5XCYfhAaljzBw1djicWK0O/pw
	3wfgzZH8vt74MBqOh+pwpZqPs97bZbcDpyI8Qjtij0ehs/0GYoa+ed7rsJdwj5rg+lSRKHWxF/c
	Iq5xdPgRBGS4liXPOaTDlT+u02yNQ+bNm1hi+/pNKi9C+r8JM53ytWM/EVze2XTfX8Ah3bFLKv8
	eKOuxpn750d3wn9Qs/baTXqEEEF/zFAhugAFNT5JtC5t9oMsBrtgd1pFvmIh7ZY7XIVaZgYoYU6
	cBGdvlW2gbsjIxK7QfpATpurpBKqiZUHbg6mo8g2JkEp6hKAESWl8REACp+z0rHXOlNbrC8=
X-Google-Smtp-Source: AGHT+IHL5lD9l+Hh164xtP764PC1ElejfIHOpAawihP6o7z5n7+TtXrvPC3UUFXr2PXT/YoRMV/DR5xhbgT7VKwIfhk=
X-Received: by 2002:a17:907:d05:b0:b73:7ca6:220d with SMTP id
 a640c23a62f3a-b7671a4728bmr2613030766b.59.1764259985521; Thu, 27 Nov 2025
 08:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com> <20251127155452.42660-3-dev-josejavier.rodriguez@duagon.com>
In-Reply-To: <20251127155452.42660-3-dev-josejavier.rodriguez@duagon.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 27 Nov 2025 18:12:29 +0200
X-Gm-Features: AWmQ_bl-vjVNPE1-lBZUlM8SQoQAsmh5XSIjD1Lm2LJMWJiupqb_fmgKaxReBWs
Message-ID: <CAHp75VfhM5GuYY1qUKgBhePDo4oe5k3K1ZDTPbYJNr5NtjVVfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mcb: Remove MODULE_ALIAS from all mcb client drivers
To: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Cc: linus.walleij@linaro.org, brgl@kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, morbidrsa@gmail.com, 
	jth@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net, nathan@kernel.org, 
	nsc@kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 5:56=E2=80=AFPM Jose Javier Rodriguez Barbarin
<dev-josejavier.rodriguez@duagon.com> wrote:
>
> MODULE_ALIAS information is no longer needed as now all mcb client
> drivers are reporting such information through MODULE_DEVICE_TABLE.

While this is not a big change, I still would recommend to split on
per-driver basis, and with pushing the first one as kinda a fix after
v6.19-rc1 (to v6.19-rcX) allows other maintainers to apply the rest on
driver-basis. This helps everybody I assume.


--=20
With Best Regards,
Andy Shevchenko

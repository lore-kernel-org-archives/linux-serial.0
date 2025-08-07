Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A871FDD;
	Thu,  7 Aug 2025 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754602274; cv=none; b=A7IkVGtOtB21+CL9ON80BZucJKbFR9SoD7ITwatUQDqV1+QpOnMrjgbFYArazIifLkZ4hu0vxK6mFR2o8iLI3TEleV+a+dxOw8orjir4Zl0LXLvQRTSMs0+YlVoUfry4AQiEKUKr3TxnMc61QqLK032K6t5FWyr7D6FXWlCFTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754602274; c=relaxed/simple;
	bh=P7WK9QE7p5flsTIPnQzAvPVoV2lI06faOeXSYMAGWwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoOEfr3mCkwezwVLXRKgn4bF+MopKWOEDXB044AL3Z2uu1Mh67P62rIKZQTdvfQUCvYu0g5WepDIOVwcsnlagl8zDu8dULYMG6MI8RnAwQeENlfyyYDr7200tMLGRgsRtfjoKDF64YQrHalbbtvIrGx/HSeeVSvIax7anGha0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5vEf8hV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5vEf8hV"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso2544675a12.1;
        Thu, 07 Aug 2025 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754602271; x=1755207071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgfxSNLXY/uBMR5oXfd5TU83h05FDRu/Eprncb9W5vM=;
        b=E5vEf8hV6CqiOSsoaDdUbgpM9QA0cved7UIccFayolC++gsVfaJzvxjHATP+8w13Rp
         Kaou7LG28beaFIs8TVDSh7q0YkXwh6NJLNQLCXYF1VYJGJh4thsipvwiVNj4imJkFLjY
         mcWtaFAB4Ldb1T2FD+k6/Ej8eyUk2Z1Ph9H+0jGvcJzkjm9x2pLC8AvONGPSKz+yTOZM
         kAyDnCptgxKiiS+2zeowdqd6ag+fZc4bp6LLe5qNME7jCwBZ+Gp1fr4XWBXtTDomYeti
         cInqOQ4bcQFj5HDdHJLo01hX6VQFZBdInvBJbqxs7q1q7mUmlEFESQ7sLR4zLqAK47GV
         7WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754602271; x=1755207071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgfxSNLXY/uBMR5oXfd5TU83h05FDRu/Eprncb9W5vM=;
        b=UCky9s+qWuFGEH6XnEUES/KyAVehKXvPeSYsm5nHTXM7BSjjzfmfEHv0ssOMqoSVg5
         cixHLju5oJdrdqyNHBBi0m7tDt7zyVTXKizINS5dcA0EzrlvWiNvGzB/3pgzo8sr07RX
         paL26QNLkJSzO/EOXMaZJ4ZO+Oz90GimE76AWBg8LFDZJS4sabKcF9vWyC5xn/Q8+/HH
         88QXuLfFy/et6/EpN0pBvm1OOq+46UueatGPSvfNg5rHq0qLeXSI330CoepPHlimp2CR
         UJGtnsIMt6xYfC3Uen6HWxrt8t3MckZWAjhmXoIgPqUBNv56p1TGmfbhdQC9Vzzu9bl9
         l/yw==
X-Forwarded-Encrypted: i=1; AJvYcCWGbWE7UWYIzwBG0J16wpX/a2Ydg+aTH3iQ6Zij2o+ANkdo+ixWJOF+CLrNohla9oDS8cMZiePylCBDaApCef8=@vger.kernel.org, AJvYcCWT3u+NzIZdqvHZPduxZnd5fU4qvByuO7RLYKfGYCO3fXiGq9yW5jlKUw4HM2Pvo/4pu/P0Ady/KkqKU2OC@vger.kernel.org, AJvYcCXZKt8/yAUCtA0esQ9rGoXJkGgs31/qtJR0vKQ50VuTwRG1Q+DDxD7myFr4T5/GppGUd1ByJVM26I/z8xN9@vger.kernel.org
X-Gm-Message-State: AOJu0YzfVX0HAioPxDokGIlf7MYf+MMOSIgk0aSZ80sibM0TEDDSlqPF
	T9ekVvRAZJPap4Pvko34+d5S0sO/XJBTz1wqnajg+Z1y9b80gngTnxaYZm2aG4aM6c7rJ0gfalZ
	NABNup9Z0zvYLdUyN3VVeK646q1lmcx9CnODNJJQ=
X-Gm-Gg: ASbGncuZ5ITbAMS4XWnLr2fkyuwJe81fy1BzrT/BDSBNge2SjThDYdKhb2f481TE47Q
	Ozn06HXK2i1ZOrXcEGdO2YTjpuwkl9NApqDT+zZosOuw19nWdiRgmF4yhZuCDDXZdS+oRqZ9RFZ
	rXK03JkZqDJD1Uk8GLKa1yqVhQEzkDQj+WIFt/eixAvZ67s20WPWMoYYLZJiJhOtJ0aBXyxpPYH
	UcyFxaGFczqCIvnq4Ifc+1vtWSIj9OEAlqJ5V8ixi35baU/kL1F
X-Google-Smtp-Source: AGHT+IH1OSj1D0U+HcwnAVYgXw1ssRAWe4/Kyi1Y+QVMHvDklmj5x/83T5iWCB/sL/xFR/od2I9UmItDgFszJEXNe1k=
X-Received: by 2002:a17:907:7fa4:b0:aec:76c6:6ef6 with SMTP id
 a640c23a62f3a-af9c6525a10mr32605066b.50.1754602270577; Thu, 07 Aug 2025
 14:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJTMPZiKqeXSE-KM@stanley.mountain>
In-Reply-To: <aJTMPZiKqeXSE-KM@stanley.mountain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:30:34 +0200
X-Gm-Features: Ac12FXwNfnuNMdq6_9-Y0wRL6ipI8DXi0g1PoohCNxW0ckNm3vyw9lpt_0qVtrA
Message-ID: <CAHp75VcVA+yARTBvcOiKYdhgxtS_YQ82Xd-R4o98OTGp167ZQw@mail.gmail.com>
Subject: Re: [PATCH] serial: max310x: Add error checking in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 5:54=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Check if devm_i2c_new_dummy_device() fails.

...

>                 port_client =3D devm_i2c_new_dummy_device(&client->dev,
>                                                         client->adapter,
>                                                         port_addr);
> +               if (IS_ERR(port_client))
> +                       return PTR_ERR(port_client);

I'm wondering if this is indeed a critical error in this case, but okay.

--=20
With Best Regards,
Andy Shevchenko

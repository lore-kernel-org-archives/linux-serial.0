Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE32E764B
	for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074548; cv=pass; b=oXXq3e8JDKdcAv3hO6jSJhR+w9vc7beMV0oE3xeLz3XSdXV1nZewiyGKZ5MNggZW8G6ghRwY9UiAYnyFXeIRlwoWmQWRhNQFzwgCXz0mGm1iZ+tEmntU4oWBHx/Q78HOTh+4ojWroOxzaF+aHMiHf5mGGKz78T0gjEMQSgAIFdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074548; c=relaxed/simple;
	bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mt0dPe118CMePcrFe5IitdVxRQAoDRXTHgqwJVS+G4d/nls2G+M9cBQ5h1IB6bY9kZGz8IjVpyJ9w6ytEI4ecXbsPF9EDB10ICEiLU2FAIddAw41qxhtUIj5QB3rLi2jSiLXFNuAewNk6vE/6DHTixfTcFbzm/ZJBCyyvNXoyBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=WMmVf+cD; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="WMmVf+cD"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6582e8831aeso1244675a12.1
        for <linux-serial@vger.kernel.org>; Thu, 22 Jan 2026 01:35:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769074545; cv=none;
        d=google.com; s=arc-20240605;
        b=LWwGDmZLQUc9i1hoxdRyQk+4DvkZlG300fo3MI7a/5sSabklDGsdnvo85LsEE+vgxi
         pRwozyFC4W1I/y0kuOpcP2bl/6A4jDb+jWXGZeAy+8jrpUaVfeie6LLPMfxy0QiGW8B6
         qL2bep5XnumvH4GoTrMhSxLJQPkOxS7lqoWsdsl+oWakYhkFxFWCrSHc5wjnb9SlU7ik
         kHHDujT7dT0QiMguHphV6bIWR0Jfj4gFtxI09/SHiZs0JCpbW5yI7pqdD8oX4csC9phI
         FxqHjms6sGBNXiUaE6GrQ+MVedTKVejVYTsWloebiUHz9DsNIDxKx46959P8VurCdDWe
         L5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
        fh=fAyKZhc2xpPbEKPJOQS/repcW6ozqQQByxEQKUpHM8Y=;
        b=UhHlnBCJ1ernHO645MJGAhW2nhOPYRPBVVyraod8w7FcJFYgDtO1yFLMKH2W1GZJYx
         sGOjBFp5rbLwfH4+Yl+BtAYS8CaG7UnJtGMfDCglWkjqm3QwZZ49/QUfz2fQnuDgNFDB
         H57ty7bjhsivvlAqovByTJ3ghByNjkJGY7FeiXCJjiaHo5gviNn+tVGyGmfErdqo71IB
         lnFlGCX6xe5EntvXMSV+zB55HTxw6+gY5KKqnQ0fofsoNRI5bmlXzxi3izgjDJNw8EnC
         QbHVsw3DVIiJuXFizw21aWgNgbjtskjyUFNT/le2naugOhXhHpizhYhk+zChIovsx9jM
         ZBQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1769074545; x=1769679345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
        b=WMmVf+cDPVXyzKm73nlXhVqX/GgwBPysyw+V8fdoMVElEaKbT5iIB+JX6bg1SMgNHp
         BZ/xpZLXmDtL49wkbLH6Qe5t/c1FlVbMBwB35Yj2bfbomiTfVmmlbRHxUoEZR/oQWck+
         Be74nd4grwTHoU8lZrxh7rK5Z11b36UuyBJ2+hjYl8aOJ18c08LpQdSkzjpNZL7dXtFS
         T9v9pdYZUJX2F6R2ZKeQUFJ7x2iA+DdPl0QupDzrrWAwUT1dVBgpkasAEVxZ/M05ccks
         CyBCrEYEw1asEPFNKbUBuBO1ZPFruijEtPlo7DqxHXrUhxmMxMlp5rmrVyWYwRFOfOVs
         sNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769074545; x=1769679345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
        b=IScI0u3sou8gTCwas07U/7edGrlT7NNVId7rp8DX4oxt7hA6DqAF7/N4nyFUSpF9Qn
         hWsUzKGXwkEqbeV2YG7iHpt67a125JaGqc6BBwC+Pu/pqnJ14bJEXAQIIce0fhQ1XZnA
         BeKu4rTb09z1+BO9zHu+no+yvW92CyTtb27NAeT/R0vGbKOtXV7vJaH3qs1IAW9iOekK
         3T52xYusu3/c6s1faCUQzh4lkVyX3YhRyQ1eMs96G2am2uzzq9hyDDcnf977cj7NisO6
         5oVtZzYfCB8RcOYBxfFstjqUSWI9XelsYl9pVzB9xtkM6d/tU4Yz5m0iZNgwvKjXkbu1
         QoPg==
X-Forwarded-Encrypted: i=1; AJvYcCU5a4L8IpXbvsLsbQ4chLD0rSh/BOg4bUucNIIiYezIxNl1AC6QPq5n1ehFJl+uj6TU2D7L6j8CnrvVyMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5suKJZVafOQr3sV9qds5e6o8uKW+luje131xA7R47rKXbAaA
	YpvcoyMb182q86dmL+OomnZMXLTuo91X42SDLxVBtf4CDZnmsTfA03SvX9egJFtPwjPogQADJg4
	Pm9WJ9+cB5ut6wHcbf1XP17ugttx4uVGfrcnhqwe7mQ==
X-Gm-Gg: AZuq6aIFXfsL1LJ8h9C4+JPPTe0G4Rm/vPDFf+sqa5M5L3wjRRL3+5Wu7TLBSqCnGB/
	ZEIblfHtN1MrPUu+yzctXxhgyFMbcm94OmzMx83PsOkQjHQ911KF29vn4NF9UYaE0YlCC1mQ31T
	4pduOpDcPI7Otjms47njv/pfOHn/2kx+U3PX6fZqYEGp/HVzXSJg1aYYNGNSWzB0a4gKzfUurRs
	14qCFN28k0M5pgfoLy4BJZn9XwmTpOWXc9E4NbP4LsX9KVWkkHt/3onFCaSWM4eGXm1C1J9hLK+
	Y9LaXLatQbr8DQvOXIFYiw+UvofkRPJoGe7UDZDhmkpvasxvIiiPxtIyjOHxhQ==
X-Received: by 2002:a05:6402:f02:b0:658:1304:b68b with SMTP id
 4fb4d7f45d1cf-6581304b771mr3388171a12.15.1769074544348; Thu, 22 Jan 2026
 01:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115114021.111324-1-robert.marko@sartura.hr>
 <20260115114021.111324-7-robert.marko@sartura.hr> <CAD++jLmitNVhWmUf9BBqLR2_WsAR7V-+ykVJsLK3MuOSUKQF0A@mail.gmail.com>
In-Reply-To: <CAD++jLmitNVhWmUf9BBqLR2_WsAR7V-+ykVJsLK3MuOSUKQF0A@mail.gmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 22 Jan 2026 10:35:33 +0100
X-Gm-Features: AZwV_QgGcZewelkI3QjoxNf_Rdp39oV_bH_54mEjrqvn-sBMKJLuqze3gq5di5o
Message-ID: <CA+HBbNEw_9FNOFxx8Mo63Aq49MxWvvuQ4Sc75mXFYpwtMmETiw@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] dt-bindings: pinctrl: pinctrl-microchip-sgpio:
 add LAN969x
To: Linus Walleij <linusw@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, herbert@gondor.apana.org.au, davem@davemloft.net, 
	lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, olivia@selenic.com, richard.genoud@bootlin.com, 
	radu_nicolae.pirea@upb.ro, gregkh@linuxfoundation.org, 
	richardcochran@gmail.com, horatiu.vultur@microchip.com, 
	Ryan.Wanner@microchip.com, tudor.ambarus@linaro.org, 
	kavyasree.kotagiri@microchip.com, lars.povlsen@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-serial@vger.kernel.org, luka.perkov@sartura.hr, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 1:44=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Hi Robert,
>
> On Thu, Jan 15, 2026 at 12:41=E2=80=AFPM Robert Marko <robert.marko@sartu=
ra.hr> wrote:
>
> > Document LAN969x compatibles for SGPIO.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>
> Should I just merge this one patch to the pinctrl tree?

That would be great as other bindings are slowly being picked into
their respective trees.

Regards,
Robert
> Looks good to me.
>
> Yours,
> Linus Walleij



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

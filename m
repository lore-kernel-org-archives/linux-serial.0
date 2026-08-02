Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355720E023
	for <linux-serial@vger.kernel.org>; Sun,  2 Aug 2026 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785662457; cv=pass; b=kz6i1lhOOV2U6BDitdjXB6Z1N8teFW9OZ1zPN/+XTBlEpOSgMTSjbZ7Ne8p4YaurEo0ix9QsHLkY+Uq8BTS0wPBtFyhjPmK6+T0BusfbgpW2zkWdXmEOSf10AK11rc50LWj6vS/+H24mF40Xj2RjjEASkgyQVie/gAb+VkWgOxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785662457; c=relaxed/simple;
	bh=BlwrI3hIsDzBiut32d3fqCIX2JOe7xef1CYL5MAt9qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aI/U+3TpWTEXsA60UL65788bJZwBs6WwgCgNQHPUZliJL2FlI8OympJoYAlMraQuAhGIp96HV5KHjryVxuOIe0u16ABJbdbrPBQdEZepmt6Wfn4ihjLCmDLZESltcQYJpGmp/cXA3b1mBoQYRE5jXdWSZoi6AeGTxtF6aslxL9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0ZFz98i; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0ZFz98i"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c16794450aeso351508366b.2
        for <linux-serial@vger.kernel.org>; Sun, 02 Aug 2026 02:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785662454; cv=none;
        d=google.com; s=arc-20260327;
        b=IcjCw7/bmAr1rVRcy9kjtQUlqWCoqiUd3vp9WLJncZc5lBa0wFRxKrru4Yv84g1E+f
         yJPKASwcniRXj9SGdOohwclq3/brpKXObuqJPWKrtn7KqCesU280MMF/zhITSslQujGJ
         FUjnxGcwJYxXhYZP1bW0+hvEVRxyHfv63S8ZnPcfsArkd2726EQ2iRYqHmpiiFDiieBv
         m15H4gvjUV7aMwcNtHHdPJiK+9wUOOTQ5jFewAzQ7Aa+5/LeXfoXAYb4uNXZMSys892Z
         Ng3fZ+M2Yg9XnJ6L0Te0Gxra2qP5eQyeLvV1ete3x/CLosFj1gPE+OeTjHTESQzzyHg5
         9CPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qiCOETn2UvNgP3HJIGmmXz9rU7LkQmt35xMa05rwSts=;
        fh=zxL+SHZZE7GqlmtOEKvz2x6KjMkuVxNa9rN++Azx3lA=;
        b=JvZuwD1xJBZ9tvVq4E04VHHS/UktnI1HSc4vePj6qRudTlArz6ZhtIivEdw3ISPIf5
         sLYmR2sHmDPTAk/E3ykfH5Q6vWT+Q12N2u3z30SnuhL1zT1OL/CJJoUmaodgdHkYJsUK
         SzOxkvMHMCGWEC6l2VEbpy/2StUDWgQoB+ZXeEONGlK/rKWhjR7Q8V99BK1mZT/52KFH
         ggaeqjbz9Hjn1Oq8mxc49hqI2nyGRX/OOuz/cfP4Uu5iWuW7Cacj7bQO7nl9XNq60lbv
         IkbB/asDxz8yPLNjdOOaxPqeozxYntn/v0gPnfDtRxAT9Dx20/eiBY70xOLkjrUxsNuC
         azyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785662454; x=1786267254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qiCOETn2UvNgP3HJIGmmXz9rU7LkQmt35xMa05rwSts=;
        b=S0ZFz98iLu3oWb7PVt75JO7ETMv17CmxLruV6kuFiFQqUsVd4ZXZNtWPYxdOscYghh
         YgvsqKcna+pcOU5k1UK4JyDx6E+POGZyKQ3xAbikUfVCufS6jpc7Nk4TtgSy4om6pdGs
         PDBs79O1mnMFT0dinPMZOdXr+MCaDwq7cyUmDMIZm3pUmNkW8KYICnccAoUi33WG8NcF
         Qr/540I872fVxy5pyWFr0V+HSrKFfYn1YWW9UPkdG731Dcxa0C+EHxADlSXm+Wmjk5jb
         /kksGiKXZ6UdzR/YG4sobFdq6K/QzNRQnTsGKwDs/UIne7hroDayGgXrOXkDfy43z6FO
         MTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785662454; x=1786267254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qiCOETn2UvNgP3HJIGmmXz9rU7LkQmt35xMa05rwSts=;
        b=S6R21Ii3btkGmGLvEvM4nJgcYND51iJYA2SfpccQOGUyRKyH2c2QPpO2SlHydqQ964
         4kItu5w129gPNgto9VCEKrfeQ2RNtEjYxygjQ3UBkM+98Mo32AX1n077AKrRs6/argHa
         I4mjCs7O1tffkmlEpvOwIAOfqIXmJqm8DSfhEvZCF23HOSE7djtWb8oyKoqLLxrxhk8i
         oXoJlztaXzyKrIrgzvlqaS+k5g8Y5nyTpjQpLZBL7pWA/N6l84wofXk4W89yDehHUdEB
         dfHkCZgoVRLsstKmk1I9ivK+fexX1tzT6TQBE2IzzSQDpRNJ0kfHfmLox4XzFaRlmbFO
         d8Wg==
X-Forwarded-Encrypted: i=1; AHgh+RqtUrD1xnvd9ZN3F2Wftf56t3BIZf/4tuFXyWmIsWFEekCUNvMu4/n1AZTbr5knvuI4Hg9dzRH9XDR6TcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5vgR2DjorAPeKHb0Ej/DMg5Nkaw9r/0XHN6SlhQc6XTEdMBl
	lhZnbhmDT4yaSdBfgzFfsbVrts2tVCm1IS0e/190cFYkJSJBzByhXdCNIIBI+H+TPaHQSftEWzN
	ZMVIoRdkNVIn9q3EKH0WxqE0qALE9Ke4=
X-Gm-Gg: AR+sD13k4ue5sQ9Cy1+SIZaRic0EG2CpYWz+teajEdBBtcsFQQ9uZRarcFlswXEWrsf
	nrK1i9494wZRof+douVzG1L4c0U0MLdAxG+phzfYgjt9Ukvo+YCsE7ja8EWzyXDcJPuI1FwABkB
	ud2gNTsAL++ilHQPNHGR3Ts7JAJtjVVJtrZL2rOIvSGFJXV6/ljl37GdKbeaXXJtWPN90ppPYQl
	IW/3r5Q8ZRRkSdPaLXXqNRJdRfy9ydLI+wQu2ODswyd3WXIj10xaevydY/wo99JkHoHS5ubcNTu
	gO/iA8DALyzA9ky/IlDufw48xtzWR3YGgDc2vgAITW4xFbF4+Gv/b6nYsIVkY3t1xhONQvLL2dT
	RoK5lQLkN03QwwL3qaahSWkfuEnnM3cCbIfahMSJ4UIK+R5Z8V7f+PDjrWrTA5r1zUi2nh5gFLV
	o1tD+5VDVNuP8GqphTVRnWv40RyJ76gV35UTO/gV7v6ny9mm7tiSYks5FRAVGsogY=
X-Received: by 2002:a17:907:1610:b0:c07:43ed:1b3e with SMTP id
 a640c23a62f3a-c1fe7c4b08amr476347566b.0.1785662454544; Sun, 02 Aug 2026
 02:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com> <20260731074820.735619-13-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260731074820.735619-13-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Aug 2026 12:20:18 +0300
X-Gm-Features: AUfX_myeq0k8H8hqUKwCjnY0KU6tFHsdgZ90rv7XnZb2ZU8DTDr5Z6OKaqLs1Do
Message-ID: <CAHp75VcRkgsBOYWwk9pUxDvc4-YmSvVn0fkrhPSHHerwykVvWQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] serial: 8250: allow UART drivers to override
 rx_trig_bytes handling
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com, EddieSY.Lin@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:49=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The rx_trig_bytes sysfs attribute currently relies on 8250-internal
> helper functions and assumes a fixed mapping between trigger levels and
> FIFO behavior.
>
> Some UARTs provide hardware-specific RX trigger mechanisms that do not
> fit this model. Add optional uart_port callbacks for setting and getting
> the RX trigger level, and use them when provided, while preserving the
> existing 8250 helpers as the default fallback.

...

>         struct tty_port *port =3D dev_get_drvdata(dev);
> +       struct uart_state *state =3D container_of(port, struct uart_state=
, port);
> +       struct uart_port *uport =3D state->uart_port;
>         int rxtrig_bytes;

Hmm... do_set_rxtrig() and do_get_rxtrig() do the same, but under the
mutex lock. Hence there are questions:
- is it correct to have without mutex?
- if so, why not to propagate these (if you really need it), to the callees=
?
- or should these callbacks be integrated in the lower level?

> -       rxtrig_bytes =3D do_serial8250_get_rxtrig(port);
> +       if (uport->get_rxtrig)
> +               rxtrig_bytes =3D uport->get_rxtrig(uport);
> +       else
> +               rxtrig_bytes =3D do_serial8250_get_rxtrig(port);

--=20
With Best Regards,
Andy Shevchenko

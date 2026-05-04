Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D03D9DB4
	for <linux-serial@vger.kernel.org>; Mon,  4 May 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901403; cv=pass; b=jxbrU6BZMocjg8BX1cQmwgoYRuukcKjhHUdwBtbgD58ECo9seLloKzHdcUthL0SJlynYpY358Zbncp3F9QtQylFaMOWxFoLAcuXGrd71qJT8lQJ/2yrIsfPFKWYiytGXwN2ij2gAnfzHUQGvkX61yuD4q/WRI7MuDmiafZ2/k3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901403; c=relaxed/simple;
	bh=QvYQedenftzFSiBfI8D402Mr+31ucAaq/Y18AUMSkIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eq0AA7EhLTQYZj5vHcPkHqgGKcrQBrB3XFxB1MIheFs+M0xcGTlvQf8hdGOPg6MWMQLO3rEV8/c3KB0q5/Xv0KBmA8l8gMlWLWzTUTfcrGqsz16+t3wzA0PVfBAHU4UqFp0Lz44LbUMLC51zcHmWNFIQDEqsAyfSNMrA67Wp/SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aev9BrJO; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aev9BrJO"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba699316b42so576393166b.3
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 06:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777901398; cv=none;
        d=google.com; s=arc-20240605;
        b=UrWjzmweNTsemP1CqpnfVOPBf6UIAcy2h7x33NO1JzpSQWWh6dtJIilj6/N9brApj+
         eBeDvUW/qARBEsOh4teeONCc8a/F7fMDk8Fgd/UogplImNPfhn0pkzbBAeBiuO1i7iuZ
         hQhEwZC5H6+dkEQ0gdWUbfVP0ZIWY7ledSW/ozSuuuvl1/l5hYKdXebOWVbmzHB/cnkH
         /emR0qHEgkH5mnV8ZCaveZ5rGuDBVesJ6t3dUr1Ib2i4Bm2Dw0RZwRJgJZBH4aiOTGiw
         tpvdusOXZG2KJoDAREAU/w1Ct7cdZtlRobh7q/VXSLiSVu+l5RJBra5bthHWgAkn+3Nq
         uvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qB0D5Pkcl2d9MlgYt0C7O3ULtSATNMl36JLMHXHyhbo=;
        fh=yW4FSZ6Frq1pxOUmwNdzKEqZBaqmebevsEk0K2Y+J6I=;
        b=UALtnWl//qkpo3SlSOfn5M7wbNDGKdHLLal2awesoBoS45FvJA/1u9oNXoEvR2Rn8g
         54nQ08Zk3jXiguH1jR9+u9v7x2MZ6maV14yN3HpvUlE6Nn0Y8/qalwJJnE6yKNIjkgx7
         jmQGl6UU7AekWu18ownijdvHFpEMRj9YNhgsaHkR/7cYqPJGUAsqeGcCjN/XLax3YLmE
         05u6iMMT99BagbSbWP4ceCnJp0+Ga3qVD3OPByHeZdckjbLwm68V8xLxN4Xvhtk8VJfp
         IAQ+e/upE0bif6sLcKkdfA6PHg+Z63sBkJKJMl9lKA7U7OpUomnnpPd3Z1E0jPBHN/ad
         rNOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777901398; x=1778506198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB0D5Pkcl2d9MlgYt0C7O3ULtSATNMl36JLMHXHyhbo=;
        b=Aev9BrJO1F8Yfr/kgtITv/CN49o1he7YLeKLy6Rlm5yxHd+gkauXbi1kWBgjp2w3fh
         0ziyK8D3eH/b+lHtNu8YKtgnn7vXHbkcswYoZarl15tDDFI6lorSohE7nL4Hh1Eveqae
         UKPerOLgfyy+TQz7YaiIClMnHvKzEFFBY+uuZ0QJL3dTjTu+GRQaE+Ulx4RnxpliLOhO
         8gimyBUi1Fw+7+ox7lAZZMz8YNdCndDncQOVbpW/p5sPQFaQWqTKjtZz6esqoAuGqwpU
         Eez0pNqANt5RtMLgJrHBustaIKH411pcYLxkd8yCxbl6x4aOBYWWK1qWam3Ce/UBV1ce
         nW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777901398; x=1778506198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qB0D5Pkcl2d9MlgYt0C7O3ULtSATNMl36JLMHXHyhbo=;
        b=Z4ut/vpAs5oL7TldAC6vhKn8i5vo9ZxoDKfYdWwhczTCrOZoHiCLYPkU4YZaER3YOW
         UJMcuM3nXROoZzcnlbrjLnRoZXFl3v6Ysz9wfBSh/92yRkHtu0KAdPZfPP4Z2HBDz9tm
         dyED29hLicVxWgrjhiYfIRH6Bm5ZwLp25i5YVwSL+9GsQWmcD2uriY2phRbDlPXxEgnZ
         +M2EaRu/ZVFAXzoMAU2F/jmAp7X489qYDfloyC8ABWS+FCMbOYSA7e9PNPztWxx+1U9d
         JzG9aRM6gr/sgePDr8TVfpkbOhW8nlP4HJ3J1kyu3myoE901juFoQwv36ZMc08QEcXFC
         iNEg==
X-Forwarded-Encrypted: i=1; AFNElJ98ZIAcfxxxYfj5bYu1ZTntHTxxNmnFXQPAQVJbR3++pTUCJ2zTCHOZh7P/+YMfKqBjp9eeGLRdhj+0/4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW16oncHGWYgmLIqJYn4zssdd/tqj9nsbtIuBtfsjKJ3H+79X8
	U3yoYZRKLhSlCw2tdvopqrvWVePj56Y7A/DqXm/mWN1IDqh9rbzkiWDFEbbux/Ry9zaiD0MHbZN
	toFYgYzUhf/DPTHgOGf50mCus/yp8//c=
X-Gm-Gg: AeBDieuE46dueuwYEkFpVJUzuerz1POk9QJovNwG+65BdcFoyku4/zODlIjeYdq4ZAO
	3YK5nHxGGJwHJ8TTrExyJKilQGVmVCOUlKSFat2OjxMVKSgbWtUYd8CyG4JYONkdsiJs8WJxSkF
	gckFhCrMTGMDV47i4q+rn0cI/HxIvwovYVxf4Mg6S3CbhX7s4W7gGKeCLVTJ5ul6CwQ+ugPF7U5
	e5R1jSy9dMpFeU0t3fJHf9z7zOL6ErMQFJkcbyc8befd9dym3U1WWx4WfDYwrOJIxRTUf309CZi
	pW4Eu8tGgotBxLa/BV0oN4fzDs6RTnN3Iiay7e+OGRfOBvSAMtTKI6XmK78FlW4P+VP0wzOE9/k
	KKSbAbHMwsUbSCrsCbw==
X-Received: by 2002:a17:906:fe03:b0:b97:c719:14d4 with SMTP id
 a640c23a62f3a-bbffb747b39mr554777966b.29.1777901397942; Mon, 04 May 2026
 06:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
 <20260504084900.22380-2-crescentcy.hsieh@moxa.com> <CAHp75VfFMLnLDP0V3U=4zG4Ayj71-ZgVkJsVtgNE=52tGQ963w@mail.gmail.com>
In-Reply-To: <CAHp75VfFMLnLDP0V3U=4zG4Ayj71-ZgVkJsVtgNE=52tGQ963w@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 May 2026 16:29:21 +0300
X-Gm-Features: AVHnY4IcJoiCmmPpXxaJzS_aZ6LdeYFWnac1hicsCOltXK3gqWALm-k8sZlGa9o
Message-ID: <CAHp75Vet5nj-njOyrDoYvBVRbCu0nn0ZW_H8DpzDFz0xq17s+w@mail.gmail.com>
Subject: Re: [PATCH 01/15] serial: 8250: split Moxa PCIe serial board support
 out of 8250_pci
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, fangpingfp.cheng@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 4:27=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, May 4, 2026 at 11:49=E2=80=AFAM Crescent Hsieh
> <crescentcy.hsieh@moxa.com> wrote:

...

> > +static void mxpcie8250_remove(struct pci_dev *pdev)
> > +{
> > +       struct mxpcie8250 *priv =3D dev_get_drvdata(&pdev->dev);
>
> platform_get_drvdata() IIRC

Note, for the sake of consistency the probe may use platform_set_drvdata().

> > +       unsigned int i;
> > +
> > +       for (i =3D 0; i < priv->num_ports; i++)
>
> As per above.
>
> > +               serial8250_unregister_port(priv->line[i]);
> > +}

--=20
With Best Regards,
Andy Shevchenko

Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB93D47D7
	for <linux-serial@vger.kernel.org>; Mon,  4 May 2026 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901304; cv=pass; b=fvgi7zPATzZRgv/bZ22UwX3a7ncWJvpfL8sXkwdTWYCYjwDZownKGWljDLEz05Jik4BnOn4XvFSAotikpDja+ndj+ZlhvP89TVFtfB5trNJfkWH30Mm3nnheXIggF8GMKDZxu/ttym1gjvIB+g9PMXM0Afn9VDkp5V2KViJthe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901304; c=relaxed/simple;
	bh=sVzmZz/+7Ldd3zpWkB/H/nMqrCafe257oGBDv5rBhVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=havG8YmhFShPDIyDn5P0TclFaNR9W40u4sAFIXoqeWwam+9ds8UO2qGAj2oxhi4Nm+U2EJsg24btrPkCnhB3zdSVhCbCRZU+y6tKp2sXoQ6EY1x9tUi1OZxv+2K55UCAOrJm6UwswC6lws82qIwY6QjwpodHKNQv9zUWG6qkdwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsKxI7Ru; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsKxI7Ru"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bc1f0f48351so152676466b.1
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 06:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777901301; cv=none;
        d=google.com; s=arc-20240605;
        b=ESus79pWB8OdUj8SFzWFO7gJk8UlR3PSvSjr296Y2YPLkzua4vdAtaSMp9WUnz27xd
         mr1wNhXq7/IUH8bmfxp405Z19YmVMjjzA1XBQrrL0zT0+ysGMluSIUiT2+taTrYXTh0e
         28sLP9wyTstRmEPUH4utBwx8Z//CsLBVaicYjek5lJqc92/ayMmWSXSgax4ndhXJssS1
         zcipiet4byzLVj+Q5hWWxytT2wa7xIAHg4BjOtnhsTOY1TtcUeFFPDSHkKb46ZEhVQKD
         qdN+OWIlaq1doDMy3nojXE0VwaTSSvDOxSFKh3I9yu+1YYLX7Pm8lp70SgCOm3muC5zZ
         l5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VR7H7r7EYLgkWgonDcpWGeJwc05JKTDH2wVjsnhrOrw=;
        fh=f5j44Gc1H43nNkf2rDAUPCAA4i7x3zBeGN3UJfDzO1g=;
        b=JPJtqLFLp7jgqY76lBUPOQ6oio37K3RdDcuigPqmwgsTNakjdv7iJfjXo+8Qf4Zq0y
         9EyBdBaCFEB3zhl5+aOGLunAIbiQyJs5qyVmPak5bf7X+8Twaq0NdEXaDEairUECJDNX
         J3s8Xty9nFFlv7bjthgAA/LQ48bP7iBecieGEbgX5mgH6RajWJt5zFJ1KFn9iOlrjEMv
         FIRmdCjBPJcdXwqZ0N7oWIV5Gf2pAF71Iv/PAeDzWe27q91hjEANoXfWOet2HH6uI/Ur
         U4FooVSnfsmccUx6P7S3Ox6f1M8uzV9ZN3fPBXfDKf3mYruCCzQZ45J+pQCEXBejiuOf
         m4lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777901301; x=1778506101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VR7H7r7EYLgkWgonDcpWGeJwc05JKTDH2wVjsnhrOrw=;
        b=XsKxI7RutAXE7JFUoVhi9GBNhXduXni5J3rUI7pQsrqqfZEeVKLzsT85DXfmSBpzt0
         U+X+KKGaK/zXfmZGOkiBd+vLV7FjaJvPhXIPqFrFsQ3wbGdr/qCMq0BKu2O9NpZuT5Q3
         YNFMH99agsXW8wUXic74jJtAmve8fbRx66LW6ifa7RpqXlcM1kagc52nQY+30s178XXN
         i8Tiu7zipJn6N37Pn+i9vhG1Y+ep4EIednh/0gDj8V/CpZXlDNC98cnjNQEERHMZXs9F
         F672nzp0xwu+D5vZlxXLjHP7gypAjX80rdq6UDLDpf0BsK1OhdrEX17dNns0kknQZ7Hy
         wZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777901301; x=1778506101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VR7H7r7EYLgkWgonDcpWGeJwc05JKTDH2wVjsnhrOrw=;
        b=D3igGsbNZ5VeDmLfNBONUlt2WXsVk5asJBjbz/BAHShISblyDQ4g02plvTSGMVq9PM
         TU2afxnmYyGLcn1NB6GW3s0FhG1JYrzY3QXt3l5XT2gS5JaoB6WPmogYPOtsgPAHG6fT
         ZwXLEYczL8HYZTEVwrbBNFDsVxwwhJKhTV3rsk/MX8FTYaHxlIHAP4Ofi5qQ6H1FojCo
         RW/xdbDhd4vEr/58ZEtJQ/Z9tzZwMDR6/TMH8kwORKtCnYHrv+7u4lbiriNsH5oX2b53
         6SnopuO6ApXwnD33//TN+EtvI+UeYYumV2YJ1HdfhR3FQYt5yYjJFJQknG+YqmGwFjhl
         kC/g==
X-Forwarded-Encrypted: i=1; AFNElJ+2RIfqyugqASyP6KHjivy4kTK9z6Eq/fxpAvHtAiRuiqQDr3rqNYSFMcint5QzD1gbK32l1Sy8dcNAAMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhzZPVdZmKcImpcpOU5wHxbBqxM9RVI6Qn3ENLtx+8LjVAB8g
	MjKshP4WgDZivb02CCJudqiM1kxLLfc+oTttctoZaU9Ya93NfAUyopapq5FoyLxgtWjRDcqp+8f
	MBUy0J4jwclBBtMA06gJNZRDIUACx63g=
X-Gm-Gg: AeBDieundkrxRwxNrB5jPqquaqbrA3zbCHdYGuq13BGPQgay9n2ioI7dkT/iUeuHsj0
	bCfDy7WYmo57smVjxocJmGV5mAfPW3AkGgBdDjVhhXl798R0apsthnj3mp6cqHXw0KWrmeAs0FE
	WfFch1eLZbTYqht/Fx9GplHM70JVFa95VtxSdarp3nSsrLh8c5djnnitKaDgal7eCRKucL1dq4/
	Uo3FPYH/v5+XPmSHeSf2ptML6srUOSnneL9/LsTMMgOCOFVgoCUfC7SXXCfXkr5bGJw2PbXHXO7
	xHsLFDy1gbUL/q3lawsPgJ0Owm3+nzS5L/TmjXhPRhTF/AcQTsAmPP1pddOGdv+ez0j4HabU89H
	kmWlMzflpirXfHUjSFw==
X-Received: by 2002:a17:907:2dab:b0:bc2:1f0e:3fab with SMTP id
 a640c23a62f3a-bc21f0e404bmr245057766b.24.1777901300560; Mon, 04 May 2026
 06:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com> <20260504084900.22380-2-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260504084900.22380-2-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 May 2026 16:27:44 +0300
X-Gm-Features: AVHnY4IJI3cuVqph-3_OkW7f_f5xr8_0lUEYFxYhwLc1CBQvZs7X3XBEMsBoTc0
Message-ID: <CAHp75VfFMLnLDP0V3U=4zG4Ayj71-ZgVkJsVtgNE=52tGQ963w@mail.gmail.com>
Subject: Re: [PATCH 01/15] serial: 8250: split Moxa PCIe serial board support
 out of 8250_pci
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, fangpingfp.cheng@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 11:49=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The Moxa PCIe multiport serial boards are currently handled as part of
> 8250_pci.c. In preparation for adding Moxa-specific UART features and
> optimizations, move the Moxa PCIe implementation into a dedicated
> driver.
>
> This introduces drivers/tty/serial/8250/8250_mxpcie.c and wires it up
> via Kconfig and Makefile, while preserving the existing probe flow and
> device IDs.

Thanks for doing this!

> This change was suggested during earlier review by Andy Shevchenko.

an earlier

Perhaps you wanted to add a link references here, something like this

  This change was suggested during earlier reviews by Andy Shevchenko [1][2=
].

> No functional change intended.

> Link: https://lore.kernel.org/all/ZmQovC6TbDpTb3c8@surfacebook.localdomai=
n/
> Link: https://lore.kernel.org/all/CAHp75VeDsVt0GQYUFxLM+obfmqXBPa3hM3YMsF=
bc26uzWZG-SQ@mail.gmail.com/

...and hence

  Link: https://lore.kernel.org/all/ZmQovC6TbDpTb3c8@surfacebook.localdomai=
n/
[1]
  Link: https://lore.kernel.org/all/CAHp75VeDsVt0GQYUFxLM+obfmqXBPa3hM3YMsF=
bc26uzWZG-SQ@mail.gmail.com/
[2]

(note [*] references)

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>

...

> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/types.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>

Keep above sorted alphabetically, it makes it easier to read and
follow and see if anything is missing or a leftover.

+ blank line (i.o.w. keep the below headers in a separate group as
this driver is 8250 driver)

> +#include <linux/serial_8250.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>

Only the first one is needed.

> +#include <linux/8250_pci.h>

...

> +static unsigned int mxpcie8250_get_supp_rs(unsigned short device)
> +{
> +       switch (device & MOXA_DEV_ID_IFACE_MASK) {
> +       case 0x0000:
> +       case 0x0600:
> +               return MOXA_SUPP_RS232;
> +       case 0x0100:
> +               return MOXA_SUPP_RS232 | MOXA_SUPP_RS422 | MOXA_SUPP_RS48=
5;
> +       case 0x0300:
> +               return MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
> +       }

> +
> +       return 0;

Simply make it a default case.

> +}
> +
> +static unsigned short mxpcie8250_get_nports(unsigned short device)
> +{
> +       switch (device) {
> +       case PCI_DEVICE_ID_MOXA_CP116E_A_A:
> +       case PCI_DEVICE_ID_MOXA_CP116E_A_B:
> +               return 8;
> +       }
> +
> +       return FIELD_GET(MOXA_DEV_ID_NPORTS_MASK, device);

Ditto.

> +}
> +
> +static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
> +                                    unsigned int port_idx,
> +                                    u8 mode)
> +{
> +       void __iomem *uir_addr =3D priv->bar2_base + MOXA_UIR_OFFSET + po=
rt_idx / 2;
> +       u8 cval;
> +
> +       cval =3D ioread8(uir_addr);
> +
> +       if (port_idx & 1)

% 2

With them (/2, %2) going closer to each other some compilers gain a
few bytes, see this for example
9b3cd5c7099f ("regmap: place foo / 8 and foo % 8 closer to each other").

> +               cval =3D FIELD_MODIFY(MOXA_ODD_RS_MASK, &cval, mode);
> +       else
> +               cval =3D FIELD_MODIFY(MOXA_EVEN_RS_MASK, &cval, mode);
> +
> +       iowrite8(cval, uir_addr);
> +}

...

> +       priv =3D devm_kzalloc(dev, struct_size(priv, line, num_ports), GF=
P_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->supp_rs =3D mxpcie8250_get_supp_rs(device);
> +       priv->num_ports =3D num_ports;

Swap these two lines (by the order) and add __counted_by() to the data
structure.

...

> +       for (i =3D 0; i < num_ports; i++) {

Seems i is not used outside the loop, hence just

       for (int i =3D 0; i < num_ports; i++) {

> +       }

...

> +static void mxpcie8250_remove(struct pci_dev *pdev)
> +{
> +       struct mxpcie8250 *priv =3D dev_get_drvdata(&pdev->dev);

platform_get_drvdata() IIRC

> +       unsigned int i;
> +
> +       for (i =3D 0; i < priv->num_ports; i++)

As per above.

> +               serial8250_unregister_port(priv->line[i]);
> +}

--=20
With Best Regards,
Andy Shevchenko

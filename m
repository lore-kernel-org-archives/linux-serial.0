Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F84328F5
	for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764530579; cv=none; b=jIFXsrWdisj/4VUw/wVOY5US9NO+6R9YHzoeNVngRHVHB6CMPHmbDVaGx/bN32N+bm9Qr8Gz1hnriXGcqU5iJjrgXYuw12zxYR+vqyJ1HVmzTamp9ezRhcd6SZ/hsGI6qeGRKybj/iPsnYhBlvejiXiedwes7C68FzVt4Xntje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764530579; c=relaxed/simple;
	bh=+G7WdCoLRj1ZHOpw3TmcEDfSpO1ZqTAtcR7R2BKuLa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3553pGa15uPDMTna2V06iVtOvX91gsTTVX2U682XfVWiAWyaoSU0qTyJnthugCzD+OOzEfhw764fKaC/TehucoUfQoluyehWIIJS7fySCjSWHEF4ac4MZRH5ES8w2XzwWybewNNXODNLCVCYfFIjnj+RBUmbCkUbut+BFKj/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsHqPlri; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsHqPlri"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so5492072a12.3
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 11:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764530576; x=1765135376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B8cFqIlvm+0ovtUhu09occdqnCYJN1LsIzBc2ngE6o=;
        b=nsHqPlriqy7QMCGTtjU7tLgjyH21lXaUCrR9razDPp7bMA1x+hqpzUz3VyvR3zu3bd
         x0Wdo1kutcsJ/QNJF9CVDBM976lW5vK7ogtIszShMx06SE0WsnypcD2OSZu5KngcsGGw
         lRhLYB0s+l7mGVdZDPnMm+7wY4KtYFipFjRFKWwdQnnFQwvVVW+NrhnvCem6ZstOuiGi
         PotSpBdpdGwbwJ+u/CYTWyxhPLUqZ0RUTzY6TzGnDS516PngNVCmGv3zu5Bj9c0cQulp
         gw33VFKZi+DR5NVJHiVVoGCCvxyOaGCUSpgP2n6HyFAq3ko0PwUWyl6Y3Ym0P1klPTti
         UNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764530576; x=1765135376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9B8cFqIlvm+0ovtUhu09occdqnCYJN1LsIzBc2ngE6o=;
        b=f6DTM/9xHnkFHA892pqlaaCFjdtOpXUEhzMtJo/1DyNYGGayH8RMZaaz480WyyDbzR
         Ce/jLm8/1X2sXoKnGthrK7UQw0ylxlcS/+UPPpkKsBQN/Tf3I/Vdnl91+RUbMBtGGyOC
         Z/b6GqzW+O2XDExGftuQLHGWbbf61PrrRfjwuwtqbl2Jbsrc55FW8Fop+VnRFw2iWKV/
         km7cRVQObhJ1AGsqd054AwHhDWP+GPjnYv/JMRZa+0UXQ8+9i+0v0XhzfNRjrYaxEZod
         ASOiDeboCvzzpmBdh/h7J/EIGY6we6tTCSQkAfr76+mtI7G6PoeZdEN5HtiEV7OpuQsH
         Pscg==
X-Forwarded-Encrypted: i=1; AJvYcCUX9g+iLrd67TkNMGYJsuWV7qxzI7C8q7nz9xVtOro8rotljAsqvei0sATtrmKk9owOTDz4Fo/kjkwQyhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJ18rdG3MjajcaM6wCSDr2a0/16pwHDaEMCtz+qW+eSoeKCpN
	TeR4nOdNXgQ6GvuvdN83rw0UQ4j4ZGxv5sVa7nPhlU+uYEVaJBMnfzT/aB5TL1MGl6MnWLLda5p
	D9nIIAg2xCggdkm7k33n6480QXc0trIg132lkusw=
X-Gm-Gg: ASbGncswLvlrIfVymRe+3uCyQLLwoouftoyDlvyWNkcH6mUXyBEO3lWhY126Rf6zBJ0
	KoEY0OmJQsJ7xO0WR5GpSHuksStL//xeBrK/QSlz0eaqFimNTM7s2NCbWu2+9BrMo0KEfFSKFau
	bZTUup7QSt1jjMqg3TRu6Z2PLpyWYvAYRCQugB50VSS/CsPnVGJ+2bkGMlBSaN19l1Bdb0HEPGs
	mP0pMf577TYSNnFTQuFswnYAkas6GWM47g51zerZNoIHt3J1lbPT02lu0+4EhRO09ruNfcxiPmb
	gz31gLg334Kej0Q88VIoXHR0SNbvCh9R6Uur4xZnWSy4hmpGI7NVVflc3boguV0vS9MhWELBdXD
	QO3wQCLtHBkXSyjQoQw==
X-Google-Smtp-Source: AGHT+IFUBBM1yhy5S5Wb3V+ushXqAMnZvQqPPRKj3NbS1IP0B7YAe6XRlDWo4EfFVIgawtyPCk0l0gug26mL1HbZv0s=
X-Received: by 2002:a17:906:ca04:b0:b76:ece0:368e with SMTP id
 a640c23a62f3a-b76ece03705mr1383452266b.47.1764530576163; Sun, 30 Nov 2025
 11:22:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-10-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-10-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 21:22:20 +0200
X-Gm-Features: AWmQ_blvhUQLWGzrhEfET1jItFFrPQXTFWq7_bZTt-m41ZpItv1hC7ufwCXKBSQ
Message-ID: <CAHp75VeDsVt0GQYUFxLM+obfmqXBPa3hM3YMsFbc26uzWZG-SQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/31] serial: 8250: split 8250_mxpcie from 8250_pci
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:44=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:

Thanks for the patch, my comments below.

> To avoid polluting 8250_pci, as suggested by Andy Shevchenko,

Suggested-by: tag?

> this patch
> separates 8250_mxpcie into its own module.

Imperative voice.

> - https://lore.kernel.org/all/ZmQovC6TbDpTb3c8@surfacebook.localdomain/

This can be made

Link: ... [1]

and referred to in the text as [1].

...

> + * 8250_mxpcie.c - Moxa PCIe multiport serial device driver

No filenames in the file, it makes it desynchronised in case of rename
as people often to forgot to update this.

...

> +#include <linux/module.h>
> +#include <linux/pci.h>

This needs more headers to be included

bitfield.h
bits.h
dev_printk.h
device/devres.h
ioport.h
types.h

...

> +static unsigned int mxpcie8250_get_supp_rs(unsigned short device)
> +{
> +       switch (device & 0x0F00) {

GENMASK() ?

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
> +}

...

> +       return FIELD_GET(0x00F0, device);

Define 0x00F0 with help of GENMASK() and use it here.

...

> +static int mxpcie8250_set_interface(struct mxpcie8250 *priv,
> +                                   unsigned int port_idx,
> +                                   u8 mode)
> +{
> +       resource_size_t iobar_addr =3D pci_resource_start(priv->pdev, 2);
> +       resource_size_t UIR_addr =3D iobar_addr + MOXA_UIR_OFFSET + port_=
idx / 2;
> +       u8 cval;

> +       cval =3D inb(UIR_addr);

I think it's in the original code, but can we switch to
ioreadXX()/iowriteXX() at some point?

> +       if (port_idx % 2) {
> +               cval &=3D ~MOXA_ODD_RS_MASK;
> +               cval |=3D FIELD_PREP(MOXA_ODD_RS_MASK, mode);

FIELD_MODIFY()

> +       } else {
> +               cval &=3D ~MOXA_EVEN_RS_MASK;
> +               cval |=3D FIELD_PREP(MOXA_EVEN_RS_MASK, mode);

Ditto.

> +       }
> +       outb(cval, UIR_addr);
> +
> +       return 0;
> +}

...

> +static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_devic=
e_id *id)
> +{
> +       struct uart_8250_port up;

Can be just =3D {} and no memset() below is needed.

> +       struct mxpcie8250 *priv;
> +       unsigned int i, num_ports;
> +       int ret;
> +
> +       ret =3D pcim_enable_device(pdev);

> +       pci_save_state(pdev);

Why here?

> +

If there is no need in the above, this blank line should be removed.

> +       if (ret)
> +               return ret;
> +
> +       num_ports =3D mxpcie8250_get_nports(pdev->device);
> +
> +       priv =3D devm_kzalloc(&pdev->dev, struct_size(priv, line, num_por=
ts), GFP_KERNEL);

With

  struct device *dev =3D &pdev->dev;

the probe code will look neater.

> +

stray blank line addition.

> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->supp_rs =3D mxpcie8250_get_supp_rs(pdev->device);
> +       priv->num_ports =3D num_ports;
> +
> +       mxpcie8250_init(pdev);
> +       priv->pdev =3D pdev;
> +
> +       memset(&up, 0, sizeof(up));
> +
> +       up.port.dev =3D &pdev->dev;
> +       up.port.irq =3D pdev->irq;
> +       up.port.uartclk =3D MOXA_PUART_BASE_BAUD * 16;
> +       up.port.flags =3D UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_I=
RQ;
> +
> +       for (i =3D 0; i < num_ports; i++) {
> +               if (mxpcie8250_setup(pdev, priv, &up, i))
> +                       break;
> +
> +               dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq %d, ty=
pe %d\n",
> +                       up.port.iobase, up.port.irq, up.port.iotype);
> +
> +               priv->line[i] =3D serial8250_register_8250_port(&up);

> +

Stray blank line addition.

> +               if (priv->line[i] < 0) {
> +                       dev_err(&pdev->dev,
> +                               "Couldn't register serial port %lx, irq %=
d, type %d, error %d\n",
> +                               up.port.iobase, up.port.irq,
> +                               up.port.iotype, priv->line[i]);
> +                       break;
> +               }
> +       }
> +       pci_set_drvdata(pdev, priv);
> +
> +       return 0;
> +}

...

> +static const struct pci_device_id mxpcie8250_pci_ids[] =3D {
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102E)          },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102EL)         },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102N)          },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A)       },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104N)          },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP112N)          },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114EL)         },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114N)          },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A)      },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B)      },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A)       },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I)      },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL)         },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132N)          },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A)       },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134N)          },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138E_A)        },
> +       { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A)       },

Too many spaces (or are they tabs?) before each of }:s.

> +       { }
> +};

...

> +static struct pci_driver mxpcie8250_pci_driver =3D {
> +       .name           =3D "8250_mxpcie",
> +       .id_table       =3D mxpcie8250_pci_ids,
> +       .probe          =3D mxpcie8250_probe,
> +       .remove         =3D mxpcie8250_remove,
> +};

> +

This blank line...

> +module_pci_driver(mxpcie8250_pci_driver);

...should be here.

> +MODULE_AUTHOR("Moxa Inc.");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Moxa PCIe Multiport Serial Device Driver");

> +MODULE_DEVICE_TABLE(pci, mxpcie8250_pci_ids);

Move this to be closer to the ID table initialisation.

> +MODULE_IMPORT_NS("SERIAL_8250_PCI");

...

Shouldn't MOXA devices be blacklisted in PCI to avoid enumeration by PCI cl=
ass?

--=20
With Best Regards,
Andy Shevchenko

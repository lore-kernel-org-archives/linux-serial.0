Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AAC21348
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 02:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556891; cv=none; b=D0qqAC54b13t3501xqKuUJHuFh4QARg9MlNgJz2XK/61AEsO75f0SytaEf50n9nfkd/Se8282JDCy8VBowhqcDlsOgrvcGbtDxZPpK5LPFfWHtN/Sv/WFnIijnPjFYy+PqcO7r7B5dmXn2MmzdL17MjLTjWvOOq0u5gjOuEUYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556891; c=relaxed/simple;
	bh=IaZxaBd9xm0YkfZ0JD4vMFIOGtLL+6Si1RrWmqw1zsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jdp8qLXUDUWtIjSfOGPFF3uNv6NHZk+GrLrrUPKaKt02yGZeU62BZsS3PpQIOKpT+ug0JcYLrph51z/yz/HGQPO+JPbQHiHgbK1OWMPDOcEMS18PXL7LgCJEUZuVzb6WU4jjFRGk069TJV6Xbc0aX22TZfbPtwEVbADW0E+UlIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMOli9NU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMOli9NU"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735b89501fso456511366b.0
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 18:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764556888; x=1765161688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vReJxDJ4Yns8Db7QVxlNqx1G29fk71NNpjY9xqZy4Kg=;
        b=TMOli9NU7BcPrMdT0CTzonIAxe+qTcpjUaEITKeaStAs2ZG2gOTrPu3AeZgjlyw9je
         83kzJh4/Jt+dPw5I5AthY98hbQ9Zc4vcZqE6z2FFeC/jN9LdA30w8/P+wAw6hlBvq6yB
         p3a1ayYAPU8/+VHUyp/R1zc4UlslFOdv4RlaktEi++G5Hi2i9MP5z0UXFb/HGr6sPZVl
         vhNLHxsXRn+3zqQ1iNR9uhSCn0DQsfoCpY3QrAFXL5gXzH+FIHXlA2ilgit4UUwyKwzk
         c908zJ/7ZxrZ8BXAWqqyNxttw+nExymV5/euLTq2HPYWdkv5vpJMXKqF53jKKpbWvuG6
         /1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764556888; x=1765161688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vReJxDJ4Yns8Db7QVxlNqx1G29fk71NNpjY9xqZy4Kg=;
        b=DDMQlTVwXwVTbI1vqnaSAz2u4DrOspVAofaEp9iFaBrDKRoy5C5WqKjU3fn3GTzhN+
         v1WCqOU5Rgd4Ne/Bc+DGGiC8dzUmg8EOlvCmmdoPD9ZSOe7nwvAKFTeCqwgJmH2ms3sK
         c0cqWvwGUCa7BOKxPb8o3HUXHRLfmaCLZY6njOxprOKb5eRruD+2j8tmd2P7yiA5WLuz
         ZP0R5qZj7QO5+EuAx9xcrtKhAQF8DSIbWEVPVuvfr9KwuG1f+beAppjiec7brg2On+lc
         uUcwW/IzSrd8mFViAoIA6Urf0yiFTv70HI8FE/pmXO3QOkg+zOSNDfGEViogWLjGTGgd
         AruQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCgwmRItD6KwCAHEguCtdsqkDIP/XsE2jZ1K8BHJKzEFiNnjoooBDlzgOasT4amDpEWReZH3BtY5vquw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoEDPSLAc1+IM+YMx+Zs4YQB1uPKWnShT2usH5Zjl6H5FO2A8F
	ayYrUjudSDAPv7u3NLhiCY4ZuQdM/o5F894X4TH53SZgI+xI23HBR1emclWdg4ahcgP4Ldl+aUH
	bKb+k258HvgLd90N2lNRJHoF1Jlo5OKs=
X-Gm-Gg: ASbGnct7O33rKTfW1dMCgRiqwPSmHjCs1eMoOKI2uuGDWVWYidefouKFgmVOvvnHleS
	LBctHvDKHBF2mh9a0fyot82UJGKHkH2/L5AM5roPZPcy6mgyiE+2dyHoh6RnfAyfMncRM1jxANV
	NoIG9EtMTzfzK9e5tF9PxheLX1vaz8Lz10oRFw+vXH6VR51wiDaiHJz7d/drNd+vj3BHN/2fKQj
	U532jZlhyJEx3uj+Q/MUEKY5HNe7WwmQHZjb1V1Pe8B+2eyqtOIdymEQhwYR2i1Cu9P9XTdh3tj
	Mmyf5zhOvXeNdL4eSRD/5OaALL4w0dvCJjdEx++HgmD+3wo6XHY7s3wybQYlRFOcTpsD+Uw=
X-Google-Smtp-Source: AGHT+IF+yegqEGonXKyDvNcjn5pnjbZajSrVeuguDE7V7hbekUNvm95pkHFqzzVriOPz6Y88nxtHyIwK00PbleJtJZw=
X-Received: by 2002:a17:907:c10:b0:b72:b433:1bb2 with SMTP id
 a640c23a62f3a-b76c5355806mr2724557566b.7.1764556887698; Sun, 30 Nov 2025
 18:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-30-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-30-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 04:40:51 +0200
X-Gm-Features: AWmQ_bkpH9DnawhyuDMaeBlGzZmxaDkU-2vjzklKv_lCi1_qOMlFvwLIPlyoI_M
Message-ID: <CAHp75VfAfd7Ubhh1YxYH2fYJMv3wXUvUzrJSC1=V6HQ-wczYJg@mail.gmail.com>
Subject: Re: [PATCH v1 29/31] serial: 8250_mxpcie: Add sysfs to control terminator
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:46=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Some Moxa PCIe serial board variants support software-controlled
> termination resistors on each port. Users currently have no standardized
> interface to enable or disable terminator state from userspace.
>
> This patch introduces the following:
>
> - EXPORT a new sysfs attribute `/sys/class/tty/*/mxpcie8250_terminator`
>   to allow users to read or set the terminator state (enabled/disabled).
> - Implement both CPLD-based and GPIO-based paths depending on board model=
.
> - Track runtime terminator state in `struct mxpcie8250_port`.
> - Serialize CPLD modifications using a new `board_lock` spinlock.
>
> Example usage:
>
>     # Enable terminator on ttyS*
>     echo 1 > /sys/class/tty/ttyS*/mxpcie8250_terminator
>
>     # Check current state
>     cat /sys/class/tty/ttyS*/mxpcie8250_terminator
>     enabled

This introduces an ABI without documentation update. It's no go.

...

> +#define MOXA_CPLD_STATE_MASK           0x0F
>
>  #define MOXA_CPLD_DATA_MASK    0x1F    /* Pin0 ~ Pin4 */
>  #define MOXA_CPLD_CTRL_MASK    0xE0    /* Pin5 ~ Pin7 */

Use GENMASK() for the above.

...

>  struct mxpcie8250_port {

Run `pahole`.

>         int line;
>         int interface;
> +       int terminator;
>         unsigned long event_flags;
>         u8 rx_trig_level;
>         struct uart_port *uport;

>  struct mxpcie8250 {

>         struct pci_dev *pdev;
>         unsigned int supp_rs;
>         unsigned int num_ports;
> +       spinlock_t board_lock;
>         struct mxpcie8250_port port[];
>  };

...

> +/**
> + * mxpcie8250_cpld_get_terminator() - Get the terminator state of the sp=
ecified port
> + * @iobar_addr:        The base address of the GPIO I/O region
> + * @port_idx:  The port index (0 to 7)
> + *
> + * Reads the terminator from the CPLD by accessing the appropriate GET_S=
TATE
> + * register for the specified port using GPIO-based communication.
> + *
> + * Returns:
> + *     MOXA_TERMINATOR_ENABLE  if terminator is enabled,
> + *     MOXA_TERMINATOR_DISABLE if terminator is disabled.

Have you rendered this with the kernel-doc script? I believe you want
a list, so you need something like

 * * List item 1
 * * List item 2

> + */

...

> +static void mxpcie8250_do_set_terminator(struct pci_dev *pdev,
> +                                        unsigned int port_idx,
> +                                        u8 state)
> +{
> +       struct mxpcie8250 *priv =3D pci_get_drvdata(pdev);
> +       resource_size_t iobar_addr =3D pci_resource_start(pdev, 2);
> +       u8 cval;
> +
> +       cval =3D inb(iobar_addr + MOXA_GPIO_INPUT);
> +
> +       switch (pdev->device) {
> +       case PCI_DEVICE_ID_MOXA_CP132EL:
> +               cval &=3D ~(1 << (port_idx + 2));

BIT()

> +               cval |=3D (state << (port_idx + 2));

state can be more than one bit set, is it a problem?

> +               break;
> +       case PCI_DEVICE_ID_MOXA_CP114EL:
> +       case PCI_DEVICE_ID_MOXA_CP118EL_A:
> +               cval &=3D ~(1 << port_idx);
> +               cval |=3D (state << port_idx);

Same questions as above.

> +               break;
> +       default:
> +               return;
> +       }
> +       outb(0xff, iobar_addr + MOXA_GPIO_DIRECTION);
> +       outb(cval, iobar_addr + MOXA_GPIO_OUTPUT);
> +
> +       priv->port[port_idx].terminator =3D state;
> +}

...

> +static int mxpcie8250_set_terminator(struct uart_port *port,
> +                                    u8 state)
> +{
> +       struct pci_dev *pdev =3D to_pci_dev(port->dev);
> +       struct mxpcie8250 *priv =3D pci_get_drvdata(pdev);

> +       resource_size_t iobar_addr =3D pci_resource_start(pdev, 2);

Why can't you use what is stored in the "port"? IIRC there are 3
variables: 2 for MMIO (membase/mapbase) and one for IO (iobase).

> +       if (priv->port[port->port_id].interface =3D=3D MOXA_UIR_RS232)
> +               return -EINVAL;
> +
> +       switch (pdev->device) {
> +       case PCI_DEVICE_ID_MOXA_CP116E_A_A:
> +       case PCI_DEVICE_ID_MOXA_CP116E_A_B:
> +       case PCI_DEVICE_ID_MOXA_CP118E_A_I:
> +       case PCI_DEVICE_ID_MOXA_CP134EL_A:
> +       case PCI_DEVICE_ID_MOXA_CP138E_A:
> +               spin_lock(&priv->board_lock);
> +               mxpcie8250_cpld_set_terminator(iobar_addr, port->port_id,=
 state);
> +               spin_unlock(&priv->board_lock);
> +               break;
> +       /* RS232 only, no need to be set */
> +       case PCI_DEVICE_ID_MOXA_CP104EL_A:
> +       case PCI_DEVICE_ID_MOXA_CP102E:
> +       case PCI_DEVICE_ID_MOXA_CP102EL:
> +       case PCI_DEVICE_ID_MOXA_CP168EL_A:
> +       /* CP100N series doesn't support SW control terminator */
> +       case PCI_DEVICE_ID_MOXA_CP102N:
> +       case PCI_DEVICE_ID_MOXA_CP132N:
> +       case PCI_DEVICE_ID_MOXA_CP112N:
> +       case PCI_DEVICE_ID_MOXA_CP104N:
> +       case PCI_DEVICE_ID_MOXA_CP134N:
> +       case PCI_DEVICE_ID_MOXA_CP114N:
> +               return -ENODEV;
> +       default:
> +               mxpcie8250_do_set_terminator(pdev, port->port_id, state);

Missing break, but see below.

> +       }

> +
> +       return 0;

Just move it to each case (group of cases) where it's needed.

> +}

...

> +static ssize_t mxpcie8250_terminator_store(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          const char *buf,
> +                                          size_t count)
> +{
> +       struct tty_port *tport =3D dev_get_drvdata(dev);
> +       struct uart_state *ustate =3D container_of(tport, struct uart_sta=
te, port);
> +       struct uart_port *port =3D ustate->uart_port;
> +       int ret;
> +       u8 state;

> +       if (!count)
> +               return -EINVAL;

Dead code?

> +       ret =3D kstrtou8(buf, 10, &state);

Why is this strictly decimal?

> +

Unneeded blank line.

> +       if (ret < 0)
> +               return ret;

> +       if (state !=3D MOXA_TERMINATOR_ENABLE && state !=3D MOXA_TERMINAT=
OR_DISABLE)
> +               return -EINVAL;
> +
> +       ret =3D mxpcie8250_set_terminator(port, state);

> +

Ditto.

> +       if (ret < 0)
> +               return ret;
> +
> +       return count;
> +}

...

> +               spin_lock(&priv->board_lock);
> +               ret =3D mxpcie8250_cpld_get_terminator(iobar_addr, port->=
port_id);
> +               spin_unlock(&priv->board_lock);

scoped_guard() from cleanup.h helps here.

...

> +       if (ret =3D=3D MOXA_TERMINATOR_ENABLE)
> +               return sysfs_emit(buf, "enabled\n");
> +
> +       return sysfs_emit(buf, "disabled\n");

str_enabled_disabled() from string_choices.h helps here.

> +}

> +

Unneeded blank line.

> +static DEVICE_ATTR_RW(mxpcie8250_terminator);

--=20
With Best Regards,
Andy Shevchenko

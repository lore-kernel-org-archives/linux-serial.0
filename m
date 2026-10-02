Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B1430CF9
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925945; cv=pass; b=tGdaJ83nVV/JOqbMyB8FtnqPlKToWzPcP8SGi9HcZrtnYkcB3CLmXwhm9OQQmp55HmUGQ78kiiUn0wwOtwj6xTy+STzm11D8Lh/Lw1+S5p6NthEjUtDMztIMW9j/TJbNLDmrkRzrm48XcDzczs8PnqyTH4f9sMtQslnLJU26qZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925945; c=relaxed/simple;
	bh=vkuQVJtffJ8fMkOsTmgLQ2DxIsx+cCdeSaJrYf8laNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSzHsMb49w5NZYY0qVW3soKL5RIepvo81MSdc8OuVzSg46GBX84MtRHmpu6haiz59ulSXZu2KqaMYwNcHMrHT/sxVLweb7cNp2CBwsmGMnM6S4DwwI9b3ukVCQwoncK9lAVFH7eTaIfUlxexkAJ3GgOc1KkOOkJ62Rze1jyBiqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omgi8R3y; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omgi8R3y"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso1896398a12.1
        for <linux-serial@vger.kernel.org>; Fri, 02 Oct 2026 00:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790925935; cv=none;
        d=google.com; s=arc-20260327;
        b=DGIMBVitO19VETsEeW4zkqAI1g+WBiJi46iEfB/nUlcQc8gsAwVFcjkTWVXsKrB3Nr
         fTtmW5+cg/Xhe/rMSVvAzyp4IV5OoH6/7zKLGgWeHDcPU90Kx1UF7mw0Jr8VKu0fGhlM
         tDrH7ZToQWc3LgIfISEUWOozALIve2PXPzTzSUsc9qNoZWfCNfxoTYWxqcusoNbW2a1a
         Kn4S/879B3TKulwefMRMneXwxzOOu8kV4/3N1ozAr7sD/0/nImoz3Pas4bVaYstJJ6an
         VBVP4q3sV+lonHB4GIg/DAFeoQHzwgysfsQbY4lsEb+s6gf5zWH/LB4bZiPg0UpD9Qp6
         0IBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x59KLtPfuG4aN7iW1gUsYPP/JvC2giQpEEdn897TLao=;
        fh=yBXTMFpvpq/6iufX8D9yKl+GmlU/n1SsxkVONCqx1ds=;
        b=HozNB4ICLOOjqFiEhbI5kQF7peiIjZZI6EP+61UFUFwSvvG3xcTXsF/Rk3gaf8VCCn
         QeFxi6b4IC22Um5bur0nadN4Ean66r/qXHgT+RxCfc2H9SAdGJioGGG/hnS4pjgvlkVJ
         3paXncAulwVeM82l7EwcO3mSoFuVMSy1XtvZ/5oOkZU6YUD6hAhxXW4zAeli+fNISwjq
         6I2Y/2Na5zyiC3hequ21fpRtB5i/FanUM3yeYal4jVCuVyL+ZbdXQEVtxZ4YoWulasia
         ohR3hALKS6DQKaaHSkyl5Xi2SluM5GfWI9gPVXDgTzGk3vv7FMjLGZinjN1rWrsRNV9d
         aBeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925935; x=1791530735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x59KLtPfuG4aN7iW1gUsYPP/JvC2giQpEEdn897TLao=;
        b=omgi8R3yfw60wW9HSxa7U3Nd3Nx3Shy49ga07pOfBmsqrEbG8IaZtNCYWsrPt7y+9e
         UGEYEdx3cGP9Jw4mwh9AN3wWWIcjmISU5j7fK5qFBs+9Nz2yNHYMHCZIJUZXFvDT2AjS
         xo6+xqllnqVKumR2zF53/G1LlubFimymku7zlBH/DVPf/CfZGZKYDaRPC3IR1fQAHj4U
         b9jCXzMQ9y9t5aJ4wSKHF+fps1mzeMcF6VchH3hoT2DGy7NXT/Rmb/Jj1zhY3+N17WM2
         drXc2cLfEMIFvEl8vEOyfTthw3S+OKuzfmPzPAvNOYj/E0DUlgzpj0KA4VL+w2hskYus
         VaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925935; x=1791530735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x59KLtPfuG4aN7iW1gUsYPP/JvC2giQpEEdn897TLao=;
        b=M9e35JlvLYzdnlOE0bVxjh06prt6zNdE5uwXri3sh0lvLeP0IWP64OZGGC8CWLzHX0
         7m/Cium0Vs0nIbgESyh6U/MiKT1QU4WRH8kYiopnZ+9x+IiHkFKubHQ726LS8kL2kK92
         D/IaWaLBjnMWzU8iTyHGyJ0WDSh6Hv1bw1fIvv84FShmGzgmoH8dn2A2sCgkxe/xu8tl
         1O5YboPoptCS2udEi/+IlGeO+sdjLrQNIoU2I+TxX5CMOKI8L0jhlrYmpJr3ylIZf7Co
         /Xc8T+YTSzMsTH0z5EyiyBx08kn8Gpv9MrrQ/AqQ/iuMepHAjM/8kdCK3MPBSdcEjUpM
         6p+g==
X-Gm-Message-State: AFq9FYImJw4hNHQHK6otARbd2Muw0vWdxTruRZRAeqeHP5PqZ2PV5+T0
	vKyVUHT4Bntt2n1zSkgW37tqambHuhZf0hpHcQduG1h21W06R1hSNupj4HUP/4IfWvPaEv+iKZM
	2+m9ydVFiYc4AeCjHxDWeSdActkZtdr0=
X-Gm-Gg: AYBFou3h0btbQHV5vRsnbJ/KibOw1SAIAmY7AUJI3H/WwkM7o51KcspGv/+DWtUynSK
	6UAtWkG1yGfRylZTjdAGRzdDZrWPo3jDiCs6HHrjrDa5aHG1Bs6PHUwNFTHL1yuYXPQiCjXdn0o
	2XWxKxojAovlfXTCnHb6XNPqq7dAJNaf+xOMqzwvnclg6tXgeJqRpIK0B/4hFv3bgtfurvezPjh
	+eFRt1r1OV0PNmyfHYydyXqIQI8TqQDh84TDGPsyBjMnkyp/RwzwiE/wHgZ8flJGSWwNQjsSXm3
	rvddXi1d0aoh3lUdz3p79T7/7Km0CsqyNs8TrJR003nLO77Dov40BwtbfwQ8J/yobVnP3nPckdq
	45mRBezTX+Fnk1ALSPJ5N5KfUkmN/5IcfZkrNPmFj7wb5Dhzjo2kXwI9eob7IFgirvWeY/P2E2r
	MfI51Q9mt/lYfdYFwnzERUikEObIS1i51k+srG5/vlaE3mku2sxmvQ5jl1HlhFJfZhZw==
X-Received: by 2002:a05:6402:5165:b0:6a9:8863:ada4 with SMTP id
 4fb4d7f45d1cf-6ae307e5667mr2995775a12.3.1790925935285; Fri, 02 Oct 2026
 00:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925183050.56839-1-rosenp@gmail.com> <2026100129-unrest-cleaver-6528@gregkh>
 <CAKxU2N8Z-CSxki5mWQvJCEiQDmy00WLJqPEMgujOA0LQzbHHjw@mail.gmail.com> <2026100211-unturned-scam-fd80@gregkh>
In-Reply-To: <2026100211-unturned-scam-fd80@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 2 Oct 2026 00:25:23 -0700
X-Gm-Features: AclHuK-DIP7WjK3JYUzQGXnqA3_qOSSMeSBRglKWf3j7RwahMAS-EdxikdQir5E
Message-ID: <CAKxU2N_Nm3rRnXEg9+-iwRSHXrvV-0rgdDQdmhn2MojTneFU7g@mail.gmail.com>
Subject: Re: [PATCH] serial: arc_uart: Use platform IRQ helper
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, 
	"open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:55=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 01, 2026 at 11:58:05AM -0700, Rosen Penev wrote:
> > On Thu, Oct 1, 2026 at 1:42=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Sep 25, 2026 at 11:30:50AM -0700, Rosen Penev wrote:
> > > > Avoid calling irq_dispose_mapping() by letting the platform_device
> > > > machinery handle it. Also enable possibility of handling -EPROBE_DE=
FER
> > > > and other errors. Handle as early as possible to avoid doing unnece=
ssary
> > > > work.
> > > >
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > ---
> > > >  drivers/tty/serial/arc_uart.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc=
_uart.c
> > > > index 3988e5958896..b46b057a181b 100644
> > > > --- a/drivers/tty/serial/arc_uart.c
> > > > +++ b/drivers/tty/serial/arc_uart.c
> > > > @@ -30,7 +30,6 @@
> > > >  #include <linux/tty_flip.h>
> > > >  #include <linux/serial_core.h>
> > > >  #include <linux/io.h>
> > > > -#include <linux/of_irq.h>
> > > >  #include <linux/of_address.h>
> > > >
> > > >  /*************************************
> > > > @@ -571,12 +570,17 @@ static int arc_serial_probe(struct platform_d=
evice *pdev)
> > > >       struct arc_uart_port *uart;
> > > >       struct uart_port *port;
> > > >       int dev_id;
> > > > +     int irq;
> > > >       u32 val;
> > > >
> > > >       /* no device tree device */
> > > >       if (!np)
> > > >               return -ENODEV;
> > > >
> > > > +     irq =3D platform_get_irq(pdev, 0);
> > > > +     if (irq < 0)
> > > > +             return irq;
> > > > +
> > > >       dev_id =3D of_alias_get_id(np, "serial");
> > > >       if (dev_id < 0)
> > > >               dev_id =3D 0;
> > > > @@ -607,7 +611,7 @@ static int arc_serial_probe(struct platform_dev=
ice *pdev)
> > > >               return PTR_ERR(port->membase);
> > > >       }
> > > >
> > > > -     port->irq =3D irq_of_parse_and_map(np, 0);
> > > > +     port->irq =3D irq;
> > > >
> > > >       port->dev =3D &pdev->dev;
> > > >       port->iotype =3D UPIO_MEM;
> > > > --
> > > > 2.55.0
> > > >
> > > >
> > >
> > > You forgot an Assisted-by: tag here :(
> > No LLM used here.
>
> Then what tool was used to find this issue?
git grep irq_of_parse_and_map

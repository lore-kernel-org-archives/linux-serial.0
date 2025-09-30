Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648321B9E2
	for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2025 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201660; cv=none; b=kTvo/C2IFqBbJ7qOY/3IAoh1xiPhTFLxqlqZ0k4vopmwauVQ7GtVYY1yJiJUj0R1e3O1ZH/eirMybbSsADkhhCmyz8Z4ldxpvOARg1MIWefqddP4foc96Hd4YQsDGZo6cjN/z6YSNwEnmZWeHuMHL89E9ERYTPdW+c0ePfG8Hfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201660; c=relaxed/simple;
	bh=trQzuaxM7PQI3lc7+SrnpL4ChZ2FG1z0MjB3OtsDT/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9Mkw2kfUF9FE+t/DGFbYLAEzhsmDs/1IlEsMI5/gVB4dFwTW6HktJoZ31vmlLVUMLHRCpGW5exRZNlGFsiPS+sVrBjEIompkdw8iLvPcMpdcLj360LnjOyzZfdoqqrLDBxNxGmbcN9TVtkOGLmYURB3SpbAZCGuscdMIHTfgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxsTdE/r; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxsTdE/r"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3ee18913c0so327259366b.3
        for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 20:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759201657; x=1759806457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cP8Qg3pgdasQQeaKIyYbB5fXWml1kh5kpaGwLIEk0T8=;
        b=SxsTdE/rkBgprIZa5UbJ2RP9y7ScCY4TE0QlYKBOyP3GtjMbb/3jETtzx5t4utvj6/
         mZ/7AJeqb4JXCvPLxJtVi+JajpadPkVu9SBk4foY0cRgh/ajxTEN+B7Um1ax+ztFfhOo
         90jgo5dSRXPGIzAv9EnTMhGl57YtEd775qe8XEbry+58DB0pMutEyQQvQSz27nYMcIrB
         pwbkbNy/QkRf893VrJY3969cdPCi/qkHZdi56a7+iQcZNJH7LVzC8Gft+AAlMDGhcCJp
         zLS+4ttweD+lLq/KvxbWWexKIkxORUVoh6x9RAykcwHXRQyilV72lzlI7cZGfLBzKC75
         7JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759201657; x=1759806457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP8Qg3pgdasQQeaKIyYbB5fXWml1kh5kpaGwLIEk0T8=;
        b=HDNNZz7U5FlcmGFU2JHAYSLF/tGBhlO2JMUsNg7XTJFJ99YpaM8TbghVtl+Z0Em4aS
         kGuWFGgprMCpi2mjBDaHeGyhQkWl3K1jW+h2/BeDrFy8Xnz/RjXj8pq3xE7B0PM/Enrj
         keQfol8V0mQhmMMiaLLfrDFcNDGHdPV/zKO7AO+4kDnB3a2efr+imX04x5pRXOEChdrO
         klykoRsBZXvISFTHZswD0m62n3vg/P9WTH9hnPZq6hiE5bqv8BcXO3Aaz4/sDv+sLCR6
         fGEGeej1RCOpWm7UXXdVY3rtzy4lC9+pB0exoQnnaS/IP5LthxgLVYluWhEZZ3BtQ2fI
         4h5g==
X-Forwarded-Encrypted: i=1; AJvYcCXrgFdp7ihXz1ko1iDRWJcNZI69WNE3g6S32XhD+YT+eT4zPd7Y7+3qU3qxiXJP1x87exUDsYHapF8+4rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQnRTXVDMZeneQoLqv/Xiq+23UV/JsnuLokAxpGoacsmbiTGp7
	IEqOXExSZ5KqXBClRWXsO3uOZUfQkRMwbeyfOWYdJM30NRGBbUYiFrx5RXvEc0ATw6Wkz2pS0eZ
	PgF7GMelR/Gtz5O7HZMuXTSDSXhyO/u0=
X-Gm-Gg: ASbGnct3hgZgzXjFzj4AD8Ylf5a0KUoUDp+0mWQJ2vel+rAQ+nuM3Z9f8EYwKQHFaz3
	6ZDiQ1mrULUWOBinYL8NBxsVtx0re+ordX7sO6mmkc65yuBnk136TkWaxDGOIlSyRPYCp/ZEoAs
	e9bO0eh/SpyQmBTvjR907W22pTY1pJKLm10IUdfemoQUA8ff1YGgBWBE4RQcbvu3guEFomaN1CY
	ibCWqcEa0tusWjUJdkFIkqe+Y5KC8td7hY1zQ+Q7tuD
X-Google-Smtp-Source: AGHT+IEN648vI6Hm5m9/RNBdn/c6BTF3t50WrblnPLPcU3GBbVZCvpdfAA56AdTbz+ybr1l29cbfpXFz2yx0RQiYjaE=
X-Received: by 2002:a17:906:c103:b0:b45:44f4:30e1 with SMTP id
 a640c23a62f3a-b4544f479e0mr28136366b.34.1759201656713; Mon, 29 Sep 2025
 20:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758676290.git.zhoubinbin@loongson.cn> <9823e7afe713450e210dab9dba6fa18683dc1fe0.1758676290.git.zhoubinbin@loongson.cn>
 <a985f144-7489-4a99-bcb7-90e7b21d9885@kernel.org>
In-Reply-To: <a985f144-7489-4a99-bcb7-90e7b21d9885@kernel.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 30 Sep 2025 11:07:24 +0800
X-Gm-Features: AS18NWDRGIX8ccYnyCzkTicMCR8HLLJvmhoh5wlIK_KmTb0hEwHglsNxtMS1qtU
Message-ID: <CAMpQs4Kpcb5n0g=cH6_RPnjvcwPQ0k0Obcc6c8j6yMxg3THp+w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] serial: 8250: Add Loongson uart driver support
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Haowei Zheng <zhenghaowei@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri:

Thanks for your review.

On Mon, Sep 29, 2025 at 2:27=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 24. 09. 25, 8:29, Binbin Zhou wrote:
> > Add the driver for on-chip UART used on Loongson family chips.
> >
> > The hardware is similar to 8250, but there are the following
> > differences:
> >   - Some chips (such as Loongson-2K2000) have added a fractional divisi=
on
> >     register to obtain the required baud rate accurately, so the
> >     {get,set}_divisor callback is overridden.
> >   - Due to hardware defects, quirk handling is required for
> >     UART_MCR/UART_MSR.
>
> So how hard would be to implement this in 8250 using existing (or new)
> callbacks+quirks?

Initially, we attempted to directly add Loongson UART support to the
existing 8250 driver. The critical section is as follows:

diff --git a/drivers/tty/serial/8250/8250_port.c
b/drivers/tty/serial/8250/8250_port.c
index aa4de6907f77..6754f496a95c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -395,14 +404,36 @@ static void hub6_serial_out(struct uart_port *p,
int offset, int value)
        outb(value, p->iobase + 1);
 }

 static unsigned int mem_serial_in(struct uart_port *p, int offset)
 {
+       unsigned int val, offset0 =3D offset;
        offset =3D offset << p->regshift;
-       return readb(p->membase + offset);
+       val =3D readb(p->membase + offset);
+       if (p->type =3D=3D PORT_LOONGSON)
+               val =3D serial_in_fixup(p, offset0, val);
+       return val;
 }

 static void mem_serial_out(struct uart_port *p, int offset, int value)
 {
+       if (p->type =3D=3D PORT_LOONGSON)
+               value =3D serial_out_fixup(p, offset, value);
        offset =3D offset << p->regshift;
        writeb(value, p->membase + offset);
 }

This made the code difficult to read, so I concluded it was not a good
solution. Therefore, I separated it into a standalone driver.

>
> > --- /dev/null
> > +++ b/drivers/tty/serial/8250/8250_loongson.c
> > @@ -0,0 +1,202 @@
> ...
> > +struct loongson_uart_data {
> > +     int line;
> > +     int mcr_invert;
> > +     int msr_invert;
>
> These two should be unsigned. They should be u8, actually.

OK....
>
> > +     struct reset_control *rst;
> > +};
> > +
> > +static unsigned int serial_fixup(struct uart_port *p, unsigned int off=
set, unsigned int val)
>
> Both 'val' and ret type should be u8.

OK... I will check twice.
>
> > +{
> > +     struct loongson_uart_data *ddata =3D p->private_data;
> > +
> > +     if (offset =3D=3D UART_MCR)
> > +             val ^=3D ddata->mcr_invert;
> > +
> > +     if (offset =3D=3D UART_MSR)
> > +             val ^=3D ddata->msr_invert;
> > +
> > +     return val;
> > +}
> > +
> > +static u32 loongson_serial_in(struct uart_port *p, unsigned int offset=
)
> > +{
> > +     unsigned int val;
>
> u8
>
> > +
> > +     val =3D readb(p->membase + (offset << p->regshift));
> > +
> > +     return serial_fixup(p, offset, val);
> > +}
>
> thanks,
> --
> js
> suse labs


--
Thanks.
Binbin

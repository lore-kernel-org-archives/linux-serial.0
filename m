Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF542A83;
	Tue, 14 Jan 2025 02:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821546; cv=none; b=c/AFNuQfdlPjr8FLKuWSrwEnjpEnvJn2PsyUWPfhH56DuDELa+4xsoArQAv4KKP2CRUdRbvSXPg/CpKLYmeB4zPv1zLGGRzjGPQlyrQHweDe3Uzd/BsjB/+lKovwuN0nJ/k2Ih3iK4N/sQq9dY7ejJTdwFGh/e90/+cIjCH4yWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821546; c=relaxed/simple;
	bh=9YIL/iwPETtS3Uc4g5zKiFIi3rMywxSN4XY/P1/T/g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5vrNpJwH8Y+Z6aShkRJRaW+O3pXIwG198LZB0/lo+3WIrt15RXtuw4OPJYadt+aH5g24Jy3K5fov3684XZi2su85wuuSYCHjc8+GXO4Srv5ram8KBpsg3jpwMIU+I+6DtYYvG0Rsi2bzNuBEqMlvssj1RhXiQfhlc2W7lauEvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBJ6F12F; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBJ6F12F"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2163bd70069so89844155ad.0;
        Mon, 13 Jan 2025 18:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736821544; x=1737426344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovYJILSVRDnDMfqXl3o1WSHf4vb82agxa/r/cx4UTlg=;
        b=ZBJ6F12FacPZDCjCKay3vj9RpQx2uBtM/P0VVw16IjO41cp0LBXOsSaqdqU8WYl3oh
         1buqUpO/uIsRV56h8u6y+eYndPtoV3OAGOlmiapUQFzRWqs1iiizodyrg9gvDB45bEse
         SBVlTxlTT5xhUoTtSI/N+QCbRH1hsKwNl3AxeNnLuU1o2M5vwpmT59v+PSZXfXLHKBU3
         5uy52dIlypoCS3ZA9bMvoSz4OC1PtSI/Q4OUUUixhDXhui0yqZnL3vErX7Y02krhYuF8
         G4w3stB4vFMLzTryclytbQVgDUBCrUSff2+AWHd3Ps32suo5H6u8G1TY5mFzRUSIYx2C
         GMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821544; x=1737426344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovYJILSVRDnDMfqXl3o1WSHf4vb82agxa/r/cx4UTlg=;
        b=Rw6P0tpLrlhsgOJlNbFKM0TRUZzICiJBF35M5KQxdMiOhVU9puCxjtMgIay59reCY4
         9pS67nWa9ZbpG61j2ObI+nglON/O+zaeqN/ozs8TLd1FPfBjlBYnq/d326rcbIAVrQ9m
         PYkCoy8Uy4OK9be2a0prZptNtC1e+Q7/Z7zwDGNYYR2xtGospA5rp2w0uY0fF1U8yuU9
         Xo00nIvdGmNyn9ectF2lJERvfBvpQ3gxgGr9iGhEQEJ1SO2QOSkGunjIUE5YyYnVVc0G
         1jvXWqDl9nw6R6XQqv13GhPpA9brUC18apM8+PB1kfd0/jtiT6VHLSldNWn4E7SELmju
         3nMg==
X-Forwarded-Encrypted: i=1; AJvYcCVcdNx/96mlMlMc2nroIBV+pGwsT2TafmzhRRYwdJTROPhZWym1pDy+fYFHOtE6UHh2rQB5v5YLnx1V@vger.kernel.org, AJvYcCXJ6U+zVKwecu2BfbYyoQpBNIrUW/NomqUhzoczKHXpRodmCIw1NDrTazk8f9+/O3feFRYmidAmNSIJCuo8@vger.kernel.org, AJvYcCXQ4dofLX2McslpNZAnoyoy76Btf1q6YAcFbO2zVua52VMCp+AAd86Uqs6swAKUkBwk82vbNyh9ry1PZfc3@vger.kernel.org
X-Gm-Message-State: AOJu0YwQMC2RUNSeF1iPNydHrrwd+FrwDLOtDnlXWqVN+duATeJdptAT
	D8Nz9ua3mxBI1Pt3NZdlC8Xj7hG8m6IGPvI7MguyBXVjww/DsPQdtuNlvoZayf/2IlPjgcY+3FU
	4LaIoe/+T+c61aEQO88OYJME4Eyw=
X-Gm-Gg: ASbGncubZhr59hnGv78gwUAfhDxkDmpBhv4/n3HB/fWNADiV2EJEXiXBUAR6mtjVZPh
	6mM0UgOXq9AHIzfcN4oNXOpD6xTLQjQ1dvh5Cn8M=
X-Google-Smtp-Source: AGHT+IGP6i//JJgpTX27oV9PRMOvdfH3t41hB8kWi16VUWsAtyGttoeJ6QkexjvS/wDs/fL4592N/MAEALXiO9jTX3Q=
X-Received: by 2002:a17:902:cec1:b0:216:3c36:69a7 with SMTP id
 d9443c01a7336-21a83ffbe22mr356266955ad.45.1736821544065; Mon, 13 Jan 2025
 18:25:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113031917.3354988-1-Wenhua.Lin@unisoc.com>
 <20250113031917.3354988-3-Wenhua.Lin@unisoc.com> <CAAfSe-uAsDfDvDbOdEqrR=0=U-bfSuDpLSw_EFv8=GNMGDEvgw@mail.gmail.com>
In-Reply-To: <CAAfSe-uAsDfDvDbOdEqrR=0=U-bfSuDpLSw_EFv8=GNMGDEvgw@mail.gmail.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Tue, 14 Jan 2025 10:25:32 +0800
X-Gm-Features: AbW1kvYznCjGzoZXOIKRBOGNeRQ6G5op6dSUTq91uCjIqFSdjCeP_U0CyB0nVMw
Message-ID: <CAB9BWhcnagYYtdq1+-r-MrEmr45gTPg1PnzAx-Q6YqaY1vNR2g@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] serial: sprd: Add support for sc9632
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 3:13=E2=80=AFPM Chunyan Zhang <zhang.lyra@gmail.com=
> wrote:
>
> On Mon, 13 Jan 2025 at 11:20, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
> >
> > Due to the platform's new project uart ip upgrade,
> > the new project's timeout interrupt needs to use bit17
> > while other projects' timeout interrupt needs to use
> > bit13, using private data to adapt and be compatible
> > with all projects.
> >
>
> It seems that this patch has got merged into the last release, why do
> you resend this?

Hi Chunyan:
  I'm sorry, I didn't realize that this commit had already been merged.
  I resubmitted PATCH V2 to fix the issue with tags[1].
  I made a mistake. Thank you for reminding me.

Thanks

>
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  drivers/tty/serial/sprd_serial.c | 41 ++++++++++++++++++++++++++++----
> >  1 file changed, 36 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index 3fc54cc02a1f..882580c3cf37 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -53,10 +53,12 @@
> >  #define SPRD_IEN_TX_EMPTY      BIT(1)
> >  #define SPRD_IEN_BREAK_DETECT  BIT(7)
> >  #define SPRD_IEN_TIMEOUT       BIT(13)
> > +#define SPRD_IEN_DATA_TIMEOUT  BIT(17)
> >
> >  /* interrupt clear register */
> >  #define SPRD_ICLR              0x0014
> >  #define SPRD_ICLR_TIMEOUT      BIT(13)
> > +#define SPRD_ICLR_DATA_TIMEOUT BIT(17)
> >
> >  /* line control register */
> >  #define SPRD_LCR               0x0018
> > @@ -102,6 +104,7 @@
> >  #define SPRD_IMSR_TX_FIFO_EMPTY        BIT(1)
> >  #define SPRD_IMSR_BREAK_DETECT BIT(7)
> >  #define SPRD_IMSR_TIMEOUT      BIT(13)
> > +#define SPRD_IMSR_DATA_TIMEOUT BIT(17)
> >  #define SPRD_DEFAULT_SOURCE_CLK        26000000
> >
> >  #define SPRD_RX_DMA_STEP       1
> > @@ -118,6 +121,12 @@ struct sprd_uart_dma {
> >         bool enable;
> >  };
> >
> > +struct sprd_uart_data {
> > +       unsigned int timeout_ien;
> > +       unsigned int timeout_iclr;
> > +       unsigned int timeout_imsr;
> > +};
> > +
> >  struct sprd_uart_port {
> >         struct uart_port port;
> >         char name[16];
> > @@ -126,6 +135,7 @@ struct sprd_uart_port {
> >         struct sprd_uart_dma rx_dma;
> >         dma_addr_t pos;
> >         unsigned char *rx_buf_tail;
> > +       const struct sprd_uart_data *pdata;
> >  };
> >
> >  static struct sprd_uart_port *sprd_port[UART_NR_MAX];
> > @@ -134,6 +144,18 @@ static int sprd_ports_num;
> >  static int sprd_start_dma_rx(struct uart_port *port);
> >  static int sprd_tx_dma_config(struct uart_port *port);
> >
> > +static const struct sprd_uart_data sc9836_data =3D {
> > +       .timeout_ien =3D SPRD_IEN_TIMEOUT,
> > +       .timeout_iclr =3D SPRD_ICLR_TIMEOUT,
> > +       .timeout_imsr =3D SPRD_IMSR_TIMEOUT,
> > +};
> > +
> > +static const struct sprd_uart_data sc9632_data =3D {
> > +       .timeout_ien =3D SPRD_IEN_DATA_TIMEOUT,
> > +       .timeout_iclr =3D SPRD_ICLR_DATA_TIMEOUT,
> > +       .timeout_imsr =3D SPRD_IMSR_DATA_TIMEOUT,
> > +};
> > +
> >  static inline unsigned int serial_in(struct uart_port *port,
> >                                      unsigned int offset)
> >  {
> > @@ -637,6 +659,8 @@ static irqreturn_t sprd_handle_irq(int irq, void *d=
ev_id)
> >  {
> >         struct uart_port *port =3D dev_id;
> >         unsigned int ims;
> > +       struct sprd_uart_port *sp =3D
> > +               container_of(port, struct sprd_uart_port, port);
> >
> >         uart_port_lock(port);
> >
> > @@ -647,14 +671,14 @@ static irqreturn_t sprd_handle_irq(int irq, void =
*dev_id)
> >                 return IRQ_NONE;
> >         }
> >
> > -       if (ims & SPRD_IMSR_TIMEOUT)
> > -               serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
> > +       if (ims & sp->pdata->timeout_imsr)
> > +               serial_out(port, SPRD_ICLR, sp->pdata->timeout_iclr);
> >
> >         if (ims & SPRD_IMSR_BREAK_DETECT)
> >                 serial_out(port, SPRD_ICLR, SPRD_IMSR_BREAK_DETECT);
> >
> >         if (ims & (SPRD_IMSR_RX_FIFO_FULL | SPRD_IMSR_BREAK_DETECT |
> > -                  SPRD_IMSR_TIMEOUT))
> > +                  sp->pdata->timeout_imsr))
> >                 sprd_rx(port);
> >
> >         if (ims & SPRD_IMSR_TX_FIFO_EMPTY)
> > @@ -729,7 +753,7 @@ static int sprd_startup(struct uart_port *port)
> >         /* enable interrupt */
> >         uart_port_lock_irqsave(port, &flags);
> >         ien =3D serial_in(port, SPRD_IEN);
> > -       ien |=3D SPRD_IEN_BREAK_DETECT | SPRD_IEN_TIMEOUT;
> > +       ien |=3D SPRD_IEN_BREAK_DETECT | sp->pdata->timeout_ien;
> >         if (!sp->rx_dma.enable)
> >                 ien |=3D SPRD_IEN_RX_FULL;
> >         serial_out(port, SPRD_IEN, ien);
> > @@ -1184,6 +1208,12 @@ static int sprd_probe(struct platform_device *pd=
ev)
> >
> >         up->mapbase =3D res->start;
> >
> > +       sport->pdata =3D of_device_get_match_data(&pdev->dev);
> > +       if (!sport->pdata) {
> > +               dev_err(&pdev->dev, "get match data failed!\n");
> > +               return -EINVAL;
> > +       }
> > +
> >         irq =3D platform_get_irq(pdev, 0);
> >         if (irq < 0)
> >                 return irq;
> > @@ -1248,7 +1278,8 @@ static int sprd_resume(struct device *dev)
> >  static SIMPLE_DEV_PM_OPS(sprd_pm_ops, sprd_suspend, sprd_resume);
> >
> >  static const struct of_device_id serial_ids[] =3D {
> > -       {.compatible =3D "sprd,sc9836-uart",},
> > +       {.compatible =3D "sprd,sc9836-uart", .data =3D &sc9836_data},
> > +       {.compatible =3D "sprd,sc9632-uart", .data =3D &sc9632_data},
> >         {}
> >  };
> >  MODULE_DEVICE_TABLE(of, serial_ids);
> > --
> > 2.34.1
> >

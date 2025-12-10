Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B530DEB5
	for <linux-serial@vger.kernel.org>; Wed, 10 Dec 2025 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765352200; cv=none; b=FCUnd3PO2PUGl94bYWmYLVGsn8QpW8n3q6+TmqxjXXywhC6glrova3glqasu3rFsmNYWIg8sKK47DViTTZLqeUykCR55Rm08/j8P29RzQxatWiqCqCQkxaa4VANl248k5cZN3TVTzuav+CHF1ekPXBIsNFGDPzRmUIzPBO1S1as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765352200; c=relaxed/simple;
	bh=Ql+05higkkk3xfE5KuwoiqXuKr8OVpUcr8CUYtFtfUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hwv+2OLbYg465hykn6Y44QXyKCBxrgZ/VAZqkWbixqW3Kzblisi6JwxgXFnE6KwXsoj5FDGRNes2wIf1HFQ3va19fpnwrA4w2aS+eracxY1kJMD5gi91nKicS0KjOOpDHlJUixFfHUq2kYefDvM8eiTgiST1luvbf24HNX/6XPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MToFudpd; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MToFudpd"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7aab7623f42so7807021b3a.2
        for <linux-serial@vger.kernel.org>; Tue, 09 Dec 2025 23:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765352198; x=1765956998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoyjYG5sEIbdYt3BmcC1cG9e1qKcfkJWvU/QxfIf9lM=;
        b=MToFudpdB7PS5Oll6qf11UIKoXW+C9Vdy4WrXKoC/JimIZQ6nfhD+g0j/VkZtuR7eu
         3c7xdWp+UNUNhH4mjDGWMrlpmXLDD1cksrRL8cQoTpAbbO73cLvSrMXwqY/3YwGl+DhQ
         xPfC5OMxeahHw7Xjg/Ok73/+38mtmEZuojBOUnB9y2r4l0W76QCB/cEiaVvgE1KjeHY3
         z3g0Af+MH1gIGzSKlt9NgCTIN1ZJNYk5F7TSSmWO0G1U9m3275Wl+PMEx3sMd0JcZh84
         hMFt+6l7SNjfu6FQgu581zl6CydgBjOYrI14C7x7X+lvHhHioYPi+j7W5gjzeVggojvD
         eNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765352198; x=1765956998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BoyjYG5sEIbdYt3BmcC1cG9e1qKcfkJWvU/QxfIf9lM=;
        b=WZ82DC9wlbBui9Gzz6q+/F5hjV4ytvCYo5WwtSoN7iIOUDcHJVWF51Xvm4UXOYWHAr
         i1WBp0BxBgr9eKaaQKttDuyx3nDMb/v9AihN+0nNo2wojXdNlsI34DUE6VeolvA1cEGm
         i5OqOZe/hbQFsFjVAXd07TuA9iYfV0ujGF4K0LtPCJsZ2a6Z+DRtF7gffwX7vo9f3tJc
         0+Cq716XPYgUzgMSamyv4SYCyCZ54QcQMTd4G55pl+SBt+vwPSVnysO8CacMTZqIyk/o
         BySLXOcq8gKaFzzoTXsVha1yxGCA7g/ECgtAPtS2cuwJ/ll/0q3cvcNovCzBUo5Fm3+T
         XTuw==
X-Forwarded-Encrypted: i=1; AJvYcCUEkcT8YOvOo/CKgwl6zhmtzaam+0/Qudfs5y61zDO78hTfxAUw+54CDdrmj5NcDpva1A73PTvji9Swngo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYZImX/nZy2f2yl9vwbjSFSV+fgQXHB0zaX4BZaJ4aHSYnfuV
	nU7ax1wYutyCMP/xfxGTdLd0VPWAGg3hQGko6fb0M64PDYgEeGC75fqPQf7IZYCdwcK65Jw0qX5
	QBU9GVusovlI12a5u4Okcy0e8yyqo6JE=
X-Gm-Gg: ASbGncuOmVH4KETTYryx77Fl1A2pBpCiA9uQ91liSbq0c0qqSyhbJ9udYYgADrmGM3/
	YCa9ou/+UIhWgS57E0l5YCOjVteLh5uE4KAPHfYCu3q/BNp5E5PSDStNmYvyvPCd4vThRER5+zu
	AH/sHAmwXBVkYDiOj2aXNLhClJrwbzhcmVADUvr5aiLktRjnbSVnOEmTvpY9WckldbvBqP6qurO
	ZJ+uxG7UxqIdQf5y+/eX4IpdD6mVbRSzdeDkj8H/xAY3aOAQh7DVz3fen2P5afndQybVW+8
X-Google-Smtp-Source: AGHT+IEnKkRkhzEdKcwtgjVFn+rWqIifDCM6yc8T7qggnMoBcUilGwnxP1eczFtN/9YnA6r95PM8dj3nrRou9WY39UE=
X-Received: by 2002:a05:6a21:33a9:b0:35b:b97f:7471 with SMTP id
 adf61e73a8af0-366e03c9f97mr1426401637.4.1765352198196; Tue, 09 Dec 2025
 23:36:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210063543.2185727-1-Wenhua.Lin@unisoc.com> <CAAfSe-vXq6Q6bzSbkWYaB656NqD64+9XdVkKdKVid6sZo3fu0Q@mail.gmail.com>
In-Reply-To: <CAAfSe-vXq6Q6bzSbkWYaB656NqD64+9XdVkKdKVid6sZo3fu0Q@mail.gmail.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Wed, 10 Dec 2025 15:36:26 +0800
X-Gm-Features: AQt7F2qrUDxDGQybSaqy5gBV2WDN8ObGUklhpM5OpVt95T6cQgNWOLx_yMKVC6s
Message-ID: <CAB9BWheXhm=ib7xKjxa6FFBFqDk0nss1eSWA+P_gMo7KQyRYwg@mail.gmail.com>
Subject: Re: [PATCH V2] serial: sprd: Use devm_clk_get_optional() to get the
 input clock
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Cixi Geng <cixi.geng@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 3:12=E2=80=AFPM Chunyan Zhang <zhang.lyra@gmail.com=
> wrote:
>
> On Wed, 10 Dec 2025 at 14:36, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
> >
> > Simplify the code which fetches the input clock by using
> > devm_clk_get_optional(). If no input clock is present
> > devm_clk_get_optional() will return NULL instead of an error
> > which matches the behavior of the old code.
>
> This commit message is not describing the key point of its changes.
>
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> > Change in V2:
> > -Change title.
> > -Change commit message.
> > -Replace devm_clk_get() by devm_clk_get_optional() and drop NULL assign=
ment.
> > -Delete the sprd_uart_is_console function, after using the devm_clk_get=
_optional()
> >  interface, this conditional check is redundant.
> > ---
> >  drivers/tty/serial/sprd_serial.c | 40 +++++++-------------------------
> >  1 file changed, 9 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index 8c9366321f8e..83ce77b435ee 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -1115,34 +1115,21 @@ static void sprd_remove(struct platform_device =
*dev)
> >                 uart_unregister_driver(&sprd_uart_driver);
> >  }
> >
> > -static bool sprd_uart_is_console(struct uart_port *uport)
> > -{
> > -       struct console *cons =3D sprd_uart_driver.cons;
> > -
> > -       if ((cons && cons->index >=3D 0 && cons->index =3D=3D uport->li=
ne) ||
> > -           of_console_check(uport->dev->of_node, SPRD_TTY_NAME, uport-=
>line))
> > -               return true;
> > -
> > -       return false;
> > -}
> > -
> >  static int sprd_clk_init(struct uart_port *uport)
> >  {
> >         struct clk *clk_uart, *clk_parent;
> >         struct sprd_uart_port *u =3D container_of(uport, struct sprd_ua=
rt_port, port);
> >
> > -       clk_uart =3D devm_clk_get(uport->dev, "uart");
> > +       clk_uart =3D devm_clk_get_optional(uport->dev, "uart");
> >         if (IS_ERR(clk_uart)) {
> > -               dev_warn(uport->dev, "uart%d can't get uart clock\n",
> > -                        uport->line);
> > -               clk_uart =3D NULL;
> > +               return dev_err_probe(uport->dev, PTR_ERR(clk_uart),
> > +                       "uart%d can't get uart clock\n", uport->line);
>
> No, as I said before, you cannot do like this, this patch is making
> the clocks mandatory, sprd_serial driver could work as serial ports
> for logs output without this "uart" clock.
>
> It is very useful for early debugging when the clock driver is not even r=
eady.
>
> If other SPRD serials' default clock is 24M rather than 26M, like I
> said in the last version patch, you can set default clock according to
> the compatible string, that's saying make SPRD_DEFAULT_SOURCE_CLK to
> be an element of "of_device_id.data".
>
> So NAK for this change, sorry!
>
> Thanks,
> Chunyan

Hi chunyan:
  When the clock driver is not yet ready, the earlyconsole remains function=
al.
  At this stage, even if the UART driver probe fails, it will not
affect the debugging process.
Thanks

>
> >         }
> >
> > -       clk_parent =3D devm_clk_get(uport->dev, "source");
> > +       clk_parent =3D devm_clk_get_optional(uport->dev, "source");
> >         if (IS_ERR(clk_parent)) {
> > -               dev_warn(uport->dev, "uart%d can't get source clock\n",
> > -                        uport->line);
> > -               clk_parent =3D NULL;
> > +               return dev_err_probe(uport->dev, PTR_ERR(clk_parent),
> > +                       "uart%d can't get source clock\n", uport->line)=
;
> >         }
> >
> >         if (!clk_uart || clk_set_parent(clk_uart, clk_parent))
> > @@ -1150,19 +1137,10 @@ static int sprd_clk_init(struct uart_port *upor=
t)
> >         else
> >                 uport->uartclk =3D clk_get_rate(clk_uart);
> >
> > -       u->clk =3D devm_clk_get(uport->dev, "enable");
> > +       u->clk =3D devm_clk_get_optional(uport->dev, "enable");
> >         if (IS_ERR(u->clk)) {
> > -               if (PTR_ERR(u->clk) =3D=3D -EPROBE_DEFER)
> > -                       return -EPROBE_DEFER;
> > -
> > -               dev_warn(uport->dev, "uart%d can't get enable clock\n",
> > -                       uport->line);
> > -
> > -               /* To keep console alive even if the error occurred */
> > -               if (!sprd_uart_is_console(uport))
> > -                       return PTR_ERR(u->clk);
> > -
> > -               u->clk =3D NULL;
> > +               return dev_err_probe(uport->dev, PTR_ERR(u->clk),
> > +                       "uart%d can't get enable clock\n", uport->line)=
;
> >         }
> >
> >         return 0;
> > --
> > 2.34.1
> >

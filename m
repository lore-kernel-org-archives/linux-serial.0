Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE62C231A26;
	Mon, 13 Jan 2025 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736752409; cv=none; b=Qo/RT4T76QNU0rz7shcaYQPmz91XnZ0dKnjJzEclTf6SDQPkx3OZcWZZ6iMTQMqsBEXuoXcgBVpTTZnnODC1MFOHh6flkv7e/FJ72HDOIPn2hRs0o+u9mF19Ba+KQYTh52UHoCcpeaGBncplPFkn3cgSSO6TDh9+WKeX8SSrb0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736752409; c=relaxed/simple;
	bh=ZCDrfM+KNaUpjOtFXZdo7WofS4/G96/1zABL2I/zrwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnBztMTJkUyotkp1U8ituzu3IQhVnQLcq/k1zYkVSz0EioUF/BSTYrd/dFoeNKEg/zBWjGq3EhNLTA8IvrccgIGPSnyJwKDrYoqP026kwTP0g+bFyA5ooDEu0U9r29fHm99KC7Jhm0MsDP+AFoAehDKu6VIaNX9xGI6MZlECaOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGxCn9+O; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGxCn9+O"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f31b3db5ecso1732039eaf.0;
        Sun, 12 Jan 2025 23:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736752407; x=1737357207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p92GmtB/vLq+OZlxslDA6bCTqujKhsKLrRIIHGnv6Jc=;
        b=AGxCn9+OqQi3+br4Bxrm8DIkAnb1efesOnhT/U/b95+nca/OkdBuiyD6TzlPXn/3ER
         nhW6oJqQjJiB+g5rQmRIyCKqgEv+etn86ALnJS/Mio5NAa9r+jjdK04oE9NufoItAqe4
         RbHIgr1T8Jeibz2WU06uMztpURcRsyKt8lYf5/HXXiCQZvWNViAmIi7ZJm5tOPtSjJ6Y
         Wmrwi8SIr01G4lKhltJsvBU55PhFcUC40tQ33BV9qgjyFbB/BaIAEIsc5v3NaRl4yjxn
         VEE62qEBVc85DycMt4nncFINJsV7aGX/R4Az3BPYTF+JAPb+3c61Gl1Yhvkpo1jKmyY3
         3c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736752407; x=1737357207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p92GmtB/vLq+OZlxslDA6bCTqujKhsKLrRIIHGnv6Jc=;
        b=ZHnaKoMDP+nhqAWhj9fhEY/lVDdNza2DUxATJYKV0f8wxw5cwOfEKpn5wILQuJEAvf
         tlsFP83C86l5PLft5jxo6rjmo+d8grTd2XNfIiuH7RYIkiEmWM0XHJeLYufTKeIdbiK2
         jpGiXoCgkYfGdm4Kj9OkAhgOAXb1DkDu9W2ammjXzQUUFvSEyacKBgYAZ7GlqMZRl9xZ
         FGWlMokUSmaJrpLHfnRESvScuQvPfg767QUy0kwvpF2FTKgLmU/Rv7CnEtoll3pL7mUQ
         /VJmh2C9u5PwY3iCeluBKD4Aynw48L93wwGEzqF6sqp1eQcz/XZEBAsjvc+L3QwSgcq8
         TK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU2Z939sWVCYAl0J8FblrjclN6FyVIrFPiv5R0b0aXHfS7gBciN7XKkhKpPOgf+qHqywhLf0C7AVzoo3+S@vger.kernel.org, AJvYcCVgqmc5zxFleQoiPUS5e3IwojqM/Y2D3pjlWMNZ80Vuys5AfllomkCEpakYV6RnEtUmHYW0qPmUK+5L@vger.kernel.org, AJvYcCWY+efMCh3pqDM795bSvIKNw2KqTkUoiA2h7RVU4Uke6K6WmcnmSUZiEPGpAAkO3WHZK4gZEXUwX2ch9x/2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg9WZO3G8nQlRiFwJOBxC+on6qiYcHFv8V5YdU6L4fJEqrjwzQ
	5tZJVob6t6qHb+OUEADZ3kJqRt4RHMT+agsWbirdKapJvCOgVy+ePY0RzI0rR9uqbLZBNtmZceq
	ZXMOef4Bw836C3Xq2BewKYUD9vP4=
X-Gm-Gg: ASbGncuipeaoAb4vm3l7Dgr29ShHIvgMogHfsTxlxLXUaR8bNAc+0rTJda3C4CLWCS2
	hgu9zqAOqH9AN8CmOveGgWe53aF13eOOWbyd5L1/3qfhUQvgYRad/L/02yLDtmKRi7G32Nw==
X-Google-Smtp-Source: AGHT+IHRRKHkQ7+W1V1NkoQwcEQ2wslzZXrg0GXYLaGVtwubnfqjXyFM9L/XSh5YCAHoRT/Z9hxSabSuFXdWUFkzqKM=
X-Received: by 2002:a05:6871:6302:b0:29e:5d4e:a4c9 with SMTP id
 586e51a60fabf-2aa0690e5e2mr10988658fac.32.1736752406668; Sun, 12 Jan 2025
 23:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113031917.3354988-1-Wenhua.Lin@unisoc.com> <20250113031917.3354988-3-Wenhua.Lin@unisoc.com>
In-Reply-To: <20250113031917.3354988-3-Wenhua.Lin@unisoc.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 13 Jan 2025 15:12:49 +0800
X-Gm-Features: AbW1kvaE_y9Az2K2icnKAcUPLv_ZHQJaHIZVRG2iJkf1drdlMz5rm62ME4h9R1s
Message-ID: <CAAfSe-uAsDfDvDbOdEqrR=0=U-bfSuDpLSw_EFv8=GNMGDEvgw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] serial: sprd: Add support for sc9632
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	wenhua lin <wenhua.lin1994@gmail.com>, Xiongpeng Wu <xiongpeng.wu@unisoc.com>, 
	Zhaochen Su <Zhaochen.Su@unisoc.com>, Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jan 2025 at 11:20, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> Due to the platform's new project uart ip upgrade,
> the new project's timeout interrupt needs to use bit17
> while other projects' timeout interrupt needs to use
> bit13, using private data to adapt and be compatible
> with all projects.
>

It seems that this patch has got merged into the last release, why do
you resend this?

> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/tty/serial/sprd_serial.c | 41 ++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 3fc54cc02a1f..882580c3cf37 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -53,10 +53,12 @@
>  #define SPRD_IEN_TX_EMPTY      BIT(1)
>  #define SPRD_IEN_BREAK_DETECT  BIT(7)
>  #define SPRD_IEN_TIMEOUT       BIT(13)
> +#define SPRD_IEN_DATA_TIMEOUT  BIT(17)
>
>  /* interrupt clear register */
>  #define SPRD_ICLR              0x0014
>  #define SPRD_ICLR_TIMEOUT      BIT(13)
> +#define SPRD_ICLR_DATA_TIMEOUT BIT(17)
>
>  /* line control register */
>  #define SPRD_LCR               0x0018
> @@ -102,6 +104,7 @@
>  #define SPRD_IMSR_TX_FIFO_EMPTY        BIT(1)
>  #define SPRD_IMSR_BREAK_DETECT BIT(7)
>  #define SPRD_IMSR_TIMEOUT      BIT(13)
> +#define SPRD_IMSR_DATA_TIMEOUT BIT(17)
>  #define SPRD_DEFAULT_SOURCE_CLK        26000000
>
>  #define SPRD_RX_DMA_STEP       1
> @@ -118,6 +121,12 @@ struct sprd_uart_dma {
>         bool enable;
>  };
>
> +struct sprd_uart_data {
> +       unsigned int timeout_ien;
> +       unsigned int timeout_iclr;
> +       unsigned int timeout_imsr;
> +};
> +
>  struct sprd_uart_port {
>         struct uart_port port;
>         char name[16];
> @@ -126,6 +135,7 @@ struct sprd_uart_port {
>         struct sprd_uart_dma rx_dma;
>         dma_addr_t pos;
>         unsigned char *rx_buf_tail;
> +       const struct sprd_uart_data *pdata;
>  };
>
>  static struct sprd_uart_port *sprd_port[UART_NR_MAX];
> @@ -134,6 +144,18 @@ static int sprd_ports_num;
>  static int sprd_start_dma_rx(struct uart_port *port);
>  static int sprd_tx_dma_config(struct uart_port *port);
>
> +static const struct sprd_uart_data sc9836_data = {
> +       .timeout_ien = SPRD_IEN_TIMEOUT,
> +       .timeout_iclr = SPRD_ICLR_TIMEOUT,
> +       .timeout_imsr = SPRD_IMSR_TIMEOUT,
> +};
> +
> +static const struct sprd_uart_data sc9632_data = {
> +       .timeout_ien = SPRD_IEN_DATA_TIMEOUT,
> +       .timeout_iclr = SPRD_ICLR_DATA_TIMEOUT,
> +       .timeout_imsr = SPRD_IMSR_DATA_TIMEOUT,
> +};
> +
>  static inline unsigned int serial_in(struct uart_port *port,
>                                      unsigned int offset)
>  {
> @@ -637,6 +659,8 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
>  {
>         struct uart_port *port = dev_id;
>         unsigned int ims;
> +       struct sprd_uart_port *sp =
> +               container_of(port, struct sprd_uart_port, port);
>
>         uart_port_lock(port);
>
> @@ -647,14 +671,14 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
>                 return IRQ_NONE;
>         }
>
> -       if (ims & SPRD_IMSR_TIMEOUT)
> -               serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
> +       if (ims & sp->pdata->timeout_imsr)
> +               serial_out(port, SPRD_ICLR, sp->pdata->timeout_iclr);
>
>         if (ims & SPRD_IMSR_BREAK_DETECT)
>                 serial_out(port, SPRD_ICLR, SPRD_IMSR_BREAK_DETECT);
>
>         if (ims & (SPRD_IMSR_RX_FIFO_FULL | SPRD_IMSR_BREAK_DETECT |
> -                  SPRD_IMSR_TIMEOUT))
> +                  sp->pdata->timeout_imsr))
>                 sprd_rx(port);
>
>         if (ims & SPRD_IMSR_TX_FIFO_EMPTY)
> @@ -729,7 +753,7 @@ static int sprd_startup(struct uart_port *port)
>         /* enable interrupt */
>         uart_port_lock_irqsave(port, &flags);
>         ien = serial_in(port, SPRD_IEN);
> -       ien |= SPRD_IEN_BREAK_DETECT | SPRD_IEN_TIMEOUT;
> +       ien |= SPRD_IEN_BREAK_DETECT | sp->pdata->timeout_ien;
>         if (!sp->rx_dma.enable)
>                 ien |= SPRD_IEN_RX_FULL;
>         serial_out(port, SPRD_IEN, ien);
> @@ -1184,6 +1208,12 @@ static int sprd_probe(struct platform_device *pdev)
>
>         up->mapbase = res->start;
>
> +       sport->pdata = of_device_get_match_data(&pdev->dev);
> +       if (!sport->pdata) {
> +               dev_err(&pdev->dev, "get match data failed!\n");
> +               return -EINVAL;
> +       }
> +
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
>                 return irq;
> @@ -1248,7 +1278,8 @@ static int sprd_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(sprd_pm_ops, sprd_suspend, sprd_resume);
>
>  static const struct of_device_id serial_ids[] = {
> -       {.compatible = "sprd,sc9836-uart",},
> +       {.compatible = "sprd,sc9836-uart", .data = &sc9836_data},
> +       {.compatible = "sprd,sc9632-uart", .data = &sc9632_data},
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, serial_ids);
> --
> 2.34.1
>

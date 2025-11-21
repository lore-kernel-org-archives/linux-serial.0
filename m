Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BC242D78
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736405; cv=none; b=IbtzbOaPzImodXg1nFAg8TocemmCPC5g0TeYIX+hHWgsOQJmeAFP02m3LZQN4NS/SagQJEMt4iW4LYWwMGzg7nm9HUmoPIF9B/kaeMxbBtpw8JpjyxCGyApkqviTtaHb9N8IVCPKCvpcxRm/yKVDuSA1B135RuE6qHOsU/eg6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736405; c=relaxed/simple;
	bh=eUopMHDcrOOQ3SDLbKHxv+NyN+8j07BPv0wKk64BLns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4jSewAvSUY+uLPrk/49DCrovM/gZcDhSFaJidqYzzbQXVctQugU/KqWbw8abG/EmTc+Km1yH8srBX3HR292smBp7sMNKeF2UidM0NBoDJDP9xQAtLEZRP1RZM6SeU/NJ10v85nli1jge3ua8Mok9v5WRtrtj7Buyd57bzoZ3UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55ab217bb5eso291837e0c.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 06:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736401; x=1764341201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENP0h/R0a3V4uxvE+8RQQ9YGEKzdgQGNp1M5prxm01k=;
        b=MpN873qEYKnI/am6pmR7Y/ubqiv9FHVjJ6vCfO3ZtR429DrXVglatkMfhEsyBMDM66
         eBmQin8W3/Sl4NtAW44lPMehbMfGkt4yBWAhM7qvJKvLhJ7cRgZjJYGpvfejDEVqiZJq
         j6mwqGz9ajTIDpXNRKLF8YGu4HQQMEDyggLJSTZkKehQRig+3KVLQ8wDPh59vYezoQRB
         oHTteJQR3zlR9tkKTUefK+oDQEM6Tul+msjjktdFAbABmj6mg6/8X05uV1UCK0gFrhoI
         vqVun2b1BP6VcVx0h2W1+gx4tCsAnlbEPwQA09oI+FhQLWXcg1jMuHcdGetGLJxxPk3g
         Z/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRJ1SXtHSbXEiCm+dBz20GAtjOOmZzweoZdP0VkRpmPB8iaRFZBE+pCpmX8hHx2U5+PkifU2/zJT6Rmco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPz1dujfKHDnNtKEfEbFuKMCLzTO/6c8mZyYk0iWmeCIe+BjRc
	ARcUl2x90MTMtCl80eqWRQfmiJ0Lq0nc6JtiKVb77zg/nqjbMDfR4OT6Oe/5WtKF
X-Gm-Gg: ASbGncvQSBdDPXwOG4LZQalmv3zJ3SwMDPr1SeVaM12ARCk/ri49lxWnjm1qkBZEpJg
	vtGB+GvTDkmVVLjkYW5xQzcY5h84kwz7DzhMOpwvvPC1DQ9hZ/gj39FEYjc2rPzPOvgDzkqqCCL
	W8ddia1l3lpAAI3Vu8JJgJbUO3+1O1YrHiaYqAaYCszpXLkQ0RORXtSvw2vz+iWJALcSwdhpH5p
	7KzYNGxZZi+bNJTVdmTZR+jzJPGfXHPUUvfG+Ic3sJeu4T+0Ua89OD5ELOIhfy7xqz3kIh67X2w
	JKop4HIc1vu/FLeAIStO2Y/nDqVUpx6JR/GV7dhocTYOWmqo3milt18ZNSeqkF8qmlDkC3BW9HB
	BNvE//WbGEPqtxqJg8RgeHLKu43MsjJoPVG+qIjAOxwPe4vSIkALK1PI99DX87g4q3KoKar9S0l
	D7r2dql44I1h2weKUlhs1kHuYOB0IZjVt0o4jaDQixu+y+NJyXMSGCRy5Qchpk6Ic=
X-Google-Smtp-Source: AGHT+IH1xhdyIImAAvZRjEtzeYS0EsLC4pTavbW5P0yRhHCKsd0P/ncS4sfUSI+GXXPCLlXo6HMnXA==
X-Received: by 2002:a05:6122:3293:b0:54c:da0:f711 with SMTP id 71dfb90a1353d-55b8d6c5a50mr769435e0c.7.1763736401489;
        Fri, 21 Nov 2025 06:46:41 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7a1133sm2394767e0c.18.2025.11.21.06.46.41
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 06:46:41 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dbe6304b79so783128137.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 06:46:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUo6Lgdx81sKVql7vZN/jU6HQQ75A3pdwJnCOycfVqOzIcpJFCccBsSZLpAbdqH/XEl3ehT29YGClr9quY=@vger.kernel.org
X-Received: by 2002:a05:6102:5129:b0:5dd:b2a1:a5a4 with SMTP id
 ada2fe7eead31-5e1de0f50fbmr689223137.5.1763736400807; Fri, 21 Nov 2025
 06:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-13-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-13-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 15:46:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXshthP8nrV-qP=fSv6HGCDj47x9_jQYobZTEivy15tvw@mail.gmail.com>
X-Gm-Features: AWmQ_bmAeU3gltmbELTNuNCMFNbRqLYdBo-mhJUddza9Ysxl7Zd2lut4kibciNM
Message-ID: <CAMuHMdXshthP8nrV-qP=fSv6HGCDj47x9_jQYobZTEivy15tvw@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] serial: sh-sci: Add support for RZ/G3E RSCI SCIF
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 14 Nov 2025 at 11:52, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add support for RZ/G3E RSCI SCIF(a.k.a FIFO mode). RSCI IP found on the
> RZ/G3E SoC is similar to RZ/T2H, but it has a 32-stage FIFO. it has 6
> clocks(5 module clocks + 1 external clock) instead of 3 clocks(2 module
> clocks + 1 external clock) on T2H and has multiple resets. Add support
> for the hardware flow control.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Dropped cpu_relax() from rsci_finish_console_write() and added a
>    comment.
>  * Added sci_is_rsci_fifo_type() helper for reuse in probe() and remove().

Thanks for the update!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3563,6 +3563,11 @@ static struct uart_driver sci_uart_driver = {
>         .cons           = SCI_CONSOLE,
>  };
>
> +static bool sci_is_rsci_fifo_type(u8 type)
> +{
> +       return (type == SCI_PORT_RSCI || type == RSCI_PORT_SCIF);
> +}
> +
>  static void sci_remove(struct platform_device *dev)
>  {
>         struct sci_port *s = platform_get_drvdata(dev);
> @@ -3574,7 +3579,7 @@ static void sci_remove(struct platform_device *dev)
>         if (s->port.fifosize > 1)
>                 device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
>         if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF ||
> -           type == SCI_PORT_RSCI)
> +           sci_is_rsci_fifo_type(type))

I think Jiri intended[1] having a helper that covers all cases, not
just the two RSCI variants. E.g. sci_has_fifo(u8 type).

>                 device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);
>  }
>
> @@ -3669,6 +3674,10 @@ static const struct of_device_id of_sci_match[] __maybe_unused = {
>                 .data = &of_sci_scif_rzv2h,
>         },
>  #ifdef CONFIG_SERIAL_RSCI
> +       {
> +               .compatible = "renesas,r9a09g047-rscif",
> +               .data = &of_rsci_scif_data,
> +       },
>         {
>                 .compatible = "renesas,r9a09g077-rsci",
>                 .data = &of_sci_rsci_data,
> @@ -3936,7 +3945,7 @@ static int sci_probe(struct platform_device *dev)
>                         return ret;
>         }
>         if (sp->type == PORT_SCIFA || sp->type == PORT_SCIFB ||
> -           sp->type == PORT_HSCIF || sp->type == SCI_PORT_RSCI) {
> +           sp->type == PORT_HSCIF || sci_is_rsci_fifo_type(sp->type)) {
>                 ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_timeout);
>                 if (ret) {
>                         if (sp->port.fifosize > 1) {

[1] https://lore.kernel.org/all/19a08b75-13ca-45f9-884d-f96602336dfd@kernel.org

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14563EDE6C
	for <linux-serial@vger.kernel.org>; Mon, 27 Jul 2026 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145165; cv=pass; b=t2ucKgfviSH8mRcFZQUBgaHwA1DqkiigrFoJrg8z9e3fNhvZDUZCT0XgH11Pgg4GbV9YME5vX6gnQCT196NDNOf2wXZ5iQPmoROodqYH/hxyc6xDAdx7DXkbs2NRK/tKAE8dve5HkPYSPB+N9VSq5th7ZAhff5NeQxgwUgEFFK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145165; c=relaxed/simple;
	bh=EWE0XNGnMSCN5TYj/XunOP9DnmXi029IzHnshfp+Alc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMgYPKmLm+klcJACL1Kd+NYlPWfs4ZSYRTXqQOPHQRHA848xADPMC5qlXlQKZbMdcMJKlG7H2z1MhB1FRxOuoKofnzYkjkghu2EC5wnUPeiAuho/cnmf0ZNfVrjFU0W4v8eVWst19BOfKxKpgHjuxk8YCY5WGZ70ZQgOXbpJJBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ibDZ6kVl; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ibDZ6kVl"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80814edb536so30481817b3.2
        for <linux-serial@vger.kernel.org>; Mon, 27 Jul 2026 02:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785145162; cv=none;
        d=google.com; s=arc-20260327;
        b=odUYUATCYcs9dsD93epQY+6YRtbqJyku4CTwmuJxiFDNybRyFW8GHQG65Gh5eoX7m3
         +9GGiOGSo38ZArthwUDzFISTjMDPFE2RLHI9dpqVdif26mrVLe+2PqOKWHnGdeuEIN5t
         HcZh+Z3jViBQQhFvCu3JY89Wf9SZ0MMQ4IPv+eZISea38Yk4XX4DtB2WaKx8oyufYzAM
         pGT4Gb0xQHuULIfv/uTdfGj53evX/lcCEXUsCaokYNOwEOG5wRzoiWcADMpEXRz7Lump
         ws4CRWT+9dpTH38ovi9rzvcaGsDcqcGfLrAhnHOd2IMlxX3i7RcLaRrPwbnCI6wl6Bk9
         Jzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YQ2tgjM+wXy4QeurUPVKQ/lR4Rk/RqXxn7O1aD2yYY8=;
        fh=jx5E10KudulpnUnHvuCxlP843TOyYQE7yvZA3Bs19ag=;
        b=eG0Jpi5/ufqOlGC0l6i8wS4lKsHr3YxExPnLGu0ef1AryLwhFstHqHCWTfsudITX/I
         1FyuYpF1Uy5TA+b7P1HJM9iCB6jRc/G9tKXRYjX+0A9Qqn0l5rc5vZBN3nyC553YANrL
         rHT4FKCxzVt0tdguQmH8PFRKTPOVqGz/hjSoi1Ev5PhXYaHke7u95gI6yuTyp0lNk9Ps
         Vrq/AVBNvD2cxwbpl8qKZBM2YB7ZFcIf1WajEKnSSTGQVNuTPtLU5gtoYtaQUQWXA7d7
         rN3acHBaUWE6zWUGq9aqfVlZ+h/mum+kMpYEHWEzHxp/eBzavfhqKIdxLlMvXHkxTEX9
         LdVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785145162; x=1785749962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YQ2tgjM+wXy4QeurUPVKQ/lR4Rk/RqXxn7O1aD2yYY8=;
        b=ibDZ6kVltxORFb4IhrIIL4xGkLpv1q2atW04Ba3UbV4zbgV7TSCQUoVtRScf0xjI8e
         K3g2vCqotc6xhAv7Ld0HYax3lBMCzxnw0CvLxWTJW9Pm0NBZDZT2DLfY4isdW+MexaNY
         JFTWPtnMXY6jBVnKwnnvk4AgpoMcMVFbMTgs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785145162; x=1785749962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQ2tgjM+wXy4QeurUPVKQ/lR4Rk/RqXxn7O1aD2yYY8=;
        b=g5tAjwZ25d75auvs2Q6Qm8Vzl5HM8xufZZIDalGcIHJXqQsM9omkB6FPAm71h+BPNo
         3bxcJMfGIRXI6O+ZubFJB1JBcbG5XJEUX3PgnHeJ34fmO7OFS7rxs85LI8PEh0Yc9x4w
         L5SWMerV41FUR9U2y1twGnAW9mHuy/J27gCjv3zzixYbo8jIZN41IQEblNO9z/gIOheQ
         xqd7uHFMCmz0JbyCT8U0+9Ya0CEPdtYgCugkKKmjNc+HD7Q3E3IC3LhwJSd+S5YAPw8p
         VMQGNeRT1H5R+NhWHp+5MPmJcEgqs6uBGy65ZJsMDX6+Y4G0ZZ71Obnp4hTBU7o4/3dP
         v5og==
X-Forwarded-Encrypted: i=1; AHgh+RptahdP8HU0rMhtfqGuLY+3VpKXi4GZncT8yMKQjcaptoNGmaBUcBRTQ1OyC/xDM9Kqghdw/uTa2OCQ9w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/xNOGLry78TzH0GI5ejjlXSXrhK0kDTSYfBJZz5ZlvDp0Fiy
	rD8HQD/3Vb4dJW92ZoSfIqIzMzLG++QDuHvUKQcMiK2eaXzEkDWM4yaAvcMmZuCgE03Xtje7qML
	LLPFa47ToNW0CVsBy+RGdOonA5407O9wXxejdceSW
X-Gm-Gg: AR+sD10phjh0KiVd12msIeM0VSJwpnGS94/CUIa6keX10Yj808bf0KRLlFSl2GNRnwq
	ze5Ml4kjE0TFCvuLeGOlwV2VGRVfPnQNoGpB3zdt0Lt5UCPv80phGY57Zcc3rucSefyP63sQolB
	pG+mdTjLOKOHlvcVYKaiogTnw/21quypaQVRa5ckInKB2rbW/BT9yL4MtvECGcpzlcz2zNceVqL
	Bp8ShttWfVybodMBddqHdGTo9CVAbLdxelyQxA6Rlo1quMV0HcutsSOKCZid1fT5Dg8pT2fQ61q
	n3VwU4VNqDMqyEs=
X-Received: by 2002:a05:690c:22c1:b0:7ea:809c:2af5 with SMTP id
 00721157ae682-81f69dec43bmr26374967b3.37.1785145161730; Mon, 27 Jul 2026
 02:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-ccaione-genio-serial-aliases-v2-0-0f2ae41a8e89@baylibre.com>
 <20260727-ccaione-genio-serial-aliases-v2-2-0f2ae41a8e89@baylibre.com>
In-Reply-To: <20260727-ccaione-genio-serial-aliases-v2-2-0f2ae41a8e89@baylibre.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 27 Jul 2026 17:39:10 +0800
X-Gm-Features: AUfX_mwlgcUapUfGZW2dMAil1rMukXcM2pCT5Z8U-x1BRJr_pwTehuo1NL79Xlc
Message-ID: <CAGXv+5Et=hVYp74v8p5FhdrifjUotPbtp8XqyNuCV+NvJ_LMGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: 8250_mtk: honor DT serial aliases
To: Carlo Caione <ccaione@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-serial@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:40=E2=80=AFPM Carlo Caione <ccaione@baylibre.com>=
 wrote:
>
> The Genio board DTs provide serial aliases for all enabled UARTs, but
> the MTK 8250 driver still registered every port with the default line
> number. If uart0 deferred and another UART probed first, the 8250 core
> could still assign ttyS0 to the wrong port despite the DT aliases.
>
> Read the serial alias during OF probe and seed uart.port.line before
> registering the port so the 8250 core reserves the requested ttyS slot.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Matches what is done in __uart_read_properties(),

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/tty/serial/8250/8250_mtk.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250=
/8250_mtk.c
> index e6a56cf54ae0..841d64f6a707 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -8,6 +8,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/pinctrl/consumer.h>
> @@ -521,7 +522,7 @@ static int mtk8250_probe(struct platform_device *pdev=
)
>         struct uart_8250_port uart =3D {};
>         struct mtk8250_data *data;
>         struct resource *regs;
> -       int irq, err;
> +       int irq, err, line;
>         struct fwnode_handle *fwnode =3D dev_fwnode(&pdev->dev);
>
>         irq =3D platform_get_irq(pdev, 0);
> @@ -575,6 +576,10 @@ static int mtk8250_probe(struct platform_device *pde=
v)
>  #endif
>
>         if (is_of_node(fwnode)) {
> +               line =3D of_alias_get_id(pdev->dev.of_node, "serial");
> +               if (line >=3D 0)
> +                       uart.port.line =3D line;
> +
>                 /* Disable Rate Fix function */
>                 writel(0x0, uart.port.membase +
>                         (MTK_UART_RATE_FIX << uart.port.regshift));
>
> --
> 2.55.0
>
>

Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qw17kMSq"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ACEB8
	for <linux-serial@vger.kernel.org>; Mon, 27 Nov 2023 03:22:49 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50aa698b384so12300e87.0
        for <linux-serial@vger.kernel.org>; Mon, 27 Nov 2023 03:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701084167; x=1701688967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwT5hJLuzH/vmwnhunH0w6f2oqAqqH8JJnk36sG1iqo=;
        b=qw17kMSq0+41I6HkKUB2gM8SOtfDiMExK0MDZl3o4kNaMG+9I+SdjVKK7FQ3zDMgLM
         XHlI2rY+Sqp+AxXueWTUzcY4Ax8CydfjLUq+1BN/7B7pu9NhI5KCc0Gw5z968zTqP98e
         O5XxENgttWvQMlfS+SgcAuNA860t+wLNnEn1hYzEO+I6M0w+oYTSWPn8xofgvS+tow31
         Vs7rVqELRxhV6SM5cFBF1buarHN6mhs0NPQO5rK/F2lERGuDW7rgbvp/Yn/Cjw/6n4ze
         D+MagvM1SEzJxI37j2CYMPTFDn3TniYMDJaBiOjmfGEF48t7Co23JiSU6b2PCjXEZfPR
         YoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701084167; x=1701688967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwT5hJLuzH/vmwnhunH0w6f2oqAqqH8JJnk36sG1iqo=;
        b=nDOAtZF0eEp+5OsO1Igy5djrbdwwGGLh7eJJoH3UbSTYi25vtZElK8Lu8n9nfWU8eK
         h0BDLolweOK9EU6eJ85KClInDK6FScTZe1IY3SUerV05h5Fuahb8LsK0YAHOe94XUmsu
         julZCz2pU1yT4wX9f1G7Q6llRaVLvGHvN8QBmkc0YynBEV/27qnEYEBzGJEez2p6QQ7t
         pwFdLhm0EwBYOMzDzf6ScWD2LZRxb/qC53HNh5wNIx4RM0PI00C3ul+NdRKtGTmGTDaI
         HRZcmgRBxOdrT6QWXb6PmNPyXhyabUre8c86shIBwB/VKO7pQ/p1rIEiEzwJc+5dQciV
         Sohg==
X-Gm-Message-State: AOJu0YxnwCw6Mm2G0xod3WDvehXGVQ9UTCuCY07KCaW2mBJWFgzzir69
	bA8aBKJjfPq5TqvHcISIG13lJeQA7uqWKvQaG7e42w==
X-Google-Smtp-Source: AGHT+IEycF56nqnX17lIBUm7g7PxQL5cBbulIaMHhdTBCYUhQe71hH0Gr0zy95XzzQC5hMfQFeXJZiQHitZEVvCv7GM=
X-Received: by 2002:a05:6512:3b0b:b0:505:6e12:9e70 with SMTP id
 f11-20020a0565123b0b00b005056e129e70mr445087lfv.6.1701084167106; Mon, 27 Nov
 2023 03:22:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
In-Reply-To: <20231017130540.1149721-1-thomas.richard@bootlin.com>
From: VAMSHI GAJJELA <vamshigajjela@google.com>
Date: Mon, 27 Nov 2023 16:52:34 +0530
Message-ID: <CAMTSyjpto7_Keq6-wz9OC475f1EUT0kQfYLnRFsTNVwGS9mACg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, tony@atomide.com, 
	linux-serial@vger.kernel.org, gregory.clement@bootlin.com, u-kumar1@ti.com, 
	d-gole@ti.com, thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 6:35=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> If the console suspend is disabled, the genpd of the console shall not
> be powered-off during suspend.
> Set the flag GENPD_FLAG_ALWAYS_ON to the corresponding genpd during
> suspend, and restore the original value during the resume.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 33 ++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/825=
0/8250_omap.c
> index ca972fd37725..91a483dc460c 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -27,6 +27,7 @@
>  #include <linux/pm_wakeirq.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/sys_soc.h>
> +#include <linux/pm_domain.h>
>
>  #include "8250.h"
>
> @@ -114,6 +115,12 @@
>  /* RX FIFO occupancy indicator */
>  #define UART_OMAP_RX_LVL               0x19
>
> +/*
> + * Copy of the genpd flags for the console.
> + * Only used if console suspend is disabled
> + */
> +static unsigned int genpd_flags_console;
> +
>  struct omap8250_priv {
>         void __iomem *membase;
>         int line;
> @@ -1617,6 +1624,7 @@ static int omap8250_suspend(struct device *dev)
>  {
>         struct omap8250_priv *priv =3D dev_get_drvdata(dev);
>         struct uart_8250_port *up =3D serial8250_get_port(priv->line);
> +       struct generic_pm_domain *genpd =3D pd_to_genpd(dev->pm_domain);
>         int err =3D 0;
>
>         serial8250_suspend_port(priv->line);
> @@ -1627,8 +1635,19 @@ static int omap8250_suspend(struct device *dev)
>         if (!device_may_wakeup(dev))
>                 priv->wer =3D 0;
>         serial_out(up, UART_OMAP_WER, priv->wer);
> -       if (uart_console(&up->port) && console_suspend_enabled)
> -               err =3D pm_runtime_force_suspend(dev);
> +       if (uart_console(&up->port)) {
> +               if (console_suspend_enabled)
What is best way for adding a check here, either using
`uport->suspended` or `console_suspend_enabled`
> +                       err =3D pm_runtime_force_suspend(dev);
> +               else {
> +                       /*
> +                        * The pd shall not be powered-off (no console su=
spend).
> +                        * Make copy of genpd flags before to set it alwa=
ys on.
> +                        * The original value is restored during the resu=
me.
> +                        */
> +                       genpd_flags_console =3D genpd->flags;
> +                       genpd->flags |=3D GENPD_FLAG_ALWAYS_ON;
> +               }
> +       }
>         flush_work(&priv->qos_work);
>
>         return err;
> @@ -1638,12 +1657,16 @@ static int omap8250_resume(struct device *dev)
>  {
>         struct omap8250_priv *priv =3D dev_get_drvdata(dev);
>         struct uart_8250_port *up =3D serial8250_get_port(priv->line);
> +       struct generic_pm_domain *genpd =3D pd_to_genpd(dev->pm_domain);
>         int err;
>
>         if (uart_console(&up->port) && console_suspend_enabled) {
> -               err =3D pm_runtime_force_resume(dev);
> -               if (err)
> -                       return err;
> +               if (console_suspend_enabled) {
> +                       err =3D pm_runtime_force_resume(dev);
> +                       if (err)
> +                               return err;
> +               } else
> +                       genpd->flags =3D genpd_flags_console;
>         }
>
>         serial8250_resume_port(priv->line);
> --
> 2.39.2
>

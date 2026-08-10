Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B86E3E1686
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367202; cv=none; b=AtZ2pXwe0KCjJeCcBzk8mHXoVtF+gmvbRqnd6VOqmxTJh6Y7AMji/bI/Uk6y7J0bqgQQidSNCVao7HBR85bMREVNvkz6/tcOHo9poTKCJ2dVE6IIzLT/TyT8oQJ22Ggva/pvw88QjzTpIgt0eyxZuURajhAPHdGwrCI2oqbSWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367202; c=relaxed/simple;
	bh=UOqS2BQJPAESAW6nffGEETU8D6OAwM/CNtqbcFzYb0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JuNPtWxR5fTdpHvTE635CEhnbAF1U7aBUKJAvH5rznXJtcZhXnedXeQkJGWnHMw5LuUdv0xkI3PRzaEVGilm0gGnK+Fscn/9XR1/2yUGpAWXV34xdwextSEGPBIQqVkMs2i4qzMm6qrrOTtbfjTixcT38O/c73IPL5gKRffpDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mkmkl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCI77hR1; arc=none smtp.client-ip=209.85.208.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mkmkl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCI77hR1"
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-39c9aa07c5eso2756781fa.0
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786367199; x=1786971999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IdhndaGQ5ilhTKEdFH/lvhXJ1C8BSb4SQCGnhzgRjo4=;
        b=XCI77hR15miC48FSsZHnm8hW8Idtwtdx5UtpBoN89Is49Kgnah9cvZqfAWcdIEnPyD
         wgJwEJWoBaU8avbTKHbEYZtwpBotU0ZLUeIFNIJKIbyjvPfQqBw/BUAKOlp4HxI8Gh3W
         kmRVmeM18Vcd0lF8cbkeOiYll7l77J+9iyJVDIYi73r27mt0A1mTdphfK1TdcrtmiRBA
         2rvu4tO+c5Gozeb95JTYlC0u5f4ogVshITa4f2x8n8VYtr3UllBt95My7xo86FLf3csh
         uut8wLynIwOnCqrCZBZbo9GjsMw17Yx1VKv2fNVPREoVDiohI21hx48IvBfuTcEcUVDn
         2nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367199; x=1786971999;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IdhndaGQ5ilhTKEdFH/lvhXJ1C8BSb4SQCGnhzgRjo4=;
        b=luagxawzx8hf2WezbtoPKJEWbnjlGNueQsIQNsDmvo4s2SMs5i7DGbrcBZRzRd8O//
         +oraEURn62vkc/XjKbw8Q5PtC3OhYxMlfOKbqErxarmNIlWClK5IaNAZ3mzgf4ZMsuP4
         5fD11uwY7QPmD0HFYfnVd5QKnhtvTH8W9VSdgtc/hWyweI2nCi16Un48Ly6Ir4fmLxEC
         rFsy4BENhHkwTnFZ4xRYjp1lj1+rqb6SUSratSNJeYVXrNKaXjgzAynWedaw3BqSKoBg
         6aBGJCxc7dnro0Bw3asc8uPhxZhPs2oax0ftseHfboRCd9vhOfK4THUI3daPNUHfosk1
         sbkQ==
X-Forwarded-Encrypted: i=1; AHgh+RpP1Tav7aJBkTr7oKpKHJsSwViusRso1YOLCiTluFRTPDszbyndfoEHMk1cHmG4yx6yQqcEzdSZ0SNd0Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGOpccbk7vnTmiul9KyNd59ApfiLn9LiSqXzKTPnjrJFZtD0uC
	yNcd9LmrfZYGWa3d+jBXajkMbsFp2I6QyMXT4IKBZ/C2sm2tWoA1XNfH349Fl7jszTX804Qqhpy
	E2A==
X-Received: from ljxd20-n1.prod.google.com ([2002:a05:651c:a114:10b0:39f:89:905e])
 (user=mkmkl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:651c:a204:10b0:39b:1a03:bcb0
 with SMTP id 38308e7fff4ca-3a00e8253f1mr1938371fa.10.1786367198475; Mon, 10
 Aug 2026 06:06:38 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:06:35 +0000
In-Reply-To: <20260810130635.1166626-1-mkmkl@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810130635.1166626-1-mkmkl@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810130635.1166626-3-mkmkl@google.com>
Subject: [PATCH v1 2/2] tty: serial: 8250_dw: Keep init pinctrl state until
 first open
From: "=?UTF-8?q?Micha=C5=82=20Karda=C5=9B?=" <mkmkl@google.com>
To: Linus Walleij <linusw@kernel.org>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Douglas Anderson <dianders@chromium.org>, Vic Huang <vich@google.com>, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Micha=C5=82=20Karda=C5=9B?=" <mkmkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When a UART port is connected to an external peripheral whose power
domain is kept powered off until first use, transitioning the UART
pins from the "init" state to the "default" state prematurely at probe
completion can cause parasitic back-powering into the unpowered
peripheral.

Ensure that on boards specifying an "init" pinctrl state for the port,
the "init" state is preserved until the port is first opened:

1. In dw8250_probe(), call pinctrl_keep_init_state(dev) to opt out of the
   automatic "init" -> "default" transition at probe completion and record
   this in data->in_init_state.
2. In dw8250_do_pm(), when the port is opened (state =3D=3D 0), transition
   pins from "init" to "default" if data->in_init_state is set, and clear
   the flag.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Co-developed-by: Vic Huang <vich@google.com>
Signed-off-by: Vic Huang <vich@google.com>
Signed-off-by: Micha=C5=82 Karda=C5=9B <mkmkl@google.com>
---
 drivers/tty/serial/8250/8250_dw.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/82=
50_dw.c
index 5fba913f3301..74e568e2a0d3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/lockdep.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -77,6 +78,7 @@ struct dw8250_data {
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
 	unsigned int		in_idle:1;
+	unsigned int		in_init_state:1;
=20
 	u8			no_int_count;
 };
@@ -461,8 +463,15 @@ static int dw8250_handle_irq(struct uart_port *p)
 static void
 dw8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 {
-	if (!state)
+	struct dw8250_data *d =3D to_dw8250_data(port->private_data);
+
+	if (!state) {
 		pm_runtime_get_sync(port->dev);
+		if (d->in_init_state) {
+			d->in_init_state =3D false;
+			pinctrl_pm_select_default_state(port->dev);
+		}
+	}
=20
 	serial8250_do_pm(port, state, old);
=20
@@ -770,6 +779,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (data->data.line < 0)
 		return data->data.line;
=20
+	data->in_init_state =3D pinctrl_keep_init_state(dev);
+
 	platform_set_drvdata(pdev, data);
=20
 	pm_runtime_enable(dev);
--=20
2.55.0.654.g21b8a5bc05-goog


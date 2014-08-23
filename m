From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 7/7] ARM: meson: update documentation (uart, timer and
 vendors)
Date: Sat, 23 Aug 2014 14:24:33 +0200
Message-ID: <53F88801.4050300@suse.de>
References: <1408272594-10814-1-git-send-email-carlo@caione.org> <1408272594-10814-8-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47152 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbaHWMYi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Aug 2014 08:24:38 -0400
In-Reply-To: <1408272594-10814-8-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com

Am 17.08.2014 12:49, schrieb Carlo Caione:
> New UART and timer bindings are documented. A new vendor is added to =
the
> vendors list.
>=20
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.txt   | 17 +++++++=
++++++++++
>  .../devicetree/bindings/timer/amlogic,meson6-timer.txt  | 16 +++++++=
+++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt   |  1 +
>  3 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/amlogic,=
meson-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/amlogic,m=
eson6-timer.txt
[...]
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/=
Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac7269f..5cf0618 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -14,6 +14,7 @@ allwinner	Allwinner Technology Co., Ltd.
>  altr	Altera Corp.
>  amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
>  amd	Advanced Micro Devices (AMD), Inc.
> +amlogic	Amlogic, Inc.
>  ams	AMS AG
>  amstaos	AMS-Taos Inc.
>  apm	Applied Micro Circuits Corporation (APM)

Sorry, here's the vendor prefix I was asking about. Please split it off
into its own patch and best order it before the first use.

Documentation of SoC and board seem to be indeed missing though.

Cheers,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrn=
berg
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

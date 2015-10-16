From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 1/3] tty: serial core: provide a method to search uart by phandle
Date: Fri, 16 Oct 2015 21:05:11 +0200
Message-ID: <6829927.BRrJSMeG05@wuerfel>
References: <cover.1445018912.git.hns@goldelico.com> <c46694357c903d8791f07e2ec287c684832056a5.1445018913.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c46694357c903d8791f07e2ec287c684832056a5.1445018913.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Sergei Zviagintsev <sergei-E844GTqJAzo@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Friday 16 October 2015 20:08:33 H. Nikolaus Schaller wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/slaves.txt
> @@ -0,0 +1,16 @@
> +Device-Tree bindings for UART slave devices
> +
> +A node describing a slave device defines a phandle to reference the UART
> +the device is connected to. In the (unexpected) case of two or more UARTs
> +a list of phandles can be specified.
> +
> +properties:
> +       - uart: (list of) phandle(s) of UART(s) the device is connected to
> +
> +
> +example:
> +
> +       gps {
> +               compatible = "wi2wi,w2sg0004";
> +               uart = <&uart1>;
> +       };
> 


I would have expected the gps device here to be a child node of the
uart in DT. Can you explain why you chose differently?

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

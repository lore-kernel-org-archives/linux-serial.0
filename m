Return-Path: <SRS0=+90y=4V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8334FC3F2CD
	for <linux-serial@archiver.kernel.org>; Wed,  4 Mar 2020 14:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F06320866
	for <linux-serial@archiver.kernel.org>; Wed,  4 Mar 2020 14:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583333067;
	bh=uKiNLVFgpNoNxtlTI4l7WNRrAcGQ8h1y7f4ZG2yWftA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=R04jiW54AUGPAtrMLYuES/zfGhk77zypGwBAAT0qoeaU9/c1VtWT1+R+HvCVXCjLa
	 AQf1C0j9I/0RHmFDUfl62IcK+WM8VPWJxDtLra97PTV0BGr/3Y2ozqrRXL7C2pSILo
	 +gXOJjwT2N001Z7uKrv5EZJ9Z+8JLG1fQB/0veNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCDOo0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:44:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDOo0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Mar 2020 09:44:26 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DAD820838;
        Wed,  4 Mar 2020 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583333065;
        bh=uKiNLVFgpNoNxtlTI4l7WNRrAcGQ8h1y7f4ZG2yWftA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nJckBJpbRQtZMzZeaJd5QmQZ7oiEodMkvUBWz5Os6ddrqiyM0x8BnbY7S0N3WzduP
         q77RTBF4uRaIN9OMHIhBr7Ahj2qLXBFvQheDd/6aPDH9XK2qNkbXnNUVDOlhZ72Kzi
         E8BPm5mrA196q2PwdPFJj74Pn2fZ++abTITczgd0=
Received: by mail-qk1-f177.google.com with SMTP id e11so1793208qkg.9;
        Wed, 04 Mar 2020 06:44:25 -0800 (PST)
X-Gm-Message-State: ANhLgQ28EiWT2G11Nx3j7eu11fqsurav8ATCrtz+rP64TISSEU2MrrKC
        4+f8MxlfDjwnKo+7OP6X3oolevXZlEkKj8+4GQ==
X-Google-Smtp-Source: ADFU+vu33UNp7iWZzTLTq5f0V0ldGIAyWHjMkXzB7UHEeMuowhUTqDVhlImIbXJ1QIz+xFMC6YKU9hGXrvWoCZ9XfpE=
X-Received: by 2002:a37:2cc6:: with SMTP id s189mr1679888qkh.223.1583333064226;
 Wed, 04 Mar 2020 06:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20200303134351.22270-1-geert+renesas@glider.be> <20200303134351.22270-3-geert+renesas@glider.be>
In-Reply-To: <20200303134351.22270-3-geert+renesas@glider.be>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 4 Mar 2020 08:44:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKpK-6Ud_MY6LqS5L0iq3ewBjdc+mJ15ig9jmYN6FuHA@mail.gmail.com>
Message-ID: <CAL_JsqJKpK-6Ud_MY6LqS5L0iq3ewBjdc+mJ15ig9jmYN6FuHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: Convert slave-device bindings to json-schema
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 3, 2020 at 7:43 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Convert the serial slave-device Device Tree binding documentation to
> json-schema, and incorporate it into the generic serial bindings.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/serial/serial.yaml    | 53 +++++++++++++++++++
>  .../bindings/serial/slave-device.txt          | 45 ----------------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 54 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt
>
> diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
> index d408335319f00215..7381966449b62deb 100644
> --- a/Documentation/devicetree/bindings/serial/serial.yaml
> +++ b/Documentation/devicetree/bindings/serial/serial.yaml
> @@ -7,6 +7,7 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  title: Serial Interface Generic DT Bindings
>
>  maintainers:
> +  - Rob Herring <robh@kernel.org>
>    - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>  description:
> @@ -59,6 +60,45 @@ properties:
>        "rts-gpios" above, unless support is provided to switch between modes
>        dynamically.
>
> +patternProperties:
> +  "^(bluetooth|ethernet|gnss|nfc|wifi)$":

A bit fragile, but okay. There's also some serial attached board
control micro-controllers. See the Zodiac i.MX board "rave-sp" node.

The only other way I've come up to handle this is:

".*":
  if:
    type: object
  then:
    ...

> +    type: object
> +
> +    description:
> +      Serial attached devices shall be a child node of the host UART device the
> +      slave device is attached to. It is expected that the attached device is
> +      the only child node of the UART device. The slave device node name shall
> +      reflect the generic type of device for the node.
> +
> +    properties:
> +      compatible:
> +        description:
> +          Compatible of the device connnected to the serial port.

typo

> +
> +      max-speed:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The maximum baud rate the device operates at. This should only be
> +          present if the maximum is less than the slave device can support. For
> +          example, a particular board has some signal quality issue or the host
> +          processor can't support higher baud rates.
> +
> +      current-speed:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          The current baud rate the device operates at. This should only be
> +          present in case a driver has no chance to know the baud rate of the
> +          slave device.
> +          Examples:
> +            * device supports auto-baud
> +            * the rate is setup by a bootloader and there is no way to reset
> +              the device
> +            * device baud rate is configured by its firmware but there is no
> +              way to request the actual settings
> +
> +    required:
> +      - compatible
> +
>  examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> @@ -93,3 +133,16 @@ examples:
>              power-domains = <&pd_a3sp>;
>              uart-has-rtscts;
>      };
> +
> +  - |
> +    serial@1234 {
> +            compatible = "ns16550a";
> +            reg = <0x1234 0x20>;
> +            interrupts = <1>;
> +
> +            bluetooth {
> +                    compatible = "brcm,bcm43341-bt";
> +                    interrupt-parent = <&gpio>;
> +                    interrupts = <10>;
> +            };
> +    };
> diff --git a/Documentation/devicetree/bindings/serial/slave-device.txt b/Documentation/devicetree/bindings/serial/slave-device.txt
> deleted file mode 100644
> index 40110e0196209fde..0000000000000000
> --- a/Documentation/devicetree/bindings/serial/slave-device.txt
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -Serial Slave Device DT binding
> -
> -This documents the binding structure and common properties for serial
> -attached devices. Common examples include Bluetooth, WiFi, NFC and GPS
> -devices.
> -
> -Serial attached devices shall be a child node of the host UART device the
> -slave device is attached to. It is expected that the attached device is
> -the only child node of the UART device. The slave device node name shall
> -reflect the generic type of device for the node.
> -
> -Required Properties:
> -
> -- compatible   : A string reflecting the vendor and specific device the node
> -                 represents.
> -
> -Optional Properties:
> -
> -- max-speed    : The maximum baud rate the device operates at. This should
> -                 only be present if the maximum is less than the slave device
> -                 can support. For example, a particular board has some signal
> -                 quality issue or the host processor can't support higher
> -                 baud rates.
> -- current-speed        : The current baud rate the device operates at. This should
> -                 only be present in case a driver has no chance to know
> -                 the baud rate of the slave device.
> -                 Examples:
> -                   * device supports auto-baud
> -                   * the rate is setup by a bootloader and there is no
> -                     way to reset the device
> -                   * device baud rate is configured by its firmware but
> -                     there is no way to request the actual settings
> -
> -Example:
> -
> -serial@1234 {
> -       compatible = "ns16550a";
> -       interrupts = <1>;
> -
> -       bluetooth {
> -               compatible = "brcm,bcm43341-bt";
> -               interrupt-parent = <&gpio>;
> -               interrupts = <10>;
> -       };
> -};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 59c14ee9a917a794..5f5d074c7b3927a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15034,7 +15034,7 @@ SERIAL DEVICE BUS
>  M:     Rob Herring <robh@kernel.org>
>  L:     linux-serial@vger.kernel.org
>  S:     Maintained
> -F:     Documentation/devicetree/bindings/serial/slave-device.txt
> +F:     Documentation/devicetree/bindings/serial/serial.yaml
>  F:     drivers/tty/serdev/
>  F:     include/linux/serdev.h
>
> --
> 2.17.1
>

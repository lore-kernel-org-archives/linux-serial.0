Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD7DC4361B
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 20:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85A922B51
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 20:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgLOUDJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Dec 2020 15:03:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40941 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgLOUDD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Dec 2020 15:03:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id p126so24703517oif.7;
        Tue, 15 Dec 2020 12:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OujEOb3VPBUeMwlgk0xuNnddMQc6/ggtdUHwl4fbzoU=;
        b=uEStWa/NzFWtaZKuUcxoNC7QLIBHKBCi8PCwAOTGtcRy4XzkMNBv4JBdqPyb7p9D/n
         GklKvp/n/btZ8HDADOtwl9xBWLu/+bW8EHFshpg2w+vjKL8iIMpQU+ZgxZQFEqoXd9Ut
         kmFVWWh2Tcwl0ekAP4wvLT14hTuO5yiLzDpP9pzan3Qfs1xACqLLYN/5zFiCPP8yaZai
         +zW+9j/Q26aT8rHR4fIgSKDtA+sI+Qy8H6sJtycYIYACC3OXJvRHslrjETEsg/q8G2gB
         kSGRk0mWSfQCPaPG+Vpf736DsgjM1AHMy/IQhuv60LMJdUPLwwTOiQc4IvDV4vjMkbg+
         L9tg==
X-Gm-Message-State: AOAM530DLuNegHqnbQ3UDifGcoautQP86CW+wGPBHKk7COWoXtayFDIP
        Om/6bbgoPDZB9PPFvhaSQQ==
X-Google-Smtp-Source: ABdhPJxhj1QiepA97wmPfcweVOfy585NuR9FLsDHk/Pp9lM9L8jwR19TYcm2kuWg18DX9ZNE/xCAeA==
X-Received: by 2002:aca:44d:: with SMTP id 74mr373918oie.4.1608062541672;
        Tue, 15 Dec 2020 12:02:21 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x31sm662665otb.4.2020.12.15.12.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:02:20 -0800 (PST)
Received: (nullmailer pid 118657 invoked by uid 1000);
        Tue, 15 Dec 2020 20:02:19 -0000
Date:   Tue, 15 Dec 2020 14:02:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Serial: silabs si4455 serial driver
Message-ID: <20201215200219.GA4148374@robh.at.kernel.org>
References: <20201215072004.GA12388@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201215072004.GA12388@dev>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 15, 2020 at 07:20:07AM +0000, József Horváth wrote:
> This is a serial port driver for
>  Silicon Labs Si4455 Sub-GHz transciver.
> 
> The goal of this driver is to removing wires
>  between central(linux) device and remote serial devices/sensors,
>  but keeping the original user software.
>  It represents regular serial interface for the user space.
> 
> Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> 
> changes v1:
>  - fixed: drivers: serial: si4455: coding style
>  - fixed: drivers: serial: si4455: error checking and order
>  - fixed: drivers: serial: si4455: remove unnecessary compatibility
>    strings from si4455_dt_ids
>  - fixed: dt-bindings: rename sdn-gpios to shutdown-gpios
> 
> changes v2:
>  - fixed: drivers: serial: si4455: coding style
> 
> changes v3:
>  - fixed: drivers: serial: si4455: coding style
>  - fixed: drivers: serial: si4455: replace device configuration procedure
>    (SI4455_IOC_SEZC ioctl call) with request_firmware(...).
>    The firmware name comes from dt (silabs,ez-config)
>  - fixed: drivers: serial: si4455: replace transmit/receive channel
>    select (SI4455_IOC_STXC/SI4455_IOC_SRXC ioctl calls)
>    with sysfs entries (tx_channel, rx_channel).
>    Initial values comes from dt (silabs,tx-channel and silabs,rx-channel)
>  - fixed: drivers: serial: si4455: replace package size setting
>    (SI4455_IOC_SSIZ ioctl call) with sysfs entry (package_size).
>    Initial value comes from dt (silabs,package-size)
>  - fixed: drivers: serial: si4455: replace getting last rssi
>    (SI4455_IOC_GRSSI ioctl call) with sysfs entry (current_rssi)
>  - fixed: drivers: serial: si4455: remove si4455_api.h
>    and custom ioctl definitions
>  - fixed: dt-bindings: silabs,si4455: more detailed description
>  - added: dt-bindings: silabs,si4455: properties silabs,package-size,
>    silabs,tx-channel, silabs,rx-channel, silabs,ez-config
> 
> changes v4:
>  - fixed: dt-bindings: silabs,si4455: $id
>    from http://devicetree.org/schemas/serial/silabs,si4455.yaml
>    to http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml
> 
> changes v5:
>  - fixed: drivers: serial: si4455: coding style
>  - fixed: drivers: serial: si4455: remove struct si4455_one,
>    members moved to struct si4455_port
>  - fixed: drivers: serial: si4455: fix line endings in dev_err and
>    dev_dbg messages
>  - fixed: drivers: serial: si4455: remove unnecessary else { ... }
>  - fixed: drivers: serial: si4455: refactor si4455_do_work(...),
>    xmit circular buffer handling and start tx moved to
>    si4455_start_tx_xmit(...)
>  - fixed: drivers: serial: si4455: refactor si4455_configure
>  - fixed: drivers: serial: si4455: refactor interrupt handling,
>    remove unnecessary wrapper
>  - fixed: drivers: serial: si4455: modem line(si4455_get_mctrl)
>    and tx buffer status(si4455_tx_empty) conditions and signaling
>  - fixed: drivers: serial: si4455: remove unsafe int to pointer conversion
>  - fixed: dt-bindings: silabs,si4455: $id
>    from http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml
>    to http://devicetree.org/schemas/serial/silabs,si4455.yaml
>  - fixed: dt-bindings: silabs,si4455: serial.yaml reference added

The revision history should be after the '---' so it is not in the git 
history when applied.

> Signed-off-by: József Horváth <info@ministro.hu>
> ---
>  .../bindings/serial/silabs,si4455.yaml        |   98 ++

Please make the binding a separate patch.

>  MAINTAINERS                                   |    6 +
>  drivers/tty/serial/Kconfig                    |    8 +
>  drivers/tty/serial/Makefile                   |    1 +
>  drivers/tty/serial/si4455.c                   | 1372 +++++++++++++++++
>  5 files changed, 1485 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/silabs,si4455.yaml
>  create mode 100644 drivers/tty/serial/si4455.c
> 
> diff --git a/Documentation/devicetree/bindings/serial/silabs,si4455.yaml b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> new file mode 100644
> index 000000000000..ddff67e6a667
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/silabs,si4455.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Silicon Labs Si4455 device tree bindings
> +
> +maintainers:
> +  - József Horváth <info@ministro.hu>
> +
> +description:
> +  This document is for describing the required device tree parameters for si4455 serial driver.
> +  The si4455 driver tries to represent the Silicon Labs Si4455 sub-GHz transceiver device
> +  like a serial port. The required parameters for proper operation are described below.
> +  https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> +
> +allOf:
> +  - $ref: "serial.yaml#"
> +
> +properties:
> +  compatible:
> +    const: silabs,si4455
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    description: maximum clock frequency on SPI port
> +    maximum: 500000
> +
> +  shutdown-gpios:
> +    description: gpio pin for SDN
> +    maxItems: 1
> +
> +  silabs,package-size:
> +    description:
> +      Radio payload length, variable packet length is not supported by driver.
> +      This value should equal with EZConfig payload length.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 64
> +    minimum: 1
> +
> +  silabs,tx-channel:
> +    description:
> +      Radio transmit channel selection.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 255
> +    minimum: 0
> +
> +  silabs,rx-channel:
> +    description:
> +      Radio receive channel selection.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 255
> +    minimum: 0
> +
> +  silabs,ez-config:
> +    description:
> +      Radio configuration data file name.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    items:
> +      pattern: ^[0-9a-z\._\-]{1,255}$

We use 'firmware-name' property for this purpose. 

Looks good otherwise.

> +
> +required:
> +  - reg
> +  - interrupts
> +  - spi-max-frequency
> +  - shutdown-gpios
> +  - silabs,package-size
> +  - silabs,tx-channel
> +  - silabs,rx-channel
> +  - silabs,ez-config
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      si4455_0: serial@0 {
> +        compatible = "silabs,si4455";
> +        reg = <0>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <7 2>;
> +        shutdown-gpios = <&gpio 26 1>;
> +        spi-max-frequency = <300000>;
> +        silabs,package-size = <30>;
> +        silabs,tx-channel = <1>;
> +        silabs,rx-channel = <2>;
> +        silabs,ez-config = "si4455_spi0_0.ez.bin";
> +      };
> +    };
> +...

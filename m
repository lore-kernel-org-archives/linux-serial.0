Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08713B2AD
	for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2024 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364784; cv=none; b=H6ksI0WP3yLlm5b0HcwIbRB1AJLv2lw2kLOr6DPfs4AZftiiR1p2NkGxU/MoDFATlAzXu3zHX3jDvs0I9Cu1fMFBjwH3R2D6uphXuexHBazWfrWY1CHBkXz5yrkEkUDqDjLOGDRX9sLR/TDxlG9ZUX9wMi53uXU97xd4BjySm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364784; c=relaxed/simple;
	bh=1zgSzz3jfz99v5f0YhtznF9yd5rSOj7q4PJu1k5xWnM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=EnieTY/MGzP2PYM+0+jJymxCoA/00RX8PMQtBJtKV6N1mNvnsB9Xiu7P9AlRXZj4vTDH6J9DT0Gv4AujDc21noIAOSL+SLytWRUdbA1cDau/EXfGNhFHrGqPehZyOcdO0XgsXWDWInW2QwAsamPAh5oZGWQlrlCum6N8+ceds8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=gNI7Ja4Z; arc=none smtp.client-ip=185.58.86.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="gNI7Ja4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1718364780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0ydGSAkjaL7nI5gcYzQKY03XTshCFOCF7AH9qjPGVY=;
	b=gNI7Ja4ZBWUDSceb6csEWwQHe9Omwr1QgRUTOFPTBMciPVTiuRdEDknX8Mf2zj+HfDT224
	MA7nAsTwm2nP6PeOQLiXXt8YWoWBD0oB0OFE0y7u2cX4RUNGI24E+SD6X3yZHn2yYntcRB
	Gd0EJLMQwLnI2OgK20QEQZjSXbIuurE=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2041.outbound.protection.outlook.com [104.47.85.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-323-CbU9F9AHMcKNxP4JhWDJiQ-1; Fri, 14 Jun 2024 12:31:17 +0100
X-MC-Unique: CbU9F9AHMcKNxP4JhWDJiQ-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LO8P123MB8051.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 11:31:13 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%4]) with mapi id 15.20.7677.026; Fri, 14 Jun 2024
 11:31:13 +0000
Message-ID: <34b415cb-871c-4baf-acb3-566615734091@camlingroup.com>
Date: Fri, 14 Jun 2024 13:31:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
To: Hui Wang <hui.wang@canonical.com>, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org
CC: jirislaby@kernel.org, hvilleneuve@dimonoff.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 Maarten.Brock@sttls.nl
References: <20240614102952.679806-1-hui.wang@canonical.com>
From: Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <20240614102952.679806-1-hui.wang@canonical.com>
X-ClientProxiedBy: WA1P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::21) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LO8P123MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecad2ef-b562-4c25-69ba-08dc8c657ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jhzqnfv9y4B4BIC9OPoaV+CPizlB4ytCCn1W2FQaoNlDtIWzJ2QLFZA9rgWa?=
 =?us-ascii?Q?MmLSKCFMBDgylU7h8zhEaNlvX1k68mUQz9kiGdqnmnNoHScfKfvafrbu7tyK?=
 =?us-ascii?Q?QSlS1DJqDm/8GPRIzUEkxxwlINmsVkdjpvjXabWcolGvcyGG5jmL6ZEP08wQ?=
 =?us-ascii?Q?ufCx1PLzOk4meZJIqCJHEf72LORaYydS40dNJkK2C7+AzRiP2/L2keNhx42x?=
 =?us-ascii?Q?dsn3YAovaChosug8Ixdn30u8hWW3N2wPIv0KD8aU+UbMuohe0pGiQRW6FXbY?=
 =?us-ascii?Q?abqiaGaKEQuaIOgQ4dcpPgLXaQhbiw63KFImIq8yOz2MGGNcrjsi2iI8M4XY?=
 =?us-ascii?Q?6LZ17XH7y+PTQ2o+HTJ8OnOEesKOcQASdxjt1+dZ2BuY9uCh3mOvt2BfcaB7?=
 =?us-ascii?Q?YbNn5TRNzZXEaziDyl/WIVWGwQN5xRMx6ZvDm6gvOrDQF9tfA65RaLSVd2gt?=
 =?us-ascii?Q?urFodHAcnuXFp0fWVqncOcxgPNxuFYUXVUgP9SdsPhqJvwySPGT2HwSsTbCi?=
 =?us-ascii?Q?gaDOpXwChWrHKQ37xVuTON5RoZ0cgvGb2AmwXncvyIEoFD6qVy7GsOfPEfxO?=
 =?us-ascii?Q?j9H6JAR29mrZ3B1z1CwhBeULoaatf8i7Div3uHRsFWS/Oi+MygpkD/QyPOoK?=
 =?us-ascii?Q?/gI2z5xkSQCP3MbFIBB9gyyOtjQBgWfTuTjxFYBT8CMHYvmv9ngtDRNxofSk?=
 =?us-ascii?Q?iQZ9lL5iFq7dokJRIuV6j8fzZYz71yo8Ix1Tq3SvCnSJmLCriEdQ8fD7fsos?=
 =?us-ascii?Q?evkjEQhSI9lZnE19TxIR/QtwGA2arkcKQRMXs3BWV9GkslcnYlbBU6VG8ILi?=
 =?us-ascii?Q?rlYjDBpBSmTJaRDHkaoN3NldnOchhTNUvS8PoP7F0xO7GyNHnmU4C4dA24hz?=
 =?us-ascii?Q?Xyj8umxOZyJ5v2aXLEKTa61euHsHKVYYgUK58E4P/0doFQslqoACkDGBbcMw?=
 =?us-ascii?Q?5pfirQV0KvYN+g25rndbvY8ir6w+4LHcc93DECaTTs28FOpSZ3yG9zfisNAu?=
 =?us-ascii?Q?EXzPxk0UltZa97E27FZx8NLUipVlTVnCPZeLQJrvkrOPgC6zNptCaKtajK8L?=
 =?us-ascii?Q?GP+nNo6yyucQwm+Jq+PzcnIuMF63yiLwmjDVaCUw/yKepH1kVhpHDToqUps+?=
 =?us-ascii?Q?sqs9HSDgZ7zc/d3RY4JD7Ze2oVp1Z0vZDafo+v+WRPEbNZBCuM9m1ldOi+Ir?=
 =?us-ascii?Q?gxBUUEi1AsEPwQ9QOFQ7k26NrBkWajSBsAjrmv2GC1K45XoFP1E55TJWKohe?=
 =?us-ascii?Q?J8hcGsddBTY2Q0QAlsjc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HNj0dxa/jKptxfrNypIj32oIrstxNHjOypp33/wihQNMnF6Dsb9gb+Gx0O2R?=
 =?us-ascii?Q?wglh3/W4dEI85qG6KBVSnM1kgIj5x2UoaVZfCJ8boNndbVKNkIqZQsAVKZEl?=
 =?us-ascii?Q?bbfGfWrIPQ7ErfKfxXfBgIYyu+Nnrr6O0uRmUXBImQr0wX+A/Fe/rRF1hwCE?=
 =?us-ascii?Q?WL0Uqsu5u+AJ2ECAAlcZ+K5Vz+UsZpvEDIe/Fyz3Sitauc07Am2/eAaoW3hG?=
 =?us-ascii?Q?N6vncvdeApjzBMDZX4YR6GxgQkepgi2NetCycSGH5gIos93EbgNvJwBpdzPI?=
 =?us-ascii?Q?2YcM7H9jnQC+Cx7P618l/jvhuzHEMCaN81OY00xRUUbxEMxvP+Gm71RuLXwt?=
 =?us-ascii?Q?hbgucDqtfKH3q5BJMkwVLKmyuhc6byWpL2UW9sq8fPtBI7APrbGJ5ZcEWaOv?=
 =?us-ascii?Q?tNvLDUDekTqhY8Z5v6Ntu7JLfUqbB/0Xb3T2zUEe+6R9eFDCVhWDBB9GAx03?=
 =?us-ascii?Q?UfmP2G3oGdC8GdzFE4nc4nPEPG45vDc24Lujsb9sFdtHKU4+hvF33f0jxWUi?=
 =?us-ascii?Q?CyT8oTKMWuwyTIMvQEuD1vdJcb38lxRTA2050gp3B2ilWdSUA6/GepgHxmFV?=
 =?us-ascii?Q?DeZU2dmYuR+98AswSpEYzfwwyjWeCDKhuhnQ5FxDBcybxXZQo0Nkx7jAp+s8?=
 =?us-ascii?Q?PxtgO5sF+q6Wq+sd9ofh7paMmZZj6EK3HNH5IsoKeUVr/Fxq6BP6vTjStMx9?=
 =?us-ascii?Q?BZUFEYe5Ln1bzsRkSJLMa+pIucaywvJ4vW1gukAIGvNUZh4i8Wmy5xb/oVjR?=
 =?us-ascii?Q?JiDsRyERUUUlzStkExG4u1TTmPn1onPlnX1ffuNk3NC4CAigr+NR0QB88yky?=
 =?us-ascii?Q?3VmoS9AqUq8+OvICGVDoCoGuQGWPQpt/xFCM+jdtxHL2qu9jhtDYe8PJG6nN?=
 =?us-ascii?Q?Gbz5bzLFCMhwtQOYKfH+zVD7pqrKY5t/M7pFRYJq7ENzW/Av/sEYqBTnI214?=
 =?us-ascii?Q?0czlxwdADrzZK6xKpQ0hdh8sXisCb1A9XVNyrlccq2Jc5KaPgrVIdNPGqqgm?=
 =?us-ascii?Q?BM3xHxlhkEUvW/ql3ky1swaZPrWsM9qq0eIm1JnMp7Zn1r09NZ6Eks/BLNVh?=
 =?us-ascii?Q?T2lucW1CogHu+wnUzU5TKDIOsP+8pFFPyenNo4OO6uF4DGw6m1X50m6cZMRq?=
 =?us-ascii?Q?/b5lfKGIko7v0B1YfetMMM2ifJN7v3PfkbSwCXrQeYpBdotrQBxB7SnjQFra?=
 =?us-ascii?Q?nE3gPnEvfZScFuqMPN5Q+YJLNiT7GQeTAmg/i+TP2qFnB2LnJBHyeuQchmMn?=
 =?us-ascii?Q?ItmxG0IIEdFnsY4sBDMF2+2tvzmqi8qgJo9WrAABldk5OtxxiUAB1u7NG+s0?=
 =?us-ascii?Q?2VodJcHOH19kbNHf+K2wEFEatF1TS38m6mKZlTsSvG/raZFD02kUL7EzBel5?=
 =?us-ascii?Q?q1e6P9PnEBXWN7iXmGGg5gaa1oOrm58x8lV4i0tFlrbtSxqAxHwXrkuoOvWv?=
 =?us-ascii?Q?cJDz/BnVg0UyA7SCWPPSK5vy0ymNCKtnHijvWdF7cZQX2+rFGGxZ5wjEQv/3?=
 =?us-ascii?Q?iY0xOI2Knmt6A9XxTMYszDa1TsVOx+uUQOJv12lXHQdjhhePT0GjOp6hhAYi?=
 =?us-ascii?Q?JUUlocLUKOjq9LsTrAYgab8+a5cogib2R5VEDbrD0aDpm1MwQaDMCG61GLXF?=
 =?us-ascii?Q?AH/i3laWDWlAiGPklLhv8L85qqO1yy/X3s4acwDNSeRbT2oJ3Qq9jxDYuwLa?=
 =?us-ascii?Q?+LJZFw=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecad2ef-b562-4c25-69ba-08dc8c657ede
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 11:31:12.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOioBz3Xm6qEVW/B3s1tyY464loKF3wurO9N5kxPyI5GxbkbU0stgQzUoC3tjJjM2B6QmpQvmP8cHiJxSsSAHDA/sdm29MNqEPsHot2LeXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB8051
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


W dniu 14.06.2024 o=C2=A012:29, Hui Wang pisze:
> In some designs, the chip reset pin is connected to a GPIO, and this
> GPIO needs to be set correctly before probing the driver, so add a
> reset-gpios in the device tree.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> No change in the v5
>
>  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml =
b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> index 5dec15b7e7c3..88871480018e 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> @@ -28,6 +28,9 @@ properties:
>    clocks:
>      maxItems: 1
>
> +  reset-gpios:
> +    maxItems: 1
> +
>    clock-frequency:
>      description:
>        When there is no clock provider visible to the platform, this
> @@ -91,6 +94,7 @@ unevaluatedProperties: false
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
>      i2c {
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
> @@ -120,6 +124,7 @@ examples:
>              compatible =3D "nxp,sc16is752";
>              reg =3D <0x54>;
>              clocks =3D <&clk20m>;
> +            reset-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
>              interrupt-parent =3D <&gpio3>;
>              interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
>              nxp,modem-control-line-ports =3D <0 1>; /* Ports 0 and 1 as =
modem control lines */
> --
> 2.34.1
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>

--=20
Pozdrawiam/With kind regards,
Lech Perczak

Sr. Software Engineer
Camlin Technologies Poland Limited Sp. z o.o.
Strzegomska 54,
53-611 Wroclaw
Tel:     (+48) 71 75 000 16
Email:   lech.perczak@camlingroup.com
Website: http://www.camlingroup.com


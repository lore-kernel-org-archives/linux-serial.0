Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022104.outbound.protection.outlook.com [40.107.149.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C51D95A3;
	Thu, 21 May 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370254; cv=fail; b=OQP1EGGtGFmoG57lAuHKEHg+o9lvVPSvUQuUndCO2Tnka6umSauYOGcpL5d5jEvceyUQqZqp7mr650g8UOuN6OvnROZFiLnKLrVsVlVS0lM8Xf2Ibd2ugIqME3VTtMBNaQyq1ixkUxsGWYERzSlbmrs9XABq4EWmc8F5/F/Fibo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370254; c=relaxed/simple;
	bh=sfuQnb0Af9oGEnEHq8ck/MgEWHEp+GgXWWBgHrP7ZDY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MK1cXxVDpWzlLYvp/NYMNGJMOoYspg7tg41X03F+f11ieVibc7/s0WjgFquI8vGkf+KmaewDmVjNX21jFWgtukLpgMNhwAw2vApIGBrsc9dlpKu95Lwf4wpQ9G0wtis5VkBYjAwinKKEVVh+XEaSplk+w967QmOTkqPQWFhpBqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=KBSgmbhfr.onmicrosoft.com; spf=pass smtp.mailfrom=KBSgmbhfr.onmicrosoft.com; arc=fail smtp.client-ip=40.107.149.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=KBSgmbhfr.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=KBSgmbhfr.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1PYpJQOIVJMjnOGLC9rgDGEqJZBZoJ6QkFpOOCtQEepCrow/5LFQqJtcH4bISaiGlJyaKJUkKtStQhG4Y5wlsr9ln+Qfc/aDSnov8zI65f/WeY4cu+WfUvX37wMk35ty8r8dF4z7pzhzcdOIyNUnnZdyxqtmRtso/7sLzbNrpgZFJ9r4pCzo5OJL/PoOdqIJOILiFIWRcxySU3jnff8hw6SYuOPMj7AQh7vrCtZsW7fx56h91reX5IM2W9uFuMBYT4uxNiqg9OvgoY31CfrCHE73pdj1BKHJYfZVS+jGFkxpSjJtnYXsmvYG2kV6b3iykGWF7mX+b/Qg2JrcvAdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPPTxITlKJnqh8oIoeT9t9RH3H93FOdJg8/QsSnzxUk=;
 b=byEUnq3Oso2cs7Rji+IttGWGvebaKLCGAnuw5+I0wBsS0K4icneeZYYOQPf31G7k8NVParDGcMU0ZH4f3yZJHXS/Hn7+RPSKDPcyDnLijsHwPU/oWEBA/+WGyDOJq+5PL2Ztre9PVwF8nhOe9i18td9bLYACrdH27niFa7R0lMhF+w64bPbGSjT8vDzWA4kVS1bUa7V8VAHUUhggWHW7bWc6qnb5rFiv6gLHd/enFx/RgkdHzp8qReUCvVL8Ba4m1y68kNXblAnXKuK94vGQiHaXzo8584+AswPHpia2wXZ31yqKKjOhDqVbUZf6KOo2l3OkXqnugDBdyXjpij4nwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kbsgmbhfr.onmicrosoft.com; dmarc=pass action=none
 header.from=kbsgmbhfr.onmicrosoft.com; dkim=pass
 header.d=kbsgmbhfr.onmicrosoft.com; arc=none
Received: from BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:de::17)
 by FR6P281MB4189.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:12b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 13:30:50 +0000
Received: from BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fce2:69d7:2d84:7d9e]) by BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fce2:69d7:2d84:7d9e%3]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 13:30:49 +0000
From: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"k-willis@ti.com" <k-willis@ti.com>, "m-shah@ti.com" <m-shah@ti.com>,
	"msp@baylibre.com" <msp@baylibre.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>
Subject: [PATCH] serial: 8250_omap: clear rx_running on zero-length DMA
 completes
Thread-Topic: [PATCH] serial: 8250_omap: clear rx_running on zero-length DMA
 completes
Thread-Index: AdzpJZP0Qp87CwkjRbaIwjeNriIcog==
Date: Thu, 21 May 2026 13:30:49 +0000
Message-ID:
 <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=KBSgmbhfr.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE3P281MB5515:EE_|FR6P281MB4189:EE_
x-ms-office365-filtering-correlation-id: 8b33eeb4-1014-4180-e24e-08deb73d2c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 F/8uSA+ptjpH7rTo5I6HqMNzER4PcU7QSW9yFQYI2GFM08SBtj556qrHEMZryAg5iIHlxRb316O2qgzlApc/DZmEmoKa/PVIgDyFMZuXOw2/hB7JwiTr1bXSnGaV/2cpPtylaK4N/OSZdm0y6+kZPmo9BDGi/tJBM0443u5bfo2PpbMoixP2FQy+K3+ugwMe/L9TDI5PUgK2PeqLW0/jG6vzjnyEevv6wRrRFeMIPZcF2IURg8uTGcmHy+2SptDSzvlWzlWPhiXto6Rm7B3K0HwIzz/jKQo75F/3L+fV8z4TeF9Z76sZlpzNF9IrmQGjxKSw1MFKj27A2NAe4woyvwLKQU3PLVzVmwmNMVlKAnEiXw9ea6dvMf7BC8G7L2b7M6ooM/pqeopFCwENz8tlzEdHkvxxryAEw5MfrbSZr/RjelDOELcMDfLgoeGG1xSUn0rAQqrKE4AJd4JEFjKLBtzxAbHqVnjTjW0ddL1MHpcCe4I8fqcyzWzlwINMxBavW7Z32Fk1feXAlcTI2bCsatrpJhAPoNQzyqmo3/Ayc2WDMkffLpwGxyy9Ts6p8GBRIIr5zRfO5UDD/SOxa+g/2DhEh9VKJ014djUY/2ZbbrvTKlMLq5e3JlufxM7tZOxLYRhuSCBgQ3KwBsMcH282RRHQACQfQWDGoH9UyBqu+S4vgZCsQllEjXacej7biNioPj8prhhPjfk8oGATHdDebkcZZO/wg8EkmEjbdxReZebDXLP9TjA8Z1RReS+wpIe9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TVMOTVpVk0QBQk+JkL602LI8LwBGA+7evsSsVsuloj2VJJJSmtmiRG+HTjnC?=
 =?us-ascii?Q?QzTQ5KjklRWyffcv2BpkvXW7q5eHsiiZa1jI8YsNRwRkeskcfFb6IQ6uyhKk?=
 =?us-ascii?Q?7gIO1Q1YrL0Jfx6x6bgIjZFhJXOysVJ947JollLp9VniDX14HL93wobWSg+u?=
 =?us-ascii?Q?gQcvo1Jk9Vjcmx16i1EYMNCb+K2qsXKvAUA/XjLrdPRBlcF3kWLblPHl0iAw?=
 =?us-ascii?Q?rkId5ddQKDxd8RmXBUC3+TDE5XMP+aJMcWN1ryhrc9XiBBJWVWG7RXMR+qe1?=
 =?us-ascii?Q?e3o3smhTcPJUTGW29X47oiNeq+NecejLT7DSaTVtN/mPfp7rDnWdo1CJMJwZ?=
 =?us-ascii?Q?a43uo10oGKOZmXdwsRaUzKfi/gm4Be4lx8OfsJuMt5rK2oUoV1zl0S41w80E?=
 =?us-ascii?Q?FcIwdc8oTOUXR1QtmEioVu7Zb5OxDnRCZBMdFJE+Gpxnm+xxZeKYn+VFLZbg?=
 =?us-ascii?Q?y23H/jS6Y0PkJBOvFbHRwzqHuMDJZ4Z+yyymEY6vmt/4ZcRRqV0fm5xJSazp?=
 =?us-ascii?Q?oFgKWdnkmQXiXbL2T8tG8AcnYfqVIeN+OsEkGTLnIzFiF16SN8S5S0Munrqh?=
 =?us-ascii?Q?Yzzxy8404EUtNuOzpUR5IPBwqvG27Y3o75Ko0MUFU92YxLf7UIOqX9UHw8lV?=
 =?us-ascii?Q?xeAo9+uQiKAVVs+gDkEqEodjPzztCLO5z0L0ilpBSl93tnJPUQuwm7jR7utS?=
 =?us-ascii?Q?tCAmUt55KR3jgOUzDeJ1bcCI90mIW7Cd4iQCpB5W99dW2hLWWFFdP/YrCKxO?=
 =?us-ascii?Q?A64130kPD8f2fbusRG5m4ZDrj0b3GtLcjBjCtkXSCDABlyPRu2bXURSDy7Bo?=
 =?us-ascii?Q?0yWmmge70pNuhXYdPt34AVU2LaXBfTMGgnODJHyQuQ3c9ZvBwM9A5oQQ7lZk?=
 =?us-ascii?Q?msZ2H3ihN25FSlN8Lpxp4mlpbLAhr98V6vI2gVczVzNQfofKEHfcvm2NMcv3?=
 =?us-ascii?Q?cQjF1DR7/fA14sUlmzLzD6TU7OW3142y2HSCG2scPN4IAR5U+lcS2D10G/uB?=
 =?us-ascii?Q?X9Tq9vSiRBmMiJEzTopAoqmuUzROuAc3BOnVKsyD33++AxfdWeEU8SOb12lT?=
 =?us-ascii?Q?qf+QLwQeOl8RstVhyu9qEvGPhmLrIbdaQzgTjJ3Us67eigqu+6bRhKJvZNVy?=
 =?us-ascii?Q?fok46vLN82DtuxQakdGUrSqxsNwuC45gcgXQUcQEN0ZMU8g3BPLtuksANnDX?=
 =?us-ascii?Q?P/0LO6ZlJ1b3GcjMGF8YW/1Br10tK0pgreww4FcDicq9Qq8+m3c9rtW0YG3O?=
 =?us-ascii?Q?R58EUOqk0OMMh4ibpxFWvCEE5aE/dzCOvgaBdhiQ0cuL2yFi9C3NMT+pbunR?=
 =?us-ascii?Q?iQjkRo8WGJy1KGflPvzRCCnuey3CP/dbD20UCXRxfJJFlYGyP+gc/mdshUaI?=
 =?us-ascii?Q?qwkPHGYsehId+jWyKorDNJuBREBk1Bn5ByDh4X6q/yi011krx7JEbE/N3Y9I?=
 =?us-ascii?Q?N2fHwL+jFepUD9fUIWBjISDnMsH0yx4/ceZOierJxUKoSBdaXxH2YIDKYyvu?=
 =?us-ascii?Q?prAKCdmyGPKyBqLCKFmd1YyDaaVjvYQR8RjbseO2ziDQJ4RRnyo0cTodTYIr?=
 =?us-ascii?Q?lB7gABZvhsNUGND99aP+u0G5TsivFa5pz5K/JckGuh2oUv7Qw9J+j02VZGhX?=
 =?us-ascii?Q?1apAaE3oqPwrjmhtbOFuira8FL6rMfZJxziUwDBvfwC0WdIeA+bYIKTfJl2O?=
 =?us-ascii?Q?TFzkNjsNlYJWQY8igw2sqRN8PFDffs4v2oUzbG45N/kqtwTYhKI6s/RpMgfv?=
 =?us-ascii?Q?XDUGetYIJg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: KBSgmbhfr.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b33eeb4-1014-4180-e24e-08deb73d2c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 13:30:49.7968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f174257-ca3b-4127-8fed-91fa39cecdd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gSxqu+E0U31eZergO0EqTyqRdIHiVlXpA36UnJDCtdlkk6lazH6TCuzqjHo2ohuGeA9wFIQDQxnT3WKn40/YsC1OHe3okAShaD7HiyivO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB4189

On AM33xx RX DMA only triggers when the FIFO reaches the
configured threshold (typically 48 bytes). For smaller bursts
no DMA request is issued and the FIFO is drained by RX timeout.

In this case __dma_rx_do_complete() can legitimately see count =3D=3D 0.

The current code exits early in this case and does not clear
dma->rx_running, leaving the DMA state inconsistent. This can
prevent RX DMA from restarting and may cause
omap_8250_rx_dma_flush() to fail, marking DMA as broken.

Fix this by always clearing dma->rx_running on exit.

Signed-off-by: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/=
8250_omap.c
index c552c6b9a037..686e54859aa5 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -948,11 +948,11 @@ static void __dma_rx_do_complete(struct uart_8250_por=
t *p)
 		goto out;
 	ret =3D tty_insert_flip_string(tty_port, dma->rx_buf, count);
=20
-	dma->rx_running =3D 0;
 	p->port.icount.rx +=3D ret;
 	p->port.icount.buf_overrun +=3D count - ret;
 out:
=20
+	dma->rx_running =3D 0;
 	tty_flip_buffer_push(tty_port);
 }
=20
--=20
2.39.5


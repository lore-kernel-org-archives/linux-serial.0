Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020125.outbound.protection.outlook.com [52.101.169.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACA33CEBB;
	Mon,  8 Jun 2026 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916450; cv=fail; b=P6nDC5ishftPqyQ2040SofiZXY3D9xvUXqKa6cZs7xtXJYpKiU9AW9nd7XebjVFwJQ/Zq27o2/5s3a1K5lfiHvYoFwmBwdMBDBSnlrvzLePGWjSG2OzJUhdKo1hJIzafabhOklfeEA1xmeC4zdj685jew4LOB4sOn/9EnOxlxV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916450; c=relaxed/simple;
	bh=TLy4pFL1u6IM33YWudknRNR26Ribkc+r6OQvyrky81E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fD+KMYkBOmMQBnxkEmPu/w4H5c7ppn4fWVCYNBOmgaE3N7VTKo2gplhRkToz0jo7iJCTzq07q8kYb7Yb6OdJFYiiayhM6eBD9u8eHpjHLcUpvPtqAnhQTSBEgAawANbupOM1bvXVxlN7WXGg2DO4PogGudIKWgRg8wINgceq+80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=KBSgmbhfr.onmicrosoft.com; spf=pass smtp.mailfrom=KBSgmbhfr.onmicrosoft.com; arc=fail smtp.client-ip=52.101.169.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=KBSgmbhfr.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=KBSgmbhfr.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmIhy5BInHUKTcEKJ91JjG7P9ssLELAlANXpsDBfdO11zN+1UcUOVIQRh1tKmbE8PamnKR9ta+jxK5sLfa2KAnsAtVozKkKi8nqlSLuUImZmhrvZWz9wfF4fDn539USEASdEEFBQuAxTNQ0e4+spWH410qI7zIcmiJz/jxPSD+cOKyuJDmpCJFnNc2wlfdQgmGr0LF5TkOziLGYRwO0X8qBtdqTgCUIJhgDt6tVbZ/985oh4NFaRqXK50GpKx0nCWCPOV0k8kI/59j73T8/6Qq6UMO8pPk/0BDlOhLAqAE9+spJGkXV6U1CRx8q9C2Q17FhP4qYXMCqHdhFpqCM/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLy4pFL1u6IM33YWudknRNR26Ribkc+r6OQvyrky81E=;
 b=hB8rzfhSoj90uPuIsE2u0z5FqlpG4ypa95hJuJuxnF6wl27i/TYVVRPyclLJKSy8HrAbbsNLD6C9Rim1l4eWgl32emp+CPuh/qFLoY1iMVs5Ek2WM5xBzYC9EFaQkgd9+Xjd9m4l5RGqnJkbqD0ECWdwo+6b8sAwgDgSacPSmzxFyUpurr1iZP7VgeTZP2dDBovLORw80+aA3IEjN0VxXsrwpg1SipsvCPeP1OlW220Rx41HfzLvNjOiAcYpWsZ0NPgy0sl2eUCXZFw2KxjCXRxOCd6eob5uEcw9sm7K2YjaxotUQpGRKJL9MvM6ABmxYvfJTnrxzf9DAwY/+AMMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kbsgmbhfr.onmicrosoft.com; dmarc=pass action=none
 header.from=kbsgmbhfr.onmicrosoft.com; dkim=pass
 header.d=kbsgmbhfr.onmicrosoft.com; arc=none
Received: from BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:de::17)
 by FR2P281MB2762.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:38::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 11:00:44 +0000
Received: from BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fce2:69d7:2d84:7d9e]) by BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fce2:69d7:2d84:7d9e%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 11:00:44 +0000
From: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: Moteen Shah <m-shah@ti.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"k-willis@ti.com" <k-willis@ti.com>, "msp@baylibre.com" <msp@baylibre.com>
Subject: Re: [PATCH v5] serial: 8250_omap: clear rx_running on zero-length DMA
 completes
Thread-Topic: [PATCH v5] serial: 8250_omap: clear rx_running on zero-length
 DMA completes
Thread-Index: AQHc7OItt2o2LMDBtEueXc02m0/NX7YrpAmAgAjspbA=
Date: Mon, 8 Jun 2026 11:00:44 +0000
Message-ID:
 <BE3P281MB5515D220F1679A21D35D9619EE1C2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <4b8c59fe-c6a1-47cb-ab3b-855b1edddde2@ti.com>
 <BE3P281MB55153573889A8124C06291F1EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ab76b900-6d1c-4218-a14a-59541b92f2c6@ti.com>
 <BE3P281MB5515A937D47F610974FAEFA7EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ede98ffc-9e34-46a5-8d8f-87894fbf9d12@ti.com>
 <BE3P281MB55155F2F5795E411F5A65282EE0B2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ah8i-aGuHTKcRpaA@ashevche-desk.local>
In-Reply-To: <ah8i-aGuHTKcRpaA@ashevche-desk.local>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=KBSgmbhfr.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE3P281MB5515:EE_|FR2P281MB2762:EE_
x-ms-office365-filtering-correlation-id: de7330d7-efd6-4031-bb54-08dec54d3001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 UpBsA/6Pf7usMi6aoQsAurR1+RQa962g9ZccDNbUqWappu++5YCoyoiwYeqHJZizxS87avQjg7bEEnZzr2sRsYNze4U9vWO10ZdqT6HL+BnH6TJEWXLIPA/8qEhHQQH0O01IUVhO14sd5yy77yk7GR15L2NE63enMV4ObhfmFRhXUv/UldhDsgzRp/WX9RrQZMo8ePKoWu6TuS6VS7LMXgPdvv6ijAdu7NYdNy/79p2o/NBzPStp24iTvVapeS10/1aFSVXmthD396mJ/OR6XoV5852USAk2NB/nXFWj1QhCeWuy3Wj/9d4L6zkXYPJJKv/FQ2mu6Ha2DNDv58NX+KUbd1sUbxjLxHUoI0p1buYVYLCpAfyQ2CxW4z2i7kynBwOQveBPq8rocPjwt8gv9hV3UPw+41nuMLMyfVUS877MI3OQGNHkfiDKtYU/3vHP6uxDQp1Be1Cmr99ApluJyr5tw6z9kZeMgVULRgMeXlPvDy5+7nmG/P2meF2qi9xwOZffNCpk/U6x1ZkjH5CPd6EERpvJN5471pSxtmwnja+OV6+35PIvJ7/1jznrDZqxpkQal6EGPn+JLDkLeHAwbKvaoWBgJvAYax4E6XEsH3vY8+c3bf7lXFyUfKueSk3B8hzHYTIQZiaHC/XrUMVz8flTyNpznddC6EfkG8PA97XDZdgaIe1Fvm1Nl3xwDWSM1Gw/+zyFgJmqoL4WARZF9fPauOPiT7pT7AulZjCqY4bGcTuLqTC3EXBergra+Pag
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nTN9jWzUxSygkFnNVx9Sz1+jl5pIYl5b1MAnWyf6NXlOZdDiB4iS4umFoeyk?=
 =?us-ascii?Q?/4bBR2KBOQvZ9dCpcjKvSjwfVKrwIxulNZuMVaydhcpe7kAhnpMDlG4LnIyi?=
 =?us-ascii?Q?2w2WNYobyGznnL3RFsrhbW1xupoO1/QaHKvzxhQoq757O4vxLIEWnws0r/Wj?=
 =?us-ascii?Q?mJgNi5XX7dchcW1qgGwCWmp/9H+xwSZfcFGwX6jOxFSbTTpYqjVn6eBfE7fW?=
 =?us-ascii?Q?xk+7DXiBdSUTw3yUSD7k1t3k/31/QVn0ZDsi3BZeWeq/v/IPXyAFPbCfck81?=
 =?us-ascii?Q?mrtDQlAwCJtIsK9JxZ5j+qmoqfnrPqIF74Tlr5jFxRPLAEBDzj7qbvFb2zRy?=
 =?us-ascii?Q?Cqqr5dmhZnZsSvNBh7zRIVYzSiH44L8e8SMO5tebb9ggtn2nXq8hmqLYUPJU?=
 =?us-ascii?Q?uTcatTe4cFfSdfajxo4iRkGdYyjq8i3oq8bKFO8KVfBxtmBrDw9K+9grZFsa?=
 =?us-ascii?Q?U2D9VBXK5Zhn47wePQP3QkTHHXRXiQxG6FbpQJn7rpaOEQRx3CHZE/Fx1g3c?=
 =?us-ascii?Q?/sgjKv/HLzAwLiDaBIocAbtyQN4fEWS+VJTjPDCneNrSxBNPdMrbunckcJ4g?=
 =?us-ascii?Q?WV1Tj9F4U754+U51FcJ0Q6su33kTxdERt0/NGKgJx+7k+x08hkGIS4JKB/dF?=
 =?us-ascii?Q?In9P4l/4qwdnJPX9Bc2ASA10IrhFtslPYgF4SLIzdBKzbIZNdZWtaKPGlNEi?=
 =?us-ascii?Q?/KehA11ZfQzlKt55hPoybAg0Bky3U9FVBkLHjStPUig1vfEbi2fjGUz5NMsp?=
 =?us-ascii?Q?3FUseiOjkwd9jSH77A+xwAkeUVJMEzdgT+xM530HlMcd1K55NG89NVqY8zZd?=
 =?us-ascii?Q?WqMlGUMifSMG3IcjPK2T9Ffk1UZXCJbrlOnCwJUctPA7rf80JS9515g41Qea?=
 =?us-ascii?Q?qVJ6hVSon0zGpoL60Crkuv1ch5tVIkjoTJOXDpviNMDiK7n/Ve64sphDDr9R?=
 =?us-ascii?Q?NSaxI/tZvaXRTeWsslw1jsU2LVFCX0ZyCd0gqFnrRlVLKjjj5YTC8J4bAubG?=
 =?us-ascii?Q?XZFuiIMOWjJBlaIhCYLSl24xcxEGByg0d2LRjlrsxv5HXVdX2uBq67Uh2P9w?=
 =?us-ascii?Q?8Nxv7S4ghs++t9c90Je8GbLsDeFofhPmrby9imn8M0enE0DBmcY4XHuiS9r2?=
 =?us-ascii?Q?oDa5USP6VAIOXUhTk2Ew31T7+GzRVBKVmvwJT+EqEJj8wqSHNAsKF/aKgARE?=
 =?us-ascii?Q?NHAfzDKAl1NkLOGZYhZ7yS8enCGu80F4UZ7ig99fnvBfwvZH1gsWgfNa3mUk?=
 =?us-ascii?Q?ApxBQYl5CYj1duiGy0HAl4QO3rcDkBXXW7mnNhxVOyDjNKw/xLxCC08Fc+qy?=
 =?us-ascii?Q?2C6h7NkpoVZMTc65aHSDJh4776tbtTaU5laZEZY6ixmInUdZ2ugv2loFi7xg?=
 =?us-ascii?Q?ezxgYbgd6fUPlSuRqp+CbaSBBkLM7FgKCGjNarK/ohu1bL69VejbDnV+AFN1?=
 =?us-ascii?Q?H7YF/NzMBpKQR+SwvEZQCd8cnKcV5SDKr+eov7CiRPsvHECITow7e6UUS5nd?=
 =?us-ascii?Q?jCnSXUxf/eRUhNwzm2ADeTqIjSj2lzAphVMNK2A24WcSpYlY7jgyXLMqJdwv?=
 =?us-ascii?Q?a57lT/+unoB3GrteKQqg8q1hycFdrebhKKVO2BjerS2eyoKtTECQrS9vTOfx?=
 =?us-ascii?Q?qgzpMopLRo9ETeoz8pgFYEcItVMAjg2++ac/NSNFIFbWQRqMh0IfrvmsZSX4?=
 =?us-ascii?Q?wFltfxDakE9Z4Dwh4EtrROKIhdexvBHohh/yJ7Vv/NAwtCojhW/RVpYNXOoq?=
 =?us-ascii?Q?IbbwRIt/1w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de7330d7-efd6-4031-bb54-08dec54d3001
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 11:00:44.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f174257-ca3b-4127-8fed-91fa39cecdd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhbltlpZH4+U+nVDSezjwx0qksQKCHlGZiDxL4+SzHMTUFljmbgrUpGpRtHFP1L3oxHMuQsWVj0UsXB+7ihZ9QPIAeAYDl+/teLrvwRwXZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2762

On Tue, Jun 02, 2026, Andy Shevchenko wrote:
> I'm wondering if this opens a window when dma->rx_buf may be
> rewritten (or unmapped or something else) before tty layer has
> a chance to insert bytes to its ring buffer. I.o.w. is this
> change synchronous to other threads?

Good point.

RX DMA can be started from the DMA callback, the IRQ path, and
runtime resume. These paths appear to be protected by the same
driver locking.

At the point where rx_running is cleared, DMA has already been
terminated.

So I don't see a window where rx_buf could be overwritten, but
please let me know if there is a path where this could happen.

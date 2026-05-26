Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020093.outbound.protection.outlook.com [52.101.169.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A63CB2D2;
	Tue, 26 May 2026 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779780914; cv=fail; b=ZjlWLIva31clIrIvReKSE8+fvjqUbWtVme6KZ4OqukA7seycxXe9sSPoKVfuEei+mNJor+/Cu8FRIn91SJE/D737FaCKREkcUuLgZhDf+wWpTagHxUgajWWwnmJQy3n5IL4iybeMC3TacvxDGZN87WViBYAjRt+h1DbPpX/sUgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779780914; c=relaxed/simple;
	bh=I3FZseircM32mZn17FmYvTHTgyDg6Y7bAtU3pwJA9f4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XDIC8tXkX5IgGb9lvSABDDevIffHB+oqdrweQVnxrDu+oOr1prL2KgJ4V78BlBAp6O7M4s+5o8fdVpiO9opp+Qy92V7E1ArQMDf7kj9909ECLJQoG+QNaDiDUbTX2Jk5lVkOi9SK5ytPnAoQtZSdCxvrhjujLPuc5DDTcLGLo70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=KBSgmbhfr.onmicrosoft.com; spf=pass smtp.mailfrom=KBSgmbhfr.onmicrosoft.com; arc=fail smtp.client-ip=52.101.169.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=KBSgmbhfr.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=KBSgmbhfr.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI4Yi5GL82V8MjPtCbW+Bqaq+5xjYVPuOLbeKHjfuBsj2zZARY8t4LlJzjIkM786UgDeny5cIZKF/0KjCaVMxOjtGc79JtcpvTBfG+qJFGp4hoAWONsF7khU6UudbNoQLqzj/nuCNofwtqzAZS1nklrPNpMcrz+c/H2CHUGNLrisKmpD3LGlJjXApczkJW83g3RQ/7RXhlEONN4Wd7vXbQsjginWqiHH/s3CYbSE1F1mvcBIyu0KaWIwZB2gSa38XoxmpMhPOr7umCshfTFLWIKxmHCWJ91DeoZ2m+7urER3q9B2o4N2TflcrFdW24eRHaVbERAcKhzluSWG1xrtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWgo7oQe92flGx1l91r2PBnxbo5fBFQ8uRBLcVJdlow=;
 b=DAmBkUDHfo+QKQn6SfUK7g8Tt4cCEaQZTwPpCewTV7Aw0Av1s88/WzabaEI7VHqMzNs5hv5UTBtrXDbyv3qq4Rxxj6mwk8vb+4ciBnGwC1t8bgwc+XGGOmoynEM/RwVHN/1QnZ4yqyJKIFoAd/FDdI7iFeJc4JxrdCsfVhoZocYNR/yGUZWw2YFQdXIg0ueeoicO8WWdtK6NNODCj0QK51wl39Sg+Qgnbjyfws2wmMRveAbD+HVPHuTuFoOsLmm+As9jRoRVCvHjeTmyMeJfDkfozzurLI9Z2r9MyDbd/F7j638C+TK8nGzTA0lQorh5qWrwcfmIrmGonm/YiBHAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kbsgmbhfr.onmicrosoft.com; dmarc=pass action=none
 header.from=kbsgmbhfr.onmicrosoft.com; dkim=pass
 header.d=kbsgmbhfr.onmicrosoft.com; arc=none
Received: from BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:de::17)
 by BE1P281MB2274.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:35:09 +0000
Received: from BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fce2:69d7:2d84:7d9e]) by BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fce2:69d7:2d84:7d9e%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 07:35:09 +0000
From: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
To: Moteen Shah <m-shah@ti.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"k-willis@ti.com" <k-willis@ti.com>, "msp@baylibre.com" <msp@baylibre.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5] serial: 8250_omap: clear rx_running on zero-length DMA
 completes
Thread-Topic: [PATCH v5] serial: 8250_omap: clear rx_running on zero-length
 DMA completes
Thread-Index: AQHc7OItt2o2LMDBtEueXc02m0/NXw==
Date: Tue, 26 May 2026 07:35:09 +0000
Message-ID:
 <BE3P281MB55155F2F5795E411F5A65282EE0B2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <4b8c59fe-c6a1-47cb-ab3b-855b1edddde2@ti.com>
 <BE3P281MB55153573889A8124C06291F1EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ab76b900-6d1c-4218-a14a-59541b92f2c6@ti.com>
 <BE3P281MB5515A937D47F610974FAEFA7EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ede98ffc-9e34-46a5-8d8f-87894fbf9d12@ti.com>
In-Reply-To: <ede98ffc-9e34-46a5-8d8f-87894fbf9d12@ti.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=KBSgmbhfr.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE3P281MB5515:EE_|BE1P281MB2274:EE_
x-ms-office365-filtering-correlation-id: 529fb454-d1ca-4c79-355b-08debaf9507a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|4143699003|6133799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 9anQUJySBt8NoOVXNB79ii5YO82afRhS7/yhZrBO6I82rrVBhE68K688hHCBqXybdB83WOLdenmUybx+SUIl9Z4gBXAfc9JplYMTj4vBOOAj8x7Gyr3/XbL9d7/b1IA9t/Jgsob7eHHKp759Fs3L1GdMWghyKBEWCTNyVHssAQmHACd5imQ2ztPXc/Jw0iI4s4jsx2p+za0h/l2yCKOGWMGIXsKbNtdNDpR40Rh6lopahxu4r69Lby2ETANK8cOiO7+7cf+sxG499o2hyJpPaWbcs1PBxHBaAfrkIfs1li7lJPNGSotm73m82HvejHHtNO+JpaMK1wHsuUt0qi+nkaADy97u54Ju4COS1yv+AicVi4FTfLX1vR/7m25cSvicoS1XN+LLjrwfPpw4sTK8rVM61ZLYWgmLkcQWTtoqp/roCQ/Y5t7s49tCEM42ZJUxEWdoUFMk5ApUnoFlfOQ/ZBuLHkhK5BsOaMqpvT82pRHs1d2sOBy2cfIoSB2AcQLcIQ7QBjQYVohhm/FisfEYhdp7iYvI3b7bmY8o+rRf5F+3agkuh9c1lX2sVAooX3BFJNCb4195ftqT8upzIQVe7j29Z68Q+Hgb7bdspO+DMKO4Z9zy0kNMPGdJcJHPoeBelwBEw17oXxKf0pixRhV6PwYZDvf5a47ft/+SPcpzjLPi/dIHfICB9eLul1atkpn0j5nawJNd4jcPfCR9758iUVxryar/FJ8VmpIyuczIsVQeAX0LyHNSdqdZGPtRHBEu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(4143699003)(6133799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LAeeitmz78QYHWBZYSELRvPDeKeDhD5fi/oYS9jbobBf8dqg6FdUP0GSs7kE?=
 =?us-ascii?Q?2SK6TGPRuYWJC3WANLuVtzvjCUwBikBaxe5WMgGMiNlNGlkzVGghsqlJo1F+?=
 =?us-ascii?Q?wwhrkWS9zOkLCQz7xb2qZUhhETltxvKqbuMoxnTnv1hhAyjOri9Bjwi0zc/f?=
 =?us-ascii?Q?PntpTqZHegaDdPoHdTpAaqKeSkzfV6lpRwNedIv3SNIeH06h5xgatEyz8BFW?=
 =?us-ascii?Q?pMyWtCCzK5Iip3RmxVAq63C+1ULlXfKcqu4g4tJGsKWJ8aEXS+MRa7ZpET50?=
 =?us-ascii?Q?fq1fqn3hftTtAvlpI6z2UqbPeZ1IMgMOSDYfBsHhsUSVPVHvzu1mw9wOpi1t?=
 =?us-ascii?Q?d8qAEtZh0mFJhjkleQu7DmFqZLdqdsscwR8NZTi9niJCtMReQbYbwpXXrIUQ?=
 =?us-ascii?Q?goSasFyBxJRgDY3ope0iHEaQFJ1K7d8MEUb9zAjnL3KBDkbM4vGGUlEUImHb?=
 =?us-ascii?Q?HvTv+ZpZ7IW5+XPDvmTN+U0D8CWXIUaXYxdrWlc4SAv+jpSYK1VEBT5iVLbB?=
 =?us-ascii?Q?8iVx5/5/zOjQY2JgLk7DgIKEhbDZt1LzXhcFNR1NwIR4fvF9P4TlwiYsDmwB?=
 =?us-ascii?Q?j/hZ1jr6P9QUMpvK6m9SISjKwyTgcvAQlPz77GJWAxBX0Q7R1h2tL7K5/SKG?=
 =?us-ascii?Q?1r7iadFKFKdFQLZhKG6cuPBovyMnhkw1bhhzXP3V6HrFo4TERbYocDhbJhW9?=
 =?us-ascii?Q?XC+WABJL0/ggfQexFmvjamLtQm11FIle1uc2u3qFPhfPyKwnWpuuryI7t9mT?=
 =?us-ascii?Q?fuXuRppfzg0aT0NunGtNVdjk7r7y3u3SWyYarBN1e7oWEt5KRpYY+PYn0eP3?=
 =?us-ascii?Q?gvZR7Y85BN2YVayCE5Ehinetdg2tHtH7WFcvBnQIuvQQw0jQBJnylP0+vH0B?=
 =?us-ascii?Q?z496q5fCXZ/XzVe4ma/GQCBkxT8K2vje1WvxzwIAymECtmdcQWQb5E8CTGlE?=
 =?us-ascii?Q?+2R14HPD+KO+XdKp3OvubgkU87lwVeb+sxallbVyMiZW4lNwx+tD7Zc6vYwJ?=
 =?us-ascii?Q?F/AXrKuaurBc+qyM1MydEQPa64cZ+Utd4Ssk4He9aNINFa1xYrkSH6ecoiSG?=
 =?us-ascii?Q?vhJbAh0APG5NCXyF3sIyr3/xFV/pVra9My/Y6OWap7gmm4GpZv2fKbcktFDa?=
 =?us-ascii?Q?KneJzXkGACM50DEkhbeAdazgfRWuPjdDIrFPZQvRFsU12zgWGR9vnjYU3Sbh?=
 =?us-ascii?Q?rHRpdxFVjN+uCjSMWLqIiJGPQYZSM4pkoq6mUOV8yRO8zPVCGwDDLa//BwzI?=
 =?us-ascii?Q?Qwj9cdJMg8qNYAYtlYu4hlyTVitgd6I1G1NfJ1XFsDYh0l9Himp19Q7yf0Jo?=
 =?us-ascii?Q?FowXZ7FFD/6Syk+ZHE/RHq4HVrOc7Fd5Yw05WBUfPK2CmN7CQqQiFkW2/jHw?=
 =?us-ascii?Q?R88b0F3Z9lx+ixoQwVF63wZzwqn9vaPAnYAPUyl+Wr5sD6NMkcEYfN80R/6T?=
 =?us-ascii?Q?Gv9MRBOjRRjQAkafz/H6P7ZCdzeuLFQ/b5p3mHRhOXqad67ypTYKhtMQWijr?=
 =?us-ascii?Q?PviVc7lCx3Fa+f2+dYG7myMd9H0hh7bBsGeYwsKZ1pamxXocAqvMH0iyiBOD?=
 =?us-ascii?Q?NDDrKQieeDppEuGMHSDrHf5HMddQElQctcz2MqydV4Fd9+WvgUGf1sP5fWyq?=
 =?us-ascii?Q?zD8L2Z2R+0NFD/m2W6D9iWE8Daoog2GijRKzPsWxkXmIphkgW4cqiKzo5dmt?=
 =?us-ascii?Q?wB3PTbREqiroNGLUMeiS/95rzAZSkf2RAAPDr8XFebOMFlS5d88BR5YQz4mQ?=
 =?us-ascii?Q?thI2qTSXBMP7gG/q00OBwoGpTwbghi4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 529fb454-d1ca-4c79-355b-08debaf9507a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 07:35:09.2862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f174257-ca3b-4127-8fed-91fa39cecdd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICaz6mavgxy9QamTRnEX2dpYh0xPgZTs5Cxcukw5DglbvTOKxHdugTTLWxITkZWp6enHsPD/csOpgZyz8TwPPkxZFLBy5ZgsdXmCiMsMha0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2274

On AM33xx RX DMA only triggers when the FIFO reaches the
configured threshold (typically 48 bytes). For smaller bursts
no DMA request is issued and the FIFO is drained by RX timeout.

In this case __dma_rx_do_complete() can legitimately see count =3D=3D 0.

The current code exits early in this case and does not clear
dma->rx_running, leaving the DMA state inconsistent. This can
prevent RX DMA from restarting and may cause
omap_8250_rx_dma_flush() to fail, marking DMA as broken.

Fix this by clearing dma->rx_running once the DMA transfer has
completed or been terminated, even if no data was transferred.

Fixes: a5fd8945a478 ("serial: 8250: 8250_omap.c: Clear DMA RX running statu=
s only after DMA termination is done")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
---
Changes in v5:
- Add missing metadata (Fixes tag and Cc: stable)

Changes in v4:
- Add blank line before dma->rx_running as suggested

Changes in v3:
- Move "Changes in v2" below the tear line as suggested

Changes in v2:
- Move dma->rx_running clear before the count check

 drivers/tty/serial/8250/8250_omap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/=
8250_omap.c
index c552c6b9a037..3c7775df27ef 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -944,11 +944,12 @@ static void __dma_rx_do_complete(struct uart_8250_por=
t *p)
 				dev_err(p->port.dev, "teardown incomplete\n");
 		}
 	}
+
+	dma->rx_running =3D 0;
 	if (!count)
 		goto out;
 	ret =3D tty_insert_flip_string(tty_port, dma->rx_buf, count);
=20
-	dma->rx_running =3D 0;
 	p->port.icount.rx +=3D ret;
 	p->port.icount.buf_overrun +=3D count - ret;
 out:
--=20
2.39.5


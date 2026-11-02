Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793642194;
	b=02hqM91ffuaJyulvybZOfERc2c6Yrb6HlIytjUUaWZpKclKPxCFzn8ktEa429c8puIOH
	 y7+Z5Tdim4w0h8fDFx1Kqk2t9YMLuUGoQcZfHoaWhHQUPHvbANddM2gwivY3x4svHPT/Z
	 M/uwLoGoXT5gU4bD0kt+8oyyeZcesRPo+64F1/F/qzAyBKR+FFikZehcg6B66PTtkym2i
	 5uEHRrOX9pSETWMBQJ8Y4wHyYnMDSN3+RorS31/Lg97y4d7a4eE1hEmFImRNpj00lw6TV
	 lr3FKoUol0/OcQXB1QrZvKTPCKro7AF5cnf+kfoQeuJe2SM/KwfWcCmlBIeTauLVc0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642194;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bARrvuuFK4uB8cnET76jFjFerjVh9sW0qJwJegK31go=;
	b=FzK2Zhha5qZ1NqSZ5llroW6CMpONyzLKo4riZeoLXdR7bWGs9AfrHeuUHmipsZM5wa9H
	 eEeZFjeBahaWCOrqD30Ck/KwiElCo8GHEi0P+o2FB5SM46SbQ5ncDghsXH8RVue813h0c
	 15o0SkS6UQdh9oOzmcf4s8QKCgHysINlMbqtXY4dPzPn1yOKvL+lOM4D7hrPshf8vrQq8
	 S94XLkJsWGrdoaysEM1zg8YbP7ZzpQ8bcY095jNKZVASWG3nCJbHkyviZ54HZVxFwN34a
	 a5JBIi8bVilYPSI3CvRdBc8qWGtKePsxe0jMgeTOjq4m4p4OBxxLroupE7EEFeBC4ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gMypEu1h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.19
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5B606D82C;
	Mon,  2 Nov 2026 17:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CA5B606D82C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gMypEu1h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhnOOlMGddtdpm8hgxFps4MFpT3BXsxyf4+y4ftwL3oFkkD0S6sHZfnjgykwJbvKrm6Me/S8e103OjO0ZpVEqB8Yl8pdggphLYt4hfxugorp48OvN3Tm2z607zXJEXne1c0gt/hIPEDYKBzOHCOiPtdul/p+wKdrAPTl4Rvo27OLvoSEZ1Q0wqndE7x5ZMdet3Ukx9PiEyvsZwEQGjYqjeaoCDPGEnpyaRs5q6Ai8w8UNjW8iIdEbvG/9DIZppHMyBzNlRWm+rt8YWB9Nf+dSaTfZMlXJU0AaLYSbhLVwAOQCPJ5MLwYWVO3eWSXoRwQsHDPViKIZg8Y1K6M9lTvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bARrvuuFK4uB8cnET76jFjFerjVh9sW0qJwJegK31go=;
 b=jsAW2lp9HFXCGDCc4MP844aEjRiFLx6Q7S40qjPuXGY2rFLsqSMSZpkd0TX1mbRSdK3XZVYKRo55SKMmGV93VrydrgkSPbjjWf0R/x5N+0FfSHnLcGeQFch4XmBOl6D/lb+jJmN290dwEmwb57o8jdLbvJbX4OhrdTgf+nGB9ik2AxPhjh46thNKOU3N7W9FDxfZnfGrDMd6Ukcnw2RJhO4lsqQEWMwJ81qju3O6tooajqMMeOjIKoKMyz5nORN2Z0bJMzmBDcHX3hnbZ0AAC6mVfpjxDvjDGv1FjI9wSrHeFlV9AHDwl/rQd2GZ/JkLDCCc7azVbjJX2UYV9qwRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bARrvuuFK4uB8cnET76jFjFerjVh9sW0qJwJegK31go=;
 b=gMypEu1h0VLcVuIZj6tNeR1J4e/8dCoq04kZA3Hz9soDjnRCxVyryj5Bt5zDpuPoh5TYLGDRdDgisCEkg1lu7mTlMdpI0WXoftapYJV/js9nFt64FJVrZRhgmWQV71cqD9ntXVN4MOU2U8ssxxrqUulQYJKXWC92OxHAxMgTb3/Ykx/ZSLDGnQX2cobm+FjA1kosVPhORz+YH3xWu1jF76PWM+PDgof3QI3OOPSxF0G/RgJ02Nejbbid55JGQqfAuUqZGclDpOrmv6/ojKhaLnNMk5EqLF+zWcgD7QWEB5GJyAN2VAsBW5zpgADRhiyjG515H2NLqryOdvgE6CfB+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAWPR04MB9935.eurprd04.prod.outlook.com (2603:10a6:102:387::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Mon, 2 Nov
 2026 17:56:28 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:56:28 +0000
From: Frank.Li@oss.nxp.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Cunhao Lu <1579567540@qq.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Yenchia Chen <yenchia.chen@mediatek.com>,
	Zhiyong Tao <zhiyong.tao@mediatek.com>,
	Carlo Caione <ccaione@baylibre.com>,
	Moteen Shah <m-shah@ti.com>,
	Kendall Willis <k-willis@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kartik Rajput <kkartik@nvidia.com>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	=?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	John Ogness <john.ogness@linutronix.de>,
	Pan Chuang <panchuang@vivo.com>,
	Petr Mladek <pmladek@suse.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Zhaoyang Yu <2426767509@qq.com>,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>,
	Haoxiang Li <haoxiang_li2024@163.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Myeonghun Pak <mhun512@gmail.com>,
	Wenhua Lin <Wenhua.Lin@unisoc.com>,
	Cixi Geng <cixi.geng@linux.dev>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT...),
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH 1/1] tty: serial: use dmaengine_desc_set_callback()
Date: Mon,  2 Nov 2026 12:54:48 -0500
Message-ID: <20261102175527.3957740-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAWPR04MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb916b4-5617-4767-bf36-08df390a9ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|1800799024|366016|261102123227099003|18002099003|921020|260925021911599003|260925021311599003|11063799006|260925022911599003|56012099006|261009223327099003|10067099003|261009221727099003|261028144727099003|261026140227099003|261009223027099003|261009221227099003|261009220027099003|261022105027099003|261021123027099003|261026121527099003|261021121427099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	DJ6sGe/88is5yG7FURzvyxi3rTl/WFMsFVftYwMrdq3Hk+7qkJ1Ow7oeorg0dWPXCrCqIrvNfoxaumoGQ8fdcjwZCJUrLY//xj9fcokUexXwyCe3/LdiAavRPvCFL9cG+wH0OJEQPyhp88JzJD7IdnmuJR2e3Ehh5I7wi1ygjrP17KHZI19Kqyr0sR7CRGo7KYEs+SqkUivuEj2Jsixvteurlw0+VVWjF0DT4IM5SF5FxtwrB9/hEGjqTL6B9EIddjMKGeWPIv7LHh1v0sh2owhj/dy5R1o9UEADUNYlBQREqIQ6jiC+ewU/gKZGies7r1tunZky+mffrmgtuWWUx2neS2vSpiiyzCkBpSWS7Tt5kTWZdOeiNBlMk3YkDCHcVt2zrgJRYBAo9sAlosTpd3KF6ASKUrLwZ2CvUGfckR12F9LOR1yHnFgIooCopVzrUldZHzOGkQpRZihq3fqIhhD7tmldRITagWnMfZP/gm28SgUyGXz4pbTLjuhIi0sB+Gpy1LB7MEUIUrjYU+ApiKg3b5KvXrWDZXOsuPlhhmP/Png68KBLMerngVkXejA5Ncs2ueQbilukvktlA4lm+VDc+KwU4atuO39zp7znl8YOsZTwmU8jlsD02dcya2G2d+O1mQg6bCBFQjNHX8EbZ5zP14nQ/R3wfu3GaTHCRAgiYNcf0lyeIVo0TcpxXysAqSjNy2o6iEfCos2+l9ikAA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(1800799024)(366016)(261102123227099003)(18002099003)(921020)(260925021911599003)(260925021311599003)(11063799006)(260925022911599003)(56012099006)(261009223327099003)(10067099003)(261009221727099003)(261028144727099003)(261026140227099003)(261009223027099003)(261009221227099003)(261009220027099003)(261022105027099003)(261021123027099003)(261026121527099003)(261021121427099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/74pkHQHm0MS8cS+4Wab2F+Fn1Bs0EXiioDfOIF0L1oDKeNAJua165W7RwbC?=
 =?us-ascii?Q?DNdSujVQA2iXVMUtdOos52daNr45144cOIW9mTM/+1UZkwrYpQJsUvjRb9aS?=
 =?us-ascii?Q?1zdz2fQEtOEgcXOb0eI2nVEI9VkRib9iYCmGsX+si6dg5O3xa4oqP2m6c+uX?=
 =?us-ascii?Q?q2ulTq1MN52a2d+i9YKWEtU0/aFGEon5uIRaKiitqifsXK24Efmf7zO2RpS2?=
 =?us-ascii?Q?rZmWKWTHq60SUCKqAkphvogz41r8yvvukwKmq2MOCsKiEoyBDJZ9jEpi1SsN?=
 =?us-ascii?Q?OvKhYMEck+w0v9mxn0vY4VqZNo08GwodnOh19j/83UJ6wHlA2UhOfbx9x/6e?=
 =?us-ascii?Q?HFiGiIryICnYibr9GoYouATzAS+hA6jWNd+beS4buhkmiwtP3wVwHxah5HZv?=
 =?us-ascii?Q?XZnrxSyv/19vxFRUjQE+ELTaqulqnF2R4qxLEB4CBMC7JYi7W2tL0bC6k7/J?=
 =?us-ascii?Q?ivovyINKMVhcwOgHJ1VG/xs8wsa7q9lslAAvhwztQjawJeAUsKfm2FG3GG++?=
 =?us-ascii?Q?4Btp6sjPLvf3X9VO29O8V5k0auPpeCI9r+6zL3rx6h9LXLzdRTp8mhGgPs5z?=
 =?us-ascii?Q?HU/sRSoNRpIwYHpKW8ymcX6q7sxktiA74smzwuwhwMJcO6cLfKsuqEn1jJZZ?=
 =?us-ascii?Q?bHGO9ofMtFwJKibz5SL7zqa43DrIb3La25BY8JlVqGPDnUrJpSrSkerMO+X8?=
 =?us-ascii?Q?cWGHU6Tv24G4L+TNunfqTV5ajMkWKX4BUutYYCNxMQE75oGXRlfT52qDEsPw?=
 =?us-ascii?Q?P+rycOoR7eT70gkmlgjM8I2WqM61UfZvepcV7wFVy8Pi3yq8JDo4ddoGdJim?=
 =?us-ascii?Q?BN/ztYzwxG9mKW64AodPvUkRPyYbmNO3jEXFoXPDpo4YeO/7uh4srvxZ2+P7?=
 =?us-ascii?Q?aFADvNSt29hFtn5eZWBXQQtR327BA5kHN2wgpaB0p5wjYtmY9PQj7KalAP3b?=
 =?us-ascii?Q?mk2oY568Jnaj4ilP6MVbTmXphh3eYUYhgIObvG/bnSar7NcEAljtB0w6nU88?=
 =?us-ascii?Q?hfG6wWTsBS6cpmbBemoSOw1idnJxhGOBu7PyNUtG1X4ZMGzzpbSNFCpZ6IyQ?=
 =?us-ascii?Q?MgeVOA/JCHe3C0tknfO2WCVuw83erTU/rEbylHwGTRZ5lZjQe6u4eZitAuXx?=
 =?us-ascii?Q?oXQlnWROUJCWC9ffK/QItXPktcB7oxZv5MkzJaZqx92BELee4SCZrAMaKiaC?=
 =?us-ascii?Q?NIS3GXb3Qc2IggjxGQU+1tGT8/xi+KEjccitBqlWTBHCYZldUs4IB4dSQ6lW?=
 =?us-ascii?Q?VObhli85o5DGBHoXIVaXCHpEJywfK5Q/7uLdX1B/qdrThyvEjlcxsNrH/OqJ?=
 =?us-ascii?Q?uPKDjXK7LLQI/9CDjyCjYZrbsvnzq5HxHzJy6FrXCyGty6ZT5FelXlcVh/+S?=
 =?us-ascii?Q?rnRgYQDzJ5Ummp9as3UerTPdfEwpCb/R8kimGibWtpHVR8QeJfhEUf4yP/t/?=
 =?us-ascii?Q?wR5TaCPurhdfLUwv39sdaqOz6NbxEBopYTDdAAtjMlMNfYhYVwGuR6uPMW8Y?=
 =?us-ascii?Q?mxE2AOFZ1siAJ0FbItKssakzMwYa00kEf92mEPp5705aLEByjivckOmrIbwJ?=
 =?us-ascii?Q?p90jTfQwdb65uGGM6mkR2umqbqRpB58jNOhnLyUBiZfa+A0x7iA5JQZ4xaaJ?=
 =?us-ascii?Q?o1ZvghngikfRHv/iweHP9iQeE567LqvhX6SU2zR67R/uQ/pF20+7V79qxJYE?=
 =?us-ascii?Q?87dsICl1woN4QOUT3wRSdXW75gJP7IuYvOSOtOHZcbZNIwdwVRkF8yQ4M5B5?=
 =?us-ascii?Q?GI+M/rZrSu/yaG76Ym2529EOlxV4BPWZRATe7tDI46QxUBEdf13a?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb916b4-5617-4767-bf36-08df390a9ea3
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 17:56:28.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYcvhQwBL0fJZx14uL5aknwFTknvMVeCD5TdfMvRdaGh2ctKcjtCRp4iciDbD0Ud3Mt7kXVbuuSb/1LUvjzb/SBhbUMt7tMedfdxmVIQK/ZOUS73cmvvSH5begEjTTWj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9935

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields
of struct dma_async_tx_descriptor with calls to the
dmaengine_desc_set_callback() helper across serial drivers.

No functional change intended. Prepare to make struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/tty/serial/8250/8250_dma.c  | 6 ++----
 drivers/tty/serial/8250/8250_mtk.c  | 3 +--
 drivers/tty/serial/8250/8250_omap.c | 6 ++----
 drivers/tty/serial/amba-pl011.c     | 6 ++----
 drivers/tty/serial/atmel_serial.c   | 6 ++----
 drivers/tty/serial/fsl_lpuart.c     | 6 ++----
 drivers/tty/serial/imx.c            | 6 ++----
 drivers/tty/serial/msm_serial.c     | 6 ++----
 drivers/tty/serial/mxs-auart.c      | 6 ++----
 drivers/tty/serial/pch_uart.c       | 6 ++----
 drivers/tty/serial/samsung_tty.c    | 6 ++----
 drivers/tty/serial/serial-tegra.c   | 6 ++----
 drivers/tty/serial/sh-sci.c         | 9 +++------
 drivers/tty/serial/sprd_serial.c    | 3 +--
 drivers/tty/serial/stm32-usart.c    | 6 ++----
 15 files changed, 29 insertions(+), 58 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 1da605cc86011..7d42afe1ce33b 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -131,8 +131,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	}
 
 	dma->tx_running = 1;
-	desc->callback = __dma_tx_complete;
-	desc->callback_param = p;
+	dmaengine_desc_set_callback(desc, __dma_tx_complete, NULL, p);
 
 	dma->tx_cookie = dmaengine_submit(desc);
 
@@ -197,8 +196,7 @@ int serial8250_rx_dma(struct uart_8250_port *p)
 		return -EBUSY;
 
 	dma->rx_running = 1;
-	desc->callback = dma_rx_complete;
-	desc->callback_param = p;
+	dmaengine_desc_set_callback(desc, dma_rx_complete, NULL, p);
 
 	dma->rx_cookie = dmaengine_submit(desc);
 
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index d1fb917b762a1..442856b3fe6d9 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -147,8 +147,7 @@ static void mtk8250_rx_dma(struct uart_8250_port *up)
 		return;
 	}
 
-	desc->callback = mtk8250_dma_rx_complete;
-	desc->callback_param = up;
+	dmaengine_desc_set_callback(desc, mtk8250_dma_rx_complete, NULL, up);
 
 	dma->rx_cookie = dmaengine_submit(desc);
 
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 29a203ed93fd8..9bdc0f00dec5a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1048,8 +1048,7 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 	}
 
 	dma->rx_running = 1;
-	desc->callback = __dma_rx_complete;
-	desc->callback_param = p;
+	dmaengine_desc_set_callback(desc, __dma_rx_complete, NULL, p);
 
 	dma->rx_cookie = dmaengine_submit(desc);
 
@@ -1192,8 +1191,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 	dma->tx_size = sg_dma_len(&sg);
 	dma->tx_running = 1;
 
-	desc->callback = omap_8250_dma_tx_complete;
-	desc->callback_param = p;
+	dmaengine_desc_set_callback(desc, omap_8250_dma_tx_complete, NULL, p);
 
 	dma->tx_cookie = dmaengine_submit(desc);
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e6f652905ca6f..e7373cd11b621 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -715,8 +715,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	}
 
 	/* Some data to go along to the callback */
-	desc->callback = pl011_dma_tx_callback;
-	desc->callback_param = uap;
+	dmaengine_desc_set_callback(desc, pl011_dma_tx_callback, NULL, uap);
 
 	/* All errors should happen at prepare time */
 	dmaengine_submit(desc);
@@ -906,8 +905,7 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
 	}
 
 	/* Some data to go along to the callback */
-	desc->callback = pl011_dma_rx_callback;
-	desc->callback_param = uap;
+	dmaengine_desc_set_callback(desc, pl011_dma_rx_callback, NULL, uap);
 	dmarx->cookie = dmaengine_submit(desc);
 	dma_async_issue_pending(rxchan);
 
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c3880259e3bce..886280bc8464a 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -993,8 +993,7 @@ static void atmel_tx_dma(struct uart_port *port)
 					   UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 		atmel_port->desc_tx = desc;
-		desc->callback = atmel_complete_tx_dma;
-		desc->callback_param = atmel_port;
+		dmaengine_desc_set_callback(desc, atmel_complete_tx_dma, NULL, atmel_port);
 		atmel_port->cookie_tx = dmaengine_submit(desc);
 		if (dma_submit_error(atmel_port->cookie_tx)) {
 			dev_err(port->dev, "dma_submit_error %d\n",
@@ -1242,8 +1241,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 		dev_err(port->dev, "Preparing DMA cyclic failed\n");
 		goto chan_err;
 	}
-	desc->callback = atmel_complete_rx_dma;
-	desc->callback_param = port;
+	dmaengine_desc_set_callback(desc, atmel_complete_rx_dma, NULL, port);
 	atmel_port->desc_rx = desc;
 	atmel_port->cookie_rx = dmaengine_submit(desc);
 	if (dma_submit_error(atmel_port->cookie_rx)) {
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c8575c9652035..3213519776b35 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -508,8 +508,7 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
 		return;
 	}
 
-	sport->dma_tx_desc->callback = lpuart_dma_tx_complete;
-	sport->dma_tx_desc->callback_param = sport;
+	dmaengine_desc_set_callback(sport->dma_tx_desc, lpuart_dma_tx_complete, NULL, sport);
 	sport->dma_tx_in_progress = true;
 	sport->dma_tx_cookie = dmaengine_submit(sport->dma_tx_desc);
 	dma_async_issue_pending(chan);
@@ -1407,8 +1406,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 		goto err_unmap_sg;
 	}
 
-	sport->dma_rx_desc->callback = lpuart_dma_rx_complete;
-	sport->dma_rx_desc->callback_param = sport;
+	dmaengine_desc_set_callback(sport->dma_rx_desc, lpuart_dma_rx_complete, NULL, sport);
 	sport->dma_rx_cookie = dmaengine_submit(sport->dma_rx_desc);
 	dma_async_issue_pending(chan);
 
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 986fefb45c632..c83da7c48b675 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -655,8 +655,7 @@ static void imx_uart_dma_tx(struct imx_port *sport)
 		dev_err(dev, "We cannot prepare for the TX slave dma!\n");
 		return;
 	}
-	desc->callback = imx_uart_dma_tx_callback;
-	desc->callback_param = sport;
+	dmaengine_desc_set_callback(desc, imx_uart_dma_tx_callback, NULL, sport);
 
 	dev_dbg(dev, "TX: prepare to send %u bytes by DMA.\n", sport->tx_bytes);
 
@@ -1294,8 +1293,7 @@ static int imx_uart_start_rx_dma(struct imx_port *sport)
 		dev_err(dev, "We cannot prepare for the RX slave dma!\n");
 		return -EINVAL;
 	}
-	desc->callback = imx_uart_dma_rx_callback;
-	desc->callback_param = sport;
+	dmaengine_desc_set_callback(desc, imx_uart_dma_rx_callback, NULL, sport);
 
 	dev_dbg(dev, "RX: prepare for the DMA.\n");
 	sport->dma_is_rxing = 1;
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index bfa44b01c3e97..62c7872f9ffbd 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -521,8 +521,7 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
 		goto unmap;
 	}
 
-	dma->desc->callback = msm_complete_tx_dma;
-	dma->desc->callback_param = msm_port;
+	dmaengine_desc_set_callback(dma->desc, msm_complete_tx_dma, NULL, msm_port);
 
 	dma->cookie = dmaengine_submit(dma->desc);
 	ret = dma_submit_error(dma->cookie);
@@ -642,8 +641,7 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 	if (!dma->desc)
 		goto unmap;
 
-	dma->desc->callback = msm_complete_rx_dma;
-	dma->desc->callback_param = msm_port;
+	dmaengine_desc_set_callback(dma->desc, msm_complete_rx_dma, NULL, msm_port);
 
 	dma->cookie = dmaengine_submit(dma->desc);
 	ret = dma_submit_error(dma->cookie);
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 697318dbb146b..0b39dd2d653ee 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -559,8 +559,7 @@ static int mxs_auart_dma_tx(struct mxs_auart_port *s, int size)
 	}
 
 	/* [3] : submit the DMA */
-	desc->callback = dma_tx_callback;
-	desc->callback_param = s;
+	dmaengine_desc_set_callback(desc, dma_tx_callback, NULL, s);
 	dmaengine_submit(desc);
 	dma_async_issue_pending(channel);
 	return 0;
@@ -858,8 +857,7 @@ static int mxs_auart_dma_prep_rx(struct mxs_auart_port *s)
 	}
 
 	/* [3] : submit the DMA, but do not issue it. */
-	desc->callback = dma_rx_callback;
-	desc->callback_param = s;
+	dmaengine_desc_set_callback(desc, dma_rx_callback, NULL, s);
 	dmaengine_submit(desc);
 	dma_async_issue_pending(channel);
 	return 0;
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 9505d255f09c5..8f3ffe39a5857 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -809,8 +809,7 @@ static int dma_handle_rx(struct eg20t_port *priv)
 		return 0;
 
 	priv->desc_rx = desc;
-	desc->callback = pch_dma_rx_complete;
-	desc->callback_param = priv;
+	dmaengine_desc_set_callback(desc, pch_dma_rx_complete, NULL, priv);
 	dmaengine_submit(desc);
 	dma_async_issue_pending(priv->chan_rx);
 
@@ -968,8 +967,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 	}
 	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, num, DMA_TO_DEVICE);
 	priv->desc_tx = desc;
-	desc->callback = pch_dma_tx_complete;
-	desc->callback_param = priv;
+	dmaengine_desc_set_callback(desc, pch_dma_tx_complete, NULL, priv);
 
 	dmaengine_submit(desc);
 
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 640f85e2d636b..3f82a83998e1c 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -447,8 +447,7 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
 		return -EIO;
 	}
 
-	dma->tx_desc->callback = s3c24xx_serial_tx_dma_complete;
-	dma->tx_desc->callback_param = ourport;
+	dmaengine_desc_set_callback(dma->tx_desc, s3c24xx_serial_tx_dma_complete, NULL, ourport);
 	dma->tx_bytes_requested = dma->tx_size;
 
 	ourport->tx_in_progress = S3C24XX_TX_DMA;
@@ -642,8 +641,7 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
 		return;
 	}
 
-	dma->rx_desc->callback = s3c24xx_serial_rx_dma_complete;
-	dma->rx_desc->callback_param = ourport;
+	dmaengine_desc_set_callback(dma->rx_desc, s3c24xx_serial_rx_dma_complete, NULL, ourport);
 	dma->rx_bytes_requested = dma->rx_size;
 
 	dma->rx_cookie = dmaengine_submit(dma->rx_desc);
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index b0fc4ae3686f8..05ba808bdbaef 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -568,8 +568,7 @@ static int tegra_uart_start_tx_dma(struct tegra_uart_port *tup,
 		return -EIO;
 	}
 
-	tup->tx_dma_desc->callback = tegra_uart_tx_dma_complete;
-	tup->tx_dma_desc->callback_param = tup;
+	dmaengine_desc_set_callback(tup->tx_dma_desc, tegra_uart_tx_dma_complete, NULL, tup);
 	tup->tx_in_progress = TEGRA_UART_TX_DMA;
 	tup->tx_bytes_requested = tup->tx_bytes;
 	tup->tx_cookie = dmaengine_submit(tup->tx_dma_desc);
@@ -817,8 +816,7 @@ static int tegra_uart_start_rx_dma(struct tegra_uart_port *tup)
 	}
 
 	tup->rx_dma_active = true;
-	tup->rx_dma_desc->callback = tegra_uart_rx_dma_complete;
-	tup->rx_dma_desc->callback_param = tup;
+	dmaengine_desc_set_callback(tup->rx_dma_desc, tegra_uart_rx_dma_complete, NULL, tup);
 	tup->rx_bytes_requested = count;
 	tup->rx_cookie = dmaengine_submit(tup->rx_dma_desc);
 	dma_async_issue_pending(tup->rx_dma_chan);
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bd58bbfa65aa7..f7b4d35b2d5bb 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1556,8 +1556,7 @@ static void sci_dma_rx_complete(void *arg)
 	if (!desc)
 		goto fail;
 
-	desc->callback = sci_dma_rx_complete;
-	desc->callback_param = s;
+	dmaengine_desc_set_callback(desc, sci_dma_rx_complete, NULL, s);
 	s->cookie_rx[active] = dmaengine_submit(desc);
 	if (dma_submit_error(s->cookie_rx[active]))
 		goto fail;
@@ -1613,8 +1612,7 @@ static int sci_dma_rx_submit(struct sci_port *s, bool port_lock_held)
 		if (!desc)
 			goto fail;
 
-		desc->callback = sci_dma_rx_complete;
-		desc->callback_param = s;
+		dmaengine_desc_set_callback(desc, sci_dma_rx_complete, NULL, s);
 		s->cookie_rx[i] = dmaengine_submit(desc);
 		if (dma_submit_error(s->cookie_rx[i]))
 			goto fail;
@@ -1679,8 +1677,7 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
 	dma_sync_single_for_device(dmaengine_get_dma_device(chan), buf, s->tx_dma_len,
 				   DMA_TO_DEVICE);
 
-	desc->callback = sci_dma_tx_complete;
-	desc->callback_param = s;
+	dmaengine_desc_set_callback(desc, sci_dma_tx_complete, NULL, s);
 	s->cookie_tx = dmaengine_submit(desc);
 	if (dma_submit_error(s->cookie_tx)) {
 		uart_port_unlock_irq(port);
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 3fdf5939a62c1..3801b0c03482f 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -303,8 +303,7 @@ static int sprd_uart_dma_submit(struct uart_port *port,
 	if (!dma_des)
 		return -ENODEV;
 
-	dma_des->callback = callback;
-	dma_des->callback_param = port;
+	dmaengine_desc_set_callback(dma_des, callback, NULL, port);
 
 	ud->cookie = dmaengine_submit(dma_des);
 	if (dma_submit_error(ud->cookie))
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ad06b760cfca7..a27b8797ad953 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -585,8 +585,7 @@ static int stm32_usart_rx_dma_start_or_resume(struct uart_port *port)
 		return -ENODEV;
 	}
 
-	desc->callback = stm32_usart_rx_dma_complete;
-	desc->callback_param = port;
+	dmaengine_desc_set_callback(desc, stm32_usart_rx_dma_complete, NULL, port);
 
 	/* Push current DMA transaction in the pending queue */
 	ret = dma_submit_error(dmaengine_submit(desc));
@@ -753,8 +752,7 @@ static void stm32_usart_transmit_chars_dma(struct uart_port *port)
 	 */
 	stm32port->tx_dma_busy = true;
 
-	desc->callback = stm32_usart_tx_dma_complete;
-	desc->callback_param = port;
+	dmaengine_desc_set_callback(desc, stm32_usart_tx_dma_complete, NULL, port);
 
 	/* Push current DMA TX transaction in the pending queue */
 	/* DMA no yet started, safe to free resources */
-- 
2.43.0


Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2119.outbound.protection.outlook.com [40.107.241.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A91DF49;
	Sat, 11 Jan 2025 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601828; cv=fail; b=tuq4DiP7R44v4cpDDhD5l69Jq7bg+/179qJh7oEbawU51qoRsIlaDcecYSsbwXdpUChokLQClsJEnsGTGz+miISYHkyvrwNY+wm6D3mxoODyH79TQELUgRvzDslisyKtGzDltW0s059P0H3s7wZLi9jGySZa7z3ciK9AlVX1DBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601828; c=relaxed/simple;
	bh=/sXRkVa/v4nqLMjB4CCp0qReBQi38jLskor4vZiYpC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9iV4/f/+7cfQeg0/4e7DF6G20b5H5uSsf+sZ9KiAYVFRqYoEz77/TndCxHI9GT0C6WA0YsIZEnMYM7KwcewZIhQMWhQPGOglHDQuqPiHbGl9m7ItV2EDVyX4Whd/gvSf29HMcKGwEKfR6+YvyZ8TAD7/RHaq04OuLJcTD5sh3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=CYUbt23n; arc=fail smtp.client-ip=40.107.241.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="CYUbt23n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKi9yeEfjrFlisSk2VaMNdkftQzlJ0XDj0X17Iz4mNQSej3XatuMy0ZwcPKQD2BFHaV83tkvVbH0Qeb07AN3DSDw+6uxcV9llfBVPg71mo+VN/ESgLuibhEt1Mac2tmfnGGmI0IiK3RApmLCnCgcvPl0mwktvcv6oNVhKTRBcQ4Dc+r/tvgO4f6/V51+MjoxlGSX/EpW70G1vWqcVLx+HmBg3GbWz48Xfd9Jt8MGFmofqXPNVW+D07d2zMK6WFMtcZt4bZjyaY2FDC66F8t3MUB4TF1guToxNwjNjjIFLPldaJO1lRI5GCoagjhsorKqcxvy7+zq4QaYhSwDwrjCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mmq8r7iH55u0xiikbV0jbgGyelMWtFOlIALrWIlNueo=;
 b=h9pFzxpnuWEfHdYSbMGCULaYj+DS+RY0g26Q8qHcRcmgxLbq1iceg6i/59JqSPJqIYxkKG8Uo9V4/KmJTTWE9NeCAYnsJPVaTmyVuNjFvRo8COQl0/T3vMtVNUGXBcSywqEUnPy6gxHgrePuLGd1DiomLSJPfUDyqCGkaHX5GRDUhJDfU2lU7uBkaWKAYcPBEhzM1jqS2gApwkZcIKdePodUQpULVfmlsdez3HXBByE0dBW9l8kYu4GkgcnvS8Niyw2aks3jVA9ODlGdPNPpXcLLbIrHQIgHOqpgsw/cq9QE+IEfb/LgEosWDZSrH5iVjU1MsGBGogznKGNGz6m2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mmq8r7iH55u0xiikbV0jbgGyelMWtFOlIALrWIlNueo=;
 b=CYUbt23nUWfRHTgdxU6G9Sx2ZmsEFWf5ekcujTPe6SWoWOMIN3XEB9BjAmnpQ6C+oTwLSHoP9cSGY1YSU1DmZIBYTDLJHXel8YrFSXN+IpM4MQHazlGFlIo3d097+LPPzf1A7rZYub4UPWe33bRzfkPg8oY/cZ8Z25bn6a8W6xY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by DU2PR08MB10066.eurprd08.prod.outlook.com (2603:10a6:10:492::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.15; Sat, 11 Jan
 2025 13:23:42 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%4]) with mapi id 15.20.8335.011; Sat, 11 Jan 2025
 13:23:42 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	krzk@kernel.org,
	gregkh@linuxfoundation.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
Date: Sat, 11 Jan 2025 14:22:49 +0100
Message-Id: <20250111132250.3642694-2-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111132250.3642694-1-benjamin.larsson@genexis.eu>
References: <20250111132250.3642694-1-benjamin.larsson@genexis.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::13) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|DU2PR08MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ce3ac6-e7e2-41e2-ec11-08dd32432b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uS4YQZUcU2o1/wXTrkD1xIbuNQsxABi1KXwFDDrNdw0MZJo6BJ9ZWdWfu+BD?=
 =?us-ascii?Q?ldXUM8ag2K3xHt1FFdpffxbvKK3+UnKtARm+3P6Gf+EDRg8yeb6k4VN3IyA2?=
 =?us-ascii?Q?YnpQNv/7n9NeQrjdxk9rXK6H+Vnsm9dJF2OfuD708MTN5sBQraI3xwf0lwgT?=
 =?us-ascii?Q?5d3pTLfAxGJ1e2d/RMBesJJ3EZQGspsQF6Yc0LlG5uZ5MFRvkJGsHfDahKx9?=
 =?us-ascii?Q?X3QJ7+dgTcuqVC17HmAXxTW479KqrNYZwvPah33S2RvaLUnhLhi27Gs5CDNC?=
 =?us-ascii?Q?JYFyPFxBoU1FSMDmOa/phaIhQkGzc0zUg4quFFprJ+CPOndV7889qYlzLBvU?=
 =?us-ascii?Q?Yedz/KUvYhQHYeQDerTD/S1tACHd+nFvZoJjM56ocbzeNsbySVU7f7qsZdSM?=
 =?us-ascii?Q?l4/E4js1Mf6dL51PICKALb87p+m8J25LL+myN5uCode2FYq/q938TODQjsco?=
 =?us-ascii?Q?s7lY1JYDP+B8xjA4ccCqMZueBUuTIz75yL/ZNZtqo+BN8R7taNgMmLO8aZmA?=
 =?us-ascii?Q?R7quf9kEjJKZbSVJzTXAC7PKPm0JH15IBIMRFiAwG+Lup0WfrLd5JJKT9+jv?=
 =?us-ascii?Q?ZCW9VhD09dZLmfs6+tyS1YvtuqyfqgvJF/yjwVsDZGBVd08knRFkQlr0UfRF?=
 =?us-ascii?Q?HxbRAYgvvClEp+XO5pd7Cu19c9mp7gdmE8b1muaB7FHB/lU2N02zwsqBn+jO?=
 =?us-ascii?Q?xm/G9qWo5XhMgenFh2yFSl3kZm46RSQX0iKstPnDiiasjGxIg2Y9x8gMtvdn?=
 =?us-ascii?Q?yP+CQcqyRcZh9pCfxdRroE7u/Cfv/XTCWblsiX/eTWtCO0o5BBHlSiHQMKDJ?=
 =?us-ascii?Q?J1Mh5EX0zNJ+I0EI7uXU6TXwIdYr1C3Zr+cJSSJclDH4kHVhImcvJzfLZfVl?=
 =?us-ascii?Q?0+knpnI+shAWbcirK/t+10PBeeCIy41bDsqZ+scBHKFDiHjRxqNDZyhO4sZ8?=
 =?us-ascii?Q?6AdWkuGV3u/rOvUk1mU5Uz0v5uZojllhsk7bKIn1velMiMtvraaX6zGAcKqS?=
 =?us-ascii?Q?fXf/oGrrOXhZyWFN0SuWvQyFcgmH3uCWuZYX03S8DDll7R83B1y6rNSVbZub?=
 =?us-ascii?Q?sD5pywhq6Vwk5ey5Ju5ninQQv3fK6L3Y7lf8NzATL/XZ3zjZNs6ubblALV+5?=
 =?us-ascii?Q?NcLin7icoatCJ84QABsQtHjXohHuFdufaYrAkRwsFUmHB6VFljHipWbSG/3j?=
 =?us-ascii?Q?v/Q3aPBRdwB7O8vKdxMjKLxYWAiJnPZZrvVVG6inidboya+jfwqERIJb0w9S?=
 =?us-ascii?Q?04eBHPwAqmK6yTCiw4qxI29Rr2SKTnsn/zgqPKodoTsYZi4SxiUFtAIO/XZG?=
 =?us-ascii?Q?6XFNxbrME+nqnrlOKzJXumxquKEymEDQgkPHQ1DvogwEKKQnj01PsMaJQ5lL?=
 =?us-ascii?Q?Z8m+tvVm8FOzAEVKTH0OcFcVEUyU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9MISVfzeJLfVVqW/PGCs/uR6fIoKcjfWhPtU4xIlWYwhEGo0dtHuFDDENEVj?=
 =?us-ascii?Q?qrRoO7FExiICg5WypqUNsTYLBYX7krhAwqauJO14tawoZJTtmdJPTScmv7Ew?=
 =?us-ascii?Q?lTkLxj3BR9mCeW8Q2DVxarSxrNEvFm+8HBwNfvBF9uPxoQXngsu9A85U8UDP?=
 =?us-ascii?Q?zSLJM0NcFr1rO6/ScjDUYKr6b2F4bQav6ABgCQP7EpJ0uxcZBuJQkK+5I6Dv?=
 =?us-ascii?Q?wVGWQnA7q9FtWd5yqb5wsCJ5BXvnv2CxrK5J54UpQUR7iF0Lw8ohZ/mfhe5L?=
 =?us-ascii?Q?3KXvwbhNPYwt2/xxNCRjBWdyo/t4wUnb0re+AFemRU11sl3X1BZI4WK8gpsj?=
 =?us-ascii?Q?Imy1JJ3HIbLB1GN/UrvjV3vdCUA0LjvOiOPE2+SGlxAdGSW+p+LmtR1rIdr0?=
 =?us-ascii?Q?UEDTTWEm0ok4Vaj50u3Uk3sUWdRQ7eTo4RiR1diOvtnugG3mIFKMht724zbu?=
 =?us-ascii?Q?dAyXY5ARggrSXuhBs7Ze/OnLx7pZ0n4m5oXlT+sZWccy10tNQfhvcGMvXd0A?=
 =?us-ascii?Q?dplA68Aj+jo2Ur2ekjjF/bLEZ7gU1wwPrhetxXZ9sO84nmjNIFxysbpzkppm?=
 =?us-ascii?Q?MvXg7IY6B0jeUSNufl4RKOuFo+io/E/R5M0fS3SFl3HWG3AoTF0MNwGWPfXQ?=
 =?us-ascii?Q?NEp95BXHMKeYi88KHlyxDHljcB6JuqBOfDCdoZPiHU/BhGeuLNQxNFTr7EJh?=
 =?us-ascii?Q?+xv2+BM6KJvl1fLsSmMDN2J1CDkSTkNkLSip+jLOb7lQ6OpR6CAal66ofp67?=
 =?us-ascii?Q?9irmizZ8XrpJCTKO3hgGuMmRunSdDNE0gmlYDybSdc7pOU7nRykycWrv771o?=
 =?us-ascii?Q?L4fcO5au16sVbcXjdncyC0KCqrDvf7YsFIKCz3jWWmkgN/QpdFOjuDaSmQaa?=
 =?us-ascii?Q?S4N63691T+ypepT4HVJx08dV6wi1qJyzkqFdREUl8XvqPAfXJFlO7vYWpHBN?=
 =?us-ascii?Q?FoPlT8xWNrz7X3jKbPI6sn6zm/dMUrvxNbAA7hfTCEJ8mfk5RxioMg7+S3dw?=
 =?us-ascii?Q?0ZAyQaU9+LwGvuKaoIeoop8DmB2m22p6jrxBtTSu0BBpySHvp0vG7pWwf3gU?=
 =?us-ascii?Q?h3yCeg6h+NIqq4h1oOBoRK2dTQhrJHHi4dtwTfpHwR6oj0M2LDVM/iLYW8YX?=
 =?us-ascii?Q?58UKtuATOcYanTtdBJmA+bw6dv/DDujYsUwZT5dt4ai83QQdfgkWf3y1Ef7F?=
 =?us-ascii?Q?QyH9qymj8NMzFwn/fHcfDUyt8yv3CoUsydKT62aXwL1DUQDNoBHHvOk6j0T3?=
 =?us-ascii?Q?H+Jxz31MNfbrjEwIHWCEfrgH7Zlg6cT4lXxtcFAE5ivCiyi/beCY4q18Wu+p?=
 =?us-ascii?Q?7qI/SeyOU2alUPLkDIMc8eAPAVqLF11C1uesORKeCrUSIJV+jGJ/GPt+a+WC?=
 =?us-ascii?Q?T/caW33cHQHEwcNgibLypvkU0dTzSPsfbIzuzUYXEMX2rhTs7/4z6qKuRn8e?=
 =?us-ascii?Q?a1xpCYxtUG3Kl07K/sfTU1KkVKB4j5vSxVWAzS5zinQy4RPlfy+sdttMN+t7?=
 =?us-ascii?Q?PEc5sTCICfI7Arr720uD8LeU5J0Qr9RFdoY5VbqN93T42V4siLcyzq9FoP47?=
 =?us-ascii?Q?c3sc9OdRm7Sa0norAzYgKcj8jJQpxE7WtEHvZ08+5iS0m2shJAP6+clVhqYI?=
 =?us-ascii?Q?5NHGqZmV5BPy5jkazgQuf/ywNns0oW3pGI8PFWSHZN17oM0x+ECmN1YJqNWr?=
 =?us-ascii?Q?txDE1g=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ce3ac6-e7e2-41e2-ec11-08dd32432b36
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 13:23:42.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hq/9FJH6F9D1YQhLKaF5iS0g6YhfShuA1KZ/ngRZ41LAEwhuKBOAQr5khdVgM6peemjtjQiB+6dXupOabQ2k0gUqIuwceRKAyFNtXLDejTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10066

The Airoha SoC family have a mostly 16550-compatible UART
and High-Speed UART hardware with the exception of custom
baud rate settings register.

compatible = "airoha,airoha-uart";
compatible = "airoha,airoha-hsuart";

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 692aa05500fd..2fbb972e5460 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -63,6 +63,8 @@ properties:
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
       - const: nuvoton,npcm750-uart
+      - const: airoha,airoha-uart
+      - const: airoha,airoha-hsuart
       - const: nvidia,tegra20-uart
       - const: nxp,lpc3220-uart
       - items:
-- 
2.34.1


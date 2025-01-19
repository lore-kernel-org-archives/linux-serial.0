Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2091.outbound.protection.outlook.com [40.107.241.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F61DE8A3;
	Sun, 19 Jan 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737291711; cv=fail; b=gLSBEK47dl8eNbpKTRL3iv2FnNDZjUtz5O7OKxJZUG8AdpY07lHkXVOC2e9sv+ODySY7ual4eT5jnpoJzJ1zaElZCjYzKOCRQ7shBcG1ePgo8U4DGWnZhyOUQBmPN2jKnm5xx5uqXbTJSOBIsjF10RfMdeFZveFJHgNJ+m78VJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737291711; c=relaxed/simple;
	bh=AxdwsLokCSa9sKYXEZqZpFd8geUkt//NG+4hPDEQoqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TyXMYYd3AnVLDBGqa81bioLYBRJGZMnBNLSkWzuN7lsSEjXUMFS+HtVx1OB1bu1czIBtjLXikFltdvabJLTDd+3zN8LJSQz3pGC1SOxrN0JXl9ED9fGIATPwEd7AkemeC7ySGqzwsZrjicnXiTi0MniFVWQXk7g93fLVZpZsqRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=M/4Bbfy+; arc=fail smtp.client-ip=40.107.241.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="M/4Bbfy+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGwSejRtpLv+NojXUDmCOXNk37DirxdQjOGdLO48Zv8AH7LxuZsQliDNbghAqC+jw3472q9Z9jPr7nbMEHFGO5lPSjRNqporjwHBfgMJ7ePFsalRFoT2cEPKYa3FqIS87La3PJeERpby+3TzuXB5o0QP8Hw602RN+Htmw/09/j5MByG/YmQXQNa52owzw+lu0IXUisfDszR+SP3YK9OmcMDQc8etyJHQ9YEzBdRO3kEwxOiP9GSEWnfC5fnAO0rWBlDg98HvkcPjG8ARCxDVStOc7o6v6QDrr180ACKNF4MEG9CQud6jn2wsnOV4zW2D5Haog+b9nhNv3uZA/tyBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABHtoxYPcotsRmf+DH3U5vxz560hjeM01DPpvyP+epw=;
 b=toDhr8lzzXfRYH7a5GcloX7BQ4p+IDdHcdMiQCEiSZD7t+co981N7DrPjIRMDNWMBDPn/G58w2ebmsTcsjrRph6A/hwscBu9+CH7IUMGkS3UbPtiF1IDeFxCDwo/x33icVz1ahOhZoF25tA2RhdfMZWtj9XriRgZudfdsHlJig+yhBl00/3+fqQafUUjOz5SiP3jTn4aYRVVoxwXOOYw2uJn213+0ZFJRDX6vLiynal7+FoK7ap8I7drn4W/zRRdCTyZPUWAg4DGqyM/yVRMHUclVaZPGGtlHWdTurm9hRUJALnr3rig1m1iHUOPKVawIIjHv5yUi2J7QCLXZx0B5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABHtoxYPcotsRmf+DH3U5vxz560hjeM01DPpvyP+epw=;
 b=M/4Bbfy+hg7lXITHggF0CB7LTnc/zSBdpM9LpHWk0aJWJPqrmkq4jvQL/Nymx49GYuv8v/rKV0vT8xd6qqjYnybL7dbuM6qEIsaa6vs9u3/7G0nfS89eIJ6vkbgD8Dh/Jyqd1BmIdBfkqYq//QNyMP9tCDVesF/7VgQbk1Ukxpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by AS8PR08MB8326.eurprd08.prod.outlook.com (2603:10a6:20b:56f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Sun, 19 Jan
 2025 13:01:43 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%5]) with mapi id 15.20.8356.014; Sun, 19 Jan 2025
 13:01:43 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	krzk+dt@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
Date: Sun, 19 Jan 2025 14:01:04 +0100
Message-Id: <20250119130105.2833517-2-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250119130105.2833517-1-benjamin.larsson@genexis.eu>
References: <20250119130105.2833517-1-benjamin.larsson@genexis.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE9.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30a) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|AS8PR08MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 0661b90a-b1a8-4cfe-1b11-08dd38896bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eggdndMD8RNAlE1G7GA02f3FS8ahgQGlGL2VkYChtmy2dku39fbI0e8KCj5C?=
 =?us-ascii?Q?A4pooL4wj1nM63MqozByaHDeWnvCQXM8n6YOHSqr5HX9NIbgMubDjRHATQ28?=
 =?us-ascii?Q?3TOAJl0Bfw8mbrG56IfYbMg6E3wdLNXN8oZ1caFtSJ5yB9NiQBTRvBOWcZSP?=
 =?us-ascii?Q?+64y5VY/yGENC+rvurBHdATjYGFM1r+Cs8U6Kk7NpXJIaKcyEQGO+40XpOmG?=
 =?us-ascii?Q?RR191IBzFTtL2lYPcfKNI68/ifgu0aXGkxa2phQ2rQz7dsaxqTI84thgfNVa?=
 =?us-ascii?Q?jghZXnpoJ7Kkye+KysWgPzkcvfoc3ufyhEdkHVtEzbDYSPC4IXgdR33FdkTg?=
 =?us-ascii?Q?OpMSMkKj/DGO8/mVEK/kzKKotlxIZHI1sLM+ZpHfCZcGXu9z5t3/hhpqRGpi?=
 =?us-ascii?Q?OXbJJIUBIODsfLuV9cRVcc2jAPdC9aN2jG4y8LMY7JFObZ1uR39BrJlY4T03?=
 =?us-ascii?Q?kTDkSGfSitLawgoZ+Rci+uuwPs27rpPaQ2GSD9PkXTPyoVL25LvSeUWbsvAg?=
 =?us-ascii?Q?rBBVE7LgSvSu2T21Yfb6jVoa4ESh/j5z48bjP+OoF+U46xBmOz+OQDirEoXq?=
 =?us-ascii?Q?ptKZCmX/EGlx7IQT6T8gS7OPcZn2hYwS2fHRyq89x+N74kh/Lo2ybyH/5w+L?=
 =?us-ascii?Q?90exRuUxBmqGoS8ADOFba9+1V9aADpW7BUeSH7Wt+VsdtICbpf7djIadrcwf?=
 =?us-ascii?Q?A8RXd5I9NAKp9o42oM99xb96mY7UE5r0bBrM+jo18l8pXgJGVwjoqpBbg5lR?=
 =?us-ascii?Q?c7iY1xYvBvpAIR+3TLpeDWrRg7Yau61zWAn0E2S+zZ7YS7o8s8oNP+fRhTcU?=
 =?us-ascii?Q?D+keLriSi3Ud1LJb+K5LBjFF6vHG47TnKR5pUOy6rietrIhdCjW9o8IF1b0e?=
 =?us-ascii?Q?E0jFuQvdVVLYpnkQPiiallr5LDgw582Y3Oa40xWl2cenva3s4My4n8/izYjq?=
 =?us-ascii?Q?nv0aMdcs1t1QvWtFH9+BTHCREJZK9V6cOkN5yLfp6BZl93GW1jiwW4n68xxt?=
 =?us-ascii?Q?zNJJtjLbiusDvxGWfk7qFPXhdToo1HlQfOZrkLnwbKt4mYus6QWqjnOEmW/J?=
 =?us-ascii?Q?jCu4DQp+O3JJzAAkF4SPyIwljC8c/bFpki9f/UMWjb74HNTzG78w0j/22/4D?=
 =?us-ascii?Q?vYj/Q97WrbmdEC08mRWwIxD05DyiT9Bwr7vqY8KnDwUydBPp/mN3ZwsCOnP3?=
 =?us-ascii?Q?FW75RzHwJsn4xapOaMuL+PTvV+KwLkmM8MVjvYMulIDDLy4ulb9gMh5Q1pbR?=
 =?us-ascii?Q?s/QHbXyeqmUVJQZpTKt2MiYIpvxSzULQQy1p+5CGeOfX0nmtaifGGonorTTv?=
 =?us-ascii?Q?GBjlijWcF0ikUDfrbrYjXl1NBUK2MWWWkdIQ3m0d7d082ntoP6SyhXSZAknW?=
 =?us-ascii?Q?C8TwuEobEd5/L2CFmyoMcGC/RYTL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zAXFoLxT0T9/EmmvOeHT9WrXf3BGWPE3J/+KI+Eeutg++lpLqDyP/+QFmmVG?=
 =?us-ascii?Q?aodmKnTfRMmFymvGMlFYfsowp6daLeHEfAizPvJtdR2VDw1lhARQhGLFx6cW?=
 =?us-ascii?Q?tl5Eme5Avcer+ovh0mkEGGIWVJMZxqZjduokl8t9ZpcA5bdmFjTlpAvcD7zK?=
 =?us-ascii?Q?DSteWjMe3uUUDh3Z4wBsutqFHFGy7nFLMpMCqZDO9Tc1rbcaCdaAsxQjdgu8?=
 =?us-ascii?Q?Sbj8Q38Tf2NyRRnEM2gpoa7RmKgdE4llGCjy9+LZxPll46WlBp8UTRCvMMRa?=
 =?us-ascii?Q?CkdXmokJtNuZ99N6YonijZlCXvC9+6jQi+0MMlB123vxG1cItarSPDmHxd3U?=
 =?us-ascii?Q?cIq6g1YLLI6KhfsofqTtJW0JMaksyuvKz2JsvL5lEcKF3N4OhncNTOAnDGIx?=
 =?us-ascii?Q?VC5VrjNKS+Nbj3Z2UZ2VCLwcU2T0S3lsTvueBDs7NonEnQbKPZCA3vWwx5Bd?=
 =?us-ascii?Q?2O9JlWLSWIdQSn6/dSqVcjB/UxG9ZOJ8mbVzpDAr171RTq4L1u+lNdhXKGrk?=
 =?us-ascii?Q?UFr/j9YIR0SN9u6HBekPxpThIap8YH9o7lmQEHmcXwlT139Afq/tlMUXvrlq?=
 =?us-ascii?Q?uJHNfsNw+Asg5VZ5KGcOpbH0HTEZqmQ6T5o4aSijHVFhXuMH0N90M38MmzwI?=
 =?us-ascii?Q?/l5WkSFFOkc8zbXLDKMEmGF49eNqFROGBRsQN5FwzhFD46m6cJVjxhLxjgnv?=
 =?us-ascii?Q?MVji6iSIWiVLLdD9DjI7hxAET1CF7lkCQDBsb7NHj8Q3ZrHi88ep93nJ0J5B?=
 =?us-ascii?Q?dWU3mefn6iIJcM2PvjRnKriByo0MF+DYa6gWrPS98AkT4XGdy8TwLN+mB13f?=
 =?us-ascii?Q?Eea81NtrEWg79DWs32H87y5u5shM5W/0rVdMN7qYNB4oJNavb9ALz5Q3ue0M?=
 =?us-ascii?Q?OPnyerAdakGFVIWT8A+Y9IlexBztgOEXFZDhURbO7HAvUxuXZygeVN5Pcj9z?=
 =?us-ascii?Q?zDVSH+oELbAGup4jSOr/3Vn8SvSLQrNmCW8m/Lrrd9jwNf0Nh+N4pguEObaF?=
 =?us-ascii?Q?lr+RMbjNKMlDX1USn6tOVke+Q82TddOfSZKG3n0UyyyZ0vw40lLggdyq7XpV?=
 =?us-ascii?Q?BIoKU7yiE0QXXnVZxeroemlk6tvJsCYRyBlgxMklrV2VmPhMFJMbRzQ2K7Dr?=
 =?us-ascii?Q?N+BNGtdKpDdLvnEimqJVgiF2IEx0atw43ydBtYdlU8v+V36ON/Vy1t1Z2DmH?=
 =?us-ascii?Q?LRBi/Qz9c6l7NJ7ZICmwz0IHa9ChhEmmEFCIN7o/WIdVEkZBpqqc4yB24TJZ?=
 =?us-ascii?Q?tzS16iciJnJF9/uQWmCoO9VQZWTVn20Ix4lSzAkU9KVHsBJBN8ZHYzgMzojm?=
 =?us-ascii?Q?QAkQONBP4/mi8nuRpdhb98tDwoyHgIE7wVFq+lIaet/Xwv8WuPOcxGsSDmEu?=
 =?us-ascii?Q?DKIqnUv9bJH3j3PFRCLtWsCj9aezQViZOqZ6oBBubETPlcFnAXblUGIuxokK?=
 =?us-ascii?Q?IcpEXvuvmMPGctuoxScwRQkABtL65PIuPhdhntYzqUF1A4KqPctVog72AdzU?=
 =?us-ascii?Q?CKGQ5HfTKDfBxT9sEPU8yXvaeQXdH3PpT1cttV7z1wQrcNcIzaR4qje8WHae?=
 =?us-ascii?Q?SO8FLiqG8bhIQXj/B9psjX/TPhiSpjT0FfQwXoPdKpakoFpRPKRpfqpLoIVQ?=
 =?us-ascii?Q?5gZTrY/pdeDoS+ZQKwMArZr9iXdAtOkLIuEfOavjIkAIxylknMH/ojSjeXgn?=
 =?us-ascii?Q?UNJNsQ=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0661b90a-b1a8-4cfe-1b11-08dd38896bdc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 13:01:43.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LanoYFyKdvUJSPiFHHBp1sTilzw9jWShCocXlcxeHDoDZctOY/WAXUUVD2lCvBaeliHWcWghPJFPc4jPEoTlOl9EC+o9phdZI3jD6fWGCXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8326

The Airoha SoC family have a mostly 16550-compatible UART
and High-Speed UART hardware with the exception of custom
baud rate settings register.

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


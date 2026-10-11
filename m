Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3AA446074;
	Sun, 11 Oct 2026 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791720068; cv=fail; b=QYX/tKRMxNBpR4yH7vciESQ3O2Z9Inc8z+/fm1s06/s8M7EEipSIKc9rqIyk2npqcD/eHRHMSrQmnnlEkbcr70OkQcN7yCjNk23DgInw8aVA6wm/0sD3MB5G7pvgf8Rv1GZ+pUZD/H8rGVT1/J/GT7nJj/ANk1KIzgDFLX/AC3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791720068; c=relaxed/simple;
	bh=HKTtvJ9X5R4uChaHXncQpHT4Jq4XaZHat+2l14ESVBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gNn49JO86fHCuzX2T7Twnk1IvjM9DxSHsWIQjdmgbDi6daM6kcNPAh3QzuWgAQ7WVu7z5KvNJbjEj6NsGs1Xysuyec8Um8Np8ux2GK6ZNAMfvXGZXiNfQkVTiJNtZSrhxdE0W4ExbXkysVl/hujUW7CYMp6Vo5bfZTdi820KU10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qxeVuer/ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qxeVuer/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct2DM17RkUo0YB/wBF6GsipV0xwSfePSVf2lLhooV/Z5gJnNws/tghv1LBa1EWZz7ZMlc0X2Nt4KizZFRWEsNfG5fKOPrPcrf2e/2wQq9d8DdFlNETh1KZNVvumR8V4N9XFzE1ot4qv0bO68nSc4gYd86iIGcZFYd0HLU3UVQmZ2g0CD4VsTD0sjcPKNNDyDE+i7hW0KWuxjTC+GMaibvbKU4X53LoRdwB45piF2xfmUZAGpCkCjw1LVH+mgL8HFYG/fY2WOpsfqKSbY1lsbslVXjb7ZLaTIW/vaC5jWmQwdb94WimCC5+sSeE4NGBoHMdDqB1WxLBW6iOQ1Rz3rXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEz4ILXbqQ08E96XlRqNGXqHcD0XWQZezlkQojnj0aw=;
 b=CLV0eZY0KOl3xwPEdRS+3D59byGSVnTmOr5+PcEgOzYco/zg9oel5ctDGL6JF59SKoQWgUseMX28XB08IbIVhLb2bWlPzVD0vrUxVRRbFq6L8E79XaZE838Jko6dvNmKdhXeNQFMaEhAJJM3wUS4tzrAMZiqeVFzvSJFVPWzL8gcbYnzBlBI7XIxfZAEPAQXlUYsrhIHXOsXZhIcJjcMFe8aLu+qLfbYuXoRalpYU0I9O4IJnLNxUhknNZ4uN3D72so3nU7tc/aDFk2fzFXto6MSu50LEEwtdHvjI1vmoeJmGu3weLDDCtsB6Uf8hnjGJEGtJDwJumuIBoOfcT/cBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEz4ILXbqQ08E96XlRqNGXqHcD0XWQZezlkQojnj0aw=;
 b=qxeVuer/dEH1nEkS30+lY1CfMPpj5KkkwHh+UXIFMdKsxIkLMNTMt3B5dbbMYXe9EN/VRN/1XfEctZnBW9CcFxsth4RtF/S2Z8eayEqGo8FGLfcZrT4NDghFcJOb2m1zuonJc9+ag9BDVzw/X6gygibS0281MSlnE/ukc2QLnrfmS7lVKpbAhQHD9/iqUXJbEf7tS9QgX5RY8uqi38smagbYqP92ePKxTx3ZfLiDThQC5rELAW+DVb2xxXgU1eBAADT63zC7bAlGUCld4rqMIIHMxIeeYc/Eaj1b7KvErdtjtvVJ8NlBSWlO2qDHIfHDKVKCDxaXHqw/gv1ta/S5Og==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8389.eurprd04.prod.outlook.com (2603:10a6:102:1bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 12:00:55 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 12:00:55 +0000
Date: Sun, 11 Oct 2026 20:05:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 2/3] serial: tegra-tcu: Make use of dev_err_probe() in
 .probe()
Message-ID: <ast7iZBLf0d/Ql/Q@shlinux89>
References: <cover.1786547950.git.u.kleine-koenig@baylibre.com>
 <e5a1565edc2b8c0241827f4b9c40c53fca064415.1786547950.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5a1565edc2b8c0241827f4b9c40c53fca064415.1786547950.git.u.kleine-koenig@baylibre.com>
X-ClientProxiedBy: MA5PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbe639c-e387-45d2-f8f3-08df278f4e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	VDP6v/vuK8O6/JfggnXRsLqqCH+Kb7SfxFrszI+Gr0YBqXDZ5emqQs2aGNU2XmTx1bfjOtC896bfGEHFZS1KWyAfxHPgJZBKjxsIOag8di9weZJPnbvSA5jsxum5adJNL9rvd/RoP1lke+KfiHdF71ssAWx8uhzumFAik92jn3i+NGblGbQNiYbC+izD3yTGUaVdpmzBHaF/dlKi4Rd+mIpf5vtKOfEtfUWLiaqrSQZJrrmwNA7F0iLvzfZmlxlR31zTCuDCS6GQwRXRNhAnUoy0IzGGhNFLGUJvOrEJKiZcrRRYKLTMXxqJhgKrcKFJ2roU7tfZ5RkkSHJiBUSgpdDUHGy75yM8x/uAzGj1Yg6Zy/flmmLCwrKkdaLkDUOC/O3g2OGTzdz/LOppsZGGB/wHiBRZ7aTeYxaqex39+GE3yy5IgLzuYg/gd/SuvagSaT+q/FCjwq8nIlnKRPymAukSAAIqU/iPKwR9oiJPTimveKQTYRD8lO112E2NuX0M0Mkw2dVVvmjy02pJk+rJENjKYposeGsibKYVlUCqOlzZ8ihMVWgUuT5mPP0OW0FwEEhyVnCVAacalXyOeH/0afWZ/zh/GwRTqWKGCfQ2WyLB0j+r+GXEIBcWEyPMTdqcAJ0fqGihChZ814B5o7u0tAXkYu3jNQTYb4Yosv/uRiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?0suz02XQm7SgLmUnWBJsAqtjaXFg15xDqSPK6L9WENm2PIM8XkEROOt/iY?=
 =?iso-8859-1?Q?vKBPLT0LCeR2P7wRbvOso+NbTdg1n1PUM3gTXl4a+7W85djtoGmtjU/+S7?=
 =?iso-8859-1?Q?7KajLBMBFqdbke3Xwf0uSNgRxg+upHvPAzy+Dx4aTZEJK7UeC2nieat8DJ?=
 =?iso-8859-1?Q?gePZqBaqKUQtzmAn2mr8rIfN+ilEP7cWC0ENuBFudHvWydKxGRVGqxQMi4?=
 =?iso-8859-1?Q?FWaJ97wf3N6cSUz365laFV9ra7F76fz5CYq4HYmBdvz2+U1GgY+4yL7ARQ?=
 =?iso-8859-1?Q?bcQx0CQXPum6KPgNF0jm8fWmlK44k+1xpApc4HlRr0yfA6EjoYS3xXWRs6?=
 =?iso-8859-1?Q?N6Hb00zN7aoi+6Ch4FFTibpQtZSg9lyHnBmE+XwQRV/HkB0eSc4Cm12L5j?=
 =?iso-8859-1?Q?rKWps81SJx5gl9AAKbesrF+xjrofse6KvmVVCI0Ufx8HLB3TgK2bAxkq9C?=
 =?iso-8859-1?Q?7Hmw3dmn2lD/FSb36sNMrtFmgP+6SnZVtIIScQ0ZN7UpYSfB6kDs85QqOj?=
 =?iso-8859-1?Q?curgO5XINdJE0oiBc5kELF5B+1QB+Cx/FIdHTz3dIAGsXb+bGAbv5A+YJb?=
 =?iso-8859-1?Q?j3tDtP6CAf5bWaBvZeZkZmzKqxtL4ygoKHIsixgdRbCposAqJuTMPkifF+?=
 =?iso-8859-1?Q?Bor4jgK/FBG2zrDpCp4BgcdwQJXq/TkmPlfmZ4Q7PsJBGCjqlAfLdZPJcB?=
 =?iso-8859-1?Q?mG9xttAeEyKKDy14SHgZcj6BSLsTylbVzPfwu2gTSWiICCe0Rz+lkOfkOC?=
 =?iso-8859-1?Q?V2aRUcn3Y4YZEjwv023BhgVawEDHaveFJ/KRyrzk6CPQjrCTToYNnME7J9?=
 =?iso-8859-1?Q?yCW0mggfhvb87Fz5Tt0nDrLfvzcCFr+HsJ9b7h1Lsw5n/NXDQfPo+APfSV?=
 =?iso-8859-1?Q?Drm96d+DwjWn+crlsVwtk9PW1JqoDEYWIyTtIBugxwK5Z0/ufw8rcJan6E?=
 =?iso-8859-1?Q?dmj3SzKnwAPN2cnZSHOb0n1Kv0jAynk4qbc0bJQlwgCARX46osZdLXE5ii?=
 =?iso-8859-1?Q?LDpInI035D0WYQQ4dUCsE4nHr5s6wAGLgNJXTLipRZqispJa0aiMNWYjDF?=
 =?iso-8859-1?Q?SkZCBxQ4Jo8OauKQxRLFaNDlF7zd3SN/v6bFzmIbk2E7auB6mjYFN0Brlz?=
 =?iso-8859-1?Q?hSA54pfKbRcieEymwJWikilTqQvD65joB9v0iHruWrtLsBGA9PSLo/M5mb?=
 =?iso-8859-1?Q?eHRu2NuUEJEN5R8ZBKim8Ou4arcct5046ScxmNGYhn06N68H+bkrrnJxtp?=
 =?iso-8859-1?Q?1XkVnaYYws8cNhQt9/4wvR0hyRr2QncKRAdllsgXtm/uuChBA3+PZPHrPl?=
 =?iso-8859-1?Q?a6vD7VFzZgEf/Cu8LYH+DaA64q3EJnnaxdayBcM0byPeSK0HLg8PBMtNuz?=
 =?iso-8859-1?Q?gNfCAbzZHota9I56A8vG2Spp0EkqOnA+KFYA9M/Z2prclnGmHuzZpm8gyP?=
 =?iso-8859-1?Q?Hllhjkm8QpejF0W69/Jp034Dh5kfSd93pPqJBVr52iKmOxHioKBB76Obdo?=
 =?iso-8859-1?Q?lF2Pw3nTz+6HZBFYiqRNhPDv60vTCHzSYVZtA4V0XfyJ4RtjlWyiIWQYn4?=
 =?iso-8859-1?Q?KMp0ZIwaiTvuPK4DVBG3OOjpML6AhZQkjlKTjDzqXn9W2pqUshi0+dnyDC?=
 =?iso-8859-1?Q?T3jOD0wWb5MNnHIS1E14BySx0jM0OBR9ljZX0Kvadb60j4ynxNbSaYx9Kh?=
 =?iso-8859-1?Q?F0CSUs2NEneWH1JEK+RO/W2XvUuGT3L/VqPdRPgDLe5mASp6ghzSF9Th77?=
 =?iso-8859-1?Q?4nA4R2wJJIDRNsYF55Of1g60m3nURI2JWZDzZ2UwsMmxsTMNwNr+Pqmny/?=
 =?iso-8859-1?Q?a+Xlf5W8ao2N5dSnzAOZdKimelYn6c959hWEf1JLM5eNFLWjcaL/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbe639c-e387-45d2-f8f3-08df278f4e13
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 12:00:55.5318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jukv7iyY41Cx5RZOvwIWjoiXPhjx8DD+Lm7ixTQhZo+qrlgc72wosmONV7fBqS0hgsYx038NV/aejZygn1ejWdlIwuQ2omD0aekkUraQ1cHw8mVuI4JHwH02k8+dwIIg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8389

On Wed, Aug 12, 2026 at 05:25:53PM +0200, Uwe Kleine-König wrote:
>Usage of dev_err_probe() is (sometimes) a bit more compact than
>dev_err(), it properly handles ENOMEM and EPROBE_DEFER and emits the
>error code symbolically.
>
>Also introduce a variable to hold &pdev->dev to reduce line length a
>bit.
>
>Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

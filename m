Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1619007B;
	Fri,  7 Jun 2024 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760637; cv=fail; b=abFXj5Iy0v+gq9A/FNBKCuh8u6gony5b2YYxwZdxazITvAl7YStfbYHCywzNB6pAiXU0e5ejylJqU/80Qq0+oqylMO7+BEY+QFoW1GCv3x74ZH/9TmusRLaLi4RYk/vb1VlLpLZ3ZMjGC9k9HU4J1Yi5rY6mXn3WDtFN4JF+wv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760637; c=relaxed/simple;
	bh=Sh79cRi7op3wQC+cZ1Vey1+gugWkRf9F67JuE7hsT6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S0KcOaRvyPr4DuQ4H1kKu+F9pDpCsfx+1BxNjfbjx8tWT0ahwo4L/J/cKdxnTTUdFBXpt5qCRYoxMgrzKcjXrlal/T9dpasj1RB58hutnVoPofcbsU/pFeneVQbjI6L2cWKFaYi1EsShoSVWBT2wUgUsFCH5Ew97/AQkLzpmH4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=D0HRITug; arc=fail smtp.client-ip=40.107.215.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="D0HRITug"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1VMJEROiIZNamhnUKA1PUGFcK5xAuB+DB0sDwrDYgQ1jZg7sLaAz6K0pgNmQrwEj2nvPHLlQwSU+EzEDkAMraWOfG06ollg/sMCcA+qqAHaVYhRVmjMXJBEDze7SKFLXp70eKvKVACJzMfvG2kDNZmh8deMWwGhc3z8ahgcXMYVKCnokbM28TWhnfAM7r5Y0hEJjKt0+wOXv9yZ6b+NlpN3TRR9XchAvZYHcil6WuQmnFRyjdCwr29i/QpfrDOKKDsgfx+pcW1vimDIXs8cfDbP4zXIOuYwh0s5uQCxmSrgTuTj18ilZjWDrZB8mP5gTzGiFFPp3MH0BArVKYXUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9jYIZd6J4J6wHuNAfjkJ7A7kKGyyvXVTPYPQBLh2mE=;
 b=WzdYl49JE/EWL2WSF06tlIvdrFLPp80i4Co0oiUaEZ29uWPHQ6ICpHPinxWqwWDkEMJaqnDKvjsULnSpuLG+N4dZqS7/vr7i9mljFyAzfloDZ8Tl7fG3SBff14tT5VlUJ61zSOiCaxiUrr9J6l2jVVxd4huNnVMpRTMYqA0wpocd1aZwxg+5xJynMgYUZZUEEXZm1GlU+GswWg0ql+jx/li4J0u8cguJTZhDA4l6e7F8CJ2uweNsR6qJvEyz73IIqZAy9mF9HtWGi2ywFWP1caBOHdnkUD3mjHgwmP/mLyPV0I8JCia5Dzu0+Z7/BdnNFvEjPurfzoB6ZIi35TJY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9jYIZd6J4J6wHuNAfjkJ7A7kKGyyvXVTPYPQBLh2mE=;
 b=D0HRITugFnKOchCGMnPamTzUW+eetDs91Ye6fSJ4+kZQDIUMuit80ldXtW20tXMwoBJ/+C4Ubk2IOtpmnEuf1WahkGh6DxsddTXkXTQfOFfaGoXOi7wBi9EntLGg+XD1lvxztw0cUjeavgVHg2kFFvi6ZUPkwXMfcEPPh84iAic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB5588.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 11:43:47 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 11:43:47 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 2/6] tty: serial: 8250: Add 2 ports PCI configuration for 921600 BAR 2
Date: Fri,  7 Jun 2024 19:43:32 +0800
Message-Id: <20240607114336.4496-3-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB5588:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e4c943-9d21-4228-64a0-08dc86e717d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eyce/Fn9Timetgzokosmh5idohF94gSTf4Fg9mOYYZONylMmsgyk4a6a6wYw?=
 =?us-ascii?Q?qTIHdb3j0XvKxKTUSimkssr5U+Mr+bNH1NSmkcakbgihtdbDKTvglYwtHO1K?=
 =?us-ascii?Q?aUg1g7EZa3SALyqi59BI6ENGGuJQEYZLIsPIBeMVgdNVbB95DizOgQv/FQyX?=
 =?us-ascii?Q?dFirvkoPCPwJAtA6EKj8MOxVhq3KreFt9GQM/9Me/KU9Gl+k/tLKilXNIsUl?=
 =?us-ascii?Q?L5CkwvfqfC196RQ1ySxSxaapCLgHS1RFIvvYbbuzr9qycCztBVNtu4yHepDo?=
 =?us-ascii?Q?U9MdBQnQae5W9eOt8twYd71ot8m7KW/gTtRHQL2SWGDKvb2xdE1PRdmM1lKk?=
 =?us-ascii?Q?NkEMtY84XCQsKMoRQ+QZ2MhlS+pgPp90a/VtJAETQLPaBKfw7AJA9SC4VOV/?=
 =?us-ascii?Q?OXDLNvpsdJQ5xm3TYl7L+uPif9I6qdzFRjKzt2LFo70GfSBTiFfUcwrgeep4?=
 =?us-ascii?Q?0VAEgmOn08p/RUrLAXbej3/HUHC9vNATXIMtiSvbJZWcJPuBI8kpl6/mj4g0?=
 =?us-ascii?Q?dQ86KEDGRXIz3gSKz63E/52NVXwd93XONmX3PN9EHVfRESG0JcPihBEL5EA+?=
 =?us-ascii?Q?HD7cl8zDYtoVDRvitXrBd5pUyNLuxPxfRd2TRb5644OxYeTNCTNgp/J9IQEC?=
 =?us-ascii?Q?a2Ju0U8V2uuXCFtLlgwat5gLaKc9zSxoGJixseTDy2oLwj0vSSaM+tVA187E?=
 =?us-ascii?Q?1gn0Ve5csuFz66e7yY8V9puvSkCZimIYz09DWKe9A4N/+40PNd8pR5CVYOo8?=
 =?us-ascii?Q?wRxii+P1LsBHT26m3FB3Q7bZxLoRZCE/iRKNdsgLYDL/tDEQhVdMJejVOcsV?=
 =?us-ascii?Q?6af1dAGeRfEUSRUcaHqqkr8EkeyexkXgWN6YFoV2YSiK7pm/KZmSBniZ3uus?=
 =?us-ascii?Q?WMX+M2lmD6PjKgS8NFb68vWQrJCaDS01YnT+aTV7EGjl6eMXdtnkzv7Jz9H0?=
 =?us-ascii?Q?MaD+bUhQAcK9qe4Xyr96eJ5FN4cT6sGIN3SLjDxZz/+pLwlvHJC+1x8Gryam?=
 =?us-ascii?Q?LaAT/dM6y2O4g+OrLZ/VH8JR+6kn8F5nVnTkupmpPQEmN/BWrViIiiX8mIt1?=
 =?us-ascii?Q?TyvoZ5PNfCY6302MWVd1IogY/os7P+kvDdEXuIi1wY1VcMrgih294yCe2Kit?=
 =?us-ascii?Q?i/uAIjQZlkbJ+rKrxk4aFjauH6unvd5OB65ri0Vz5gB5Tz8w7BB0TlqwCmLj?=
 =?us-ascii?Q?9b/d8si4g47DDSFm4y+HOqtG/mr7wPY+/sd7eLN0Veo8x1kc3/jctgFvqt3s?=
 =?us-ascii?Q?ytAzfrinnsADOIVwezTncxLy8KR7T4OpOq5szVfNyBpkEzU1fcxj+FbKHnYZ?=
 =?us-ascii?Q?IebR8BuINXEnTVurVX+7YZ9FxyRPbbio9DZIU2h67f1dH7Wd5LiLeb4DgOwj?=
 =?us-ascii?Q?t51bCQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JDLGy8n9L2HNJq2bwVMNI94Ix5KHiR7Y2wgpbzayL/KAItNB2b+6obKXKuYc?=
 =?us-ascii?Q?LlssBhCt5Jq8jKG+WImlP40COL+/P1yv0drkh6H9KdglBcD+rQraMPMM3OEl?=
 =?us-ascii?Q?9btx0nlQAzg/0OreAfHV5TNBq7GkfP55YiAAhnCjGrSt2hiZwHz5Pd5CXc3+?=
 =?us-ascii?Q?/BTJvDCVYqlpWuBVEzoZINhADGTW0MimqOmU4B9XwyWM4VkbvYTH7eDglk2I?=
 =?us-ascii?Q?Io6fszWGU9xedmUTYCHtAtELAepQf4TnRdPCrswc27tQMzAvOXnttTBsYdTF?=
 =?us-ascii?Q?Ue7W1dhbnnrcAzwX6zWxOoasjWITXIL4inb+b9sZzzF0hKFOGATs5XJSWohi?=
 =?us-ascii?Q?e+2Wf1GeXwXx/598fMvbpDbE8NYTLfjoN4fzusnNcbrg6mnp0eSYb/LOCOZV?=
 =?us-ascii?Q?WBkyZ/kn9Q34EbtWZe8SKsZNORuB3B9lnwpoEPuHRSD9PA2bgLzl3Xi/HlgX?=
 =?us-ascii?Q?80VnEWQMzidNGXoffxGUF9GZUuSh3bqzQYt2OYVuEEMD0e9q5mlVmcBgFCtG?=
 =?us-ascii?Q?1vxudv/eMwKZwvmmm5j641y9JjMjlu4azmz0ZbVZsQDzf8djNAhxJMETgCod?=
 =?us-ascii?Q?uTJkEHoXXRUwI4l/XaTOvVbIhUXO/9f37tSUVquVNm9lF2vtGzFKAC4OQ52/?=
 =?us-ascii?Q?uUUO6rrl0sfoSEishXltVXNeoDgsvpK2+OQd/Q1MKbo/TC41sp3QlUUZBg5R?=
 =?us-ascii?Q?ZiyJNAmyRCBM25+C9eLGL4B4gdTZLpzvOohkKYPj2OvmGFM43MmDfFcNQ7vL?=
 =?us-ascii?Q?41wK2st5wZ6BOkINDp26QBRg1kqQlcXssXCwbxfSsI0GiFJgdDMW2t0VwmO1?=
 =?us-ascii?Q?CPJGtSxQ35QVfjXFqC4ITji4Vf+pgDd3q3KkhE45u4vj9zzkPFztv4Tnd6dh?=
 =?us-ascii?Q?5D/dRveqMWGsCldNZ5ZhykPSKKDbgLuBSCFLk2axsHZaJPQ83HUb5ZUCUSff?=
 =?us-ascii?Q?Xz+2Qg3I2QTs+h7FJPo/ISz08S1cD2l689/1extEuF8evXTaMO4rgkV53+gS?=
 =?us-ascii?Q?RctG8Xn6/6I0XDDdZ1goX8sjRBiL2068hucJonLxbhZZij9eioyNJZERiiig?=
 =?us-ascii?Q?GDk0w8vn3ElB8siBQKc1fFugrhB46X3yB9jP9wNk5wsAsoYrZ9GHFjxgIZWx?=
 =?us-ascii?Q?0Vet4FvXzNO9iSANQ5VBaB/09MW606Yl5OLRk1lii0UEL0c5p8ujcLWeUCrB?=
 =?us-ascii?Q?QakRVKL3o3WYF+FYlmWaDh7Vmrl6+DmoPKqCSm6Qp8wGNzFKslix21SBd9KO?=
 =?us-ascii?Q?xUf1UThsUX6F6UbcC07cxU6GFKeLoOgSE61tH4IMlRMYwFOepYF+2mckldAq?=
 =?us-ascii?Q?BFEUp8sWvZYiKfK7dU6wAQkgxPDZ1EVOSIOqPFJe12vkE+bSV3t9+rahW0Nk?=
 =?us-ascii?Q?YUFA1q9LTdzxquP09qWFsEmRtCyn/ISIweBKQp6wn2PNYOzuX6D/jnWrslcq?=
 =?us-ascii?Q?TtDcKX/ZTMtUGdzejF/KjLyMcKvE736CX0z6eK+AGIy3flnaU+gSqMQTGTHF?=
 =?us-ascii?Q?jX0YtinQ09U356BIEtX4jlcpG7hR7FHn6ge4i5Qwwe7NPY3Hx9GddARwlSaO?=
 =?us-ascii?Q?lmxGPY0QK2FzaI3wpVMM1De+9GkjsbsqsyUnDMr69c1RFUttfR02OZN14/81?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e4c943-9d21-4228-64a0-08dc86e717d1
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:43:47.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+JDLc2yLDshGvzS0GDx5qy8rjvLMmQrd5ndEYWc+Saeek0A9pk1kgh3bxt2aPwLn+gUKau9ytKmlIvyuL1zBbqcbUAZfj2M1Er+Bp3ACZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5588

In PCI configuration table, there are 1, 4, 8 ports for 921600 BAR 2
except 2 ports.

This patch adds 2 ports PCI configuration for 921600 BAR 2.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4e88ee07e548..4964cb9ccaa0 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3043,6 +3043,7 @@ enum pci_board_num_t {
 	pbn_b2_16_460800,
 
 	pbn_b2_1_921600,
+	pbn_b2_2_921600,
 	pbn_b2_4_921600,
 	pbn_b2_8_921600,
 
@@ -3462,6 +3463,12 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud	= 921600,
 		.uart_offset	= 8,
 	},
+	[pbn_b2_2_921600] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 2,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
 	[pbn_b2_4_921600] = {
 		.flags		= FL_BASE2,
 		.num_ports	= 4,
-- 
2.34.1


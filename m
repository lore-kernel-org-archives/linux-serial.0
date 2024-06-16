Received: from esa.hc1506-8.eu.iphmx.com (esa.hc1506-8.eu.iphmx.com [23.90.122.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F1481A5;
	Sun, 16 Jun 2024 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.90.122.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718560943; cv=fail; b=rBfMcKlaPOh6+tChb+XOCMQLYq+X7zw1pSYgMaq12P6+Xwg6KV2Xzd4CEZrEkXipDTefdhn+LPatwmrEX5IBCxvVbtlQ+a6akWfd6sTbX3xL2PNU0bAAYSXZ+VfQSSZzmK114GYrlhFg3nTI3bcPCYwwX7xA+Z1MbPHC7GRXPXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718560943; c=relaxed/simple;
	bh=wrtrYmhRwJmgGUW73ZJHV4AEjpjFvRBdtJ5OtpV/oC8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bi46WHLrP1THpmwRKzoqIb0C/o1bST10Pnyaf3T8Oz8ly+OjyZWS3X9hF1/dJyNCyWFV2rtVR6YHF4KBZIWntQSjgGI10jtRVTsgDtqyeUwwTuc/Z5KiFCkTbQaZHd0y2ejOzikRtSkflc1INU2XNo8zUBFJzdxACam6Asyjgjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=renault.com; spf=pass smtp.mailfrom=renault.com; dkim=pass (2048-bit key) header.d=renault.com header.i=@renault.com header.b=K5ycxGPW; arc=fail smtp.client-ip=23.90.122.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=renault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=renault.com header.i=@renault.com header.b="K5ycxGPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=renault.com; i=@renault.com; q=dns/txt;
  s=DKIMCES1506-renault-com; t=1718560933; x=1750096933;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version:content-transfer-encoding;
  bh=wrtrYmhRwJmgGUW73ZJHV4AEjpjFvRBdtJ5OtpV/oC8=;
  b=K5ycxGPWm78FyhuScYlFdb0nZa+BHnZHaeTUwNMa/SLnW346Vri+o07Z
   XTz2KzYjagHkT3q9+lI6c7JFFEXyTGuCzLHiUCckzazrGd74HVzAnBNDd
   9AyW+wsCi8FeIVzbdf5me/qNeQALf24Yp289PAKzVJAFlSq7EumhkM6RA
   HMwa4M+em6JDrVgHfemM8C2CpCk753qPaJpJL/UUkdev9GGJ5OG7b9HEv
   VmQmwSnDPS9F00AdYSyaeJMe/LSpM3c1odXUb9L5zEn2rXHLXVlzI3oU/
   FhCkAHyLOhGzB3nVJ1nPwKx0QUYUbVS6ulx2cHXwHOKaQJlqyKMfOJkeJ
   Q==;
X-CSE-ConnectionGUID: ANpCoz79QtuHKRpSDpKYqg==
X-CSE-MsgGUID: ZpGP7uUzS1iHKAAhL9TOyQ==
X-IronPort-RemoteIP: 104.47.2.50
X-IronPort-MID: 34041083
X-IronPort-Reputation: None
X-IronPort-Listener: Outgoing
X-IronPort-SenderGroup: RELAY_O365_RENAULT
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-db5eur01lp2050.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) ([104.47.2.50])
  by ob1.hc1506-8.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 20:02:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFxfNu2d3HVxN8ckMHf8pos6a6ucAfkf9VOgOtV/eKOrJ+qynoy1/D+TeJmEpp9K69Vjrax1tWXWKjf2zOF9oWcAF8CTXIYLSwrwtkD6tKcPqqRSM8nXYheEbCqNq/rc1Sehs92jjgzqcx2HpQNkaeYW+sawikkEKszT2mJthXZ4cNGKLMwAbXgBHLaVQlxFFrNnYiHrnQm4l8aQDhleQDzyB72X5+jlgoPUJBhQeWTrUBm/UiusgjwKx4ijKxiSK4LZUNTcbQrrc5ERZ9rPQjugwvrVfsfBI52u51wmomHU2+SkLEZqGx9UhM1kywrivNTjgG3LtUb//kzMRX/itw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl3gigl2SaWaN5YT22OmGZz6sf2X06PMjbU5hWjhxUY=;
 b=VNc0RcsU8N4065W3uHtWNlaHOjeOudoNhdzucJUYYhwVCB6aOC4mKjGJaLHJC5mL7/3++xmzdjp0x1shifyXZH3u2Xd7L777ofom32khRXqXK5GIxh8pgzMIaUGfZxgiepI+e4/hOF+filyq2+YYYmUYLmP7n8vRsUr6o4hJm0FPA5CWA64Sb8Paqa95ZGVr4kBz0NtYI2NThFJIok66x3TWqP0y9HJm3rgnLitVInEtNpy8lPhcQKYUpRUyDqWjfYlG0MoShUsLPf0tfWz3oAuO5+ZqtSNuJULVfaESu9qOs80R9povkF93d4LuanTkDZ+zV52E++FfBtt9LRaEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renault.com; dmarc=pass action=none header.from=renault.com;
 dkim=pass header.d=renault.com; arc=none
Received: from VI1PR05MB6782.eurprd05.prod.outlook.com (2603:10a6:800:134::21)
 by AS8PR05MB10673.eurprd05.prod.outlook.com (2603:10a6:20b:631::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Sun, 16 Jun
 2024 18:02:03 +0000
Received: from VI1PR05MB6782.eurprd05.prod.outlook.com
 ([fe80::32cb:44bf:3eda:30e5]) by VI1PR05MB6782.eurprd05.prod.outlook.com
 ([fe80::32cb:44bf:3eda:30e5%3]) with mapi id 15.20.7677.030; Sun, 16 Jun 2024
 18:02:03 +0000
From: "COHEN-SCALI Remi (AMPERE)" <remi.cohen-scali@renault.com>
To: "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: [LSM/Landlock] Adding ability to sandbox TTYs
Thread-Topic: [LSM/Landlock] Adding ability to sandbox TTYs
Thread-Index: Adq79XtfaMnSWb7DS1qpstx3E3o4lQEIF6Pw
Date: Sun, 16 Jun 2024 18:02:03 +0000
Message-ID:  <VI1PR05MB6782D0D70A2A313434013F9ACBCC2@VI1PR05MB6782.eurprd05.prod.outlook.com>
References:  <VI1PR05MB67825BD1C2EFCFCBF7521F7ECBC72@VI1PR05MB6782.eurprd05.prod.outlook.com>
In-Reply-To:  <VI1PR05MB67825BD1C2EFCFCBF7521F7ECBC72@VI1PR05MB6782.eurprd05.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_fd1c0902-ed92-4fed-896d-2e7725de02d4_Enabled=true;
 MSIP_Label_fd1c0902-ed92-4fed-896d-2e7725de02d4_SetDate=2024-06-16T18:02:02Z;
 MSIP_Label_fd1c0902-ed92-4fed-896d-2e7725de02d4_Method=Standard;
 MSIP_Label_fd1c0902-ed92-4fed-896d-2e7725de02d4_Name=Anyone (not protected);
 MSIP_Label_fd1c0902-ed92-4fed-896d-2e7725de02d4_SiteId=d6b0bbee-7cd9-4d60-bce6-4a67b543e2ae;
 MSIP_Label_fd1c0902-ed92-4fed-896d-2e7725de02d4_ActionId=94b0a7bb-86d1-4b8b-bb20-cc2b334bb84f;
 MSIP_Label_fd1c0902-ed92-4fed-896d-2e7725de02d4_ContentBits=2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renault.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR05MB6782:EE_|AS8PR05MB10673:EE_
x-ms-office365-filtering-correlation-id: 7ffee65b-8682-40ff-bbb8-08dc8e2e6d71
x-connecteur: On-premise Ironport
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:  =?us-ascii?Q?P76CLBW76KA2PaEuDqLlslPK32iB4ya8ujUgKD0oQ5Q/ZiLlRuYbDJaahqmr?=
 =?us-ascii?Q?2bbLKfU7YwUh/MjkfH5kfjBBwu295x9GhDYaBxwRhGlhuTpQLpte1ydQaP8A?=
 =?us-ascii?Q?TKSut/U9DplcsTtm8/Ioeblx+TTPJwWVdw0WEc5Qb5STxQ12lp/xa/zB5mzv?=
 =?us-ascii?Q?SztOErhO6FIWarNOIM2qUlt6S+kqBhN2RRUCkJRHiuCZEGpuT4e9mVs6+VjX?=
 =?us-ascii?Q?hTMn+gJClDIR5ARgM3JluTWAoP9Z2NjAdtG7LUSKZrI07nsG/yMbXbmLyoo9?=
 =?us-ascii?Q?wF7zP3lIAwLkkPeekcz5qZbGddnACquKh4xC/hwWqKDN0G81256caIsztRyj?=
 =?us-ascii?Q?fXV6QmMtCtBEAOacLYly7KwkM3WKf+x1MIMGxCdONwJEVPeQ/u39ztg1p4TY?=
 =?us-ascii?Q?jQ+fqv8PItwKxK4umIcNztI98PbOxWDbeJvDfbuVo/9SfflFGFA58Av6OM7U?=
 =?us-ascii?Q?5XdQ1MpsanzbeAO3sOfYcqlTAa0lXy/19zeD1eHKO3vR5kwnVoZFu03C1QWb?=
 =?us-ascii?Q?b98sXkmjQ7XTpUHJxSlekUYXKYGKYhihAKlEl/wb67F9W0L/lBkJj3Sd07DB?=
 =?us-ascii?Q?+XEDQX/O5JuBtVp23Vr8YPcAb9B2hC5gcCG4Tu6TGp9I+pxhfuPu7I8++oXM?=
 =?us-ascii?Q?tdWvIAHR9UGKqD4aDCl1XvRAu9SMHmBZMzMdMFwuvwpO/NZ3X2S1MHjnk1Eb?=
 =?us-ascii?Q?Pwk5W5Z5ncRB9AdDvMlNPUd1VwZLQF37AxYnCK4Q3gIwn5gGVWfCLwtqBPdn?=
 =?us-ascii?Q?ZMuNjOB9Pk3x4MB3OP+pfo0YrPNKj1O4Xr2J0D/QtVAo/YZLNjxoCYbUSJ5M?=
 =?us-ascii?Q?byCzctc8STEJ6AAXnV/aKAm6AasWWroZNzfaHq3hCX3LNKvjncasv4jEffow?=
 =?us-ascii?Q?GpJTgkMvqcnxWDaG1xjOLxLwkSR1WnzOG31TwVt9ys2MDNzHPf4REgb8AjKZ?=
 =?us-ascii?Q?bx5tenevpkb5w9iOcPAmAagfOjmemPnyrjF40ZxE+8ACjBgCB4lGsVlu/GsV?=
 =?us-ascii?Q?7haMKG+j58pF4PWQxUs3OfzITPhkfflYUemOf7oB22CgtnFPfAOq8uM+0VnX?=
 =?us-ascii?Q?A12/zN7VRHv3jaUt2+C1eidainOqZn6s9iW/HaCJTBqK+kVzZdJ6mR0vZvN6?=
 =?us-ascii?Q?Xru4k4COYqsL9qjciU3jStJztkeqx+iOOjQ/2bjc0u7z1CoK6kfAk/G5BrwH?=
 =?us-ascii?Q?7ErWGoM6ZqMu/MIaJ0zZJl0Q/bob0wfZJLYvbA0itFNtMHzjmAlk4i6+tlc8?=
 =?us-ascii?Q?qpDhmK98P7L34Z+w3rXUnWdKKqG53b/bzO3NeJ+Gt/53t9vQ8NpDUY6vTuMj?=
 =?us-ascii?Q?3h3wxiJFrxgJDDRnYuABm/+ii2ftWU6sOviSxoX6YAHhZ4q8mCXQql5i00Ht?=
 =?us-ascii?Q?4UofKgU=3D?=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB6782.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?/NY/EyyxT/zn/D9mDkCh80H5DSAECXXVX4ZbIU7KczOqHwfFKMtMNeWE8yGo?=
 =?us-ascii?Q?zFz8g5Yl2owkJh29h/H67XosmFZDMdb5X62QQyNHMU2EXH7/Tkqjnj1ecNwP?=
 =?us-ascii?Q?LamL1FAKj4hLxzPfYtAcNG1EOr34xsJfyNYoec3NCbGmGtQgq5fX5OIsqRhS?=
 =?us-ascii?Q?wkQgfuOnc92B6ovq3bLeUviGjPTOT9nxxqKE+MVio+fDfVlLdlR0RqfdnF07?=
 =?us-ascii?Q?vhXZeLgmyMYaR/BDi0V3WGmadHK7nzKRArDtRrAjo8/W7ZbllSxRaCT5Wq66?=
 =?us-ascii?Q?3+8MY12I7IzXMrjDFhGmnQjZvYiEo0m4YlHr4RjxXSGM2JfVi+pRiH/bL2aR?=
 =?us-ascii?Q?XKLkvHNdYwHkluUjEw4kHX3JA8PK47z6enjQyCWuJUfy6OyGl9s092a7aTZR?=
 =?us-ascii?Q?D87V00JK+9cdkhfQWZWeXfbHh/TtRFHcDFOL79EsmMAkvEJfsmmWViqRT5KX?=
 =?us-ascii?Q?NiSWbpFT9XpnHK+dsKQBiv10Mv/zbuYVogn7EYtsD6yRuvGykjbyEOH6mZsN?=
 =?us-ascii?Q?4vrG1Kyu1bT75zWLX7Prq9MCGCEv0ZMez4+eDJaIf7niDpAXPXd1sZRtkPV1?=
 =?us-ascii?Q?yWfi7NBIdnVNjvUEicR4sUINuFKByfIAfWCqwibuCN9NIafBE9PafV/i+8Ei?=
 =?us-ascii?Q?X2L5GYUJB95AZDuJ7aXFnEJbKEG0HnV0f32bVgKVM5aSV9EjjDNoo7gopECj?=
 =?us-ascii?Q?qZkOoVo++ziGD/JkyzibcUu1SCKo/CEAOvqN0ZDToh5EYefvkY1PWKfFkujp?=
 =?us-ascii?Q?C/GmAduOD3eadtFXnMQnN+edGD/v6pbmWwCRSGRuFCx/M/HX9BuYT2SauIy9?=
 =?us-ascii?Q?/liLA440zi0BzrReilSDV2QANIXrbq8B7JBD2VRvGNy1g3jlDSzCcW9cP4vA?=
 =?us-ascii?Q?eEBa6wpupmArB646RZf2K93dzg1xH7xemtjLF81jBMrNb3iYM1r9BORGzN2G?=
 =?us-ascii?Q?3KKFRQhR+nSvCQ/+aXksZvfx/+Q6FldbCL4DIHm7vw5ZSoQBvqdB0Fwkn5EY?=
 =?us-ascii?Q?D1RAwwcmdVvpnDJvN4CE6wcnBW2MHhgvu1G5lH9fic7azNF9rBmsk6FKMiPz?=
 =?us-ascii?Q?FA8oRlLmaiH2H7/Q6TKwt9BeHSxA3khq3iRzwQugGDeJqAWyIBH7LlKT68AK?=
 =?us-ascii?Q?P9H8KT8Bb9fnVa4q8hRwcXtQB7mdKkQucMz1J6/7hLYysVgf+Z2Pvem4j1wp?=
 =?us-ascii?Q?YaKhGXFFapcYEbOJXp63ry506hTnnTXuK5puYss1t0m+jbrfjlDRfSQQvOZx?=
 =?us-ascii?Q?BLfCw7PaEV+7SKvLPunp6Xxu9bc8ZGvTr130NXeLLSJjlUMzVvdCwotlb6QJ?=
 =?us-ascii?Q?0U1JSiuvQBDSnbxjhQg5kqwPmF67M0fmCBK0WmuOzGhRYteVCXa9Ms6Vu9Rz?=
 =?us-ascii?Q?GHZ8Ci5EqiZ+isU6zuoKxu0AmoeUYAnbs1BDozTlN2Dv74yQKdsxzo878mWr?=
 =?us-ascii?Q?ov7IzKsAyGuj2AIuMKBLPmeJkLurniZPNfj3/WaUvk2t5mVSO0Dzp1h30wq7?=
 =?us-ascii?Q?KD09dWyKtR6Qf6ZbpTpqe/wjzyXHe64q+HA/gZesxnQBI0ANmHj/oARE8k+5?=
 =?us-ascii?Q?tihdw/63Lmfx87DEG+T2UVDFmPR4yP7YBVzv+A+EIeuTqARkxXHd3yjB/Pvs?=
 =?us-ascii?Q?Yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	Lj9xGnQjpdOTCOVbb2K8CkMKgC+QxoyToe50p0pDs2Jfd1kxay5bV5lSR9SCr/0fSMTyuXJUhmAyCS+puO4iiW1OOBiphP3j1qPNj4vrco5FC+R0yyfO3hyB/rVea9B3GP/NXBoOcQmGJUbn0ILkrhpXl9uvmCkbF/cV3GSVIOrt+puTtUEpZ632PHxBCsIrVdqEjnuzMZeXNdIG/DZ/Q2WPZv4JR1Ytg/U9/DdtCzPTpOKyYl/qka71vxR7LsmOB+pqyFhvZkKD9aeLAyLO/C8IHtajgI3zXiyNB/m8YVbgqAJ0R4S8q8LXM3sHDm4UF04yzMWRmmf6kb0gHpsqV+RmFhiigyojM4i8A2Cx24OI7LIuiyOj0VOB5mo3lIWtPvTvbXkX4rCx0Xfq1BVHxVzmWvk6Al3861V0hJeNJVZtuu+i+DgrRd2iMKHztPhf4CdI6xKylHPQ4JQrmA/5MmgR3eZ00BQMdu8CCq1wsYsYQGBXYAKGoan79zqKT9GF3fVpqK7esU5c0Jb0LF2G6hvBNy2zca/33Zra3lqimh61CBRa4BoRjx8uet4EuKHoB2X/gSX1UbOU443lIkxLRA/wWeBGAXymH7qddX0EQYiey2TXFhGYhagS6637Zgqo/bCHyPMm4KdDhOan8TADPg==
X-OriginatorOrg: renault.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB6782.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffee65b-8682-40ff-bbb8-08dc8e2e6d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2024 18:02:03.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6b0bbee-7cd9-4d60-bce6-4a67b543e2ae
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6C+w3BVhO2HOerkY5nDCNZhIslD0M/Ul+6VF4oyGUYfiq4sMgZKlNxpd2NNuKQ2kKAkYWfe49LkRMZrmSiFQ0tLfsosUWUAddZbglpFT2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB10673
Content-Transfer-Encoding: quoted-printable

Hi

A feature request on landlock is about sandboxing ttys management. I'd like=
 to propose an api for this feature but before I'd like to hear from you ab=
out what could be proposed to developers.
Of course the standard approach can be provided for "locking" access to som=
e syscalls. It will allow a dev to setup a ttys mngt for his app and then l=
ock it. However I think this will not be enough for most of the use case fo=
r applications making an intensive usage of tty framework.
So I will go first by proposing a standard approach. But in a second step, =
and for also allowing apps having an intensive ttys framework usage to use =
landlock, I think it could be interesting to propose another approach: =

something as... providing the app a way to define several configurations an=
d allow it to switch from one to another
or ...

Have you got ideas for this ... I can't wait hearing from you if you have i=
deas about ...

Thanks

PS: I saw @gnoack proposals about this tty handling in landlock and  they s=
eems to be, at least, a good starting point. I'm also looking at several ap=
ps using teletypewriter management (gtkterm, minicom,  vterm, shells and on=
e I specifically love and use, emacs).

Rc5kali

Confidential C
-- Disclaimer ------------------------------------ =

Ce message ainsi que les eventuelles pieces jointes constituent une corresp=
ondance privee et confidentielle a l'attention exclusive du destinataire de=
signe ci-dessus. Si vous n'etes pas le destinataire du present message ou u=
ne personne susceptible de pouvoir le lui delivrer, il vous est signifie qu=
e toute divulgation, distribution ou copie de cette transmission est strict=
ement interdite. Si vous avez recu ce message par erreur, nous vous remerci=
ons d'en informer l'expediteur par telephone ou de lui retourner le present=
 message, puis d'effacer immediatement ce message de votre systeme.

*** This e-mail and any attachments is a confidential correspondence intend=
ed only for use of the individual or entity named above. If you are not the=
 intended recipient or the agent responsible for delivering the message to =
the intended recipient, you are hereby notified that any disclosure, distri=
bution or copying of this communication is strictly prohibited. If you have=
 received this communication in error, please notify the sender by phone or=
 by replying this message, and then delete this message from your system.


Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B028E0F;
	Thu,  2 Oct 2025 04:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759379531; cv=fail; b=Foe+ZKiQaoaax8/JWKOtu6ATyPQcjUyuAW96WbdT7RuUpSdjzsYqi4D0MjhjjB9hPp2wgswiMuz8Wt9+rYOT6waKQar40hkw5bQzJpkbK0pVsjyTXX7D8zxHSNLiD54TKgnjOgIbrSwY8ElRmnfSN1JfyxSzwY8CghbDorS8rtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759379531; c=relaxed/simple;
	bh=SPc0Q8IJe4ZDS4T/9Fxoo1NTHqF36HODt24f2eTBSZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IyvnDzBun+qxPrHpgRXKJ495D4gzeL6X1RLq5dhA8fD0zXwYJbE7yiq92fGc5CZu2xnRuqGPqSCCaXfnO3IxMPYEfoaixibJt0saJK0PJZjRs7oZ/FxpH7pXQw4xrU91eYDOB3yWMXTTU+t44x8vaqJZ8WOhOqHiV9yO0HuG0OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VMjM4ty6; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VMjM4ty6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYVyyRsljy9F1A93B+v9n007qWkpXzEMHDi+qwAIJFUuyW/wN+zlGjzU9MZfXJz4vkQFoHRHbqTPY8uVsc8BUaZ/CCXQZBlK6+KjfjgBRI5rEaTkhdBQ2JAHNuVvOK1BymyGfrE4w1qZ331ArXz0q+iz43IE4Mk7jEgcF/7VXf1KvuNP5lMqkw4cmmtlgxDCZs5q6C8uZkqrcBg45TSAcfdVX4nhZo9p4bj0RjsdJwUfKdoR917/Df5wZqoBAzQSNHpqlRj6jbDVPSHxOuS93lTtvuKaVoqfBbc5fWCY9Q28zoj9J9GUyGxTRgmljzXda48eOLChSR2cZX40tYLNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPc0Q8IJe4ZDS4T/9Fxoo1NTHqF36HODt24f2eTBSZk=;
 b=mLgwDXN2p1UsgPH13MOVDPe5o8eSBf/Pt4X3zx5FQYywJjbg4uEoE8Bq+8+VFP4TeUeResYzxGBhVzGlbHwSz4pKmO3wrpNr2n/0DLUnI7IrSKtrKuJxCOVfZiS6SlDFyPPztWqqReYy10cmoGoeZo3dZXYOhaPQPnPqdqErX0LDG0gXYMWh4kYUob9l7/LeQLTdJfvNm2GMU5bvLe8KU5zq0111N+KNZyDs6Dv8jctud4mcNJMkACEqw/yy6FJo4S+bBufntA0pDC2dJl5xA+0IH4uwVcI9GTzz3f1XBtHbkV2N6rClE9rDkuqEG/yl7ChOQUfS2/ZbZALzCj/yEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPc0Q8IJe4ZDS4T/9Fxoo1NTHqF36HODt24f2eTBSZk=;
 b=VMjM4ty6upy6MTb3F4JeMOGHwMIdfuXRQILXWm17N1KeiVaEgcuQTt3omjfEQo/Z2Ix0oeK4Xjn6bZarDUI2Mv5Ie5GMsOdemETGlq/1m48npjOcNtmxf/3e449BRGYPt6DbYMdYd0VvE5G9zLPTxa7dkPmeuxHe8GzkYoZkrJu2FFTRX+XVa5dPSkjCq1mACtUkxAZM2uKsVjS5U+Gaof9gr4sTUYH19KbfzZrAkHT/oem1VahsDq8fDTMeR8BusJ/wVnfAVOIcrK9Tl0K7ial2wSDSK5LkR0qaPZlROQsFvU1UKepl1/REBowinV6/dsZbAOd6gW0hugjfrz+w+A==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PAWPR04MB11706.eurprd04.prod.outlook.com (2603:10a6:102:50f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.15; Thu, 2 Oct
 2025 04:32:03 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9182.015; Thu, 2 Oct 2025
 04:32:03 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Jiri Slaby <jirislaby@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, Shenwei
 Wang <shenwei.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>, Frank Li
	<frank.li@nxp.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH V3 1/2] tty: serial: imx: Only configure the wake register
 when device is set as wakeup source
Thread-Topic: [PATCH V3 1/2] tty: serial: imx: Only configure the wake
 register when device is set as wakeup source
Thread-Index: AQHcLfyVS3gL6OPFc0iRwIWygMqExrSprwKAgASfy5A=
Date: Thu, 2 Oct 2025 04:32:03 +0000
Message-ID:
 <DB9PR04MB842998C7233FCFBC65B92B5B92E7A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250925091132.2537430-1-sherry.sun@nxp.com>
 <20250925091132.2537430-2-sherry.sun@nxp.com>
 <9b603e71-c0a1-46f3-93f2-dd31188dbeff@kernel.org>
In-Reply-To: <9b603e71-c0a1-46f3-93f2-dd31188dbeff@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|PAWPR04MB11706:EE_
x-ms-office365-filtering-correlation-id: 174624bf-d8da-4856-1cd6-08de016ca2ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajdBYnd6VUUyczQ5N2xJd1Z1bFh1Q3I5TTVFTGdjbFVpNVA4VVFvWnFNckZB?=
 =?utf-8?B?amtSZjdmN1N4Z25Yczl6dEZYUHVzRW1UQnVZaGN4bEdGMTU3YjFZQ2ZCclpK?=
 =?utf-8?B?bnFxR3lCc2pDc2N1Vk5BU0xrekpOTlU1TXMvOVJTODJXZ0xldS9iYjQ4S2pE?=
 =?utf-8?B?VlVtSldsYXhYUzkxVnQ4N1E2ZGZTVERFT0VldkJTRjV4alBDalhXWXUxL1Ev?=
 =?utf-8?B?L0c0NEJta2NCWTNmeGxqekN5Q1dUaXRRYnJ5ZHJhRng2KzVHY1hIdStCeGdN?=
 =?utf-8?B?cStsL2pCV0VZaEQrS3Z2K2tpZ0c0YkpVKzlFWFBKT1c0MlNFbmhWZk0rcWVu?=
 =?utf-8?B?MFZvby9DQkQrSk1JQlFMSFFGM0FHRXpyTFVlMnVmakVCcWNwTzA0VTZyTmVi?=
 =?utf-8?B?cUlLdTVVbThabEE4THNZNy9WY2ZyRWljSzZFNDZlQ2dleFlReXRmMThvWm8w?=
 =?utf-8?B?Y3drOGg5QlpMOGJxTjZuRVhSNk1YTVFQN2txOThQTUQvVVNGMlA1VlljN21K?=
 =?utf-8?B?cEtNZ1NicmxnVTF5MjJ3eHhJUTJDdGlYMHFTTXVybk9mRUZ1cWsxb0lIWEIr?=
 =?utf-8?B?V2dnK2l3d0wySVgxamdpcWl1bnVpbllMS3p2am4ycVpid1cyQzBHekIzVE9H?=
 =?utf-8?B?M0ovdXFBNjBCNWI4MFY3ZHNmRnpxVnp2b1FiWjhmaFkyelA0K0s4RjBQU2dC?=
 =?utf-8?B?NzNUYWtaUWY3c2ZHSGI0ZGRkakZ4eElJSGlMakFMcHlQdUkxN2MyVmVOcGpY?=
 =?utf-8?B?MnhTaU1KODdSOGxPN2hWVHlyUWFyVFBtb3M1OVAvajhURjVtL3NzZFVlTFUr?=
 =?utf-8?B?czJvRVUxWkJaMkNsRUQ3ejFMdFBMR1dNV1lla3ZuV0o0Z3cxTWxGMkJURW85?=
 =?utf-8?B?MERpME5rWkVjRCtCcWVNN3B2R0p5cWpUSDNqV1NmNlY1WDVEM1JoSDJWbDVj?=
 =?utf-8?B?aEJJamNtaFpIY21ZK2xWWlFGdUI1S0dacjZWQ1pzcDNnNmx5TExKOVcxTzA4?=
 =?utf-8?B?ZytLSk9PZWZyOUEzbXRZanpYaG1lRDNmTzh0bUx6TTZ0c2RRakZuRHB4ZExT?=
 =?utf-8?B?dTFvS25SL1p6bUtPZ3NNbGFkL0hxWklTRi9FN1VPYjJ2bUVUL2hQSFVkdVRD?=
 =?utf-8?B?RnE5WE94QjBSa3psa0pFSVN3YkwxbXp2RG1oU3d3V1RtNzFCRFNlWDBRVXA4?=
 =?utf-8?B?ZEdRdk9kbkloK0dkV0g4aUI0d1RpK1ArU0FhMnZIQy9SKzhIQnBjaldYVy9R?=
 =?utf-8?B?STM5SEc5Mno0ZzczMW1uWldVdEtZWVRBTXNYQWs3SE9SUURaRUo0d3hGUy83?=
 =?utf-8?B?RWJTR3VMM2hzaSs2V2Q4QUdYME9KWjdyWUEzWTlEdDBGYzI2Rlg2TmZoa1lH?=
 =?utf-8?B?d1RHN1pQK3hDZTdoRWlFeGlJNWh1dEd5RzdzZ0FwWlhEM0Y0aTFPMEJmemgw?=
 =?utf-8?B?blhnZGhES0pLQ05tNHBQUlJEMVRZMi9LMmFuNThsMHpQS0hMVU5TVmRCcGhu?=
 =?utf-8?B?VURpdldXQ1hWZXlUZ3JFSGRmR3Yrei9yVWZPbThPSjVtdlVWUHdzRjIreGdX?=
 =?utf-8?B?VTlxK1hlVlh0eHlaMldEREFQOElEZEhsZkN5d1ZhUkRnaStneE85RTd5cWoy?=
 =?utf-8?B?V1dmdzk2V1hTV2VSWFdhQ0oyQXlBVkxKbERvOVJXQngxZ0FSSERvU2MyUi92?=
 =?utf-8?B?aEtUSW9ObTBxS2xyZ3c3TERxRExvUlY0alRIYWxKaTVEbUMzS1pkL1BGc2px?=
 =?utf-8?B?Yk5aRk1GQkhwQllaZWVBVVR2VTk5bzFzRytkbU56aG5sTDBhUWMwWVZOZEhS?=
 =?utf-8?B?TTREbitGaGJ3M0xJRTNzKzlCSDlmNkt3STBzczFzbGVBNkNuQjUwWXJyNmdQ?=
 =?utf-8?B?c1ZNL21lUU9ZZ1F1ZXd5RXBDcUIyUWNROVpmcUZsTTJzQ1NqWVNJcXdTanZF?=
 =?utf-8?B?TDFNT0ljckZwb3FVeHFzVUcxMUI0NnJhSHVxVC9vdzhXdTlhZzJzelkrRWxU?=
 =?utf-8?B?MExoUTcwaFJ4YjhsRCtaWFZsWFRKcjAzL1BPRm1xNC9iUmw4djFSM2hraFZl?=
 =?utf-8?Q?oZuqxk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVNOU1ExbEhRenUyU0lSSCtCTWk1aEVEQlZXRURsTnNRTGF6d081NVlQZGNM?=
 =?utf-8?B?T1E1eDJaKzF5OENDQ01UT3BDaDg2OVdzc2tvNlpNTXFTVlBsWFZ3VS8rYTg2?=
 =?utf-8?B?M2xldFpMb3V5alIvTEp0WXFYeWdEZitBVmkzbVZiT1BpYVU0Ry8xYXBpZzlC?=
 =?utf-8?B?OEdiNHBxY0cyb3hKR3hYOXMrR1N5NGdoNjRabVgvT3dkUWdWMURyVTVMYThJ?=
 =?utf-8?B?aGdrZ2JwdWE4b3YzcVkvZ0JIUEJmTEswK0FIMTFzak1LVnRISHpRdGl6aFRK?=
 =?utf-8?B?RHJkUXRLVUo0ZXdVMzRUcG42enhEMVE2am16cFFIQk5XUjdqT2hua2Q3VGhU?=
 =?utf-8?B?UEp5aEYxVHFHR2g1d2NNbVBYeDA0UmZ5NHcyWU4vTlRzSTJXQmFva2xuNFE3?=
 =?utf-8?B?NXRZY3drOXRNOE1uRlQ2MXVHUnBrR2Y3aXBLZWtCSGVscmRCRWxnVEIwelNj?=
 =?utf-8?B?SW5oTXBWK3pXcUVBRklSemRrSVFIeVFFa1pBRmdCSy9pOGtKblhzNngzclBj?=
 =?utf-8?B?VzNvWWxQL1dVVER3cU1HbS9HRm9hVzF0dytIRVhwTENkRjdNN2IyajVkTURz?=
 =?utf-8?B?cU1yc0Q4NFV2WjBiRDJKNk11aHBhTkdGcy9zcGp4ZnJ1ZHhaNzR2ZExoVkJX?=
 =?utf-8?B?ZjlhTmg5ZnFsR2pQcStLSTRTNTJtbmQ3YU9iM2RFdGxIcXl5RVVwWlR4bHVz?=
 =?utf-8?B?SUZJNWltOUY4VkFxUUpSZWV3eWMxenVEd2pkQ2k5Y002dUFFSUV3NmFiTUZ4?=
 =?utf-8?B?ZTFwQUZaMWxpKzBXdURpejlzeTJOZW5venhOaUw3TTA2TU95c25HRWJONHox?=
 =?utf-8?B?NFc3cHFOMGpzS2VmdC95c3M2UGdseVd1TlFaU2pBbVloQ3JSd3l2QW5Ec2ho?=
 =?utf-8?B?WnVIR0tJREI3SjBhWmtSQ0lTY3ZzN3MvZVJLL0EvaXIyZ2k0dTlQeFMyS0sz?=
 =?utf-8?B?SnA2YXdkK2NoZDV1UkZjSmxhbHdlS0t4bGxReWQxMjl4TnFkNEJnMVFJTzNJ?=
 =?utf-8?B?d2t0QTc3aWtqZkpzS1RRL2oveS9lS29IaG02aFpYL1JVbWtscC9uZ3pzcm1H?=
 =?utf-8?B?UTFJZWU0RHVxbk9rUDBQRTRUeDJyN2V5RDAzWGtpazQ1SUxTVENHQWpmNFBj?=
 =?utf-8?B?RGc4QnE4UlRoKzlWb0NVcmczNXE4Q0NpWHJ6VTNQRVFFOUM1NDA3bFBCZjZv?=
 =?utf-8?B?eTdxZW4xVFRSbzZneU9tZWxnaGhPTFlwbHpaL2pZanpKbnRGUmF5aWY4ditw?=
 =?utf-8?B?WHdiejdGckF6WWl4L29tYWZ5UkoxR3pDY3IxWStlSnRTSHZWZjZQVGZCWFdh?=
 =?utf-8?B?Uk9OWmJTaVJhS2R6eUl5TThNTjFsaWlOd1dQaHd6YjJXb0FjMk1XZ2xCcmZG?=
 =?utf-8?B?bzBEd0pJVlE1elZXbForU21TTWRmVkNhNVZsbmQyWkIraUx4d3hJZjBlNlF1?=
 =?utf-8?B?NGovMDBBVVBkb3A5aUF5UUNoNnhHbDRoemJ2V2g3c2Y5d3dsaEx1amZ5eUV4?=
 =?utf-8?B?TjVBbk00TFRPeVZoOVUxYzV0SkZDdVFYallZVndiN1B6RlR6Q1NHVFhiUkVk?=
 =?utf-8?B?VXM1U2NPQ05vUnBVK0N2cFQxZlVoTWh3a1lybEE0bUUyTExUbGNObUkyelFr?=
 =?utf-8?B?b3ExZi83Q1VuY09NZ25aUEFuYzAxNmpodjFwYlcycUtUMmdvRlBXTCtNZ1Rq?=
 =?utf-8?B?N1kvOWh2WUJscmJGdEllODFYZ05rTS80NU9zNDc0bzVSaXZ2K2FrUVZaSHFt?=
 =?utf-8?B?bXlhM3FKY05NSWtYU0taMG9pTWc4RUp2L3pPcEFOc283c0Fpa3RJOGFpUXJ3?=
 =?utf-8?B?ZjdVeDRxdWZTVWdOU09zQW5MbDBpTFQ4OW5tYm85eXpXVmFTYThZZHlCWjNh?=
 =?utf-8?B?VmwyOHllTEJqVDBSZlVHT20xU0lTdGRwUVFUREVSMTVUTXNyTFZia3Jmb3pI?=
 =?utf-8?B?ekNienhTTjZXUjVGTnZZZW9FQ3RiVE5BRHJmK3g5T2NYUTluV3RHOFpuWmI2?=
 =?utf-8?B?MnBxYkIrZy9wdUdyb0NLRktIT2UwKzhxUWN6eFo4RVg0eHhMK1o0aURQTjVR?=
 =?utf-8?B?UzBwaXBKNXJpcHR6enhsc2FGNmVUakhkM1N6Vk5BWTBsdHU5eG05aVk5VVFN?=
 =?utf-8?Q?9WxI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174624bf-d8da-4856-1cd6-08de016ca2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 04:32:03.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXwPUvKhDGqrAWG18HkLIU2n34PEn2oHmbykcj+VvcJ/Xlbfzm/HdQYrlgexv+8dKoO73KSCvqYw9cqka1Lw1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11706

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlyaSBTbGFieSA8amly
aXNsYWJ5QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDI5LCAyMDI1IDE6
NTQgUE0NCj4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT47IGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgU2hl
bndlaSBXYW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBu
eHAuY29tPjsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IENjOiBsaW51eC1zZXJpYWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlz
dHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS8yXSB0dHk6IHNlcmlhbDog
aW14OiBPbmx5IGNvbmZpZ3VyZSB0aGUgd2FrZSByZWdpc3Rlcg0KPiB3aGVuIGRldmljZSBpcyBz
ZXQgYXMgd2FrZXVwIHNvdXJjZQ0KPiANCj4gT24gMjUuIDA5LiAyNSwgMTE6MTEsIFNoZXJyeSBT
dW4gd3JvdGU6DQo+ID4gQ3VycmVudGx5LCB0aGUgaS5NWCBVQVJUIGRyaXZlciBlbmFibGVzIHdh
a2UtcmVsYXRlZCByZWdpc3RlcnMgZm9yIGFsbA0KPiA+IFVBUlQgZGV2aWNlcyBieSBkZWZhdWx0
LiBIb3dldmVyLCB0aGlzIGlzIHVubmVjZXNzYXJ5IGZvciBkZXZpY2VzIHRoYXQNCj4gPiBhcmUg
bm90IGNvbmZpZ3VyZWQgYXMgd2FrZXVwIHNvdXJjZXMuIFRvIGFkZHJlc3MgdGhpcywgYWRkIGEN
Cj4gPiBkZXZpY2VfbWF5X3dha2V1cCgpIGNoZWNrIGJlZm9yZSBjb25maWd1cmluZyB0aGUgVUFS
VCB3YWtlLXJlbGF0ZWQNCj4gPiByZWdpc3RlcnMuDQo+ID4NCj4gPiBGaXhlczogZGIxYTliNTUw
MDRjICgidHR5OiBzZXJpYWw6IGlteDogQWxsb3cgVUFSVCB0byBiZSBhIHNvdXJjZSBmb3INCj4g
PiB3YWtldXAiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5Abnhw
LmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gICBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgfCAxNSArKysrKysrKysrKysrKysN
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5j
IGluZGV4DQo+ID4gNTAwZGZjMDA5ZDAzLi44N2Q4NDFjMGIyMmYgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy90dHkvc2VyaWFsL2lteC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2lt
eC5jDQo+ID4gQEAgLTI2OTcsOCArMjY5NywyMyBAQCBzdGF0aWMgdm9pZCBpbXhfdWFydF9zYXZl
X2NvbnRleHQoc3RydWN0DQo+IGlteF9wb3J0ICpzcG9ydCkNCj4gPiAgIC8qIGNhbGxlZCB3aXRo
IGlycSBvZmYgKi8NCj4gPiAgIHN0YXRpYyB2b2lkIGlteF91YXJ0X2VuYWJsZV93YWtldXAoc3Ry
dWN0IGlteF9wb3J0ICpzcG9ydCwgYm9vbCBvbikNCj4gPiAgIHsNCj4gPiArCXN0cnVjdCB0dHlf
cG9ydCAqcG9ydCA9ICZzcG9ydC0+cG9ydC5zdGF0ZS0+cG9ydDsNCj4gPiArCXN0cnVjdCB0dHlf
c3RydWN0ICp0dHk7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICp0dHlfZGV2Ow0KPiA+ICsJYm9vbCBt
YXlfd2FrZSA9IGZhbHNlOw0KPiA+ICAgCXUzMiB1Y3IzOw0KPiA+DQo+ID4gKwl0dHkgPSB0dHlf
cG9ydF90dHlfZ2V0KHBvcnQpOw0KPiA+ICsJaWYgKHR0eSkgew0KPiANCj4gVXNlIHNjb3BlZF9n
dWFyZCh0dHlfcG9ydF90dHksIHBvcnQpIGluc3RlYWQuDQoNClN1cmUsIHdpbGwgYWRkIHRoaXMg
aW4gbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0K

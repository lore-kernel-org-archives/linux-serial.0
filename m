Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD92C15B6;
	Thu,  2 Oct 2025 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759376683; cv=fail; b=gipP3a0znzW0vP3Kz2LMnwn3JDtL1dAvXeC3wgHWe2wGkswNhA7tCKcSCOw9mXGlyBigzdBQI+6qvQ2jRHUGE56MmOMKBuhar42KMlGulGJKIaggyOST6miPcw1aINIlzxdpvm19uHj5Suw3KBzRe2RsNK9qrTtmUI4a59w4yPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759376683; c=relaxed/simple;
	bh=uELEW+h0V5jFSsZDKgrnevROHRsHd4I7S3p6qUI6BY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NFpMIp1wedyNYWuNhRvih/X81p6yxcf3t8ZHj7XwDn1yGsQZsS2vZqlEGtj2Ea1pZ7qwmN3Y4yA/Dmsrfi7Aoaa4dVHNtHixEQh19TgbpUFB7fx93NevdDigZRq8WToyWzPI51oAfNAB96EAuob9lP5EYLX50B48IU1CdKf1Of0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D1IS99sy; arc=fail smtp.client-ip=52.101.83.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D1IS99sy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwcmM9eG91gy9sSzi+vhg3Ig9gtYAFpPLBMJ1xqROclrDMiYdlluG5n7u2QxX3omrQnBRJ0ZE+A7UMO4pj4xtWrdTzWNo8bOGzjLGFfAA8cMEH8jUaJH/Oitrm3AgymTEXCKlz+piZ9GQB7bj5+NBLKZfgXSnflUwVX48fLw86s1qcWLQGeS1yUHgaGo0rbjbWhPbMhM3hpvn6KwSbjQUsYuC4V+XIO0uEpAxZpMWiaRdAkQRBIUkQUdDQeX4jum7GlSdI/tbb74gAjakRc6sii5AW3EaHBtAprVgxHaPPcrLiZNDKP/WVdohLF6Hj+QcnSSwJqFO4A38I2jeeAwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uELEW+h0V5jFSsZDKgrnevROHRsHd4I7S3p6qUI6BY4=;
 b=Y3pIYPPj/aVZVRN5X63DqPY+gUN9QlKWcIgBJzaJIhPtch8rSavZId3KtTp6EyhDEShMTyYat7OapcaXGTt2fNLMFU88RraQeDTLc4KnaP1BNOn6QjeOmV2Ri/fVWOqoXQV40lJpxtEWZemRhrmBO6TY6AENyp3aHAIrjvwdLrFRtnLQc7C14ARNz8B57UmM9LCbGLBue0d6jZMK4gTk5O8LcOUXyJuUB33DrrJsqJ4SkjibxiYYc1cGZjBqNKDqEJcMV2xaowwn1SciMxy8u9ty773GWgaxp7r2dOvIx1VeReEep4fqQ9tlHp3+rYyqIKurLJpCayxOKvbBqWNclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uELEW+h0V5jFSsZDKgrnevROHRsHd4I7S3p6qUI6BY4=;
 b=D1IS99sySuGLqOAcyALaXMT0jjugVwpUj1b8Wlrg1hNWgQksc6uOkQRYgXKcBmc2V/zXzimzeurqQQj5bIVoQAvmRA7vE5Rt6AQ48F/r5uSieCEAh7DrOJqGyJR89NJYFMAJ+avwcvpvGFYoHrZn6u/t/MoZ5n+ZmcWcAvHYsT+w7M+nDlCmuJRBu04nDVVV9w7LiDhjHoD/jS6OBCMy1oLpqm6fMbgKaAGNPab/StbFaWZnu07rGx2UQf8vm8M2Z9g5pg6RL6phcgGICvsVtO1tlBxTnGIJ+ljv8BzUg0QwmCNtxJRbkCXFi3eqkR+duN7/GrcupXotcAeLTL7xdw==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by VI2PR04MB10546.eurprd04.prod.outlook.com (2603:10a6:800:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.14; Thu, 2 Oct
 2025 03:44:38 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9182.015; Thu, 2 Oct 2025
 03:44:38 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Jiri Slaby <jirislaby@kernel.org>, Frank Li <frank.li@nxp.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH V3 2/2] tty: serial: imx: Add missing wakeup event
 reporting
Thread-Topic: [PATCH V3 2/2] tty: serial: imx: Add missing wakeup event
 reporting
Thread-Index: AQHcLfyXYhhoMAYDCka2l9oXp92NbbSkC/cAgAWkG4CABJFCgA==
Date: Thu, 2 Oct 2025 03:44:37 +0000
Message-ID:
 <DB9PR04MB8429ABE490A4669349FA217592E7A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250925091132.2537430-1-sherry.sun@nxp.com>
 <20250925091132.2537430-3-sherry.sun@nxp.com>
 <aNVkhvmZ4GThHNqD@lizhi-Precision-Tower-5810>
 <bc4beaa6-8391-4ba8-b6c4-bde1c00d0375@kernel.org>
In-Reply-To: <bc4beaa6-8391-4ba8-b6c4-bde1c00d0375@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|VI2PR04MB10546:EE_
x-ms-office365-filtering-correlation-id: ed333a04-ff70-4f06-5f1d-08de016602ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VytQTFNBVjlHbW1qMDZLSmVtMVJoSy80Q3hUTVZvcGliSzVpb1RNazJCSDh4?=
 =?utf-8?B?eWxVZGczNHpxVGtMR1RGbTNvMERmdFp2K3UwMzltU3pBRzg4SHF6ZE5tM0ND?=
 =?utf-8?B?MWNEUUh2ZDh0cDJpMUgweEtKZGV3ZDJ0eXd2eEZIZ1N4N2VxOFd0YXgvTnNq?=
 =?utf-8?B?dzdPaDdOQ25hZyt4QWhIRGpZWFFpS1YzSUpxanFFK2ZqcVM0TVFDZDhaY0s2?=
 =?utf-8?B?Wk1mNWYzNFVXQW9wL3A3cmVGUzVFQXJpelJXMWhtOU1LS040dk1YampxVlRr?=
 =?utf-8?B?OHdHMjVWV1ZHVHZCeWc4MjZDWTNJWmhaVjBLQ2dHLzVieUNEeEFGMmg1Zng0?=
 =?utf-8?B?NStlR29UK0Rpak43bXF2Tmt4ZEpDNVkvNjRXMzFwcjdkNVpPZ005dk1QckR1?=
 =?utf-8?B?S1pkUWIzZjZKdmpNZnluKzN6amFOSHI2STlESHQ3WGtqd3kvVGtNWExnaW9T?=
 =?utf-8?B?cXhSZkh1Z3ZSdDljUDJFMG9YTERvODFyeW5CZmJCaC90bWVQNVpUb2ZsYlg1?=
 =?utf-8?B?TTdkdjFKTVhoMk90T2taQ2lrM0EySVlKTlhrY2dkY05tbmtKenFocXlDYW9l?=
 =?utf-8?B?VnVzQVh2SVFRcHU2M2d5UHlsVitaZ3pXTjFLWE8zTk91Z3N6Zk1lRGx2dGFm?=
 =?utf-8?B?SDdrcTdhLzlrYWNyTnpmY2ZiZHhSNHJMckF1ZGZra1YwSWk0bk1IMmhJRjZp?=
 =?utf-8?B?aklsZlU4RDhhOVpJdHIxQm5tRUQxcVgrZkd4b2FGdTBkQ014NXZickFiL0FP?=
 =?utf-8?B?M3llZVV2RXRlaDVLZ3FvQ2oxRC91K3RicGV2MUY0MEZ3eHpPUkVkS2VBK2lw?=
 =?utf-8?B?T0hUeSsycU9CSHZ5Y21wOTBERjhtbVErZTdEcDlyTUVQU0hvR2tiM290VFVt?=
 =?utf-8?B?akcrcFRncWxkcDl5ZUg0TS9GTkhadW1TZHRoUm1MVytLRGNaU1JmMHBBOWE3?=
 =?utf-8?B?RUNaTjF5V05kWVdyVTRYblFuMUQ0dG5jQ2U0V2N4MlY3aGRvV0NYNXlqeGx2?=
 =?utf-8?B?NEpnY1MwYk1uWXNHbDU1U0R6clI4SU8rbDA3OTArU0pERDhQRFJ1MlpBNkwv?=
 =?utf-8?B?aUpqd2NvMlpPSUJocWo2K0dFY1hUbGVEei9wQVpySUo0T1h6MnEzeTNMb1Y1?=
 =?utf-8?B?VW5qTFJXczFTRW1OaXpXM2VRTGQrVlV4TTMvY0VYcGVzVmpxaFkxOE1XdVFP?=
 =?utf-8?B?bVBWcGhpMTYxRkZnV3M4d2UrUUZrZW5YWEd4V0ZUT2Q1R096dGljSnRPSWZT?=
 =?utf-8?B?R2xKUSt3dGVsaXU5Z0U2bW9wNTNORkc4Vm9KbTg4NkdwUFhVVXp5bDJRZEI3?=
 =?utf-8?B?d3UvZWxkYjlHbkhIYmkrQzZMc3FEeU5RSUpkQ3YwQXZXUVRUN0VJWmtNZkw1?=
 =?utf-8?B?R0lGRkZaVFR3VE9RZ3dPTTNqalBDc1ZENXZTRUNBY3IzVWorRWEvaWE0d25X?=
 =?utf-8?B?MVgwT1hPa1dza0x4T2EvTW93Q2trcDRiQzBUMkNDNmZqSlFIWERWTXR1VlRj?=
 =?utf-8?B?UkVIYk4wQ3h2NWRMcGhnZWdhbWhENTgyaWlOSTZGVXp2OTZpa055cktSMmxL?=
 =?utf-8?B?N0lUdldWd0tzcldKTTM4b2ZtNW5jMUhpdURmdEpYck5IcVV0cWs4TVkveFZY?=
 =?utf-8?B?Z1VZdVFubklKWnVRSXlwSXlPMnVEMHFDWFZITEl6ZWZpS1J1MHhBdzBOdE9s?=
 =?utf-8?B?cTNENXZwR2xDY0J5am5CRy9uZUpjWXh2L05EYnEySC8vcFhSM2NlMUg1NjJ0?=
 =?utf-8?B?NktQZkJDM2dRaHFuQUMyblhwQjUyTmxHRTRlZGtmOHdwaXZMSTdtbTEzT0Ra?=
 =?utf-8?B?eE90V3ppZVd2azQ1SGtVTzlGODlKT1NIU0tUWUM2WUNQdlROQjlreWNvZTZm?=
 =?utf-8?B?bGw3UXlGQUdUUzJidU50RVZNTy9Sc09XakZ5NGkvdzZDak1DL1VtdVpVU2J3?=
 =?utf-8?B?OVBXaGNUWUtlZU5hMVVUbTEvZllXRGhIM0g3TzREVnhXZXVFbDRuTHZSSkZh?=
 =?utf-8?B?cFhPWVE4K2oxRGRkaVN3bllSV0ppVW8rRkU1RHBVNnpyZ1RMYlFzU3hnYVNK?=
 =?utf-8?Q?PelytI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1hpK0YxVjg1TDc1bmQrMDU3UDZzTVRYeG5VRkhTR0RKQTFNUFhXM0JhMXBY?=
 =?utf-8?B?V0tWQjFvLzhUZVphWEgyblgrTTQrRWI4YVdIdG9laytqdDduTmlKbHpLVG9J?=
 =?utf-8?B?eDFvNndsMXc0dm8vdXFMTWFjNWc4eS9KS1VtM3N3akVIVWhJZGVoV3Fhd1Yr?=
 =?utf-8?B?eGtPdGNZK1hJS0RwK2F6MXVFeTRZVE9STENySy83OU9MdkZaVlJ2UG80cVM1?=
 =?utf-8?B?aUNGbVZTbGZlKzNLUHArak5tTC9CeWVlajJsbHFpekxmbzBsQ3lSR3FjU25O?=
 =?utf-8?B?RFc3c05nYzZBOEJablRrMUVlTHZ4cFA4V3g2aCtYRnhmQzVHSzVGcnNaaUZk?=
 =?utf-8?B?UFBQeC9GUFU3ZXd1bVMvWTFzODNlNjRlQlRqR2h3SXhPVjZYdnlWU2pFMVJr?=
 =?utf-8?B?Y2xKWGc0MWlDcHc2TzBCVlh2Qis0QStINTN2bWVLT3IxV2RDdGdkMUN1b2dU?=
 =?utf-8?B?U2hOMDBoT05RejhITzRGYVV0ZkhFNXdaYSs3bmlneUZVZTBOSXFQNjA2QWJ2?=
 =?utf-8?B?Ris4T1FHVkVFOXJVbkg4cVlvQmN6bHgxZXh0dUlkOHp4ZEtnSEZNSVVndFlp?=
 =?utf-8?B?LzEwd2JTYkVjSDZzMUVrNE9zU1MyWXZCTkl4RjdDcHpML3V5d1huMzk2Skc1?=
 =?utf-8?B?VjJCWDFaeHlGNlgrYlZWdVQyMUhwZW5UUERudFBCTlN5cy82VlJlTkxOMWlZ?=
 =?utf-8?B?WFpoMTJpSjErRW5iLzRmSEhZRXJvQUJnTWdibUxGaHVuVCtKcllldUhRL243?=
 =?utf-8?B?YVBzcERqVUpVUHhlZGhNMUZCZnluUmY4THhYK21ZaTNrZjgwd2QrUE5qU1h6?=
 =?utf-8?B?a2k1VTUrd0loQUNWRWJDQVoxek12ZmdXZi9Ba3dXRXVydmc0b0g3azVtbkdT?=
 =?utf-8?B?NldsemY5bXFhbnYzSjlabWRTM0FuMmtGdTJ4Vk1ZdXhwQzlSZzhXcjhnNUtE?=
 =?utf-8?B?a2plRzRDWFBGZ2RJOU9uK0J3Ui9MTzlDMXMra0JTTFYxcFpRU1dLUU56NnRH?=
 =?utf-8?B?cmlMeEZxS2FDWVE3WTA0OEhhVGpWYmpkNWIyNFdhczVyMjZEVTdTYWM3NmZ3?=
 =?utf-8?B?dGxTWXlXaGRucFhMMnRiZjBaQjA0V0lYcWVPaVZrTy94NC9GbDgrSG00cy9T?=
 =?utf-8?B?Q1RFaFN3eEJMRDZ5ay8xOU5mYmdPS0RDZnk2RTdlaDlNa1gzb0FWTTdiZDFP?=
 =?utf-8?B?NGRQQ1ZVaFVPS3MwbURTbkJBakVCbnlIWFp3eDRRMnA3aUlmRnIxZjFKRERF?=
 =?utf-8?B?c0NQZXVXQ1EveGlINnZEZjFZcm1tTVkwWVI0UjA5b1pqWUVxWVVpdkoybk1J?=
 =?utf-8?B?WnFjQVo3Q05SbWk5Vk5jK0FoeitiOG0wV2NETkF4UGtJclNoeDFQTzAwNHRl?=
 =?utf-8?B?bit5bUhvSUJOUC8zSFFiaFo3aGJMT2JMVVJHc1gwcENOQ3BpSkQyRVBSbW5W?=
 =?utf-8?B?MTFyVTVzbHJ2ckt4MFBmTlhTaVlZc3JxdjdmT1lKc3VBbUpMTDkxNkZsc2hm?=
 =?utf-8?B?dzB3T0U4b1lBOVdiN01QMDdMU25BY1NNVWFTbTVaVWJ1cUFFeDFyQ254MFdE?=
 =?utf-8?B?ZUM0MG91RklXZDRLd2J4WTk1VGpEUU4xdFo4a1l5WVp0cGFoQTBHcm9VVDI1?=
 =?utf-8?B?aG5YZ0pBMUJLeVpVczhYaVFpaHJFSytRTnBSblJoZUE3aEpqbVV0VVhRc0p0?=
 =?utf-8?B?Q204UUxMc2pENm5tK0NEZG9pN2t0ZzRvMnJsUS81V0g2ZHJYV2t1akhlcDVv?=
 =?utf-8?B?TXVLT25KUnpEN1hJbWg4V3l2cWMvbUdFVVF1bFFYQ2gyMWFyQU1FQWpEYVkx?=
 =?utf-8?B?WG5yUEVmQkhQNE8veG8xZEhnWlZYS2Q1Mjh2UFBGdUkvRDBnS2lLdkRESHNY?=
 =?utf-8?B?TlVIVUVoc3NadEFaM05ZaEJDTEorb3BSWG1ncngyZkc5aE9STXpDN21VUlh6?=
 =?utf-8?B?YURKcnZMSEpUR1dUSzB6ZG5zME5zZ2pHWnVVRW9qb3JBc01vU3I1V3ZHcWEr?=
 =?utf-8?B?ZUpnSFdpaG9EZmVFMnVRRW1rSmVjbWhyajF0VXRZRjMvU3l4T1pxQ0QvQllz?=
 =?utf-8?B?cDZGVEdERjhKbU1PcGt1OERNQUVYZ0VzU3pZTExQdXA5M09iT0F2bGpqVHU1?=
 =?utf-8?Q?2cWM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed333a04-ff70-4f06-5f1d-08de016602ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 03:44:38.0121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ua/ZDzRey4fD2AoCT6Bwj1cH9AsUf7pe7QspecjxYL2soRWib6pDOVRA8R1XEqTFKeOxW757tUduZKs0TD/XRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10546

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlyaSBTbGFieSA8amly
aXNsYWJ5QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDI5LCAyMDI1IDE6
NTggUE0NCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgU2hlcnJ5IFN1biA8c2hl
cnJ5LnN1bkBueHAuY29tPg0KPiBDYzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2Fu
Z0BueHAuY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+Ow0KPiBsaW51eC1zZXJpYWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlz
dHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMi8yXSB0dHk6IHNlcmlhbDog
aW14OiBBZGQgbWlzc2luZyB3YWtldXAgZXZlbnQNCj4gcmVwb3J0aW5nDQo+IA0KPiBPbiAyNS4g
MDkuIDI1LCAxNzo0OSwgRnJhbmsgTGkgd3JvdGU6DQo+ID4+IEBAIC0yNzMyLDEwICsyNzM0LDE0
IEBAIHN0YXRpYyB2b2lkIGlteF91YXJ0X2VuYWJsZV93YWtldXAoc3RydWN0DQo+IGlteF9wb3J0
ICpzcG9ydCwgYm9vbCBvbikNCj4gPj4gICAJCQl1Y3IxIHw9IFVDUjFfUlRTREVOOw0KPiA+PiAg
IAkJfSBlbHNlIHsNCj4gPj4gICAJCQl1Y3IxICY9IH5VQ1IxX1JUU0RFTjsNCj4gPj4gKwkJCXdh
a2VfYWN0aXZlIHw9ICEhKHVzcjEgJiBVU1IxX1JUU0QpOw0KPiA+DQo+ID4gSSB0aGluayB5b3Ug
bWlzcyB1bmRlcnN0YW5kIG15IG1lYW5zLiBzdXBwb3NlIGJvb2wgdHlwZSBvbmx5IHN1cHBvcnQN
Cj4gPiB8fCwgJiYsID09LCAhPSwgIQ0KPiA+DQo+ID4gCXdha2VfYWN0aXZlID0gd2FrZV9hY3Rp
dmUgfHwgKHVzcjEgJiBVU1IxX1JUU0QpOw0KPiANCj4gKzEgdG8gdGhpcy4gTXVjaCBlYXNpZXIg
dG8gdW5kZXJzdGFuZCAoZm9yIG1lIGF0IGxlYXN0KS4NCg0KSGkgRnJhbmsgYW5kIEppcmksIHRo
YW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb25zLCBub3cgSSBnb3QgeW91ciBwb2ludCwgd2lsbCBmaXgg
aXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0K

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160035;
	b=a+oa2OEI5QOZUaWiFD7WtAomB8ERFmp2RnBZQVuiRMjLC9u818qFVCKd6vAsDbIo3mAD
	 YAMoIxUUkoz1KG+DGOkrkChlRHnURxyMjWvHQObpAVMdc0gSWbsp0dB/v5FENflbuGtp5
	 lZHqLnDCUnmMwvyfm0K0Fw8dkIrXsVfK59PJfLY34Obk7vHGAdYPyM6yirHNghXmC4EXY
	 tViJumvRP+FfX5wDj7bJcU73tnVlVqJWltqv7h1EjyO37QVL+aRTrEex+WC7iQeMHL672
	 J4vhPsz0dFVHEi3ZFNtF6odTZ7bW4T9xH0IrrsN/On1uaYkOG/8xs4H2EXxk4/YmlHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160035;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=hFH8cAt60Y17wLA5uJf7VCETirYZfPEvSF30WBbqPuc=;
	b=I00RGYjH47dBB3DEGUGA/aCSbvCuQalm/JA9k6WpZpIKUTbnBpNfLR/eeD7bZPWFkeUF
	 dpwYGEhdrjSB0R7dcBvJCeEVrKVZAaMeQfQgG4CTFqwrkaTLyPvLu2w9Lg7+qDIz3vfyA
	 6TiXJidt2nPHXC6elSHUyq9pvxFsNde/Thq51blPUEVZ78QzJcjfNQ0xc5srK6wpOhW4E
	 2KgQBsJHH7bf5BFNt9bsHj6noUCF2fIGQ81qvo+JtLGYhh4+eEV/43jMhi+Osfy3vFKIz
	 UtZto/ma0PlFsOMRxBwYV2ufFWG2psWs09ua+9bzgjrg3ItvO90xW2HRgaLv1aPvFZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=GiHyAN7J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023108.outbound.protection.outlook.com [52.101.83.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95460A2602;
	Fri, 20 Nov 2026 07:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC95460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=GiHyAN7J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQZRrpk+Vcp0mZhMo2/Tp2zcJV2mDPOCGyxbj/Dsc39JuKQSjY5Isza/e8Of2/RPnvbiU7py8vcJ3BlJtdLdnV+oumnDUCyGnwioBwwy1q22F1HL7S5BERMf/YZITPLDyfUZbVGry49h01Zt/C9muwA3ly6nARvZeVMqhFY4qEURTAoG15n+lJOtFrgIl2rC9vvU9UPrJU0BPF3ea5Ix5LpLJboAjfc21zrbM8Ncdty6NqAF3WRkrpqLG/yHcVxEhCb5x8pbix0TY0tu9w99RLtKEatSdtV54V4QfGddPZbdTHUoMfNUEfBWRGZgZlGR7UsSDYk15JBF6M3sLEHNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFH8cAt60Y17wLA5uJf7VCETirYZfPEvSF30WBbqPuc=;
 b=rHkrU9ig1TWOE3ORDeZrMp1CDT3oQcrqZaAIDF8I6dYJWc/dskXdYCBwiB+2cdRlefJDQ3VQyJouW9t3qkJejXCnY35VmkeWxepW7jc3Fmy+2Za4DbFPZJBqp3wto6yu0l4RTA9hetvDYXLE3+a8nfvSjULoNBCOZEZGAz8lSSSyOMERW09wFt4SaHjY7z+uRoPEu+69yR9fBU2KLPl+8xf8pQgnudSH8xddhwi1+RsPvDAPW+PbYLyNcB5lkSOYwJHX8fRizhGm90sLSQ6JwGaKiNBaZt9xzsanIdgue5hQP+n6Uil1wVXCG0iV5t5w5S9xSjVUZ2hmEa3h1Fjkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFH8cAt60Y17wLA5uJf7VCETirYZfPEvSF30WBbqPuc=;
 b=GiHyAN7JVhHyS5xlv7R8Mc4zSNr0SDmF1YmA/tCwbh0cK97NRWFtBvJ5OoaVmJoK310fadsxdghU5oNpJktw6f4avKOfYJBF1Ipfs4SrpZffLHQh5zsS7HwlMBo4Grp2wAG+zLTD7+E7ay72hkRKWi5chI1LM5qwArIBdrpSnnGRPFXOx0d+TpkkXn1tMQl7MRdOB6gG1U0Sr/HvTrYbmUTI/P1gYuyGtDe60pUut5UF03+5hHUDQlgp0Qw+MwnCfgFk3U5vnPR/91ynLIVjLitMb3JgX7q1ZESeZv1Oc4FJyjhX62W45lOAgXHAg5KpzpQ3lguertLXWO5YUx4NAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS1PR06MB8539.eurprd06.prod.outlook.com (2603:10a6:20b:4dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 07:33:47 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 07:33:47 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Fri, 20 Nov 2026 07:33:32 +0000
Subject: [PATCH 3/3] serial: max310x: hold the port lock around the CTS
 change
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-max310x-teardown-fixes-v1-3-eb52c8b612df@vaisala.com>
References: <20261120-max310x-teardown-fixes-v1-0-eb52c8b612df@vaisala.com>
In-Reply-To: <20261120-max310x-teardown-fixes-v1-0-eb52c8b612df@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795160018; l=1776;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=7A2lIaAyDNzmMLHmT9EGosb04Mwjg22Wel31fTHk+oo=;
 b=3/zbRzu5MpNlK0Kup/8i5NG3h3BTMTdxL+taxxNP768l2jlqaJGtlSdKZhRd08UNDWNknTJeI
 6frvUXqdOteDN2FkoqIQGSfZGE8dExk5jUguwnFohoHpbSMq3YYyVD6
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0017.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::15) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS1PR06MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b2bf1f-2c26-4d08-d6c7-08df46d89a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|23010399003|10067099003|11063799006|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261102123227099003|261028144727099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	8h6YuDTC/W2fD6hjr2V3pVGmadJpCOclbd6VNGdtlPTKBmTMbdhpY72u/Z5NvG4Fam+OL2a563Gv15//ZKrSWWUINPsVuL50i75rURYX30PqYvsQNQ1EMBhckxxAGEktIEJ8cLPTTaP+UdUl4S78lHiFnCPvppO1CPW5k/zM3mN8z5tOWq5sbL1kRnj2ap9eADd3iAKiWzMNL6emkSULRVDIPJYe2dmRt30fzeFdYa7ozinwFzYT1kUcUQFxVtheNqHhO6LN68H1IFjxBTf+XGki9OYMXun719oUR+yohz69cEvf8WIvAagnpbAWP+XItx37JHBH7rD4Mg9db5qV6aCzipwNya/7i78gxVQMT+Zwg1dCVmTzKblSdRn7sbQqq6qlSBC/HuIQ1VtEodjn1o2sgj1S7kbAegRMosjeuwrM19KcAmS25F8vRcG0VeDWhG/dbNlQhBCyu150ftMf135BAHujtg2OMH7W/IJRN3kKppZeOrXTqTDyIGrATRXRfCvMa7TvVeJIrxtOGzUghpItMnWLkwqhoJtAFd7GB/TYyhHOtY6k7Akc9PrsJCTr5QU7Pw2F8aKXsKHXP/unZrp3+9IVLwIGnIP4WWykhp/8s7d6/8mOWbduEITqSB24lRdkNZit2hOKDMPy2Vmp8mZVfhNt9xxGZsuXeageDAWFK/XE2VvSpEcSlKQOI4wXtj6ytrNA7rzDGVW5Gkih7nVmhZm42064Vc6FuC5f510=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261102123227099003)(261028144727099003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHd2QmhoNHlHOHRHMXFyZFY5R2RPaCs0YzBCTmZEMnhvVm44c0N1SDU5aktE?=
 =?utf-8?B?bnd0Uy9BWm1ZL2IyZjhDM0d5U2NocGZ3ZWNTODM3aUtXblc4T2tTU1JTRDM2?=
 =?utf-8?B?TkkwNzMzTk81UmFGanpiYkd0dzZxY2ZmMDM0U1ZhdERwNVg2Rkh6YjNPYlJQ?=
 =?utf-8?B?TjNsMjhxeTlmSzdaeHUyeHNNeUNBdWVtcFpHcjgvWEN4UHpFRWxZQWFWK1J6?=
 =?utf-8?B?WmNOakZZNGwzVWxSQm1saUIyR1Z6dVRWZTBDVVkwRGRzYmFOQXpObE1OZWY4?=
 =?utf-8?B?bUl4ZDFKNm9VSkFydE5ibHhkYzlmRWIxTlVhc0Q1SFRKemFBNTlmT3RPc0Nu?=
 =?utf-8?B?M3l6VmNPdzBPVHpMVFIrRlJkc1JSNWxKV3VJTzZUaVF5bEJKaFY0S2Y3dkZa?=
 =?utf-8?B?Vi8yOGdydDZuOEpjMjNjZ21MVGR5ZDZzQ3ZJKy9MSll1T2xybzhUNEFyS2Qz?=
 =?utf-8?B?eDZzVENtVmdjbU4vWkVDYWRWYUMyWkFFQjVqaEFiNVVyeElqb2xreURnM01G?=
 =?utf-8?B?c0lKNDlRTjAybzliaWM3V3gvcmVyNVY0ZWFJekJhV1lzVmVZSUpsejdRWU11?=
 =?utf-8?B?c1hmR1ZQWjdBSVdrYzJNckI3bmNRUm1nT0V2RDkxeU4xSVNKM3YyQktnMXlM?=
 =?utf-8?B?dE5YWjVRc01MYWFobVMrY0toU2lQN1FkMTFnNE9JcnNVKzNJaWRRakovYm5i?=
 =?utf-8?B?S0xwR3V6TmZranM5enNqL28vVngySkc1VlNOTVpLMHA0MldBTDlnYUoyTW9G?=
 =?utf-8?B?eVNiSVptSzZYc2FvNURvRm5BbVZxUENQUTlzU01nTDl1MmxiVUl4NnU1NU9W?=
 =?utf-8?B?aWoyR3pxd0dPK0lZcXRMc2hHY21ORTR1Yko2Wi91ZzZZTlJMV3NVc0dZQWpu?=
 =?utf-8?B?ZERjNTlEazFmZ1ovR3pDMVBiWDIrdXp0dFE4ZUVXOFdMQTlFNGhZZEkvaSt2?=
 =?utf-8?B?cTVxWHE2N0E4UzNjSlNPdEtFTkNRMUp3WGZmTW9BWmJ2a2k5ejVBRDJnL3Y0?=
 =?utf-8?B?L2NISDdoK2Q1azBxZWlsMEhxalAvd24rZ2ZDNTRWZTVwbkhUam5EbjJoYUJq?=
 =?utf-8?B?cUdGeW92Y0ttWnZLeXk3K0IraHh1NmpkNmZnL1Vwa2NhUklyTStBOGkzTnNC?=
 =?utf-8?B?dndicjd5eGdYSlg4K1EvekY3akxFd2U5WEtRdDc2K25IbmZEUVNpYVpXalVp?=
 =?utf-8?B?czAyMURQbU9PZ2RYd3pCaVI2Vm1MQ21XRWZVUmplK2RBNkgxM0Y2cEhEZ3hj?=
 =?utf-8?B?UXc1dW9mM3AwYTBRQVR1R0ZBaDd0Wk5IMHZrREx5Z09lRVFtUDZObklSSFho?=
 =?utf-8?B?VzYxMUp1S2F3QjNkTFRCZHF1Z1JnU0g4ZktGdmEzeEdUTnFVekFPWjF4QzFq?=
 =?utf-8?B?Wjd4cVBIczFaUHAwRUdUN0hkY25YMncrODZLako5cnhxWG9USENHLy9xZ3Iy?=
 =?utf-8?B?SXBrL2E1bnFtdCtHZmpxZWpTNmJkZ3dTQTBneFpOclNtcXowMko5dmU5MTN4?=
 =?utf-8?B?VWFQQVNVZGlsbndQMmZJc0JVWmJDRHNpQ24xU1UyK0RJMnMzRDhEWXJTVVdU?=
 =?utf-8?B?cjNVMVVMYkFlZFptaEpyTkp1UExHWk91WDBzYk91M0Zjd1A3cEY2TXM4bjUy?=
 =?utf-8?B?SGNtakdOMjZwbnFDZk1rd1dPSWpiRWNXOXFUaVliZzM4T0dJRFFmODRFNEVj?=
 =?utf-8?B?VjJCb3NWQWJET0Y2MWY5OGVPeVNEb2tPSkc3aEN0U2o3Mk1WeFlJZ1V0aFV4?=
 =?utf-8?B?eTJkM1B6UXd4VVhGdzVuRm10UTdCU1pyeCtBTGFOc3hpRmUzWm5QTXVaVWx1?=
 =?utf-8?B?LzRKZHdWTE54UHU0dzhHWXpCekY4VytwamdXWFhRODdLZGp4VlJ3d3M1NVJX?=
 =?utf-8?B?ZXp6b1Z5R25LMlZ6aTlsVEhqcXkvRXF2UXBPMXdCQTdsTHZ5UHJMcUJUVXRB?=
 =?utf-8?B?WGxUQUVkYWFLVkM2RHY0R2lWSWhIOURycXRNZ1kxaXNxVVlUSVhQb3pGWFNt?=
 =?utf-8?B?WWY3TUVTOHBxNUYxalQ0ZkthK1FOckxaUzl6bTFEYkhRb2R5WStjZjNXVmJT?=
 =?utf-8?B?VThOZS9wVHB4ai9HMndzM2NaeHFjbVN4RG1ka1d6Q1gzUE5TMXUyN0lVWE9v?=
 =?utf-8?B?MTFGamNuYVAwN2FGNDRlSkRxNEdsZ1lIci9BZTZ0UytxU21KaTNCK3RKeGtY?=
 =?utf-8?B?M3hBMWJka2FzdzhlelhYVXkvc2NOL2lIME5PODdKWS9aM2hnRnFqbWJPYlJv?=
 =?utf-8?B?ZkF3V2xvb245N1JUQW51Z01lNmpzVVhURVBTZThkYkVZb3IxSVQrTWNIWnRU?=
 =?utf-8?B?dlBpMDhIU3A0VjVKN3pJTSs1bGtzcXZ6dDN0U0R1RTNOMm55WjlOT3l3aFgz?=
 =?utf-8?Q?FBlLmet98DhAcwoA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b2bf1f-2c26-4d08-d6c7-08df46d89a50
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:33:42.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0f5F/Z+7Ik8SVczxT5oqw7MIfVsyVGjP0Qu0njdirlyISfeubcn7uznTQlbBiGDBOh7f7I0ngAbVPBxtTV794IFA6yrWC19jySR9sXM4LMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR06MB8539

uart_handle_cts_change() has to be called with the port lock held: it
updates the CTS counter and, in software flow control mode, hw_stopped
and the transmitter through start_tx() and stop_tx(), all under the
lock. The interrupt thread calls it without the lock, which lockdep
reports on the first CTS edge.

Take the lock around the call, after the register read, since the read
is a bus transfer that sleeps and must not happen under the spinlock.

Use uart_port_lock_irqsave() for it:

- irqsave, because the delay timer takes the same lock from hardirq
  context while this code runs in a thread with interrupts on;
- the serial core accessor rather than spin_lock_irqsave(), because
  that is how drivers take the port lock, and start_tx(), which
  uart_handle_cts_change() may call, drops and retakes it with
  uart_port_unlock() and uart_port_lock().

Fixes: f65444187a66 ("serial: New serial driver MAX310X")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 179f5f4cc7b2f994c1dfd1b498878f4f7d6a3299..b2d887316957c2ca46e83efab08a537fc584b407 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1043,7 +1043,8 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 
 		if (ists & MAX310X_IRQ_CTS_BIT) {
 			lsr = max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
-			uart_handle_cts_change(port, lsr & MAX310X_LSR_CTS_BIT);
+			scoped_guard(uart_port_lock_irqsave, port)
+				uart_handle_cts_change(port, lsr & MAX310X_LSR_CTS_BIT);
 		}
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);

-- 
2.47.3


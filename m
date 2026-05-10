Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F04361DB8
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420476; cv=fail; b=Mt/rOAvi/4G34uyt2Os7xoLrHJ8vRJAEYMf/Gppb/igeQKP+UU1BZ4ozHIYAZ8RNhd2IVlvXK0C8wjp3vUBcQ/EAcHwb8Z89Qf5INmdCEOGRLQvtbnzyVOQKlRicw7GtmSzW2b5mR1EED5XyyLGbnVQYCUAwf1PmX2Ej/71eWrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420476; c=relaxed/simple;
	bh=gVs4MPpkCY7+gc9NpbPi6/pOtNMg0qIOQGzj6fRtCuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbhKJXpfylPUonEdS2q9Nw4q7nPPZPGOo2BuVONXH3dCnf5QLUgn+bNeZ5HatKrx3KRQi5ENx3pyO0qS837fi9JwRTWdN/dvUteuO82yjncGBFncPOWNJVGP6VV8zfCYoaPQ/+h9UMqN2ozbhMAdOblbkjTJkUljWbZI5F85Gwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=icohDrq2; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="icohDrq2"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ADemVx1446717;
	Sun, 10 May 2026 13:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=AbH+SX1+F0kRyAa6yJWm0Ue6YyFPANMefyqRy5mBXM8=; b=
	icohDrq21yOq+tYdmO5CKLVnuxOtvm1RzDQfz5HCjp5/E4T3SLkAKh5GTjjwsSfn
	GCwK66BFFmO8wX8kVxiV0+bF6jQGKHCBiNRtUNRZ8XfcOC79ccMj+3kI0nz6AOfM
	1UF4+RjDS2j7ve7supx4q+m66MYJmKKJXVi/ONTF21vfafU0Hc+nHkzZ+bpDl0n5
	f+H75MVv9ZL0o9k8yjf4VbhNc2gd4yMijaFlNQS9Lm/ndY4YX4eigJiuA1hqnc3c
	4E1O0PkTC0g1u/+jxL4OA0JrSXsFDfgvmdTQmnu/AeIjYOR6nTHaUyH9DyMpRA2V
	AFu0P5gE011chqSXI2nL0w==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1uw6h2vw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 13:40:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3h6NYJnGIKVHt1RBhmoReVGb4Evuj1duN+PmU5vvTKme2GQ5U5jhPITIIzorQFrw/hsesS+P0w+90G3nFgsDe33IR+AS8XTKYa1wcBo6i4NBDVYcx1rahM1XUD9P+CBGomVt8RdefAcTrV5iKLEE+iz+93uocFq2SRQ4eQ4VKvZz39iCVJYEsqaGler4IKedZRKmSkmjB0JJf5SM9sdjP1cHOcCvJoq6l8niixa/dIGB0VQpLL3ZAYiP+knKRGse3vGVZMoKDzeHesJjuIUcmpex6fGfqiqRC2k5XX20gOPe8JgDoCG6kXK7g/HTUOzHyf1rIhDxzUcwXPD/Hm7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbH+SX1+F0kRyAa6yJWm0Ue6YyFPANMefyqRy5mBXM8=;
 b=bNufwZFl97EMpZgWcMm2kSKxbms6BE0Y/6Y6FtwUfnM49DxR5YNARh9gH60pLeVVQ8FCum2cLlbAeCUTG2vqhJsGSUzogLcOgQ8PBE+IVO+97bIMawTCb4vAp7cWSmSSTy7JtOL5BPZ9xXerbPFprYZkwdPgDLpllcGd8x3+H9ffJQ4SY7Nt1ecagTgWDbYMzFr+A9KlnKCmqfbqGOR0LbudMYPtIu7SSKTprPuUfe3LVjTRmFRlKwEoEH9qMmIG+0n1TxexBHv/q0yYRjcV/VjSfKnXBBmG8a3xKz0yX12GmW5ZMsXOVFXBguzYONVio8ViiNjE5g3bXPU3q4BMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sun, 10 May
 2026 13:40:46 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 13:40:46 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 6.12.y 1/8] serial: 8250: use serial_port_in/out() helpers
Date: Sun, 10 May 2026 16:40:04 +0300
Message-ID: <20260510134011.618215-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510134011.618215-1-ionut.nechita@windriver.com>
References: <20260510134011.618215-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f5d5c3-478c-432f-a225-08deae99bd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	t2ljpDbcKODEGT4lSdGTms+vPvxrvMXxvvS9B7LZfQHt3k58c9J+4L7K/D5wTPTOvDUrlD9Y0HGSPi1MjdiHqGoLD2AoTKGurIyHDFiDQDTeajC2q9LO2KgaG5vZlU/4gpH7eb50YaSNkqJcwNf6B0B20mcUFIPuP9NbrSyAlT8kRszk9cuLuvBB+ktWz8XZAfOkGcMA8h8iuHtp0iCA+FfDTLPO8z4AHqzWPfNvK/9jMc+Ed+wI1+JtOR/UgNcQkQer6F032hFi+vbZX1ajQYUHpdk3kPfg44nKAXC0JHb4gXAS+kZBW9/cKx4MGrEwQALqXOPFaGXuI9Mwn6UWkoQVJwJDDN/9KRrtRCqWf9B5Dyz7JAdiM++xVSaOt96eKXyoNyOOYCJObvLj5gCSjqcoq1y9EOPPENOEudBJBJ9EsGzv1j3WdMl3m01HBqxM47jMwNxqLjBjgwXiR2PMuIG65TrwoSJ63YopFrkc3n7XyhReO+bFO2F2WAYqSZL3ZgomWesGClSIc1Q26DqPZNMwJH1qIjcZXrqmbsll35NygULUwarqCpHhlHK8zsvuF9/CJNlnvdF3yM92T9CU2NcUCFFY5hQHCbVrQmpfQjVDr9qS0xhtpX/Awy2twrkbbsGVvM6nZf8dej2wME2Pdx0yp1icUrhJPm0u5+Z/e2OA1LRXQBG7Q8wZ4UGBJQj9tcQ8SVwAh9clWS4rnQC24Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0xQSUZQejFUWFdkUXRjaDNuRXc5S1orbUNLVnJPS0hZZjJ2TnovZFdXZjdT?=
 =?utf-8?B?bVBnMXBaMFo4blUya0FDdjB3cTlmSkt6dzhubis1aUdjWWxrempHK2xCak9z?=
 =?utf-8?B?OGV0Rjg1OGU1YlpWU0w5bWZyZi9zcG1LdHB0UFpoOGtFN1ZJN0YrTzV1V3gz?=
 =?utf-8?B?WlJVQjR4SFpoeWsrZHhUWmxlL0kxeExoOG9qT0xDL1R0RzQwd0VhL091ZDJt?=
 =?utf-8?B?Mlp0TVEyTFEwdkdQOHFQT3pWbk1xVU1IK0d0cUFDUlpKMjFyenlvQmJDQytE?=
 =?utf-8?B?dk1ZVFRnNExzcDJGd0JWdDFMLy9QSG11ejJSMVVQREpUSzlad1VPL05kN2Ni?=
 =?utf-8?B?Y0x2Tk5kTkpUUWVuKzhNcHREcjJvajhEKzdxQzRpbmppdzVxZ1RrL1hpeHBR?=
 =?utf-8?B?QnNzaVZzSkowLzBIRURzZFlJeE1FM3N2aDJNMFFrSGh6Q0lsc3NBQll0VU54?=
 =?utf-8?B?Y3BBbTczY25BYUNwSDl6QnJZSmxZK3o5amxHWnJ2NTJ5NnNCVG5Xam8yTlZo?=
 =?utf-8?B?VVdWZE5mM25NTzQ2dDhtMzQ5NEpnN3FObHhHbWtxOTkvaHJkSkVYcVV4RFlG?=
 =?utf-8?B?bk1mbVFoMHlXV1lPTnNiQXJ1amh2SVdwd25xWEE3K0gzazQvRFJNZS9TT2tG?=
 =?utf-8?B?bmxhakZWRStTNHo1VTRXakFtQTJkampMKzBLUnYvdE9uVEwxeEpKMW1HRGx1?=
 =?utf-8?B?aks2TDZkR1pPRXZzQmhDcHE3U2Z2UC8wMUZXTGpsUzdyRDc1cVRrN05LOFZr?=
 =?utf-8?B?MERBd2taZUxaMWthZXhJSWQyT3ZnM0xPR2hSS3hTelV3SzBRbjExQVhON1d5?=
 =?utf-8?B?UG5SYWo3aHc2QWZvNjZjN0c4amJrZFI4RnRNR3VTUmoxa2JickZYN01pOHVx?=
 =?utf-8?B?aFg1cUJKeW96ZkNDRTF0OURZbkYzTHJUdVVPV3d3K0g2bVBSZ2U1WlFOaWFm?=
 =?utf-8?B?azBzNEcrR2RGMlVtdjRJQ1hmYnpQNllCa0pxWTZWcm5ZMGdhQUNMY1FrRTBO?=
 =?utf-8?B?Qm5Vby9RVXZCZFF6ZFVtYy9PQVdRYmExcjRvdlBFVGJaQjR0U3kvclBSandJ?=
 =?utf-8?B?c29aMkVFUFluSTdTUG1FWDZSbDZWVTd3MGFQbDJEWnFDU2NoSU5aMTg0VmYw?=
 =?utf-8?B?V09peThiNTkyd3lzSDZFOWNSM0ltVjBUeW1vdHNJNEtSRlh2ZGdaQmgxbjJM?=
 =?utf-8?B?U2I2QjRoL01mSmlZeEZWaXp6QTkxWDdYU1hPNmdDdm1kZE40RnJOYmJXOGNS?=
 =?utf-8?B?TzRWcFhPeGtDem9YWXBVM05CeXRUcUhBQXhhM1JSR1d6UnIyNmE2RzZ3N0Fk?=
 =?utf-8?B?Y2plamNvT3lmU0k2bS93eW4vM3YxU1FkaXgxL3lGaDdTdnp1am5UMGpkOEI5?=
 =?utf-8?B?dEdtN3lsbDZCMitzZ1JzcklUNGg4Sm5QQjJKa2pLZlJtTXVuWkhFblQ2QlZY?=
 =?utf-8?B?bXFZd1EybU1HZDRRbllDNVo2UTBKK1JxVVdKb0p1OHA2ZVg0aStXL2V1M0pT?=
 =?utf-8?B?ZGUrYUJLTjBMSWNpbUdsRVpCVENpUitWNVQzdmgzVHI5cFF2azFLUXFZNzYx?=
 =?utf-8?B?R3Z3V2Mvc01ibitIMytiOEZXRmtibmtndm9mNE4reFg1VjY4WDNGOUI4M2Vz?=
 =?utf-8?B?L2EyMXhqRGhQaXBBdllpcHREUVJTbklTczRoMjIyQjB6V2M1L2g3U042QUMw?=
 =?utf-8?B?QlEwZW4yUTlaVlVMYm5oNVp2bkVVaGduUG5xYzhOWnZzNTBObUc4bzFFdWdQ?=
 =?utf-8?B?aGx6Z2V3dlgxV2Nla0RWMGtPbVFnSlZpYXpQNGVNOW92NTRVMkovNzdYaTYz?=
 =?utf-8?B?UnNKYkl4RkN2d0Rrem5vVkE0aGx5cTVUM0J3NHZMMjhvNU5jYnl3dnJzV01K?=
 =?utf-8?B?WUN5WEh5UHdvcDJNd2RNTkFVTTdSUi9FdVk0aW0zSy9aL09FWjZHNG5QU1pp?=
 =?utf-8?B?L3hwMS9zNFRQcXNnWHJWOE9KUlpWZmpyVnRBd21iMTZ6UU5lbTMwUFRnV1Zu?=
 =?utf-8?B?Tm5jTEIzN0lSa0IxcjA3RVFnQmd4Q2ZkM3k0Qk4vMU5LWHJmSXVDUGpFSFpm?=
 =?utf-8?B?UmFtTHBZaVh5Zmg4N0x2TnZUVjUyNkwvL3dTZHhQK2FhQVNaSDd3T1FKR28r?=
 =?utf-8?B?YVFsSFZTRlN4RnBYeWpKUXVWZGkzNTBsZVFkdC9oZkV4K1UvVXlxTjlITDdq?=
 =?utf-8?B?VmFoOWd5a3ZmeTh6QVQxWkNlSU54c0xCZFNLK2tVNS9NMmh0WnQxbkVqSXdx?=
 =?utf-8?B?V3NlTENMakF4MUVjOGY1elo2U0dqZU1MQ0tHUUxhUGlESFRVMmFDNVBMRk41?=
 =?utf-8?B?TXFRVTRPa2M4ajVPa3ErWnJxbWJRRklQMWIvNlc1akZrNUhGU1NTNG1TQ2Vy?=
 =?utf-8?Q?psHxIovE1GHIA/E+1mq45U4pMUXhQaBau6X2U2aeM3Emd?=
X-MS-Exchange-AntiSpam-MessageData-1: +jP4gaOtzxQyrWmm+C6gLe8LllKUrLYWwrw=
X-Exchange-RoutingPolicyChecked:
	eaJb66tqmjHXXxF+IaIgrCOXv14vI9yKBbLR/CMRc1oGbqqMsDK7OA7o53NyKN8/bHdD4PmNH9dVbR7OGcs8u3hXz7itSM6v0MKHdz834BZ1smPUpa3BYLA6rMV+oZe8mMRYM65UTz1Arqryx+nIFL4GINV4GJ6cpNAX9Evpnw0gaNLTjSK552o9y3SsiVRR5+P2hkBjxdpA07dv5n1tQzE0MmWS8RYaRSIZEBE6cJZ1YDcy3gj5SECfWVuTNha/osHe9K/WP4hPettLFWSh+0wEHj2fpl1efD4oxiC72cCLrtjjyhjpaT0+DHFdXjRBGmu8VEWjPfIrnd26mxVmSw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f5d5c3-478c-432f-a225-08deae99bd6c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 13:40:46.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hooF+3NkNyx5PlDaJdl99nXwH+dXxsAvoNrf11GS+i9dZQklD92D8Rw9uIfVkOi+6nFcJI0bFSC8rglEFW+2Xb6panaw9PSV8DafK6jqKoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEwMDE0NSBTYWx0ZWRfXx3OkC5UAuBsj
 LOCT+Pv8ghymSEwwNxVhkNkHkl3SAPk1xiACxKVSaMvgqqN9WwTvdZOt3YrTd54dlcPzl9FWWqD
 epsq/t84nYBh0eJ2ygRsvq3AqTw2ia8VabYtgq0K+yqg0wkH/WgY/nKtFJKHQVmnHbzu+jaCb4C
 vPh8fPCQxHdj6jMMIW2U88HX9IaNNGZeIJUL9rCriB6WnDtajJbj9WRRfAqoKQXVXs3sCu1gvld
 fjeBaLhUGy2+yQqVmI2GCMvMmcEX3P0Xwhz75WszRZLmCHIXZy/26RukNLI9Px0hO2zFci1nPEH
 ZmD/eif9cn646YkyKiAGB7Hq1gfhWFiWnoRyHIBYSWvssxI7PTeFqThRmJB4OnHn66U5p1fLT2b
 KYceEFbL4LY/vB4JAmPxq/RHUdN1305l6sSr8SHQ/TftlQxhNKdn6yNh6ppfZj+0rL7aqm1kJc/
 iF0wHFFTDceuX49CZNg==
X-Authority-Analysis: v=2.4 cv=d6nFDxjE c=1 sm=1 tr=0 ts=6a008ae0 cx=c_pps
 a=XZql7kJaNSG894ZXpSE/kQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8
 a=bKCr7iAUo_JsmPGjlysA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: veAXr51GMEa9MN7ToDR-Xu_mQQT1yDNw
X-Proofpoint-ORIG-GUID: veAXr51GMEa9MN7ToDR-Xu_mQQT1yDNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-10_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605100145

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

commit dbd26a886e94deb7fda9050f9195ccb41f9a5d93 upstream.

There are serial_port_in/out() helpers to be used instead of direct
p->serial_in/out(). Use them in various 8250 drivers.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

--
[v2]
* Use serial_port_in/out() and not serial_in/out() [Andy]

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # 8250_dw
Link: https://lore.kernel.org/r/20250317070046.24386-28-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_dw.c   | 16 ++++++++--------
 drivers/tty/serial/8250/8250_fsl.c  |  8 ++++----
 drivers/tty/serial/8250/8250_omap.c |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f17dc3de020c..3225011fd772 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -120,12 +120,12 @@ static void dw8250_force_idle(struct uart_port *p)
 	 * enabled.
 	 */
 	if (up->fcr & UART_FCR_ENABLE_FIFO) {
-		lsr = p->serial_in(p, UART_LSR);
+		lsr = serial_port_in(p, UART_LSR);
 		if (!(lsr & UART_LSR_DR))
 			return;
 	}
 
-	(void)p->serial_in(p, UART_RX);
+	serial_port_in(p, UART_RX);
 }
 
 static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
@@ -139,7 +139,7 @@ static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 
 	/* Make sure LCR write wasn't ignored */
 	while (tries--) {
-		unsigned int lcr = p->serial_in(p, offset);
+		unsigned int lcr = serial_port_in(p, offset);
 
 		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
 			return;
@@ -260,7 +260,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
-	unsigned int iir = p->serial_in(p, UART_IIR);
+	unsigned int iir = serial_port_in(p, UART_IIR);
 	bool rx_timeout = (iir & 0x3f) == UART_IIR_RX_TIMEOUT;
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
@@ -281,7 +281,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 		status = serial_lsr_in(up);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
-			(void) p->serial_in(p, UART_RX);
+			serial_port_in(p, UART_RX);
 
 		uart_port_unlock_irqrestore(p, flags);
 	}
@@ -303,7 +303,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
 		/* Clear the USR */
-		(void)p->serial_in(p, d->pdata->usr_reg);
+		serial_port_in(p, d->pdata->usr_reg);
 
 		return 1;
 	}
@@ -390,7 +390,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
-	unsigned int mcr = p->serial_in(p, UART_MCR);
+	unsigned int mcr = serial_port_in(p, UART_MCR);
 
 	if (up->capabilities & UART_CAP_IRDA) {
 		if (termios->c_line == N_IRDA)
@@ -398,7 +398,7 @@ static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
 		else
 			mcr &= ~DW_UART_MCR_SIRE;
 
-		p->serial_out(p, UART_MCR, mcr);
+		serial_port_out(p, UART_MCR, mcr);
 	}
 	serial8250_do_set_ldisc(p, termios);
 }
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index b4ed442082a8..59d3d2801c2e 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -32,7 +32,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 
 	uart_port_lock_irqsave(&up->port, &flags);
 
-	iir = port->serial_in(port, UART_IIR);
+	iir = serial_port_in(port, UART_IIR);
 	if (iir & UART_IIR_NO_INT) {
 		uart_port_unlock_irqrestore(&up->port, flags);
 		return 0;
@@ -54,12 +54,12 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if (unlikely((iir & UART_IIR_ID) == UART_IIR_RLSI &&
 		     (up->lsr_saved_flags & UART_LSR_BI))) {
 		up->lsr_saved_flags &= ~UART_LSR_BI;
-		port->serial_in(port, UART_RX);
+		serial_port_in(port, UART_RX);
 		uart_port_unlock_irqrestore(&up->port, flags);
 		return 1;
 	}
 
-	lsr = orig_lsr = up->port.serial_in(&up->port, UART_LSR);
+	lsr = orig_lsr = serial_port_in(port, UART_LSR);
 
 	/* Process incoming characters first */
 	if ((lsr & (UART_LSR_DR | UART_LSR_BI)) &&
@@ -71,7 +71,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if ((orig_lsr & UART_LSR_OE) && (up->overrun_backoff_time_ms > 0)) {
 		unsigned long delay;
 
-		up->ier = port->serial_in(port, UART_IER);
+		up->ier = serial_port_in(port, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
 		} else {
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 0f4ce0c69114..dc9e3e25d55f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -688,7 +688,7 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 
 		/* Synchronize UART_IER access against the console. */
 		uart_port_lock(port);
-		up->ier = port->serial_in(port, UART_IER);
+		up->ier = serial_port_in(port, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
 		} else {
-- 
2.54.0


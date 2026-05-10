Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB237E2EC
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420472; cv=fail; b=cm0UPR7WbLOhchOszDE+A4GsIZrpZxwVNn6xWOAK3NO+pNXjPGCaxFEcVs8xZFa90kt2Kb/ZgqcgS4z2aN7nghuVO+/Vxh/LCwJ4b4sREyiNXLO4X7E57JQlUK0SOYRwJNYhDqVPTn5bUed5wD4gBTWiddYw8GBi9Wtf4dzQ+YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420472; c=relaxed/simple;
	bh=pSZhiLxASfyqekZIn+ZgjWNyrombC4jHML3xs1hp5DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EAyjY/N4iuBllbHFKV6QL+VQHzyOvT9WuF/HUNUVEqaTwQ12eWR1viAM1+CbNYfoHHox2sm9DxETjZ5FlTBK7sx107nYPjqxPdc7VPokFAdZ0zD1jWhfBy0LmKCXVWg3wI2fpzZI7RjT+0O9DD5m35o76nC7GnuWpelZvSqcukQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=LmLezbSH; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="LmLezbSH"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ADe25f3724327;
	Sun, 10 May 2026 06:40:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=900lHdao5s7ZO+CeC0A0b2H9y3HnUsX+b9iUO/JKXTg=; b=
	LmLezbSHEZ2rXyMbEWql7eQ2RZ+VlWHkSSvUaGLwqnKMBsPBkoRiFyIN7szEYvZY
	lZresQrmLbZll+wIymh0xyKuzjpqUdWv01HN3PP8kRXsMVWGdJJnon+pBKXM4joa
	nZCRN98GvkeJQSbWMo5yxNljZONkbkmElTQHiIzxmryD/W3sRh1syrunS0MmGfIg
	/5Fn3/CdVr9UfmUvF2kuC5vw+6bj01W681TfYxs024o3j/nzsJEKAxk7NVfUcMcv
	27aLOpb+dOYGvFCJzeIs+5u1VJqlGj8pBTkZ0XZALjej1Z88r+EMJogsogenhRlH
	NpvBU9AjpeOQisO6kVPllQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e24ee8qet-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 06:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uqm1RjiYXrFpqQDS1XEZ3gtCJqJzb5i9YClsxy5CpaHRBsxHybL6W8344ydQ38lwkQhdQw86Yv8tN9QJhmfKR7Yr9EDYMhJq5Q4AJdzS9RZr8T59/TEvY50zOxRcodxBPiKAZt302eKDhd1qHqxAfMMiHBbYu9JYSMvsItRZ+zmU5wYDmVRidkPC1mjYCpT+aWfzCopFocqYHxro3xnO6s4DVImmfLbH9AWhO0xv4Ke1JUeJ6fiVeP3qOqkNLzymyt3uHTLeuR38U9QraXvCMmbWRkPdvDndMVH4fgTSvKcdtScvFWY2eVQ0hj/P0+QYLj3lJgDskQrff9aVIHSzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=900lHdao5s7ZO+CeC0A0b2H9y3HnUsX+b9iUO/JKXTg=;
 b=Fb2VnAZc/TLSsVeabaVJ+1Zw+jgcKvG+ieYmTZi/0JVvOsfcH1mBobJWucLN8tcDkS3std0ipSnsQvzE9Y+UbC6Zq2BrYmRChgBGGOQROYt9g3xO1/aBSgUF4/haQ/oYopwk+/Rw9ebMfJjt9ulMJKagaZ1F2Wf9Rzl2kR5yctkomgydoEe1TYctIOb/jV8qhs/Jg2VwcHN0jIi5+n+kjouFcj2teKlA+OvOLF1Ws+oSZN2lJ+fUWMGXl9TnbebesB+LUaUfnF6A/qy8BiNEXqZ+Bbaw3Y1tVcU2izGMHhTqmYokpPHKigyHem+4/9eCDlg/8Vj5oIYO80R3KcJXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sun, 10 May
 2026 13:40:51 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 13:40:51 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 6.12.y 2/8] serial: 8250_dw: Comment possible corner cases in serial_out() implementation
Date: Sun, 10 May 2026 16:40:05 +0300
Message-ID: <20260510134011.618215-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510134011.618215-1-ionut.nechita@windriver.com>
References: <20260510134011.618215-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: 87a7fc48-db79-4170-3b68-08deae99c03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5qPRiWdbIJzv0I+IF11xsPHezgr8OHGA/sMA2cZVLBdxw7BgiXVuWwOIrUdMC0UrUeaI9Rjtwho4uGujXyOhSvs3REENvYXRQQm0YJk7IbdT4pHB2DOqLEwlj9WxtTMJ62BC33QnC481l+IIIX0HTfpfbqxgDYRtN6a7us1CKVhOZ040ylQPBFII0ueUXZjjSrOq1qWR91s5vd4zSsYQIkrrDzEa4N83PylDZzjy60ZkaiA1bEFGK9uTz3NBRIgIm06r3Ui4ohBPfllik6u9+rp7rAAILAis5PbsKt4/xv835bqVB+BrWXki9gUEudRMboxCStn6SN3oeVc8aEwOAHyoubhzWR1h92II8luyGaGqXKXZCDHTPnTUY/HcwuosKIgQeAiflVw+NWL/NkLR9SfXmY6TcY5gj1jL7WsKJ+9ey9gOBZ2trMDtZ2DBKQ/Jb98ji9x8mGCXrVRAk7ZRAlbDQXKB5/SvElvFrKNyGs8X8EUA6gOfBo66yksvlAnJxxy2lo2m6RYXxQWds695o+4VylkxMZbdQ2Ru1+osR3NINdJDDHtIDyND4sv7AxskwdJOZlrE5KFWPOZ44dzlyEabLFuxD/aZyu81kliCqBdYOFPigrGEwNzDE8z6EArTsBLt/Gm2dRNYegDrYcikT8KRD4vRyKxuKW8QgqR0Xpu17gPwXZPwbTz+DPu/ydyOrim+hsEOqgpMBRuHhDMelA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DjlqZTtDnfrWVEE5IFvajMYYyyBupY/OcVHDvNZ6l+VLYaCWwcc+LElTGRUu?=
 =?us-ascii?Q?25HxaNx18Vrt39qeybp+k19yv2vx+JgcAK5Ii5JPrb289v1+lU1f9x6kx/cE?=
 =?us-ascii?Q?NpGkYH9Ur7IOWrBoCkOiRqImZi5k4xDJNHvZ5C9T++2e0wKonBMH15UKyAFE?=
 =?us-ascii?Q?X2pHpr9IfLlS6WCP3m8E1A+95EYwj2wpIjw4j+pHltz8CC8p+LRj4qrd02V3?=
 =?us-ascii?Q?GdV3cuX+sDOCaW8iZXgWYqmjFLGjJuWSlyId/bm1OkfzLmOydrJynqAEcpyr?=
 =?us-ascii?Q?H4Mf69KN9USspvInmA0s3m9cCUw9TlK07vKYdX/gE5l2udhC3VqgFWzmpnJm?=
 =?us-ascii?Q?OTwtUKsZO4QqsjC3GD4gemrmQBJrX7ndV5ENl21+LHxXEzQMUHfjYWDaXACm?=
 =?us-ascii?Q?rqdYmJnouZkTe3JOWOGUWCG2/F/7WXl2DQR69NxchM9+K5WeFuY63F/eWzfp?=
 =?us-ascii?Q?N1OJO38ycO+oVj3VO9lGko6uJzjV2ngJ1XERIueEAp+TxGNynP2NHLAN4lLp?=
 =?us-ascii?Q?gfu53pZDREim0Z/Wge/GFvJq8PcI2QauXtxTU829JCE/n70hTLo/Xr0ESmY/?=
 =?us-ascii?Q?j0rj+mU8b7T1+IWuZ4KBy5KJgGVk+ZzDCxn4Cd0O6D5geC+pTWPNXKwuGlyM?=
 =?us-ascii?Q?+RQkDu5xkDOsaQIoW241OEvQDYmEFl9CVyTK6ttjrjMiS2ahHbZ3/4EZhaNN?=
 =?us-ascii?Q?AbahqB7Lm6+Pi059WoWF6SjPfz/QVRlxXPvPRTJRY0YD62cJwE7q4NpA1gV7?=
 =?us-ascii?Q?dD+Pb5gKN7fNxr8dCf02ltaNXpl7Wp8l079PhHpADD67qXvr1xh3JC2GAxp1?=
 =?us-ascii?Q?2MWF1+UBbeqNoLcnNDvhiOfp1yNHpbR2WDKQ7QzpZNjt/8eLNfL1lqwflmC5?=
 =?us-ascii?Q?Mp120V6Rng6y+kCvyXVV/vpCf6EhPgDr4/U5locX7CpxN9gFs995E5nN/PUw?=
 =?us-ascii?Q?1fPOuqYzk0FFMVbEL1C8T1hSMlHe2Ec2lN2s0wXk7bSNv0or10+bVyZvdlEf?=
 =?us-ascii?Q?AO3N1iGAdQNyyXGQR58NE5KgGH3PGD5u+I9jtCULY9zPUuN7Z9HhHrI/DfdS?=
 =?us-ascii?Q?fZ13J+U/gCNaRwqqSK9XYr6ABk55hgGyXhvohWXNR31oyLkWek5ZBUOJLn7w?=
 =?us-ascii?Q?/jV8ggyDLiD3nj1AzAGk+AZn/NvsN0BgkWVOWAKDiINjZyvZ7hrrD7Oj4GNj?=
 =?us-ascii?Q?dQbZktzfMopduA88jfagHcKziFG6pdmk7BqY0l3hrB0euJNJqgEwYhHjy6Z+?=
 =?us-ascii?Q?QOCVxqGuue4H8UwqagnTYysWEXLWMdSDsAR+2mmzs7HkCJ46Nk7tuzQV4Miw?=
 =?us-ascii?Q?gSN/djZ5g6mb2VsTwFIX1tR4RRAsl0nLozDR02iLkpQ8PZK3xZyQ1pxbfiCG?=
 =?us-ascii?Q?kUu1VBpUAzROllnWTZqFEsb0ytNHHKgfL/yU9u1NijO8yDPJY/sTYqTm0OTS?=
 =?us-ascii?Q?Kb7BmvhyTBfCSUFnyrkG0TmhJpswHjPJFFWtQoYzRvXK4dUb+OWK2bNh9B2g?=
 =?us-ascii?Q?HzJUNnXgUW0WQvrwIKs0HOr084VipexTpHi6+w3MwpNhi4VPEGRxdmtKeFoz?=
 =?us-ascii?Q?gCwp4Kq0cIzj43UTZ+G1z9PVFM2VhVZ/MoI6+mGjp568T0UczJZF0MCUclYq?=
 =?us-ascii?Q?Hjbl0Mp0Svtww5wf4y0VnyVHx8IoE4QbYhB922njngm7Ucq6ZDWPRPeLfF4M?=
 =?us-ascii?Q?tIzCuuwR8QaUpUVQyrirn+7fBvw10jODdB83JJakvkARyzlwZ+H2BtnTL36T?=
 =?us-ascii?Q?nGG11tYUMhX99BPn9YgbLN/9cEJlfLrHrnBl7bfnKXJZO9NOv1BVD/fKCvck?=
X-MS-Exchange-AntiSpam-MessageData-1: qOVDsFmFRxnHNKaVNbKy465TtQkFRaThfYA=
X-Exchange-RoutingPolicyChecked:
	X7S9MpV8zsYk137KjXXVjT8k+EagjONyD0H1L+MuDCP8LJVgOK9RAmmRTjXpoFGR4LpHyj6m+IQS1YoPLKSf6VChGPa1E5JWtQ58+8dZBcmvubxEDAsyimYQfIZBzaE3RqUHUh4TupH1gZDv4Qntz+LfWx7wjDrA5V4IwZbs61mbNR7DfbGspH21vintYtDmpYpGVjnvg4/6nu+Gu/t9EPjdMdy11byZWelBke+njufdn88vk3NrIuqkyDboSrMY+yXldIU/ghbCSUFN7UtG3W8geskKqwnaT8bkaODgRRUQ4p0UkQ32rUhblg8GFgWnLDSFvUVjX9wfvjMjYA3j6w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a7fc48-db79-4170-3b68-08deae99c03d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 13:40:51.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mcFyoIyhCuNiQzWxO+7iMAbr5fG0lRCp156oHuYywKvO2613gN8fXiyYgixCz/nXZ7vDqVk4sblCb4n2J4zPk4EKuzucd1Ti6p7cB+5LqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEwMDE0NSBTYWx0ZWRfXx/NA5NVsoDqW
 zwFCh+b+Dnbr+Br739TbBn6VIQpJNaAzr2y6F92WkL5oXFD7GLrhZ0zTzw8wyr5NULybctIPpL+
 5nBtlWATa5FG2iatLAEEstgi2iDx8UqaOljRIy4HP2VCHu9DJoP1tgacR8nQpLPApUEXsPicjzH
 luC2R2ZaTYj3CsKuXNlZ7wYFGm8+eQPROHY8AqNeL/1FV64GD/m7EWbo+pQO3KEM0dmmgbC3Q4v
 lRPBWD32lHShgA5hluiI4TS2GvLgCGagUsGCTptUrf2jyLVrtQFwnkamVyNvTPZWXa5ab/Mpfcr
 nagSejF5AdilZ3e9QnXkzt4+gmiJQraPY++q+1U3zLN4TECHsTc1aQa8XGjaay2o+VD8teLDVFg
 VjAe84ZMSPJKMfoKE62zVAqQ08GCu3Zh8nfUrPtt4Ga2co67hedQURlgtAbqtyVoZTlDf51afGM
 C0WmaUzExcbQdWL8nDw==
X-Authority-Analysis: v=2.4 cv=H/TrBeYi c=1 sm=1 tr=0 ts=6a008ae5 cx=c_pps
 a=NgWOhXrokr2/NniB/8N7+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=zITIGW6OYzySIfM0I-0A:9
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 2ivfUNrG2Ne0Ly91YuG1A2qktNBN415u
X-Proofpoint-ORIG-GUID: 2ivfUNrG2Ne0Ly91YuG1A2qktNBN415u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-10_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605100145

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit bd8cad85561b8de36f099404c332bf3e3dbe90f5 upstream.

8250 DesignWare driver uses a few custom implementations of the serial_out().
These implementations are carefully made to avoid infinite loops. But this is
not obvious from looking at the code. Comment the possible corner cases in
the respective functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20250317094021.1201512-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_dw.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 3225011fd772..88c55336d50f 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -107,11 +107,23 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 	return value;
 }
 
+/*
+ * This function is being called as part of the uart_port::serial_out()
+ * routine. Hence, it must not call serial_port_out() or serial_out()
+ * against the modified registers here, i.e. LCR.
+ */
 static void dw8250_force_idle(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
 	unsigned int lsr;
 
+	/*
+	 * The following call currently performs serial_out()
+	 * against the FCR register. Because it differs to LCR
+	 * there will be no infinite loop, but if it ever gets
+	 * modified, we might need a new custom version of it
+	 * that avoids infinite recursion.
+	 */
 	serial8250_clear_and_reinit_fifos(up);
 
 	/*
@@ -128,6 +140,11 @@ static void dw8250_force_idle(struct uart_port *p)
 	serial_port_in(p, UART_RX);
 }
 
+/*
+ * This function is being called as part of the uart_port::serial_out()
+ * routine. Hence, it must not call serial_port_out() or serial_out()
+ * against the modified registers here, i.e. LCR.
+ */
 static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 {
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
-- 
2.54.0


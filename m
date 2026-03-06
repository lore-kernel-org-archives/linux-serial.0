Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C07130E829;
	Fri,  6 Mar 2026 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772783194; cv=fail; b=fLpzrFvU8FJ+P/8m56kUiE7YTccCEGoSL1dn+n0qsmi0oayELbYuZRF79EpLbdNYAugzAcBAblnyKVfCWAMr10jh6Bzu3ArKoD4xeEzly2+gl8twSBYsHw/Ry0z3udbmn3/cgFhAooX5JV9pmxSKKnSlHOdwxZsVOxQsNlYqf0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772783194; c=relaxed/simple;
	bh=0rvCZ6VSdNdiCDmGcpxMooHcTPXYI2A1kJe2Yd9ZQjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YJleEtuS2v8AXWq9RORui/JWoAaJ5uHWZ2Yz4MbqxuJ3iBeW7ti154DRq0ybNTZ5NXdn3t1K5nzh3hXSouPomfAGJwz/ow9snNDVz7zZjP4M3nDciv6ztbjE5kQBJt9MIWkXah8IhiHLpYItJJBQsF803eXxfvsU0zp4XEwjvG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=J0peemT3; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="J0peemT3"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6265m84w3250335;
	Thu, 5 Mar 2026 23:46:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=0rvCZ6VSdNdiCDmGcpxMooHcTPXYI2A1kJe2Yd9ZQjE=; b=
	J0peemT3SMJuI9ut/IQQis+qPuS88MvtymYSTl7ZxHRfNvW1mAmbnm+XP7qOhA+t
	fPrznODjUKpJaM5/E9sRaWFCCEpcPZrNsxl6ZRpXEvGLlxRofbaDmnOA/ZiZhMHl
	YT/c0zoSRPui86OJzgaR35YyRSf3s7qxd0Nc/OTZPRg/Eipm1KiyGnnZ9q7Fwnzs
	ZyqsRulOWXSeun3OL+Bs8I0Mnsu0/bXwRMwGmmyYC6kgMy9hPMfov0Hqr4F7EWco
	4ZTY1r8DTLEpdHX23It99bvt6xjRqdV790RUwhs5dSst5qzVJ/lI+e1BtbPxOEi2
	T1ELv88+Hb6i4Oe4/P1FqQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012030.outbound.protection.outlook.com [40.93.195.30])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckvh47bed-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 23:46:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8Aaof53ZgOlxW/Odg+PJJHWgEUwX7bWgcu2npgDfAqJfxicq/tj1sceZlz91mBhO++AMvGR7SbrbiWxY4R6V++p1qRKS3JndfYkg80pgpiA+OD8pGZ1p5UDLvQYzowXJ4L8IooU5HmO7mBkpD2sImM+gf22Tr+UhcHrMLYE3wjL9BB2+SjqwvGtaBdP4XHVtUKGq9fz5gvzJQjC7YOnGk/Xp8GUV3SkfRa3uHMqQtDUV4QDcZvg1TJvcmhoIze3rLHVvKDHgu8kVpF3HwkV3JL85TXTMX8DWtAsQiLfgoskrvy6qxJ3GmK44XfVcpbCZIq9UBxcfb9PD6JYee45XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rvCZ6VSdNdiCDmGcpxMooHcTPXYI2A1kJe2Yd9ZQjE=;
 b=AiAxRCMFYbtN9fAp9eIvhniQ6DF/sQMGJvJKpfDuXTAF/HdwgVyj/vcgmsFIeEAManUJxZI99d1v8wJkBr+xDJ4zSPPRc+SVh6diATEzxyGk4P7AitMAKnrqHXjQM2TEl9bq+wpwEQt7R/xPHZ3P9qeeSYE2urDEGlbcbEajUvDkb49VRTpoC5lhIrZr3v9Vswnlffjm5EjYAHF3JKkqT6ibGQgz85PVOvTPXlXW4fsFYNiZnKenRuTx6lbkxQUmJSB1ig7x4hUAX8aAqcJd99ImWik9YAjlKuCijCn25MUux/F1oRo3Eg5xzw9bPiQtDlGQxGibh++keX2ddFtJCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS0PR11MB7787.namprd11.prod.outlook.com (2603:10b6:8:de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 07:46:00 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9678.016; Fri, 6 Mar 2026
 07:45:59 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com
Cc: adriana@arista.com, andriy.shevchenko@linux.intel.com,
        chris.friesen@windriver.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, qianfanguijin@163.com,
        shankar.bandal@intel.com, shanth.murthy@intel.com
Subject: Re: [PATCH v4 0/7] 8250 DW UART fixes when under constant Rx pressure
Date: Fri,  6 Mar 2026 09:45:43 +0200
Message-ID: <20260306074543.9953-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203171049.4353-1-ilpo.jarvinen@linux.intel.com>
References: <20260203171049.4353-1-ilpo.jarvinen@linux.intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0206.eurprd08.prod.outlook.com
 (2603:10a6:802:15::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS0PR11MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 73413c6c-c216-413f-f297-08de7b546872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	z9UVsJrpNHnyDY5V2gRoFiQnd6q5hZj4Sj4Y1XcFtydbXBVFSo2RYSHtnWVYqTDwv3YV2TyBBWPrQIGSMh9rPDbA4rcCSMveD1Ov4dL3plH6CbMENjaZ8HKIIqUekQ6Ab9ai5V1EuWkKi5Pwy3bSfV/ic6+vPo340JEkHm9cSEHDMes34uhTCDMWsXeTsaFS3HxYnxtIX8iWX2/eWzuNWBP/XFeaZAWnQ1deVYJ36BeBVcCUHEwNaYR+w0QgZYcikLTo3r8aWRSgP9wa7HKceS7jelMKpg+PeYC9nfUusA9ODHPIV9x6CYApKyKutEqO4+f58nhKkVBeEoT8TlLst5hYmm7ErWIgMUtBfNOWfaQaV3E0xkML8NlqLL1keZBVaVmbYAybmDjuRIjOpCPvi/is32NFZux5PT8kRqCHxJviD0L4K5wmJUIWaMFj+TOTGP7nAShOazdf3LotN8f644U4fPd7QFkp0tf0kFM5nq0rj9cvoswwpKdNE/zJkyLr1toQ++TTb/gzEVl42koKxLp5Z2EcWkWn1ThMjgIVUXkTGe7Do5P0xWoQY/vstEx1HyRo3AYGBfO9KjMBefBE7JPaLLuSv3k8zZ+sxpgiPk/giEE0FIAgMQpx2sQvc3HFnAmYL8GWzb7/FTFSjag+8hyD39dbJ4RvM2uwEgrTtmrhUQ90VtURFBD48eHoprs4WSgNl10toBvI2GCaTtUZMXxWf9U5oGe66g4cEcPYayo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQX3FwHziZlPDfLirQ0TFZcSToKXiTJUc+bMlO6wuaICKppnO4Rqcrl/wdGK?=
 =?us-ascii?Q?vVaCLaFTXB9aPAmOSsWlcbaB+b2NquLkD8lgxe4WDFWEdlPzeScOxgIYodCJ?=
 =?us-ascii?Q?qDQrE2FZOppmFsMiVj83CYauX1/xKPfm1uywrS4q9ZW3L4VNnIGe4AzNB6od?=
 =?us-ascii?Q?5CM7Rn5cXssBXlIPtMif+T8dwCDf3V7u67q+rHI1JQqSKERojUGm2uYQ8pfL?=
 =?us-ascii?Q?8+t2+6xcIWhr45AZ9EXuSy4oLG6SPDEeUH9maUDhSK06C5gQOC72JjHkBGRh?=
 =?us-ascii?Q?ZF5EBsjKiw96ha6RWJRyT24sAN8Y9rhPs/5ayMiu/mzOBLQzRpFW7fXwrjw1?=
 =?us-ascii?Q?kHlRvnTW8mCyMxv7f77f9CTJIOs5pe/uNzzzlr3hlnzo+WLxKkC6ur3oJr61?=
 =?us-ascii?Q?4F0F1a8SvOFRcZnR+Gg2u+/pTxMbvVPZz/9EIKxjzEleUrWbptDV90HbdkmO?=
 =?us-ascii?Q?J30GCKgSX3eo52jbc+uU80HVX6XcIcsUKvFbEMp+zpDXB4QrFqCep7e1hE2f?=
 =?us-ascii?Q?Mzzbxh8twBgV03vddQTHemWfu0G35fFzGjPwoVvtnF93Tz2jtSTJy50y6nKu?=
 =?us-ascii?Q?k1Eq5Dujzs7HHRvJYKmDUH0Ah14x5hVS66iXpOUPY2h3g/oQtk06+4XhoY4T?=
 =?us-ascii?Q?ijS9rVE4vHuaMUqhje7mHgcilbvoI2LTEd3cnh/mZ1ArDqeiECG2xtPYIeTj?=
 =?us-ascii?Q?ii7r7PD7wbVlIUasm6eOXcK6gxQsfts/UR3AiUZFUGVf8MruD5jrP7e0fyoG?=
 =?us-ascii?Q?jQ8hLYBxhpj2O2ICMFnNlv/92WiEA21fwqPJHFqMXMzydxRdgQyaYqSnVNOW?=
 =?us-ascii?Q?6a5Bb2Fl4362jc+BeM2mYIXRbJ4mn9ux0DzIuKIYOV4fD5JfRUgDZSgiz4/O?=
 =?us-ascii?Q?N7sbqDq8nIvDjF+3RdbE5mr1twf1VGTRusq5fdXi6VAohksG7DUvM1vpBSYU?=
 =?us-ascii?Q?ONN26SYIrjVy3r0kPYI17BBKyKYAYc9E3+2W2WL6oKj//2cqQ8l1HFWZkVgY?=
 =?us-ascii?Q?sqD5s+n1hQ5uJEayazAOv5MKdRtUZFb/bnhoScF9vvwQKpEG6khmGg7h5+qW?=
 =?us-ascii?Q?DcjySGY7Nq8D5CCdGl4vrg/9/1CYnj+UkVHQfTRhPVAmSVfmD0NFCdwLG3hk?=
 =?us-ascii?Q?9C2JVJMitQlNcLsEgAKgRvaRJcxkRmD2S15bFVKkcluN86koCAyinNg9Df90?=
 =?us-ascii?Q?6P7mmAo7KIK7rG/uFF5jBZXrS04w6KdS1Vm0iZOOtiqrlHDL3EBRbSuNmNzS?=
 =?us-ascii?Q?XwzRp+yAvhdoXXV/8R/OP/Jj6jJBd+XOQGMuJHFnSnwOLyM24R0vtHSuXrxw?=
 =?us-ascii?Q?+M0Y6np0lOL3v236tJjNPz367NW/xmLM5K1gxNmdFaH9f4ShzG5SrsTTTWp4?=
 =?us-ascii?Q?uI0rYbePehv3jGSfyaPa6/W4FJ+19t0ZnbL+/dpX5fqqBtfWhPmbB6At/YAu?=
 =?us-ascii?Q?FW0JAO0x0lEbFgcQW2fWDKFbFaOO39omkOmK55EwumUWOZpp/1rX6wA6cCah?=
 =?us-ascii?Q?ipoYvvA8IIcmrg8Vd/3/VRZd3CUYSlwI+H7KPy8dHMiJFYISELNxM2eWj/lo?=
 =?us-ascii?Q?Cr1fAXGo7qaLHGa76VdUtEdEvk5j0bQuTqAsJ8U/YKqtIDOtRSF/m7HL/Fmu?=
 =?us-ascii?Q?JL8tJqDY2F12qu/zJs9copTo3Tad9DCNLP7ipeyA173fze4NJwcebFFIQtIz?=
 =?us-ascii?Q?fz8fq9lHFZqgIJWrnsUjYw2tVtQNdIEd+QJje5pxvE9e3Liu8/g4T94bnH+L?=
 =?us-ascii?Q?5sYQKrotej0C2DaAKqfGC0jIdsw5Vvm0x/roLKY+o08btHmMbE/vPlnfVaKv?=
X-MS-Exchange-AntiSpam-MessageData-1: YZ1ki66RF3FfXZzy13OGze5qVt6PgLHaWWA=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73413c6c-c216-413f-f297-08de7b546872
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 07:45:59.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 906tHCBpjyeisj6XULvVNSmiuqJaQj+BxQFc9kV70IwoC1nEJJ91qR1cU59FoC/UaFrHT0TWv11t1sMHAVcYqOz55/880jHqazih1RuNlkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7787
X-Proofpoint-ORIG-GUID: 27p-BmFoQqQRpXpaInhHpvY3SaGQ9-vA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3MiBTYWx0ZWRfXwdURLZEfz7aC
 tVc9nTJWBu3ounoytZfKbDWBPLX2V+XKd8Aoem4I5qYsOQ0+E0sdIocU4FsVTkULNeAvuij3GJT
 kLMIXb9QdmQG7AtWsdxdlMwCaXmZ+khHL9WzV/rsnB961tSg1ZjcE9a/wXzgc5jiGbhld0M+iWI
 s0r6OURDJs5k2wZPbe0C8kUPARkCP2rP3TcsqELEAOGiv4i/15hmZv8EhyLON4oCJZDAjPKb+vs
 VabzalfsT5dBpr0HpPC0FVuN+Jet6dPaYiPh2uvN7j+CAIlod4riXcbr9gpYNA75HN7AxLrEEPI
 ayoCNXfnHd6RhaYvcYZH98uuOSjX8lytbzkRRIBLnzlxunSR6ntp0JKDrGp8qTjiqzUP37FZFhe
 AsDe/NHDZA/iPIopLN5m9YTyHF5pL3Ags8r/uR2FnkX/pI4KAMihqv/c/JKkBIVdkgvLUAjvxL7
 /LDBIYFsoK4IJ2ZEt6Q==
X-Proofpoint-GUID: 27p-BmFoQqQRpXpaInhHpvY3SaGQ9-vA
X-Authority-Analysis: v=2.4 cv=Z/3h3XRA c=1 sm=1 tr=0 ts=69aa863a cx=c_pps
 a=3pdFJ6cSxbCDruMc3dgxYA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=5FMBHXBNJTPtjYDT93EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060072

Hi Ilpo,

I've been looking at your patch series "[PATCH v4 0/7] 8250 DW UART fixes
when under constant Rx pressure" and I noticed it hasn't been picked up
in linux-next yet.

Could you please let me know if there is a newer revision of this series
beyond v4, and whether it has been merged upstream?

Thank you!

Best regards,
Ionut Nechita

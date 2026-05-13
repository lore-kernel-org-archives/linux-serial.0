Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A53D3492
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655070; cv=fail; b=cNBSCNqQW1tMveqwSBuKnx0Db2/MGImgaNjRgf/f6QPyUlS+NdM8C7NxqvxhGvkXlu7GJUczfL3g4dZWMjypOc/nfyOwSWr0pk5ypDrjv9ZMgGfqC1yjgCMiMJFAyK7pHvmYyFOzah3lNUDoyz36LUgj2eRsy6sGHQ77nBME9Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655070; c=relaxed/simple;
	bh=ByTNa+CmlviKsb8f+TzWWr5kimqFh+mJBNIDE8vQM7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdV0bPsHdLmlB8h0yHHdeQX8ghYZpn7R4b2ltz/90lp//Uj2XIhiiaQrRyg/+TaQEcjQLqAwhdgAaQafv+AL44wt+FrdxxfHfTeW11WBLdY9r/LrOiY0DePmsndcQl8sNKVvBedYWeN1adgrBbNcgm6wLPA4tTfO4S1zSc+uXWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Af2nE1B0; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Af2nE1B0"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D42R0B217788;
	Tue, 12 May 2026 23:50:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=UGXOCZBKJYOrZ2li4TeyzHjTO8dXOA6AIwpAxF2TTPE=; b=
	Af2nE1B0EnTySnjautgCOUCtpwYwHpwvhNM39RHeOqZM/nLXCBUhjmzW3VQy4673
	QetMcPwd2tULZZqftCteWpUbGsQnrD3CHcKCx/7SoFOwMtZ3tYJVj5XM7BEfOS9l
	gatPCIlHTR2SyUiHHFUPl7AYLJV8J3s/QLghiVuJ7SaHz7RwaPJnd89MFJKC/14m
	uO+qbJkzVRFWWQxco7/qZbUjikT1jc1poSeG2DXPMzEB9K7H8pUh1TqLqSir+kCW
	8gxcmXPfGoKf8UyFx2VlDiZt+Q5tf4FTh+47MUt/qrA6743RrXqpxx8I5KsJxpCg
	EtlV3m7yo+H/Ionkr/+dFQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4g7g88xv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 23:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvmSzN7xbUfH9sXn6YZ3WwjNj3uoydyZjbCVyltvWhvutNivfSYLpfkd9t8feN+GzJ6JmkchEp52Onhc/Z5ahi9Wbgbu3YfufS/9Zk+i8ZEZ9xIPmzrgbhbEOy8VVf1wPnrL8FiDqEynNY3r/HjakVQl6o1kOOpWhk3ZgWb86FyjVSkYyxluzQEAPHOOYwcvmGCYXbjD1G7yorxAEpxg2PujUxBvDA+PIafbtqwsJJoiox2gwN/m6H4+HYrdggyF4Y4yosRpPCsK01zkQixB9r1mOYI/nl2DUDbqONf8WymQFx6xtJamBHQE5/WLHNZiWeIv7uNe93JZ39ORF9aLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGXOCZBKJYOrZ2li4TeyzHjTO8dXOA6AIwpAxF2TTPE=;
 b=iQQMXb5/BiKGx/xOW7JRUdFygy7M9vT/6nK5X3Y2oxVOUxUwbHxEgulBUoT4uYoe4AZRxfk0AuidspWWqTWIF7Vnc7Im1kKmdDzUpzJlo4ngL+SyZ75mx5/QSc+ito492P3dIKno5DoTTQvaa6sp3YsJdA/dP+wOAzbVlE82UH6hRWE7Xx/4jqkCJRvmKQ5lUreYw+SBPplKDJyTGEl82k5mTkHJSIBb17JNbH79Koulk6Tr1eSTuJ5d/ZKbQJFHRNcrDYNPixVN6QGrSygcHf7JGAhECxgZY1qIl8lxQ8wSRcj75zbExNWUcABwjjfx5bNLjFk51mPw+V6p9i79og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:50:54 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:50:53 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@kernel.org, andriy.shevchenko@linux.intel.com, wander@redhat.com,
        chris.friesen@windriver.com, linux-serial@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 04/10] serial: 8250: convert serial8250_do_shutdown() to scoped_guard()
Date: Wed, 13 May 2026 09:50:22 +0300
Message-ID: <20260513065028.112468-5-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513065028.112468-1-ionut.nechita@windriver.com>
References: <20260513065028.112468-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0105.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::34) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: d9af9ef0-ed48-4f03-8212-08deb0bbfa47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|10070799003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fHSTvNyxz1GtF7/xJY1fBH54tewymosY9z+UjfSo8LKLGsikma6EWB/fiv4beI9377hi6DVVzIR4ZeLAKiQRQRwiO018kpU22AlQf5I/1XviF6jfuRj9Sw3TwPUeuYwS1D3qd8jKEXrUwTixZ3xGMkjFdPTN+IO/n6jInQPwJpTp5/UYttX7qoutUUogvI0MmrspNPVzf8xc0xzrIGIAvii4C4k1kJDHTjBOksqPi/8w57ZGIAK2Fj0h+kb8l5WP8zTh8st4E9dqipOgn4/SxIwQG14nlDnwCPWh9fA3TNN/frKSpImukiO5NvLo55vm5rgDsrE4Knm10RHcu5pgmdzWODLOEv2CGa7RBJhijjrFdJUr//bcLJ3qW722kAsumh1B6lOyxF2G8cEGhk6dnWxooQ3oqtNdZHWWyy9hIh39WiLpG+EQ7S0HqoZK/OLH9jJxQXvQtDZXci80k7ZCwgLJxSmVWeBCfvuM3sEL7TG7q1+57f0xa3FdqUHSWDkOUF35GEnRJmZqmg4SwEhpvDP2Hz2+IpWLzlL1/iSICinZEgEtVWV8wmqsTzL3WZ3gkml4DdbJVAFgHn/zUi7cOMKeWEgfUp/RAO6HJuHmNab9nV2t9VoP05SbQ+YcMdOm2ouY2/sDm3YE+YGdSAb7/b1iXhU/EwkohoBzEYi+si40G6gKgqhUnhI3TPffH8EV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(10070799003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TyyAK99BE39g62fqUHjm2PDRqtaqsu++K/51ea+FrKowY4QXmcT3bqOQ6HFp?=
 =?us-ascii?Q?iNacVokgVDmGeRTc72tHdqQSaN3I0m40K2ig3IE34acJUqClOC/xXBZdROWu?=
 =?us-ascii?Q?s4bYEQv9Pe9A/6WQ2/aOguxzLDdka1XBY4vsH4yFQMC0QHt5CfdIv083zNrB?=
 =?us-ascii?Q?tAxN8lm+beKKUNlaPi74H8b84sxeqBWj8n5jm8LNu9C4nzVTN6fk/OsDbBKU?=
 =?us-ascii?Q?VHLTawIgcVe2+qm7t9RAIea8Lv7zZwbfw5h2zxIj2jnAW9nAdYiuwQAPmJpP?=
 =?us-ascii?Q?qZkCRG/XBCTS5zXBUkSHWJOuFU1WfSINrP3Z8Sxrlh5BD24w8h71tqRZddYg?=
 =?us-ascii?Q?30I2BZf6LnylnWtFf3jpnawmR1sc4lgFXyqDfTxb5U2KvN+AWEqI297i3UqL?=
 =?us-ascii?Q?hJNBN7sctnq9mS5xNNfDbQ0JIr1O8Df4/F/uUnDJutpibqS8VAn060lLs7ez?=
 =?us-ascii?Q?KZdK76gNMpcdT95Xsaxvcmjd3XdnJbgwkAcE7SEtEtUxo2kcWCcPFVpVQzz0?=
 =?us-ascii?Q?aG1ai7ctwOkhm2MPNKbUk7HYdblzgQhWegCCf/5e3SNmLPZGusKtKA2GFiny?=
 =?us-ascii?Q?dZebfqBe4psOlT2dUtOx+zxZ6vkN6O9G9R3X9mnRM4/zFmV6uldfUr0Bqh6k?=
 =?us-ascii?Q?H7vNjy+3q36UwcsvIZEl2px6D2Nl4h4LU9HW5026XgXZeaS/KZbXXZBXHNG0?=
 =?us-ascii?Q?5bMZet8T0Rt5xqfVXE5u7JlG5KFPB2vK6Pua8KCKsD56O1quLa6QKbUT+g2t?=
 =?us-ascii?Q?Nwg7Yi9Wi3jD4Q+2lxAbubH3XhLYFkKYupm1gMP/G736GTi8UTySAv/mYBt0?=
 =?us-ascii?Q?9vQ8SX1vYD19AW3EilWO+6sdgbyVIDJhj9gXpHTx3SkRC/QFx7lk4zu86+s/?=
 =?us-ascii?Q?X+DM4u7+wuRraDfGCRVA0O7lyKbqTTid+m3jRanWVCilFOAnHeOJfPSufDCF?=
 =?us-ascii?Q?UNI0bYu1HpMeFs9TgTZsOVKWbHilDVdAolI27h6woen/OJVSTYgSNfRjMlum?=
 =?us-ascii?Q?pv57ph+xhAD/mAzSSuqu/w9QoGcM9jIzK9CO9p/NMBNqqL6Es6DvXsYuUtU/?=
 =?us-ascii?Q?DchDjoFMaK8ISXcPyFCDLdhq9+sQR9W5oADZ/8TG8sz8nKg4pqa5mLcWQsdf?=
 =?us-ascii?Q?3GvdQmjw+8Hu+PGcRgixWRAY44sfC4wcnMk0IAJmxyKzRGyO6cDY6oT5jGAY?=
 =?us-ascii?Q?Bse1iUv3DmeI7Ej8conVe0D10LWGxWoHffio71M9jPZdZdMueyDE881mz/ry?=
 =?us-ascii?Q?iYacqMyv2eqn49ESk3l81aSGhmCrKd1VaRkkvdveZhdzLHi56g0lxqEAEej8?=
 =?us-ascii?Q?kO/4E/YP7iWNx8ncG8EGMdaR9ppE3Q1qVoAFqa1eBrXZPlsXn9J90EXflyzA?=
 =?us-ascii?Q?qkM6ob2E60fFWH0IL49Ydl8EW27033PG6bkN4h42DP1ey8S3frJ/rStS16Pu?=
 =?us-ascii?Q?3FkoJF/0W7mg6hjk0Wcz2FjfLAPt0lQBj5w2QwKyrafzeT/lQXw68ldwjokS?=
 =?us-ascii?Q?wo39WGY7AXypkTS1gNZABfmcT1PQ48WEUw3QED35wR1HoqOwclwCwVwXfbae?=
 =?us-ascii?Q?9so6gFbBi9GzDl3PfAOPMbKfqnlwAZnFSwiItjf6rFWwi9/8AdYkGgiX2m6O?=
 =?us-ascii?Q?ZIX3cPoUTCKE/Wz+0dyj0s0UIrRe1TZemgOWnoUtmKb1ivysJdNXDXX24pix?=
 =?us-ascii?Q?BIrUAjtKJZ35wkPXiVrvrdSnc8fC5Nx7i/0ZtISYWsPi5L174CDeU+fMq+6r?=
 =?us-ascii?Q?bIrWZ2Bs6xa/xVb2SOi1ouURr6v6rLXhGncBxlNmevfV4w8WnV2wywqwjh3T?=
X-MS-Exchange-AntiSpam-MessageData-1: LfqTVRbaNSqsHyJsW5vJMURP5PDjNkdIoqk=
X-Exchange-RoutingPolicyChecked:
	coqKUSRfuad4/ym5iYg8Gwu+Yvk4IiwC2DKCaK6zskp9Qg7zAACrS1/Rj1WsgFwqX6vbVRnpwHDZUA1SYl1PubwXMkr8x0fiNpXH02U1t6xi8TTNooXlllkX8ooDOnqUiLvU51RVJcsmcQSVwCkpeG6jr/iyRUeolE5eqHPpUGtTkjcXjmILXAYc8Eys1846dn5K/hzxWIelJE+DrksK3R/9Ng9jWIZ34eEAmWxwKnYBLWOx8AlQqIGtiv7aVqZxP8s8ZPF+sbBf3eAFiHxjKjyQIArNPFbv1Trv0qBFPqt9gzjAKFI3tVJMp/AFs17MQfSmTzzDmY5oM7nRCXCLlQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9af9ef0-ed48-4f03-8212-08deb0bbfa47
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:50:53.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLakC5hGqdXWi4XIRHsYTkBqbNhBwKoNQ+oJ+ZJeuFsPvk4W6EwGAOEvaGvTNJuz5D3aOW/nJJTo2s6b+TUPHCtZ0dAT/xq4OLn7tEiyOQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2OCBTYWx0ZWRfX4KShjYQxIHf4
 hPPVY7vXpbPPJ6Zhco3dpOJ2Oh+DL8YuwjEVza6GBiCEKEJW6EqaU83vV5w3zx283EflLiAzlug
 p67AdikGShPGQDQQNPtzzd5ZkCeY8XuygUER4HvMV5Q5BmT6U9PY/NsLckjYO8NR5wisHBy6jwt
 kesCW9cAu5iX6GtwcwiGOInwPl/5Idk5oembAwsD4c0ZVHh2LvBs0/2KXtnA3Qds+zv3Nrc4x3z
 0eSn+cUyYNCprfYTRfIFZi+ip8yVn7nIrpCZnV3PAZztiS4R7SiKCJHSZdU7iMwqOc8BLxAIvF+
 jJWjyH586H6KJa0/gvKKsml6jCJlQfGA/z2R16vQpaUEe06GagqOF9/PQmnj2/ULivge+5tVR+D
 0sll4Da4KpIIdEcZnxfpvrD3GuQTbs/bLknC23LPRr3NaG4qSpiLBGIdKjmrgsUor+Mito+ZHtM
 bOGmGgvH7V9RiPVMqtw==
X-Proofpoint-ORIG-GUID: d8FF45MBn81XhPyHAnX0wr1h0zQ3x7KO
X-Proofpoint-GUID: d8FF45MBn81XhPyHAnX0wr1h0zQ3x7KO
X-Authority-Analysis: v=2.4 cv=Q7jiJY2a c=1 sm=1 tr=0 ts=6a041f4f cx=c_pps
 a=vvCUPcqovLgrcFR9lHNvxw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=2fw_kZqAIg2IkU6GwuUA:9
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130068

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

This is a partial backport of upstream commit b339809edda1 ("serial:
8250: use guard()s"). Only the serial8250_do_shutdown() hunks of
drivers/tty/serial/8250/8250_port.c are taken; the rest of the
upstream commit is not needed for the BUSY deassert series.

This conversion is a textual prerequisite for applying
commit 59a33d83bbe6 ("serial: 8250: Protect LCR write in shutdown")
without conflicts, because that commit moves the LCR write into a
scoped_guard(uart_port_lock_irqsave) block that does not yet exist
in 6.12.y.

This depends on commit 0fd60b689b0d ("serial: introduce
uart_port_lock() guard()s") (also backported in this series) which
introduces DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave, ...).

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20250814072456.182853-10-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Ionut: partial backport - only the serial8250_do_shutdown() hunks
 from b339809edda1, per Ilpo's guidance to take "8250_port.c shutdown
 hunks" from that commit; the remaining hunks are not required for
 the BUSY deassert series.]
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_port.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b4c8388ea6fc..21fa7907c0d6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2461,7 +2461,6 @@ static int serial8250_startup(struct uart_port *port)
 void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned long flags;
 
 	serial8250_rpm_get(up);
 	/*
@@ -2469,26 +2468,26 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 *
 	 * Synchronize UART_IER access against the console.
 	 */
-	uart_port_lock_irqsave(port, &flags);
-	up->ier = 0;
-	serial_port_out(port, UART_IER, 0);
-	uart_port_unlock_irqrestore(port, flags);
+	scoped_guard(uart_port_lock_irqsave, port) {
+		up->ier = 0;
+		serial_port_out(port, UART_IER, 0);
+	}
 
 	synchronize_irq(port->irq);
 
 	if (up->dma)
 		serial8250_release_dma(up);
 
-	uart_port_lock_irqsave(port, &flags);
-	if (port->flags & UPF_FOURPORT) {
-		/* reset interrupts on the AST Fourport board */
-		inb((port->iobase & 0xfe0) | 0x1f);
-		port->mctrl |= TIOCM_OUT1;
-	} else
-		port->mctrl &= ~TIOCM_OUT2;
+	scoped_guard(uart_port_lock_irqsave, port) {
+		if (port->flags & UPF_FOURPORT) {
+			/* reset interrupts on the AST Fourport board */
+			inb((port->iobase & 0xfe0) | 0x1f);
+			port->mctrl |= TIOCM_OUT1;
+		} else
+			port->mctrl &= ~TIOCM_OUT2;
 
-	serial8250_set_mctrl(port, port->mctrl);
-	uart_port_unlock_irqrestore(port, flags);
+		serial8250_set_mctrl(port, port->mctrl);
+	}
 
 	/*
 	 * Disable break condition and FIFOs
-- 
2.54.0


Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC91BB6A0;
	Tue, 10 Dec 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845326; cv=fail; b=XtPOXhzQUcMlYtDC1B5W/wrpT2hcOlCFUmph+rQ7dC1QiNX2jTqj0p0jiIV6WVgFs0iGJ3yaUet6X8AOtMFbE7abIypnraLKIztYEKWKhtv2saZMTx4x7iQKTSpHY5ge2aL7gtvEcQnQyR/4gBpKPhnG5p7ff4Jk8Tl4BkOZ3m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845326; c=relaxed/simple;
	bh=+Wu8qkhIHZIeApsEL/2K/hqlV+YG3BcBGdaQKyuIoj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=APMqMMKyKnzK4cvBjWAumQHaXMXkiOc377++yGQHAJevgbhxGUkZ3MoKiwTzxmwcm4LybbAmbDlXxMQSyrIRUpI72N0VqEyuWMEVM3iTmDMfq+P7aFcFexg1PAbTVZLFVPLriJ5Uo+3LKQRruDHnwAE+AaIZtF0XiPnqfUZrJsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADLZUG001044;
	Tue, 10 Dec 2024 15:41:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3jxak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 15:41:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLJAqs9TULVmvSPCcQ4BmJ4IG55MyFeRfRwXVWxC/AEIWNrxjd0lXCNtPo6qcACNb83y5078L/28p5cK/HwLA47PyywY+MbgsckSgky85BUm02t7B8oNjP+XLYhmTJwbHEhlvN+48YFfto5+t1Myg31rL8hKoJIXhO6fp2rD+uWitJC7n6jn8Oj4CEEzy0K7Ma+O5wVas8BfvPydJzvAocXgJ/DNhsRd/wiIoEHgKRsReJACDTzOLS16z6W438DZr6TtkH0n5csLOGP2tVgbdtwpwHAXYV0cYHUj0uHXns19e4AOEUXgIsEw3wkZF35aTRBu89vCBAmcaiv3hd0oyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Wu8qkhIHZIeApsEL/2K/hqlV+YG3BcBGdaQKyuIoj4=;
 b=bIbomRo/H+IvAXmawtSLQEVxC2rOsYJBOueI96OgR05TL0Ra+o08T9eDy+TxlU1uNhABAr1bkNsjeeY7UPJgr2Wj/C76S9xpceR64tDwb2qkk35g64j4v/DxUDKvnnydOU2CWN2kIsjgz1wzjQZYwX5OiCBVd4tpVT0Hc1B7ibFqpoUrKPX3suNXG6N4gVQJYW8KGsuHzmaJIRcSHiS3MVchdOu8YprunKIH1OpnBSFslw6PjfWEi2BxjR4i5iFx2zUyAPYCalSA7sUtUXPQFgeYjBJpFl5eoRdu6AW0VF5ecshtNnqzZmXIJDvXJ/9bc1vmUhB5pcj6Mg//x6N09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 15:41:08 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%7]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 15:41:08 +0000
Message-ID: <6ecc80c1-8422-48d5-97f7-dcc0f8d49466@windriver.com>
Date: Wed, 11 Dec 2024 02:40:39 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: imx: Use uart_port_lock_irq() instead of
 uart_port_lock()
To: Fabio Estevam <festevam@gmail.com>
Cc: l.stach@pengutronix.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        esben@geanix.com, marex@denx.de, ilpo.jarvinen@linux.intel.com,
        linux@rasmusvillemoes.dk, stefan.eichenberger@toradex.com,
        l.sanfilippo@kunbus.com, cniedermaier@dh-electronics.com,
        rickaran@axis.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20241210034223.1493522-1-xiaolei.wang@windriver.com>
 <CAOMZO5AzNVd_xut2wBBHeyccFdC+1c4p50Uhzo=+BDbV=mEP2g@mail.gmail.com>
Content-Language: en-US
From: wang xiaolei <xiaolei.wang@windriver.com>
In-Reply-To: <CAOMZO5AzNVd_xut2wBBHeyccFdC+1c4p50Uhzo=+BDbV=mEP2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:a03:331::15) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH7PR11MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5382a3-5383-4dc1-a663-08dd193110c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUJLSFhzUjFuNzFGOEhSWHQ5RWhHSVdFQ2FkUWZJSFhXZC9MT2RrYkpydm1X?=
 =?utf-8?B?ei8ybVFyUzVFdUplbEp0YkdSZkZjcCtWbVpSUHZRV0ZFczlRZGtCazVkUjJv?=
 =?utf-8?B?TG9Uc0hNcnBPSnFWZHdBWnMxc1BTMXRBQWZWdGhMbFlabFlWRmxXYXpkcG9l?=
 =?utf-8?B?bGNPWFFWTHZMUEFxSEZvQm55am11VXpKcC9LdFVBRzUyazRNb3hONXlMVHVW?=
 =?utf-8?B?VHF3amJib1hjdEk5em9NOHNiNkk1dXhFd0lCRjQ1Q0tQSkNSUi90UmFVRmNa?=
 =?utf-8?B?aHBzQk1aUE1CNVMvYWxkM1dTdVVoTnV4em9Ed0RoV1RKVVJTbU00N0lWQmE1?=
 =?utf-8?B?blFyVi9IcnVtck0vdXlVK3pYSDIzeW80NHlDVTIyNGJ6dXpmOVRCL1krOTJT?=
 =?utf-8?B?eU03ZmpVYUpNRmRBZjRVQ3ljeUVza1BsNUV2UDVDM1J1VUxzL1Y2ZzB1K3ND?=
 =?utf-8?B?NEVFV0Jwd0FNbFVTamlqcVlyWXpiUS8wWW5ONmN1cnkzTWJ2NjNiL0VRVmk3?=
 =?utf-8?B?QXV4OXh5NTJaejkxbm04RTlUbFlORmc2SVQzWndQQWdCR3hrSGFzZjF3WkZL?=
 =?utf-8?B?NndPMk1lRi9lWUdwL3RvTUpVa3ZSM0hyeUF2SHdCNzdJdTcwTVNsV3N0cEJ6?=
 =?utf-8?B?dHA4Z3JmdTh5c3MxMWk2TTFGeXlpTFh5WGRCb3dRUnBCU0pOSkRjV252VHk0?=
 =?utf-8?B?K1NaN2xxU3cyRFpGS1dURSt5Rk8vTTBGSWl5UXJZK213bjZPVkVSMlRVTFlU?=
 =?utf-8?B?OWhrTGo2MzgrVTJ5SzNnTStydjlxY2svWlF4aG9IZndaV3JxR0paVTB0ckhG?=
 =?utf-8?B?bzNVcTBxOFVlNzk5QVZtcmFUMGxmTEdqUnlEN1V4VnhIWFVrYkwveDVzaHlj?=
 =?utf-8?B?N2NMWWhBQXRmWmxxRlcxSUlMUmhMa0h1UkZRV2xxblNYZFBRS29jS2ZBazNM?=
 =?utf-8?B?Z25YbThrRFZ2R3JjN2dDL3RQdEQzUWRsd0wrMlN3bFZsTktRemZnK2d2VGtx?=
 =?utf-8?B?S1FYOU96cHI1MDFPeFg4NlIwN3lBemkrMnpjTzRISGlHbVlYbTVLRlpPZ1dQ?=
 =?utf-8?B?dEwrNGpaVmJRaDhBVG5TNlNPeWtPNk5saVQxWGk4N1A5bzBXMndja2xmeW5x?=
 =?utf-8?B?dlZMU2VIQ1NHcnNHYk42RFQ3bXl6dGxPcHc3Zmg1ZmtlbDlOK3VNTTNkdlZO?=
 =?utf-8?B?TDhKdHlBSDRwSVdwNXNTTmx4TDBVNFY1dkRMdHphNFRqSTE4Yk5HZndBV1JS?=
 =?utf-8?B?YkxKUW83Nmlna2J2MzFRRmtBRjJoZFdSSFJFZTF1OVVqcGI4UXNTUENORW1w?=
 =?utf-8?B?WUd6MnZzQUdyWmx6N2xDNkIyeHo5Tm1zY3phYmk0UXJwSTh5eS9sV0gwNzhQ?=
 =?utf-8?B?QkFPTVUycDVJV0FVOVJpOGNJNnI4dG4rVm84TGpLa2hoYnlHcEhLWXd4RHRy?=
 =?utf-8?B?dTFGYjE5ajREUEhkZENsSmdzYXZFdFdKYzZrMzcxTVZsQU5OL2dpRXpGS2dV?=
 =?utf-8?B?SjhyM01Od1FsYnQ0TEJQZ21LQjBvQ0JpTnBCNS9jSGF3V0F4VFdLcWhCV2dy?=
 =?utf-8?B?R0M5cDFlZFpTTnpyemJMcnFjd3Z0VEdxWEVFTEtPbkV5bEt3V0RYOWowaUhr?=
 =?utf-8?B?cmN6TFlwNjU3dVNsZG01ZGNkNHZqS29EbGR1V3ZiY1hIeSs3NnhHaURsY0hh?=
 =?utf-8?B?SldHOU0rNDN2eE1pK2JYQzdvSzNYTHh0cVczR1ZWZTZ4V21SakZZNGZwb3JY?=
 =?utf-8?B?bENVdm5LamtDZ3RMNGJVVjFZekE1UGhMeVJHSmFHeVB3SVVHeEIrTmFlWmZt?=
 =?utf-8?B?TzBMNk9aWjhUbXdiMXNFdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUk0RTVJNlRTSU02UE03Z05wU2IwVmp0c3p1eitVdDNQR2d6ZHNIbndHQ1Ni?=
 =?utf-8?B?YWMyQkthQW90NmYxVHdrZWZJaDg2MitLTXQ4Sm41YXBxclRYcEtWWGN1djND?=
 =?utf-8?B?VjB4b1g0RG01NnhucDQ1YWl0dlVOOXlPWEZ6YlZFT0RUMURPRFpVWU1sT0lJ?=
 =?utf-8?B?QTd5R0h4OTUzK013U2UzYlJRQTdLL3V2d3QzWVcwZUpvem5sNjI2a2tsTUg0?=
 =?utf-8?B?d3EyYW9hZGRFYStLR3V5QStWV1pVa0YzemoxNjcyTHZoc2k4NXVKcDJGSk5C?=
 =?utf-8?B?RzZVeEtxZFRZeU9FMHpSWVE2cDNQelFQQ29uc1N1TUE2eGNSWWpsRjhjeXNQ?=
 =?utf-8?B?SDdTRWZZUWJwYmlSVmlXSFhBRjM0VGVzZ2FrR0JNd016YitHWVhPNFpwYzE5?=
 =?utf-8?B?QW14ZVdRUWdIUDdyVlRsR3NOUDhLR05zVkdvL2JMVTJNS3F5M2ROY1E2dWtD?=
 =?utf-8?B?RjhoaTRPR0ZnRHJ4cFNqR0s2YzNOMmRPVlhmS0VFaW5VNTdSeStlaDErYkZV?=
 =?utf-8?B?cG91YW80M0ZTSllubGxxNzFmZGtJS2dVUHUycDdxczRUU3ZzYW5tdTdBdEs0?=
 =?utf-8?B?Mmw0eElJdlF1TEhFTWlpZTlPRXpUeEpscSt6WjFoZlc2TVVXaEVUTDhZcVdV?=
 =?utf-8?B?S0MyczVXUXF5TC9FK0llSG9zQlpMM1FLUTVaZnBoSGxXQTV0QXFSME9OSVJF?=
 =?utf-8?B?TXRLL0xwQ05BSEJNN2lJZUtEYk5TRUNzNHJGbXJKcW1rZGdWWFJKODVnU3FQ?=
 =?utf-8?B?RTNHRWpaTE9IeWQwNGtnQmRrdHNFczZ2emgrbUFBODFFdk5wYzVoSkFEOFRF?=
 =?utf-8?B?L3MwNVF3ZXZUbTRXbzhUV1NrUVh0aG5jbXZhSWs3eUVWcXVCRys3dytCK0gv?=
 =?utf-8?B?NW9hYi9QVGpxRWsxQ0NFQmVicUZISFY3bEUzbklJaldDcGc3YmN0c2YvOGZa?=
 =?utf-8?B?NytLZWdORFNpTjJqNzJaN3ZSbkVJUzQ0RUZvU09nWnBBUnF3V29EcGhzUHJ1?=
 =?utf-8?B?Yys5Z00vVjVvRlU0NWVZbGpHZFhnQVBodVo1aENQbFN3TFIvRVVqOHhNM0lx?=
 =?utf-8?B?RHhRZzk5OVBvZEFMQ2wyTDlmc3ErMUhZN1I5WlkrUVI0SlZrbXNVUlYrZXdW?=
 =?utf-8?B?WjZGVit1SzFQNXZyTnUzVkpwYWczdHlnZ3FxWVRad0ZwYUx3cUZPR0JHSlR4?=
 =?utf-8?B?OSsvdWsyYXVGRVFtaEZJOWxqczQzZGZxZFkzUTdVaTdGaXAybGx0eE14aCt3?=
 =?utf-8?B?cm5qeWJHZmw0S1VubldGR0kxRm5XdEtQdjEvSVdvZUlWZnpiSDR1LzhkMTE3?=
 =?utf-8?B?N0pzdjNzZmFLOHFrazIxOWNVUTFibVR5WU9pazZCQ21aZTdOZDl5dDRuUG10?=
 =?utf-8?B?K2lHVE1saW1xUFprT283WnRwNzZXdksxM0ZOUTN3UWlBam9CWUFzM2MrOUZr?=
 =?utf-8?B?aU1qUGt5UWIzYlI5WWp5b2hOaWhMeEtPR1JyZEtlVUNQa3paSkxFMFNaYm9J?=
 =?utf-8?B?OTVYbGxNY3pMMm05M2xvRTdHNG1oL3h1V29kTHg0dWt0T0ttUFRCQmpWTlNh?=
 =?utf-8?B?N2VrUVN4cmY1TGttSWFWZmgyUjN3aTRqNVJVR3d3d1RJc3R0VDlGNjF5Nm1J?=
 =?utf-8?B?REhKbUxKaWw3Mmt2c29iaTNUemJFVlh3R3hoTVdPZ21kRk9aTmtZSGZJcHFJ?=
 =?utf-8?B?a3hOTzE3REdiWXp4c2dHbTZ1Q3lNeUlkUVhLaUVsZ1J0bmNLWDViOGRjZm5P?=
 =?utf-8?B?RXpVd3ZnTlZEcDZkSzQ0cWZhd2FtVzQwM1l6R1pGMi9XZ0NGTTFkUVBBdzBm?=
 =?utf-8?B?OUc0Yyt4a2VRdzhBM2FxcFk3djU4WHVReVJ3ck5RUVpPTldZc2tkbUlyRmJn?=
 =?utf-8?B?MCsyeHhvUnFTRlhsUzlZOUp4TFRvbG1xeC81UzBkZnJmRjdNWjV2NkFVR1Fa?=
 =?utf-8?B?M2NLM3I3VGhZY0ZlUDEwc3RhUkQ3Rk9Fa2RuRlpaRUFYREYwKzFZRVc3Q0VW?=
 =?utf-8?B?ZWZQeDRGd0JQMUhWSis5WHRUU21NQkhFZzVSaVZLdERMMWhnMkg0cVNCRk9r?=
 =?utf-8?B?Nkxha0U4SlJzM0U4RmtrOEs5VUhJcEZKU2h6MnpBZ2djaUgydCtuRUNiVWJu?=
 =?utf-8?B?Ny9ZbmJxKzJHV2NCcExBTXc3NlV4TGhEVENwUUNsOXpXWXI5djlIMkJ4dFFo?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5382a3-5383-4dc1-a663-08dd193110c1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 15:41:08.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0+WCIJoHEPP6fmkxdngW79ewjikws65Sp+wo+glopIEvjelReyjjxHM8L5niyFDeCM1qkIbEVgJCc0/WBNp1YNkaUZyIl4JrIH8+qcbdQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-Proofpoint-GUID: h9BmoUWnBf6MjksN-cG5Ed8xUwNO-I2g
X-Proofpoint-ORIG-GUID: h9BmoUWnBf6MjksN-cG5Ed8xUwNO-I2g
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=67586117 cx=c_pps a=v3ez6FdVe4RSF1xj2bRqRw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8 a=7RDSfPUXJbuPzFRTQlUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_08,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412100116


On 12/10/24 9:37 PM, Fabio Estevam wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, Dec 10, 2024 at 12:43 AM Xiaolei Wang
> <xiaolei.wang@windriver.com> wrote:
>> When executing 'ehco mem > /sys/power/state', the following
> ehco --> echo

Thanks, I will update the commit log in the next version


thanks

xiaolei

>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

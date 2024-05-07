Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811254BED;
	Tue,  7 May 2024 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114621; cv=fail; b=g9atP4d/HbenHX9k8MfTbL3Zt196aAOHVKSgYoNl61QBgnUUnQpAyNbYq6iD1Ob9WKAss/MEV6juooxvs6yMGdONuQpV5s0ySfS1yn69j2sALu4lwIhep6OJAArL9NcZm0sOzlrMpU8pRRclAWQCOJxiR8Z9GNK/LSf/+JZX1uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114621; c=relaxed/simple;
	bh=hc0vWKzWBYmTQPNA0uhujkmwegxnId+yCijUqEvVwaI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ixjPZg9oD9ULewCPe4yNvEjFHOe4GSCrRBWLZc8LDjyyMvhKjFYBnGS0lVrWy7Yzq4Yjc8lzEVzG8jK9vRDrNP1xEi+maaFJkUjb4lM2e/QuVHADsJZLc7AzwubPf6S395g4yGhjS8pB71/2fBvGNHGoGJ1NK8jyG3YR5a9AKak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nkYxF85O; arc=fail smtp.client-ip=40.107.247.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nkYxF85O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RniAJHX9QAXk12uEk70UXS3AquGgMbjS2OjpfAuUCeLfGknyb3psHUx3hu6ZAQf8Zeh/iIgiwS4EMjzjQkHeOdSRQxHNfCQkaig+/vsSbgdr2n2wJ/dUcSojLpHLzJHVp5Q7dwQf0UMZ4WI5F18hUHEVv7DK6Qbk+T0EWovneenpS2ZDwD97d4/WG7z3qgZjZClKqgDq/fzqin16kyagyk+kUb4UHFGBDZIYMbyttCgpFkfWdclLrjUh5q6WiKOP873tWXlMXPTR+pzqjRIcT63ekgFCBOAaqf4XU4oWxcZh2RG4/h8qsOoNI/vQn8nmwvplzfRfZzcQ4sfXfwx47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV44oIZVXxGjMUN038mXUA0fEvu2yZSoG67eTDt2HkM=;
 b=H5oyecKKb04h6ohmk/vTXpGgiYSfdu7laDUQ6nXNdSCkdv3vWx8cxAR8J48jE07it2K8zEnSGfgnzotGQ5fG2ylwJKMnLBCceRBSoqu36nsfSRhTaGCj/Vk8ll+N0NKApULZCtBxbNqrcZPtUqpmpt1MeCCCEvuWHc548oJ8P86lrxbpmLfwV9qSG47S/zFX0v/JXi5wwzUA8r03Sx2IM/NRcX0ZRDDSeMQwbKDcABbd0iRceErQZGQTJyXOcOBkUF0FwyhVxsMtCQgH+sIhf4cGXf1VnSNFRiZG68xKIo3KmKgwnIwmHkbcJZFY5V7G5LVmNnRP3tTab1wDOvvYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV44oIZVXxGjMUN038mXUA0fEvu2yZSoG67eTDt2HkM=;
 b=nkYxF85O2rB0OraZTKk1jzDTZJtMNkxG2MJ6kTsNbBOf+kjZcSKPYX4iyeQWM3J/zpOygsiVyZrg28yDYkF/Xr9bW7eJk2SxCvbxhbZKn/+Leizf2W+3ka/RBuPU0FiMgob0R+qFrOTQ3WUfg1TzrE6/JwO6Q44JXC43LqsiOt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 7 May
 2024 20:43:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 20:43:35 +0000
From: Frank Li <Frank.Li@nxp.com>
To: alexandre.belloni@bootlin.com
Cc: conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH resend v9 0/8] I3C target mode support
Date: Tue,  7 May 2024 16:43:03 -0400
Message-Id: <20240507204311.2898714-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a393d1-542d-4311-1d9a-08dc6ed65d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3g5dWluUm9hN1pCYTZWT3VCd0RxZmZueXc5UXdNNHZYOUVyOVZPbWt3ZkJP?=
 =?utf-8?B?VWJwcGR5RWlOR2dYaUFYVWtJVTRpMEFYNkxyYnhtRjlqNWRSWkxOTElQNzRB?=
 =?utf-8?B?MHk2THJoVGdjd3VVV0NTdFd2TW5ESDJ0RTVIcmF2NzJtem5ua0s4Z0hEaHcv?=
 =?utf-8?B?RjVxRkZ6d1ZROW5VRFJuUVlGZ3lVSmF1WFQxMXMvcG1tM1FEUkpEYmRwaWFa?=
 =?utf-8?B?YkNvQ0xFUHdJQnEwUi9zUHJjMDlxdW5TQXZFd3lvZWlMZXNZalJlZU9FVEpY?=
 =?utf-8?B?MjRWVFB6a2F1T1h4UjVMWVNvdTl4MFdnZm5SaWZLZFJzcXg5WGlQWEJCYWdU?=
 =?utf-8?B?cEg1Uld0RzE3NldtYmV6c1F4RW11b1lqTjExTENGYmVlUVJwWHlRUjdjZmI5?=
 =?utf-8?B?Qm5LN2g5TGZQaUdHQlJ2S210T01tcTR3KzRxanF1TGFsSk56dlR4dEpZWDIw?=
 =?utf-8?B?ZXVVcHFwZ0FzTXBuVisrMjg3bWNCWWlZbTVaRnhvUUJxMmpWd2JmeS90UHhB?=
 =?utf-8?B?VXk4UGoxM2hONnQrcTRRWkxqMTZ0MmlaVkNuR3NNaDlHbXpOb1RtVlBvUzdX?=
 =?utf-8?B?eTRwejhwQnZFNDJ6WlM3eGtIRGMxcnhUMWk0VkZUY3FIVTJFeHNhMU1UR0ZO?=
 =?utf-8?B?ajRXVHd5SWVxWGRJRDdOWmcySlJLTzlNL0kxWXR6N1RadWNYalU2SmM1dU1M?=
 =?utf-8?B?Q3dEdG9pWk0rREF6T1lSZ2ZyN1Mzb2w1Zjg4OWx1NGQrTUI2anVZKzk5RFkx?=
 =?utf-8?B?aUkwQ3RRYVZoT2VMZVppVnNPN0VoblByNWtiSlVkME5KTjI1dm1OdDZOS1U0?=
 =?utf-8?B?cDNPL3l4dXpSS1AyT2wrd2JtbGhSa1hWOXNKVE9wenh5N2NWbVdXZC9ncldU?=
 =?utf-8?B?NlVTdGFBU3NFY21WZUFlb09vR2FVWEJEbm1BUTFGcjIrV3NVcEU5WXRvMFBD?=
 =?utf-8?B?UDMrS2c5UzRQU1B0UzVvcjFuQ3JXUHpSRmNpL3h2UDJNMDdIc0VrRGZkRnY1?=
 =?utf-8?B?TjVuQWZ2d2pWbERlN3B3bTZmbjR6WndVN01LRVJGWXB4VVVwNkcxTVhiTDd6?=
 =?utf-8?B?bDhpbWk4V3g3cm12eGw0QSsxQVUra0ZEVWVMR29uZDZDS0F2ZjhOVlFoSW0w?=
 =?utf-8?B?dFQ2SVhBaDJJTldrMnZINFBsKzJTck1lWDVObThsQ0tSRjFiL3VuZnZLK0l1?=
 =?utf-8?B?M3J1UW83Ny90MHBTbDJqZkJYQzdmUXdSNnpoWTYrS0pMM1BERlN3akgvbzVr?=
 =?utf-8?B?ZXdTNUQyWGFBNGp5WlJ1b2RGeGM1anFQZGFMT3ZJcG85Z01FWERHd1EyN0t6?=
 =?utf-8?B?UWxDMFdRR3hQVHg4RVVGdFFMMVZDcUg1TGNFdC9OSm1Ld2pZUGRVNExzb3BQ?=
 =?utf-8?B?bmNBVTRrdEo3Q2NuT2N1NURZeVJudzBjYTVqSjFNWVYvWUpsc2Vpd2o3Z3I1?=
 =?utf-8?B?TlExT00vYTlLaWNlQ1Q3OEptTC84SlZCbUJzSER1VVNidUcycEZJT3NCZGFB?=
 =?utf-8?B?M2dmcjJvR0x2dlg3Rjl3dEFQMjFrRHpmTUFqZGdIdUg1YnB0Z09SVDFvcFZh?=
 =?utf-8?B?c0pWS0psMHdzN0NqZnF2eUxsV3d4N0k2bGd3dXJNWXhqSS9CM2lMNUhHYkdH?=
 =?utf-8?B?cWxFSHJpVktEczBlanY4WDFrQzUrTDV5eHl3NWZMMEFtakhyWHovZGRxUXV5?=
 =?utf-8?B?ZzltTDZ4S1RjbFZFTkhabzR6U1V6cVhLRXN0NHMvRDRIK1NGVVAyVnJGaFd5?=
 =?utf-8?Q?t0g1FZg2atvxJr6qm2QPtcB1lxnbP7J4HuPXxnq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0NJaFpWTFlkL282aXZ0MXpHa2RuWjNsVlpZUzRQRkJPbXhtWFd2UHlxclVZ?=
 =?utf-8?B?M2V3TE9pMFA0NnphK2ZSUTBobTJwTmJaZkxVRWk1YUx3eXZZYTNQSUhTZ1RQ?=
 =?utf-8?B?Tm9zNVZzc1didG5MVmJaOFRobHRReURNN2tKKzlmekQxRE5NeGV2eWhIVEN2?=
 =?utf-8?B?NXJkQmJXaEVyOE16TTV2UGVKdlVXNG42ZVpFaFdzbGpINjZEOXprUFpWRkRZ?=
 =?utf-8?B?UzcvZG4zVzZZRENObHRjMVMwakRmazZGbk16Mkp3WmJrWnVnRDZyYXJNQ1pv?=
 =?utf-8?B?MU9xZ2p1MUNIWDdheWFsVjllTGJTTHUrRWpNRjhTem01RjBLUStHYjVsNlE4?=
 =?utf-8?B?NjdLbHVqWlJnOUNIb0grbi85dkV5cjNsamRBTzZia1p0cVBLcnFhU3Z0V25p?=
 =?utf-8?B?KzVsTEhRSTlFMFV0bFpTcTBVNjlHYWQrVXlIc0FkZlk5YnUrWmk0TCt6N0tr?=
 =?utf-8?B?QU11bWlYMlI1ZzVQaTFsU3F4UFMwdXA0aUlYNFF5S2NnUmVSangrMzhYWDhI?=
 =?utf-8?B?K2d2UXNiaG82b016UmFOaFlqWkZlOEwxbkRKdGdyQkVkZzN6VVh1NFBuR09Z?=
 =?utf-8?B?ZnZvTXJVSkJCYjdSWWsxR0FXYUZkWDBIWXoxSnJ4RTlPL3ZOWFhLT08rOWx5?=
 =?utf-8?B?Q2RBN2M5TzMwMExRbS9uRGlJWExtL2R3OHVQL08xNlhSU1NJWmZyOHBaMzRP?=
 =?utf-8?B?ZVNiSXF0M0JZUnFqNzdKU05kdXI4UFUrbFVyMW05QS9kdlNNUk9RdG5kcmV0?=
 =?utf-8?B?d0MvSENVOEFNRVhsam5QOFlzbEhJUVQ4Z1BLUE9YL1FHbjBhSUZRL2tXMWZh?=
 =?utf-8?B?MlNxRmRFMTI0bFFNM1VLc0RGVGdqR2o4S2ZwQUFJU0IwYm1mQ1JDV1NIcDJa?=
 =?utf-8?B?NXdsWG5xaGlyVmNuM1hybE0xbHNKR2VhTXE2eXlsMzNZcEJka1RMcE1yS1lD?=
 =?utf-8?B?QmcrTk9wK0V6eUxKWUZDbzJVMjgvbmV1YzlvbmtKMEg4ZUNFWmdpb2hSclpY?=
 =?utf-8?B?Y2FOdXJIMkQ5UEc1T2pLUXVOdEY4dE9iSTRjeTRCc1ZZbzVxWXVoTDZzcHEr?=
 =?utf-8?B?ai9aVDZ1QWgzd0lLYTN1QncvOS9yTmlpSEUzQTZobkNzdWxBMVpOWnEvZzBm?=
 =?utf-8?B?WDRSY2pRU0FqNlJtYzlvMVkycDJTY0pLN0wzRmVTdHBOYktMMGMvQWg1YlRj?=
 =?utf-8?B?RHR3UnQ5anU0WUtDVkp1MldadFdSQUtnM0JXNkhTaEpNNCtEdVVQSHpaNnRN?=
 =?utf-8?B?WnB1ZnlXTmpzQXN4V3FiYkVDYlhzMThiR3hrUElGTEtyakJ1N1M5S1NTOG5u?=
 =?utf-8?B?dDRlb2k5aURCYWlxbmlYUi9QbURqWGF6V3ZObGYzTE1YemVueHVUNzFacVRR?=
 =?utf-8?B?M09MYVhrVWtzT1VOeVp3K3RCWEZ3S2gyMnVTaHcwUVFaUkRNQXlTTXlqTmZX?=
 =?utf-8?B?a1EyZXVtS0VjOWtXRDZvNEJCbFVmSWUwd3UwWERGUzNWTUFDMEtZRG4rT0t4?=
 =?utf-8?B?VVFDRG5nQ1BGMWxoSXh5TVFkTFY0UGNGMzdkckVWanU4NEJ3MVpCS0Z4eExT?=
 =?utf-8?B?T3d5NWRZZzNkWXJIVTA5aVd0YTZPdkhhSTFscDJGdzg2SnZ5dFNzSk5HOTZj?=
 =?utf-8?B?MnNhZWRCWTI1UWc5cnFKK25EV0V3THVuU0k0MjlQVE9kNUdrbWo0czNzbHFI?=
 =?utf-8?B?M2dBWkJmUit2TDJMOXU2Q2ZyWHhlUlhKcGY4M083RmRXZUN0NnlUZjhuZnJm?=
 =?utf-8?B?SUZhNXdTRm5LbUs3Z3NVTENvZFZNbDlYTkd3UXpYS0xCNFNWYndCS2pOaWxy?=
 =?utf-8?B?WTliZlN4ODhnQjUwQWJnRmx0aitSd0JCZjhTNHZncUY2bGlBNkFIcDFFd1FB?=
 =?utf-8?B?RUsreVNTUy9EOXZ1TnNDSjg2Y1NzSlpRVjlyNnhMcXRZbXZ0NTNxUjVjWHlt?=
 =?utf-8?B?TG1WUDUrMWRmbUorUzN6aGFyMXk0RnlKcE1iMEU0VXhSMVZ4ODVEbDA2Q3h1?=
 =?utf-8?B?amJmMFFUVkx5T3V5aTZBKzQwR0QwV3BxVGtYSUx5dTljWVBXYk1pekU3YktV?=
 =?utf-8?B?ekVoaFdwZnNPekVmdzZicExqdlBSRjg3dUFnSHZDMU5lWXp5cW9ETlVhVktQ?=
 =?utf-8?Q?l/6y2I1VaOh09wzPPqXg7bDn5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a393d1-542d-4311-1d9a-08dc6ed65d71
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:43:35.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuHXPWexR8UqZravOKmLLAo/sY0KL0qCrWer6rA6n6hbPhc4lFGXqZ/mob08QlbV55HYUNu8YHi4P+XzoiZrpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576

This  patch introduces support for I3C target mode, which is referenced
with a PCIe Endpoint system. It also establishes a configuration framework
(configfs) for the I3C target controller driver and the I3C target function
driver

Typic usage as

The user can configure the i3c-target-tty device using configfs entry. In
order to change the vendorid, the following commands can be used

        # echo 0x011b > functions/tty/func1/vendor_id
        # echo 0x1000 > functions/tty/func1/part_id
        # echo 0x6 > functions/tty/t/bcr

Binding i3c-target-tty Device to target Controller
------------------------------------------------

In order for the target function device to be useful, it has to be bound to
a I3C target controller driver. Use the configfs to bind the function
device to one of the controller driver present in the system::

        # ln -s functions/pci_epf_test/func1 controllers/44330000.i3c-target/

Host side:
        cat /dev/ttyI3C0
Taret side:
        echo abc >/dev/ttyI3C0

Notes about header files.

About Ilpo Järvinen's header file comments, it can pass build, some header
should be included by other header files.

I added some, but I am not sure that is all needs. There may have tools,
which can help check, but I don't know.

Chagne from v2 to v3
- using 'mode' distingiush master and target.
- move svc-i3c-target.c to under master,
- built together with svc-i3c-master.c

Change from v1 to v2
- change "slave" to "target"
- include master side tty patch
- fixed dtbcheck problem
- fixed kerne-doc check warning

Some review comment may be lost since it is quite long time since v1. Now
master side dependent patches already in linux-next. So sent target side
patches with tty support again.

No sure why an additional "\r\n" appended.

Frank Li (8):
  i3c: add target mode support
  dt-bindings: i3c: svc: add proptery mode
  Documentation: i3c: Add I3C target mode controller and function
  i3c: svc: Add svc-i3c-main.c and svc-i3c.h
  i3c: target: add svc target controller support
  i3c: target: func: add tty driver
  i3c: add API i3c_dev_gettstatus_format1() to get target device status
  tty: i3c: add TTY over I3C master support

 .../bindings/i3c/silvaco,i3c-master.yaml      |  11 +-
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../driver-api/i3c/target/i3c-target-cfs.rst  | 109 +++
 .../driver-api/i3c/target/i3c-target.rst      | 189 +++++
 .../driver-api/i3c/target/i3c-tty-howto.rst   | 109 +++
 Documentation/driver-api/i3c/target/index.rst |  13 +
 drivers/i3c/Kconfig                           |  31 +-
 drivers/i3c/Makefile                          |   3 +
 drivers/i3c/device.c                          |  24 +
 drivers/i3c/func/Kconfig                      |   9 +
 drivers/i3c/func/Makefile                     |   3 +
 drivers/i3c/func/tty.c                        | 481 +++++++++++
 drivers/i3c/i3c-cfs.c                         | 389 +++++++++
 drivers/i3c/internals.h                       |   1 +
 drivers/i3c/master.c                          |  26 +
 drivers/i3c/master/Makefile                   |   3 +-
 drivers/i3c/master/svc-i3c-main.c             |  80 ++
 drivers/i3c/master/svc-i3c-master.c           |  34 +-
 drivers/i3c/master/svc-i3c-target.c           | 776 ++++++++++++++++++
 drivers/i3c/master/svc-i3c.h                  |  15 +
 drivers/i3c/target.c                          | 453 ++++++++++
 drivers/tty/Kconfig                           |  13 +
 drivers/tty/Makefile                          |   1 +
 drivers/tty/i3c_tty.c                         | 432 ++++++++++
 include/linux/i3c/device.h                    |   1 +
 include/linux/i3c/target.h                    | 548 +++++++++++++
 26 files changed, 3724 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target-cfs.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-tty-howto.rst
 create mode 100644 Documentation/driver-api/i3c/target/index.rst
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c
 create mode 100644 drivers/i3c/i3c-cfs.c
 create mode 100644 drivers/i3c/master/svc-i3c-main.c
 create mode 100644 drivers/i3c/master/svc-i3c-target.c
 create mode 100644 drivers/i3c/master/svc-i3c.h
 create mode 100644 drivers/i3c/target.c
 create mode 100644 drivers/tty/i3c_tty.c
 create mode 100644 include/linux/i3c/target.h

-- 
2.34.1


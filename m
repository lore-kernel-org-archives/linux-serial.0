Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492B3D47CD
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655068; cv=fail; b=jjtNQm4Uwmkzho3ZzazM9I+G2ZnuIfX+9uTUmorItY1nDBw2NkqvqKQBXkE5bDIKHSY9y7ToC94xiJKpxwYPxoTFuLIIkJep/p0GuX63XXxgU4NlSwZAbtGs3dsohYcWRyqOolHNSXyDxRmaSXea2YJRoQkQJWz6yt8VopBbcwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655068; c=relaxed/simple;
	bh=pSZhiLxASfyqekZIn+ZgjWNyrombC4jHML3xs1hp5DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tSCDOzEJh3UulUGos1S5PgimhfV7Sdpsq76VreEHLRW1m8tUgrrq2eb5Sj4KeQlV1Bs7vOQ9XGfoMKFx4EhDmf0Vd5fl4ihxuOYmftvDyruYotDGCWBi0YvCMQvseePYHe45jEfOcKQgw4ovIksHtYmomPmNAcQ0Q/6Q8mNkfz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=SYCBEudL; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="SYCBEudL"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D3t2is243653;
	Tue, 12 May 2026 23:50:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=900lHdao5s7ZO+CeC0A0b2H9y3HnUsX+b9iUO/JKXTg=; b=
	SYCBEudLwJWqAlSnu7SPjG4CXUqTlIU1lX3apWWrycqSmCqBQQTIyY9BD2/cgjnN
	pvWhuV0dRmNHBTDWMSG9pwSaEmgIPpuafa4SVHnuaArGinBv4XGzkQZUPqmz3vzk
	PZFC4YeMgDS6jXRVtacDtydN7aQ9LzSE8aMFl15KYzvh6U1tDcpfsIfJmfNAAfCx
	OWhWNprUaRbqTMBtMpQ05KpmJEiZ6KSHWQalq1ts5/EcMkdQ+SGJFyk5c0FB6Djf
	t/AbW+4iYLELntBWK4mAbvF7Hz+OxgTthX9LWtlpJob6Uon0pwN5CjJqzJd2VkuP
	lhQrzaoq0rAUW60IhZhdug==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ftb8a1m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 23:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZeIZ+H6RHTFKvXugyMmdl+R9j1SUjyS7xU3fJQP69BbYxpYv5Q64ZYJbjA1vjYE6Rx2V+QZ7uk1+a+Bzh50xvMhePYBMc8+izyMaPGBrAf8iqjjf7KOFbpboVkchElikZybsTRibR2wByxuZfk6rYcAHnjb1ndqDZlTIn90AdHxZ9vF45TKFi1N8B3Hl2aEaUxfmFQEaZXyLstSGGD3B3hbSBYRtN8AuTFE5PIh10F7wmmPhRhuiawzHXzMb5IryT8TtvfFhHSnoudvbx0mKD+3Pa6JhwQNQ2S/SmYIt5HyB3DrFOGeY4WToovTYXphHchuOPffD7EvqbbzPtQaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=900lHdao5s7ZO+CeC0A0b2H9y3HnUsX+b9iUO/JKXTg=;
 b=jNLvmGxX2/QWZvAgzikI6n/IepYq4WUYaXUwjQ5s0QFJWwP1zYUJAcoRsvtKAfW6JREGGD2JLNx39gwH9qo8Rfpe0349oEYRIdmtLfsX8YJ4a7Bboc8WrboSZHRHJ4wH2ggY9MSXUgVPwz5YM0K5FFg1Yz9zPfpuondeCWwkr6lb+M/SuhS4PNsDkuWId1FEP+GwW9aa7y6TIW2lX2XH+RLWjq0O07pus2EfxV6+L5JO6hjOlIozapGj0mLmafOjMBLM5F4L2GnTRc7sOU2/61rr//4aZCVXkTuOc7xiQ4tDw1BTYhqpDSFpteiZK6ElRScPcFog/Phrl6GPJea0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:50:48 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:50:48 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@kernel.org, andriy.shevchenko@linux.intel.com, wander@redhat.com,
        chris.friesen@windriver.com, linux-serial@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 02/10] serial: 8250_dw: Comment possible corner cases in serial_out() implementation
Date: Wed, 13 May 2026 09:50:20 +0300
Message-ID: <20260513065028.112468-3-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41d37ef6-f050-4671-315d-08deb0bbf725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|10070799003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iUdwHy/MVDmqY3oQaMcnjOsq/OforT8MEbaj7ylP6/H/OQLOGoa0AX994VQPyI7HctxZKpUNfG7poijFbdnKWa+bIpJlkdJasANdGZyxVkOSuaC2souJbPaZ/6n1Q+Q6E84QkDGNRSz9L2TnVOrBBB3ad86l/84uRhl3hsh+W1UE+xQTJzASYKZ896KUZmKBAkCTic6OQCGt6vm0wDlU7W6hdSYiRd1PukOqK+zobe6wP4TVLlq8h4qgZhW6VtgqYSdx+g6bimX+5PGMQF5wdwTj9trqQ64RpunYEGEpAcrlEBEyc3ptXNJEy42LTH55vYsW5OzEgORVeN0K9mgUkRwrwotaQH/+S7IhoqvpNP9wdOmziTsQN1a3T/rm+PO1smWLVuI9Cl/xi/4TDP5Dmbms734Y62KuCgPBAwP55b8TjDvNXkhvUu4eDGe4OHsDJ/02BGT56mFtQ30vqhS5YcPkKekNrxN9TeloN3Fg3HThsmw+puDibTQii9pe7Rwh6e3HbybUeCLnn2XsB4byrEEf9EhY5Ck3JRarw/udmep48u7s/TruAB7URTrBQB6jNtzT15V7RHWybROkRCH43qxQlMkXlTx7dIlSlqBUPdoAUBHrQUx0wSdq6pm5LJkvxk2E9E/HY5AlqENcWwP0I4YNe99euMELn8ZWh7UGsXmBo8EORVxTxXi2P26+0nV5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(10070799003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HuZ2pbXnSiVjU5FVElGs+tjjDrCoW4DlPOTyzGvlfl5lNzHRD3ZsfeINmZQ+?=
 =?us-ascii?Q?dm88jkEMcJQhPbXal0HNzs+PNMVa0BOuHObjam/PaeuO92Hiw8SUSHPoUdA1?=
 =?us-ascii?Q?h0qPjVtktg/D3iuHt7OrHjpHVI0MMPneG2K4da/srfdqXCwL5Q10fuXC+zuA?=
 =?us-ascii?Q?5H28YjWrxDD0Z+xCDE1Xgg6E5XvhW4VUKID2CIOIMRwA6yNQFILmTaQ1jpQp?=
 =?us-ascii?Q?BM57gQdZ1Q7ert9TAEVI0KXLUwzpfvJ2vYDfu/hMCYWPmaQSpcxGVJUApmkz?=
 =?us-ascii?Q?hEMM+ufMCvl0scW6JQJA2QX0wJ5lMsT3IcE7+SAH9g7nkNT1iST6JxPGdrkn?=
 =?us-ascii?Q?2baLGb62pSl8cxDLQdFN9II1bMFeGw6i/DVGwdk8sf8CTPQZIl2KpCoZc1Qq?=
 =?us-ascii?Q?pN9bbcEU6YmkkXN+rHzspAd9lSQUpw9b1897TQgdbo0BS+mGMmn6im26DbsM?=
 =?us-ascii?Q?t4F9lFDchMzJnQiquTXcr0KknLsT6SSMsW+5c2xhk/MS2AqAMDnY/hGCDj0G?=
 =?us-ascii?Q?TgBPMeyrPP534FeE0dysz2bKQ/BR3+hlA3NhLqJiEpArSSW0SW8EY3oPzg2a?=
 =?us-ascii?Q?i5yG/Q8yvcevwmvQBLF+cB/ogHGU8ffPpw2iaVJFO1zeWnFes8ldt6szBS9O?=
 =?us-ascii?Q?OCk+1tpt7fJkOSW8k8MFabA8puuWyc3Q+4aRwAMxntWnaB6eS9Sz+CoStAaM?=
 =?us-ascii?Q?1gyB3nJjdm8z/00xaJrcurJILseY8aGTbZIPGOz4uuhbrA0krwb6NaHlTkpg?=
 =?us-ascii?Q?UFMpNZTuJCOkBVaQdPK2Fo9n3GKC1YxBVd8azjsP+4I3cXfsQvLnj9FzP4bG?=
 =?us-ascii?Q?4GyVd/PBGiTLRIBObCk+JfZ6S2X+TCXiIxrcPpDfXiVs0fdROnFLdplCIbAc?=
 =?us-ascii?Q?g2C/UUAZA0GTDBKIVhu1NATi1knpzBPxzhaW7sZtZWYBcyd9f+O4ocoUMJGG?=
 =?us-ascii?Q?nLvWDUbe8wumINDIU6MlyZ1Zafdv/MKzybAnAYDVs0j0li32HcjSfsVJcNw4?=
 =?us-ascii?Q?VJYFAPVZUNzPHwPsw72is85dthiOxzO0oOowE0IVR0gWJ2Q1Omzm3xQQIkdw?=
 =?us-ascii?Q?aOhff4neFlq6MsWv6R4/ZTEw4rhYBRPGm5wOzcvbTCcc1Miyh+60iTEg8Ta3?=
 =?us-ascii?Q?RrlXF8PZhUVNhJk3541W2O7Gie/HycpFvZ8lx0W+obETz1rhLgtOaqBatEYI?=
 =?us-ascii?Q?F/PUuUipF3E0Nx/Ezh4mNF7eny+e6RfTGWncjrpwUDmjKNH+8O3jnmF1C4E/?=
 =?us-ascii?Q?J5qMV9OcoaHYyrQvT6ytoX6548fzZaQooCMr/fmsxresAPz7XuwLCGS5Fooi?=
 =?us-ascii?Q?gBDGxKNC2/6Di/U/B/dTDT71m4jhjNXFxCBP1bKLeSeOz8RozETbPKkqSaNA?=
 =?us-ascii?Q?7HrFA3oroikJjInBtA26YHH3SajPkCmR9YSf+9as4g/IOkbnoVDjhvIIZ0U4?=
 =?us-ascii?Q?2R2W2751mhOK/SsmM7hUC4n8kFLrwwCMKpejhUXYfRlB553aK3PY4MqAz5Os?=
 =?us-ascii?Q?sw4omgab8wriQ1eCsqkbdNHqonWpa8hjSZ0H6JF+CyZ8QxvntcOuXAXlFiLR?=
 =?us-ascii?Q?4IKCAvaaC0Ub1QBp3lDAKwC6+xka3aU4QT/A60kVie+xhis9kF+Ycpr32YmM?=
 =?us-ascii?Q?8ITRcenP+1MhBWm6wQWE8sFDV/lIRa4za7Fb93E+WKa8KCGsHALsVkCogEM5?=
 =?us-ascii?Q?ZSpklsXcWpv+n83yID4xCI/C9Dgd/G074OO7nCj0iAihr/K4bItjCEvsHAuB?=
 =?us-ascii?Q?Sv/JT5V2w7dhGERIooFIdz6HvGAXPiLgK9E3TRZKOmfQSrVQ33POf3tr91cX?=
X-MS-Exchange-AntiSpam-MessageData-1: OLZUCoqAEeqd3fi5714xU7J1LDpSKbZU5Pc=
X-Exchange-RoutingPolicyChecked:
	lXynD111JGye/w45t9ObB/P5wt5S2GmWpKtze8h7QXhwFYljCxkKYCmkDh0A3M1lQoUNdJxASL2xshZGsd/00LXA5iENp+3SUBl7wZHysryb/6cCAW2YO8/tkgTX4tEStMm2tIkAIURD6swEfwzSJMmcGISMcjAutzHlr6z7f1IXgflWkdivQZo3PPHuIFXIDROM4T1KagqjDRJzttcKOBDda3XTHlha+HD1/+lvO2671m2SF22S9j68diex/gzyrrhTexBWPetqtCBUYQhjH7cwQE9IvKt4j3HwQDnTNYQa+2wWph/esOPSY0YfOI5mHbWCq9nR6am1WluHEZI0Cw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d37ef6-f050-4671-315d-08deb0bbf725
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:50:48.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03xk0xkP1qxHhENVIPKalKit6Xf2l1z2xUORtGqbNT+ESPqAlgVjkgWNKwGT1VN5Do/hRReTSEm4DRuCOv5zc6DXBz4s++hWZQL6XrOyrn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2OCBTYWx0ZWRfX3uCTBdF8T0fC
 /EdqG4pw6aGSiIrSL6Bnv1t4KMnAXV83aiI6xc0fjtPkZpo/P2oWRmOH8BE8UpU8g/dw8ifGtBn
 9GPe0KMNHXadG+zj14iGw6wW9eSKfzD27fpX2zFFih9SjYc8Gug5SJXaElzXMHQMk7ascKC1dx9
 rX/Nkr/GJCtmTlWGhJZSpQQHICG9DXgklihNZH7rzD+6nQ49TZNJ9UAJWY8Fo/dwNL/lHe6YqjZ
 OOJ2sFsN6v1ykhad4+06FbrKNhg6uLWw4CWUOJFSMktUSQ8mmzarxht5U1aQJU5srqkYoMn2IBH
 157C2Ez+RfrE44uPUbJJKgsd6uXlWrGm+s67dOOsdcNOp8LElWbkRPhXDZTCaZtcz6VMLoNBBc7
 M4NEEwqkPex/MFlBPHn0qIn+A9SWq0GOYOCoYLCJpfLhen5uC7i77O6XyN2w+XWBbVRMzKstPCn
 e4/9BtDz2RwWdrD54MA==
X-Proofpoint-GUID: nsw5D_zAKU2K8PrTaDxFy106iPJsryLr
X-Authority-Analysis: v=2.4 cv=du/rzVg4 c=1 sm=1 tr=0 ts=6a041f4a cx=c_pps
 a=jY48VJWlCesAGUsWasdw0A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=zITIGW6OYzySIfM0I-0A:9
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: nsw5D_zAKU2K8PrTaDxFy106iPJsryLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130068

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


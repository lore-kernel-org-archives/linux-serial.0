Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8301B4159;
	Mon, 13 Jan 2025 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736803781; cv=fail; b=jXn4WJpWEU5l35QJHVLiGWATKNWrr8nhgyVv0yQt1eH1sLLl6jTnc03buutgNdn1d2wqqAK1mQYLYeT8mvUhtR/LUkgYf3k/xl9Abjujbf79njzjvt3D9fWQ5cvRiA+nx2u8GzP9MW9eyv0McHMUipPdFHxmTomOrqk118yNb7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736803781; c=relaxed/simple;
	bh=jn4gnm3X0jWdbRI0kvPo5hUKqwJY+5t/w5Frz9qAaRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=elMtCr9GK77p32e0XtXk8/H6FjecWSnq3vS0EMH+GUufdxxikQdk1P6Z/9sIrwxBc4IjvasV+yOzXia0NN/N2PogAhXr+dELBIUiGqISs4jAJcCGFW272muPokCnWvXDEorpq5NHpLUDWooNiKSSdQh7JTI4l43Z/EcT+/33Gcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ha8LQ/kt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CCQ9PMat; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ha8LQ/kt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CCQ9PMat"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DHN3mX029568;
	Mon, 13 Jan 2025 21:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=XhwaemCy2ro3YkMyVK
	5wxeqWFrSFIkTxZHy2YWOUdhU=; b=Ha8LQ/ktgK1DYDWGctAmig7wv7ZMZVQqFl
	TOSNKZokTrvADvKOT8nZ5EKxXe/ApoOc0XZuXYXSWpwaXp/2qd6/S4e7mhBeHPmS
	4YwT/q6qKKMHfKc7tfLfMfyHOxsAzp0msBZ4MKCMB4C3ZZ7Wjfa4/VKO6s9SmhBB
	7Xdpgs2YxRtxdKsoxEdjBxYtzeFBSa0hhByx97V0p4deZGWoZKkViMQ1SM73oQoz
	CfhICGFU7PI3KuW+azgYMBxdnLBMZpRRiXshg3VcR4svZpES9Jj1Fx6msF5ekXrW
	VrFnQds4qDWp+bRQ78ahX8GbxWa8VhoHGkMzp1sX+oxKxCr5k2Tg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gh8vf7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 21:29:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DKobhc036225;
	Mon, 13 Jan 2025 21:29:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3807j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 21:29:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXmg9dhyhFvHpeCWzDPNL4ZYXtKvO+xVth+/15VEKzRhDxtfSp9DGL5zgXSIKRETfe0ECh7EbvMf8k+UKjysKXueXSENDsRH4hLOs9cffMW1FCQ7N6HAg86tNK6i4nXZHkggNsu9moLqvdpX9vf8Q+E4BQOPABWGG/5mRLh5tE9xclZLCtGRHFh4pl04loPuUWcqDEqVbKRfHwIh7xJHy99fnzwQyKJYko+GltvOPKZM43uhYNdVzhon5k8jmyUGNFw8oUdeVxa2XHSkybrMyFbbtdha8KW8Dam8lM4LqcVs8LhCLyN6qOLsQXkyeDqAoChgIh49mviuRm8R22Jyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhwaemCy2ro3YkMyVK5wxeqWFrSFIkTxZHy2YWOUdhU=;
 b=wqxXhhd4npo/vszwfTOP5gCrppO8xqX+v2IuWUifA8E7Mm6QwqDBdoiycT8fPizLrF761/2FMLyVxsU3rK/pJyomD+ShHy9rIAIgk9V4p/We7BsyPy5hDVY7JtGlOUq7cOfi3508Nx+pq6nBhnDMmVhDHlV/MoiucKfpFRvmgzbgbPqS/4cyduaMGvFJClP1fXvdwIIqdrATEnehlEq/aDMXwKyr1UElaihpQIf1Pq0EL5W24+cMx7FZtsjH9+/pSrhvIEP4ChRdF1iAekgz5cnoRM7DVwYIYMmEpMffOnO9rS2iZTYVRXeJPJOk8FmryghwhHXBOIUrVZuCSeUQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhwaemCy2ro3YkMyVK5wxeqWFrSFIkTxZHy2YWOUdhU=;
 b=CCQ9PMatXLlAjzXpgyorNdcwrr+ptTjixrIzpKLXtsRGPlP21RL6QGURS9vMAQtUjRPKvUOUdeqBmUB5az3dDWxtiR/q8lONXuxhOEwrVbhgVoIYnZpk8guYobUqEKqmP4UZyjUXLVev52/2O8FtCU2uKtf8uwcmCx/dLv1vZzs=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SN4PR10MB5639.namprd10.prod.outlook.com (2603:10b6:806:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 21:29:18 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 21:29:18 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Amal Raj T <tjarlama@gmail.com>, danielt@kernel.org, dianders@chromium.org,
        jason.wessel@windriver.com
Cc: tjarlama@gmail.com, amalrajt@meta.com, osandov@osandov.com,
        linux-debuggers@vger.kernel.org, linux-serial@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 2/3] serial: Move LF -> CRLF replacement from serial
 console to kdb
In-Reply-To: <20250113172936.1434532-4-tjarlama@gmail.com>
References: <20250113172936.1434532-1-tjarlama@gmail.com>
 <20250113172936.1434532-4-tjarlama@gmail.com>
Date: Mon, 13 Jan 2025 13:29:16 -0800
Message-ID: <87ed16tnbn.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SN4PR10MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: e62a899b-485f-4a61-2554-08dd3419564f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?054fPQ8+bOoLPk4c5LD0LFm3X3pQU28PLfmrqg/gig2ZkeIpGFkTmUsB4qJX?=
 =?us-ascii?Q?UH7Ly4DnzPUw0f4lR1oqlqjKNWB+uMoSc8dfb8SRC135cTaH2vyktr1NnX5j?=
 =?us-ascii?Q?wGC5N9VUPMTiMWAxJHJulW75HXDUTNSe/TzfwpUzf3dAfCsXjQEQy5bAScLu?=
 =?us-ascii?Q?XXmRvVGuxY/MtQTretLkiRVHoi+gL792kwSnINMRbXnENgj6kKKAuFCdcT/n?=
 =?us-ascii?Q?Osx3+SRGoVoyAREemmLCo6geQVjsttChimO46rNUr7/mNXQvVzC7fbj5pqUN?=
 =?us-ascii?Q?dsQ2FYDosPr0QpELszpnQeWxQnlYDkujsq2BGlvqWk/WUhNcm+40Ia8/PqOM?=
 =?us-ascii?Q?L/ZxPY+V+cjWEewNZLaUP93ChDmPEPB0r1bukWUlWICPD60rT/RQ3nh+GD2t?=
 =?us-ascii?Q?EKwpAxxNnLNqQP7SWJVnamgV01tf0PaelWl7UdfQsYY2yDZwb9Po1CmdkzxB?=
 =?us-ascii?Q?9RCTzignqDZ8aA7ad4MrgHpcNc9FYAkWEM2W0YrBejghwoFZvQi584Uc6RUN?=
 =?us-ascii?Q?xTFo1zjUGSAP/pmOLWcGgMFRvRLdzSVNHCKgi20GKodtm7xykq80mous3KTU?=
 =?us-ascii?Q?2H5jouVRVEt95ScC6oIDgwmuxk4oSzhItAVGFplPnVkcHNuM8DWexHjweXf4?=
 =?us-ascii?Q?InK8jfU/X3/CG79C57Rx+CALhLlA72OlhHedcKewTc8AX3YV7gvahYHraz2U?=
 =?us-ascii?Q?pzU/ufl4ve4vlRJmLv6fwDpXR8ArJZcYk8wjt6QaKNSemBt/scyM6jyzuMQ4?=
 =?us-ascii?Q?R/Eva2nl9d/v/cnMtFQhBlQyxj4df091vgXK/7BYKuZcaQb0nTg1bJAzi4pG?=
 =?us-ascii?Q?nXdzPW+JD72hHzu7sRJJqKyFVdLY5RtHQ2GsFop/M6qqJeTyFwNS0HaHup0B?=
 =?us-ascii?Q?91tAK4F/twJYz0hAxDHv5nDKD4VqRbJHck6S/epX7gavu1sCKFnrNgLeqvbB?=
 =?us-ascii?Q?1hJRHywcXXKKMGYpgNcnJNR0FZJLYEldcd5/XotoBZSEt13e2qEGZG/SKCjG?=
 =?us-ascii?Q?uqYSQW6oaIlb/wVdbxnGI4gqRpINmPVv6f7I6fsI4e0L0dqpI80gX4gamp84?=
 =?us-ascii?Q?2Dryqb5PIFwFSd0Tz0lLWtJtThRkay3dBD4tgrlvIraFSkIHESaiwTD18cCP?=
 =?us-ascii?Q?KFgdMRIln3b2REgiufEDEvyFkluZBS/VvPQAQKaR79zl6bMY60ctwbgh1MMF?=
 =?us-ascii?Q?WbnMP1yNmDmtrPMSjKSXpnTSx8bbuKVPV5y8FApV1hEEjrYlDshw366inVzD?=
 =?us-ascii?Q?SM70nDM7hyNXYOgRlafirXq3zlWF5Vb8YBl/Sxag+N/zqmFAQkE6sP4uiqwp?=
 =?us-ascii?Q?e6W1JIwRsGSpv+G/o/3lc/SCM81Z1SJqsbyqkABcK2gm7FjhtJ3h2X2zpryw?=
 =?us-ascii?Q?LM0gp6hNnFaH/UzVCBp8A2Fn7dqq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?02Keu2xpmAHMgJaQP5viY+T1Ka4Whr7rE6j7mxR3VmLMcMfBBvZSWi/JlYZq?=
 =?us-ascii?Q?RbfuGziYSn1xdLyhn+UYYjSZOrRcl18HQ6srEo8S3TJa1lXad97J4IkWEO9r?=
 =?us-ascii?Q?RM4Na5Zln6ZDqhTqYmcdK054YqrTaOf9kDXKl48eqiLbBtBeldf3c1CQXbBM?=
 =?us-ascii?Q?28jKmT0+n8F24RExUY0hqoYPQzToKPVMM18IuwQWsgTj2BC0PfzVEklRn4sl?=
 =?us-ascii?Q?EiABtW4KnonLuI91l6w4uSi4RrYQaoisLBntC+v+r0g5rSK6CR/O/Q+zSZvX?=
 =?us-ascii?Q?d96ae2Fl/IXPHlmJNW80+cCMGdKMEWDlJe4L93InjvYza2G6UatvVsobbZ0S?=
 =?us-ascii?Q?PK85RKpJ6TUkSTP3UCi1qRA6Hhkp/687ncq3MvIix1raF9RhHYHzBKWAbuTq?=
 =?us-ascii?Q?Mf+Rv424UW9Yuqw/x3lY0Me7hceOzkmZad3W4IjRqt6bSIyglCNpVNvuc/bC?=
 =?us-ascii?Q?JUTdZepwudnOEajjOBwTZbBu5Oq/W0LuH8aw5+fT+lfqTVXOXBqD4ZTkZUQ7?=
 =?us-ascii?Q?WnPfi3tNf5zMj8EZqXheEwu0+FuQPQ0yevysnBDJWu0iCLL0QOoDQIzAoYyP?=
 =?us-ascii?Q?fHjUy7+V5zJTKhpdQ6tZnPxurqB1ipDW2VUDcnopbub9S5KWhxFZAtlFJpbl?=
 =?us-ascii?Q?qXmdTMoP2xn/xb52ChOq5nuaUtIak45bQk3DXmWq5j2DlRBJlC4O4giKQIDC?=
 =?us-ascii?Q?EnXnef7EZ4x3Obxk4VfyeyOLeRQY3PN3MjNBVqyK5a+B0mF2CieStZ8M82+E?=
 =?us-ascii?Q?n2MWBZPzWHuOvL5269P+d1bk3WIOu230yj2YVVX7vUbrmMQrgnEWNba8F16v?=
 =?us-ascii?Q?S1melpFbcnL8AzaSXcCyPmWtJXmPWnH6qgrFYFDi4uh5xT24zAdd27XUdiYd?=
 =?us-ascii?Q?t35eYMnAVTj48pyJufc91fnlLMCgaFD8jhGVwDmStd6MHop8vDQMyTJqwGZR?=
 =?us-ascii?Q?J+Pm66cBCVmzxaUEXLPAK9/VOvS54yIMrFkYuu4Ompdnl4Z3E8bCLMVwnoZ8?=
 =?us-ascii?Q?SoOr9RzJCIuJTP4uzl9fv5ddrkioR5lG1RBrcgg1y5EKfvMjwyMxq8Hfr8Qf?=
 =?us-ascii?Q?96LKOjYXMbz9oEBRIi2pO8oenF5UGknIWsjScdfWJ9A2lLjQe2+80CNSIvv3?=
 =?us-ascii?Q?BWaCHzOGrHi7vRPL03sjoA1NdmHzqCQYQ2fg9m/QwAFY//T9+gJxYGOO66vF?=
 =?us-ascii?Q?043OEiAC5+bLKDWQu79gkGy8TPmQOdI7L+dWf5EiHY+w3ISQzOOrxtePFSUG?=
 =?us-ascii?Q?3rhbASlgiA8Poa/NJkT33jZK5ns9jyUdItPRMGLIxfSldplnXNcIY613wqKJ?=
 =?us-ascii?Q?/TktBeOIcNzkPhAtfgqaA4iLDXccY3SyUkYw0iwjQRE3Sj3pdGO3tqeqL3Gu?=
 =?us-ascii?Q?KogLesBJJ5dabAuIshC/Ob3jnOIfsvkBYfFf11mdJK4TZjvkD9wFFcptOxlX?=
 =?us-ascii?Q?EdqyyS/LC7Vkl74uDUgyM+pXOlCnAUdcNDsk7dDaF7untt5v7btMZXLYypXO?=
 =?us-ascii?Q?BQFWH0Z2Ub4dkofh4gMyjjO0dFHsdMjbkp5IUzadT/HUQufzCTxrRLItbFHw?=
 =?us-ascii?Q?SJbcaQf/ILQ2ikQ/No3kzt2/2mcjoqmzKh93l5g66Ur/mO0HXiTWC5n4gAby?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9nBqB6gmrL1QqOAo1Fh50AccTxP2XX4nuQs8YeJBqZtzPU38XG1dF4vwJdHt8vrRw1qX/5xgf2F1iZN3TM81buBidiGV4oPOqoGuJlAZGAtB7plhsYp43KQAeKDg/d7uJSYX3e9xvigmzY/dNC4/Q7Pg/Dl+AATwcf4TbG/TeQMmujLyy6ZyBHSinlXlidJRkUA42SKuu30XNFgzydnBVM9f+L2MzCtXvue0IHX04cDSMftKSSpzp6VbuOyk6evA8ZcBHKerjGzhaHjq2m5n3G++UGi38uRrqZo897HxVcJrECowHWkcyPH05iI/JSRVJ25lyhXZIFufeAGF7VsQDSNUvktCxlenPYIQ58Jn9cTdOEzZjRYjAy1R3e70njLFiOW3gXvr7SahinxcLb3zE3fgXvhANCRnE+pEQdTAjFp5WE17mMzU5Q27cIhMJLXRiyReUi1PDL/Moui7V1wZI7CMkiJAxLzPqZqhp0fny3UBcl+WUsBcWu8K+WS7EmKV+9jVsSiUbr16N8kUtejNPK3Uw4fD+A7zar09BKfWQ3nZBrsQs1o9GQwqiDuEAWsBcuHfWWyxlsZNtwXPpejlZ//nYwZMX7yVGL5vw2dzgJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62a899b-485f-4a61-2554-08dd3419564f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 21:29:18.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYXjiaraJjPMS4aAnWWNevP97MmbcEB9+6hi2WoRn96XrxLAg3p7skHwzwRdVBjBrEq6yyo+A9528J/hicIUW7J7u39xRE9iHFG2gHjBYA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_08,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130170
X-Proofpoint-GUID: QipJZPe3N9Z6djYAD42LJO5BBt4PKcyG
X-Proofpoint-ORIG-GUID: QipJZPe3N9Z6djYAD42LJO5BBt4PKcyG

Amal Raj T <tjarlama@gmail.com> writes:

> From: Amal Raj T <amalrajt@meta.com>
>
> The current implementation of `poll_put_char` in the serial console driver
> performs LF -> CRLF replacement, which can corrupt binary data. Since kdb
> is the only user of `poll_put_char`, this patch moves the LF -> CRLF
> replacement logic to kdb.
>
> Link: https://lore.kernel.org/linux-debuggers/Zy093jVKPs9gSVx2@telecaster/

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

> ---
>  drivers/tty/serial/serial_core.c | 2 --
>  kernel/debug/kdb/kdb_io.c        | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 74fa02b23772..8e702f3deffb 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2738,8 +2738,6 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
>  	if (!port)
>  		return;
>  
> -	if (ch == '\n')
> -		port->ops->poll_put_char(port, '\r');
>  	port->ops->poll_put_char(port, ch);
>  	uart_port_deref(port);
>  }
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 6a77f1c779c4..43a7c8ad741a 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -572,6 +572,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  	len = msg_len;
>  
>  	while (len--) {
> +		if (*cp == '\n')
> +			dbg_io_ops->write_char('\r');
>  		dbg_io_ops->write_char(*cp);
>  		cp++;
>  	}
> -- 
> 2.43.5

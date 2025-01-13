Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C1240243;
	Mon, 13 Jan 2025 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788415; cv=fail; b=OWgOm3ametdczYMFugwaJPW1dZ7IsgYUOVWpY3c4fcT9FUnKE1kNdpfFu0LS22h3PITnYyVOFCjbrCAXn+8TQ7nSVBrjbin8GVTqAJY5M0lWUkiCBqZShlpSnNWoi18FdHLYUXXhesn7+fTjPxSA44s20NnxEDAnbfuTWGhk/w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788415; c=relaxed/simple;
	bh=a2dIxjf1z5W+9bZFNyvWQuH3N6PCMwraFavZxAfhJSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=kKmMCaEmH0BNbxuhkk+Cn0YkyQwdJqNQmkmJFtG4qWP40nUlEcyUwz9/ZnOuROwnOTpfxJVFzOF21ZYzPTwmVLnuPhZnKTGSYmWck8m15C7GMmcbQ9dpKgyqoEpRdUqpRXzpvzXbChcAUKrx7txp+mt/kr1eeruHr9QJsQXUBIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FUFqGHZp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ao+sy3Sh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FUFqGHZp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ao+sy3Sh"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DHBe5t015899;
	Mon, 13 Jan 2025 17:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=lmzwDqmIFd4KhDLfFX
	63Bdknk43UO/DOazGO740Xzxc=; b=FUFqGHZpDkogD/nqlm8n2HPAb8Ix8KmwfZ
	j5EPJDNR+Vuf8JYGFKGBeUP+IxWLsyHg2IODBcO9tNLQN9scKfmhyTvw9DLqRhM9
	qmhaBhdGwpr2QQKYzRKQ2Aa36+KcdOlY1GK0fzcSp4OxZaWMaLIMCRLc64Bf5iM0
	rSwSwQWjYHAAf6u6Bp6QduL/SWrsjIR5mC3WiBDuJRCg21GCStKVVeiYcy60vC71
	FfDLfuVp+bSiDvA2NJLqLbKWz4156INtsFK0qFyNJvpbWEEAJr/CIsCnXpn7tzry
	VfuiOIE69oVciTaptdOzWldKYrC/IS0nV1wd3O0bbdoWfxlk2KBQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443h6sv0uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 17:13:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DFkc2M035098;
	Mon, 13 Jan 2025 17:13:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3781x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 17:13:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcyrQvIsgn0VtY5tZ7CsUlicskn/yvgPvNxj0poqhQvyHN9U0+Zu04CAcIl0Yt8ufjyi7H2Udp9pzpBaR7vGueWFY6MjAzZp5lafyT1UMVIjEORrISu6+VawLNZsR1D9MrEqCChbHNI8EqDMGvlQU2Z3Ap7YO0D3DQVLrbKzSY118CJ2Y6nkr26Kek3ja9V96z1bFKANYUK21LRQeuU5QUlQveI8qgHL4XHDhMdTzKru83ygFZWCHsOrVHmzSKUFzwrDm0vGfUjdByC+eNCVj2/YOn1IGhSBkShpbRIh1qQBsTpBODwYoZFyMHcbYqqFa68VI5K7snnBaaF9AgWj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmzwDqmIFd4KhDLfFX63Bdknk43UO/DOazGO740Xzxc=;
 b=Z+2yEXqXoZBTJAghMP8O7qA5AsSvBj25HVvhVKjR2Qd/Iq7hw1dsSnJ3hUCi1t3O7iPItbE1O0iAQ1L9910jDjyVqK+kyf2rKWrMPjog12cjYt7fc7eVAvu7cFXBJNSfngdVJi6b7h8K++Jf4P7vuIM7zmyT/Q8eiMekuTGgtpmVtgq7S9pWX1G0a7p3vUc5m+XNoaI3tUcOyHQ8fgNjJ6NK/AKti0b51dbA1K1JScDsVsfFeab3uElsrzhxdjjE1+UcUwK6NmkuvIis3q/B2uGYbVWlMwhQ1/rv4ktYwTna1xUxjvxJT9PXcXIrjbpAwUMIElHz6sV+0pXQ3doB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmzwDqmIFd4KhDLfFX63Bdknk43UO/DOazGO740Xzxc=;
 b=Ao+sy3Sh0horF1436Wff9AMeSd8eOix3IEdrhNCVUKBoUOEpGDc9JVcczRUwhhNc18DFP/i2Gcw+WQcvaDhNR3G9Y7rPeJ7lAi508t0D6Ll742UDOWwgdNHcF4adZfmVXPn0GhuYiPwGDJ/+7czdz/aO6jxVJUFswMvyfaAdnGQ=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CY8PR10MB6780.namprd10.prod.outlook.com (2603:10b6:930:9b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 17:13:17 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 17:13:17 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
        linux-debuggers@vger.kernel.org, linux-serial@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Cc: Usama.Anjum@collabora.com
Subject: Re: KGDB/KDB running over internet as serial connection isn't possible
In-Reply-To: <8b118e93-c159-40f0-b89a-817752d11627@collabora.com>
References: <8b118e93-c159-40f0-b89a-817752d11627@collabora.com>
Date: Mon, 13 Jan 2025 09:13:16 -0800
Message-ID: <87msfutz6b.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CY8PR10MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 362ae5a9-ec6e-4fc0-7f80-08dd33f5924b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P0+VnD65YOH4jH3XitlK0sjTwB0ZzszgWwoVttar3CekizuJJMJPZ7zsLlaR?=
 =?us-ascii?Q?IDt1f9YvifYHD2wqAkjeX5sqTGM+1Fwzz9fr1qNEEZKuF7y9s5RosiN4eEqi?=
 =?us-ascii?Q?a+2ubH9jZZN0IyQ+LH+UiSJeKfN9M+JRzFaXqPs60wwClhQEQgiSNr6PvL6g?=
 =?us-ascii?Q?3poQV3lPgLh/eQmYht3RVULV4tHHWwgI5q6LVnMEwr2yK3fD1Y+/yCGqk2Fv?=
 =?us-ascii?Q?0F1HqO/CDo63aR9ge1TpgWbqnMzsVo9qypKIYkRbpxqvhYBwkN+1QuHm74IX?=
 =?us-ascii?Q?/umtZDP1WSj/xUTR+mnX2wr4Dvqek79vZ1cAf+XnYwOscDZVM/5//7+YfJxz?=
 =?us-ascii?Q?HRR9F+qmRgHA/m+CwA7cloPHD9nZktHj/4O+JFJq5KuaNVhnTwaT/FHY2QP6?=
 =?us-ascii?Q?skh2wydzOjc3JIyDZl7W+cfX86TLarxwltq9bV6Wqnla9YCe5OsB7+1qnzF8?=
 =?us-ascii?Q?l3oQQ/TqnnD4cCqE/vF3U1JXXY0ie/Et7O1wkJJjUAXbBGD6zls4OlvAWrfv?=
 =?us-ascii?Q?Y8uH0wLF1T09hLmMhLw991AZJzjjhAruv09cQ3ZaW+Z6LCKiLrred7mK/LXJ?=
 =?us-ascii?Q?w0tOg/JX4FIY5lNOUy2l2D52DCgy+yOq1TF5vLr7BiBpL/NwTSDRnqW3Chp8?=
 =?us-ascii?Q?IbFjXA0ousZStTOHNACaf8PtvYJ1n+gJe6RO2bUWb/JoLYxBVpBCr0ixxPxA?=
 =?us-ascii?Q?w5raeJoFWOjuW4jWO+wfgEQtguia6G5UTrHW+g0h3T4Ba/i4LPFbBAvpGYMv?=
 =?us-ascii?Q?fUvIgruW6oi1Tk+i4/yguHhVcjWxvgNpNaQ3oOEtLa5MyobRE2Ik8nHQjCq1?=
 =?us-ascii?Q?gdTu3vCIe+u8KYGoZKoskhhvArZYV6s/RR1lJKOrWGTeWCXm8cj3+L0Q/Bw6?=
 =?us-ascii?Q?lfLfpKQkrF1vmcIZ+VfsvR+WtWmFVATamQGGh/p7ksE4VfgJ0pPOg80zr/Jz?=
 =?us-ascii?Q?oJHsNk+BhslAuMSIPcaRjQo2g4CZNr0sY9prDI4RUun9kDwB7o0EqIAXNEB8?=
 =?us-ascii?Q?LJAxOJVCf6WAM4r1/GUB+uAvkFvwGNqUunC77Zg4MxQ+3MumvRpASg107XQ1?=
 =?us-ascii?Q?G32Qu2UdKh0p2Z0HukXoWH7vTpp/KiOzxYqjixy3a2dFPrTCME2y8leLKyzY?=
 =?us-ascii?Q?zAqIVu3gkBbLV3+bwcpj3ZC8pdsz3ysqDNrWzhJ3P7Gw8ehZWnJsnbYz2Xgd?=
 =?us-ascii?Q?bG3h15Xq/KwcRbSwamcuM5IB7HtuX8CgZBeSNwucvLA8x9fLMh6I3xNVOmvg?=
 =?us-ascii?Q?+qmmydgY0SA7b4BqYADl6Rry4XANRkqN6bwdxC5Ejb3xpxnWvvi8+YMV4wkc?=
 =?us-ascii?Q?1LoNzV3tQ4QVj3j7KnBm19Vryc8ht8jWY1RQf8XFMvCpxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owxbEIh67rFR6CMDpNuZHFyC+e5ymNsXGRz1N+HuXarScUxTnhqdXISveJzl?=
 =?us-ascii?Q?32eOISTefubcCWIE39YLEd5h9bTWH7UuiQ9q2DsSDYnWxpVsq7EgfH1jnFj8?=
 =?us-ascii?Q?sUSJI3NLsoRA4KZckVTlXJ5M2sliSxbF0b2trj4Ezo/filyORyt//OMx5iMC?=
 =?us-ascii?Q?giGfhgA8SfNdCnjL3EptrhYpOeczn5WeEjwNTKPctYkV8XVxiqaYHGzYMTiF?=
 =?us-ascii?Q?5d9PSvE+oPYO4/fUBa+E0jpthjeVG1AQDdQO1tCwa/8Ef81dnf+gsukWDI09?=
 =?us-ascii?Q?SHezxUAaPiO94x4j4am41ALnStcFg2EKrteLhs2f103SCW+dcQrOrAhYZbdc?=
 =?us-ascii?Q?Xe3MN9CWCe6UT/NrmkWC8LOYnv5WlGbAQPPDOGYktkuKWTbknVO/BkmA89fY?=
 =?us-ascii?Q?4okRtEfoTg+DvMZ4+LU/0X9cijx9WV2jsvJWvGKWEZJHloi/u6EGxQ/whQbA?=
 =?us-ascii?Q?WFhVhrDDwRx1wxMyK1QzEevpYc7Uh6E3Dt7fXz0486DUsU12eX9MqVxqPdot?=
 =?us-ascii?Q?497CZbRy7iQMnofG4XDn9JDMKoGBVuWoQ5cxenp0Z9htFFQA9LFb0dX64sV5?=
 =?us-ascii?Q?qobbyabuDbm9FIZU+Z3mICHZpt4pW9JsZa4NK4gg1BGAjGOHlPmxVFCmALrJ?=
 =?us-ascii?Q?eIAY7khNS2rhzdVYneIGx5Hc9a8IZbPjkZBePDol1dh471Gif0nBIzzfG0PT?=
 =?us-ascii?Q?aNFtRC33chj08FauGumBLePGxpNdOXxBUpRGk+IIPKfBFMzhPoZ8bAwaCTkp?=
 =?us-ascii?Q?vR/A50Cpn1BXj/Ge99iavTRTHJ+rt7FRTdEedJT3rxp9ND3hoL7T1sZ6W/vR?=
 =?us-ascii?Q?tkx0Gd6nMv9ynViHv+orIyEvzsdLbY5SWP61iAM9QhyBTGCmEzpgW716zm4/?=
 =?us-ascii?Q?zAuz9Ln1qHS9iPjVy3PGQXC1mD1vrO4qomGIPjSdF+cxqmehXLjwTo3DnUT6?=
 =?us-ascii?Q?ThmZ5sfRmnDTUcz4xSH1TuZLUzWIognvgbqD5dBaMVhiN8LqPtOUBdK5x+eX?=
 =?us-ascii?Q?U5Y0aseOZsU6fdmmvbtgZi3LXBqmZvxoVTZqrI0be6XqruFxJKh+62SSR1+8?=
 =?us-ascii?Q?Hc5ULkrvytCmPRcqSfhjyrjlBvfuXQZqBqSJNjSNaP6c9ib+PyayVtfMlNfJ?=
 =?us-ascii?Q?5zn6NkNHxi+YaqOdyXjke8+DYOIXNlZaUInD2TMtGb71KvIb2npxS/480wW0?=
 =?us-ascii?Q?os/f8D8wizEfGvWlDpb43QNmHq16VmJDEz95MrBE0AcHNnQMrjgngpHWBKR8?=
 =?us-ascii?Q?eaZvKil9CP+CCDogq/4JTY1RX8A82NjfohqzNeqAyOF3Y/ZRV0ed3uQY76Ik?=
 =?us-ascii?Q?yj6Wi8cPvo9gHgRWkf7vI5sL046LJNhHvDLtLxa+q+6xgl4Vl2r9HSVnVdK5?=
 =?us-ascii?Q?ODi4kfW5sCTorGuZYI+x4wNX83icaZt/qVN8DweCUWuKx8rq1gGU4rWphJwH?=
 =?us-ascii?Q?mJcrumDXbrPGSufZKmz176XvrgyNJNXz9tK+PyM2f7dKIGZB0e573Wy8JDNl?=
 =?us-ascii?Q?ewARcCgPZfv1udhIM6bZNMAEj1FCTnDmYKqJJI4dlVL39mMBqDp8tIk7ig57?=
 =?us-ascii?Q?qw7EG0VGpgz991JCu6UEA3MRyu1y5Hrqh44IicgFS4s3bMdAsVJBHe7nq9ID?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p8ssDYMd+3H+8CaAq5zcjNR5SiIlrLcW2fovjNRUsI7PvOFPjttf9fil4w6nHczSs2TPJx645Xu1/cGmY/SUr+cVVCQdm0/6P/1pQdoLEf/xVrrvFREj49uwcmSZJ+hXijhodm52vQuzyCjHIpvN8rJMoHPzphBbFEbzKSJ1B/vEyifxYcHHl6kR1wKTvFkU9DhB3WNQumGSZ8R7xT41ftqXph+mnBtGBSLtmRaqlP+tar5WB6asoqD3VQak05Ce2phMXPCet1+WSIgGafQ/jXNHzmik1ZQ6X2hNCncUXDNTI2Red1KfgsKgYHGEaEsTbn8Vt4upFyoWY7+lmfi1MCBfXa4qulF2mL3Nh32f0xDuGhdII7LapUR8JknNS/Uidpw31JK+YH64kpsXyIup+YlpcqGacpS4Jl0Ck+kZGcIFNr1N8pXfwirD+KyMrtHiihlxCftM2t7nZNoC5ehR81SUTT2VA+XyYfBlGj8lvBYjNdB5w3QyqAVGYE5Y5FO3J+FOmTcjrpwIdPfuCbf6/sfipf18/pZOJCwsg6fCUxueAPey7pYTNf9+42MPsg9varNK3a6wz2iSUlocXOSNqE97iF9o/EvBJdBvfHFNXEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362ae5a9-ec6e-4fc0-7f80-08dd33f5924b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 17:13:17.3080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10omxcoBR/Riji7/LEwabbbmS5I4+5Sb8xLGpelCpqITwQ5oRigp6SwLJAKLIlcwJMcvOK0BdoSMg/K3czK+I9RJuhVrgVbF+i265nhiesw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_06,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130140
X-Proofpoint-GUID: f9g_8eBkSwZFU_8H_aFH0no419sd61Gv
X-Proofpoint-ORIG-GUID: f9g_8eBkSwZFU_8H_aFH0no419sd61Gv

Hi Muhammad,

Muhammad Usama Anjum <Usama.Anjum@collabora.com> writes:
> Hi,
>
> I'm new to trying KGDB/KDB. My test machine doesn't have serial port.
> I've been trying to run it over internet. I get following dmesg log:
> KGDB: Registered I/O driver kgdboc
>
> On test machine command line:
> kgdboc=kbd
> sudo sh -c "echo g > /proc/sysrq-trigger" # Launch KGDB
>
> System freezes at this point meaning the debugger got activated
> correctly. But I'm unable to connect from host side:
> gdb vmlinux
> set debug remote 1
> target remote <test_machine_ip>:2012
>
> I may be missing something trivial. Please can someone point/correct
> me how to connect correctly?

Unfortunately you are not. You've configured kgdb to run with keyboard
input (though I'm not certain where the output would go without "kms"
included in the argument). As far as I know there is no in-tree
mechanism for connecting to kgdb over the network.

To my understanding, the reason is that the kdb/kgdb internals rely on
low-level polling drivers to read and write input. Serial ports & 
PS/2 keyboards can be used in this mode (I'm not sure about USB
keyboards). This means that a single CPU can use these devices without
relying on services--like scheduling, or locks--provided & used by the
rest of the kernel, since the kernel is halted. Using a network device
for I/O would be a difficult situation, because these devices & drivers
are far more complex.

Your options are serial or keyboard. There are, however, plenty of
interesting ways where hardware can help out here. For desktop machines,
most motherboards do have a header for the serial port; you just need to
get an inexpensive face plate to expose the port. Then an external
machine could connect to that serial port, and even proxy it to the
network. For servers, most manufacturers provide some sort of management
system (they go by different names, e.g. ILOM) that allows you to
remotely manage (power on/off, view console, etc). Most of these are
accessible over IP with some authentication, and many would allow you to
connect to a serial stream over the network, and even attach something
like gdb. Laptops are a bit of a sad state, since they don't normally
have a serial port. Some have poorly-documented management hardware
which can be enabled in your BIOS settings. For instance, my Thinkpad
has "Realtek DASH", which some adventurous souls on the internet have
succeeded in getting a serial connection going[1]. However, it seems that
overall the experience is buggy and not supported.

Finally, for VMs you're in a great place, because most hypervisors
provide virtualized serial ports which you can attach to from the host.
Of course, QEMU also provides a GDB server which is frequently a more
direct route to debugging, compared to configuring serial & kgdb.  But
I'm assuming that if you're asking this question, you're not in a VM.

I'd encourage you to go through your boot logs and see which "ttyS"
devices get registered and which PCI devices (if any) they are
associated with. Then you can cross reference with "lspci" output and
identify any interesting hardware that may contain a previously-unknown
serial port. Unfortunately it's all hardware-specific, and if you don't
have anything, then you're truly out of luck.

Good luck!
Stephen

[1]: https://www.reddit.com/r/Amd/comments/ism4wg/trying_out_dash_remote_access_on_a_thinkpad_t14s/

> PS: kgdboe [2] seems like a out of tree module for help. But it doesn't
> seem to be supported anymore.
>
> Is it possible to connect from another machine over internet and debug
> the target?
>
> [1] https://docs.kernel.org/dev-tools/kgdb.html
> [2] https://github.com/sysprogs/kgdboe
> -- 
> BR,
> Muhammad Usama Anjum

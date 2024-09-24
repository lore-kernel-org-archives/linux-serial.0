Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549E1B85D5;
	Tue, 24 Sep 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187181; cv=fail; b=AIS29O8cpOxztz3sSDsafUOqOzUq9TYC3M+87kHiJsPWpSfvHQ3Izln55PeYeRe3fxT6zXmmu3Q1wDgwmC9dQUB8waE9rKlBXqiXSbyE3DSSO5FG0RbHGZobAeXujv3gdcnLVFqJNsFJPq1D0TNK2PBVpqhh8iwwZzC2QMI6yak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187181; c=relaxed/simple;
	bh=LWxsIzG7z5KZVxsjSXAphHB/rIq1Z3GftmIk+GAZKQI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KK8Kwo1LcOK5Ln6bRmNpglvQ8Ji5UAF7HIW1ojbIeyIh/I1gxsfyyj0kwZeLu7vy3Zqwn5+3KU4BL1Pd6CkL9PVOKkJvgVOcBjRgnSL846k3PxrjsVCLZR5sw0fIN8kRM7ICXBz6Vkym1lF5oSN3rt8EdDAieYpADPtp9o5dW7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OJ0yLZXF; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OJ0yLZXF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brVWNr82QbWiK9WOziVXAc0TCCFTy8MoyUPdwr+IfnQc05Ij6Y7JsoPsXtT/8r8yn50s/T0j7FIVsYPCmaOtW7hm+MgP8mIoVyB7lWzgNSrb0tVBc5nRMTzAYnIoE5FSooDGHLPkJyHbimGu6yj+OepujOeVtCAc8nLOf4ze0bazvv3QQL12yd7nheOP2ioezqfzCM5bzcrXPe3T3gr+tu/v6fUSBwwmyJ7Ie+zMVVe9Icxx3aF5HaufRNmNPdAUsYaHXuO5kUZTIULNOc6cOwKLJrS2H5L4XT2cp5mMOv91Yp8YBA5++REIo7isKTrViqCldCzTwyAAgOw+vrLtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA35i00sw0B6QnNVylK0dQeYbGnvE+3e9nrqcRqPABk=;
 b=Mi4jn8heyPEfKGdi5x84fzS7rFeln9muYLjU6mMvyv67tYEpnl2suG4B3TIiaW25wIZITcwNiMZ5kJk+XZtUNtpfoiUomhLvm+xwz1B0viB/dWFloBp/bcNnGHqCDjr8J7SnTFmCzXZkBPcLn5ud05boKLnqVuftR0DSZfJzDJNrB3U0MzAQj6ajxIWDSwmkeZ0r2E5MDn9bX5653NHVNkJK/k5Ly5r/uxJ9xMAvEO727UltAJi224UsUPxc/P9ryklJX3D/c3ombFpxIvSxLYdEvMvq4+vf/JC9TDvY3gniGlQ+/U5Ee1EWx3oxM822XDGAnMpayShpCXDDn2/frQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA35i00sw0B6QnNVylK0dQeYbGnvE+3e9nrqcRqPABk=;
 b=OJ0yLZXFfpwfroLJSBkvwXfnZ7S15qswDVdiucGAJbXLGlDxcV7utRrGQANHH43MAOVKpkiydvVG/4c/MOG/Rf+vyJHnesvXPNCFA0eD9bUR1kQuj3kK3aa3MCe+FtUCMijuaAgnZRz3mDhIGJ97F4xQpgnQzchZZZKR82MBkPx00l3u2xNTLRiosV2IuAezjmvemZ08H8O5J7QR1RThs7xw9xDC1YasLY/BnfMXmJ2kjlMZHDQC57TzckzBh8M6NxNp1Z0mbXS3JZqozhcvoxoZ6DxJJRgZcd1hKCUK8izGNwph2jBV0QMTd7IqgFnrLfNkSTh5KTVRcMRoj084Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB9791.eurprd04.prod.outlook.com (2603:10a6:10:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 14:12:50 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 14:12:50 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 0/2] add NXP LINFlexD UART clock support for S32G2/S32G3 SoC
Date: Tue, 24 Sep 2024 17:12:45 +0300
Message-ID: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::22) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: a985112a-1e20-40fb-12e2-08dcdca2f91f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVkyamdqdW1QMDdtMXVqb3NOU2tiMjlhVE9FUVIwY0pXZEducHEwTC8ra2tM?=
 =?utf-8?B?cGpkSExMMXFtWGZubzVramJDRGY2YmR1anc4eFRmQ1p3OWo0OTNWdmVuOFk4?=
 =?utf-8?B?Rnd3WEtNWFl0VXJNRjVEMzlRZnJhUHdUY0YrdnB2ZlBmRWRzSzVhVjYrUkpD?=
 =?utf-8?B?cHBpcEIyQWM3RUdrRFM5Y0hhVGpSQ3F6UVBSOXlTYzhaQTN2WEhoUWV2cDVR?=
 =?utf-8?B?MUI0Uk1kUWs2WnpyaVQzYTg1bGo5dUpJSFN4RmtXOFRIelhJL1c2c3ZHcXZI?=
 =?utf-8?B?ZmFxbllIWWlOQ1VxelVraTZ0Z3ZScXJFdmVBMjBLS1BDU1F6S3RxRUpxalFF?=
 =?utf-8?B?UnBjWGFzM2xoWDRzWE9mREErQ201VW9wVmQ0LzFtTWlZbzk2Z0hOUVQ1aDc5?=
 =?utf-8?B?VzZKQzFlbmVwNzQ1dnloR1hxR0drdVpSeStQVndNQzdoNGhVK2pJWERLeTVN?=
 =?utf-8?B?Qk5CZzkyYU9nTUFNNDFwdGJlai82YUVKYzZZUTd5NkdJSjBEalJyVnlFekhW?=
 =?utf-8?B?SzBnWlErWTlWZUhQYVhTLytpbFRaVG5jbHNmMmUvT1FZdk12UGY3RnhpZldv?=
 =?utf-8?B?OTI1S0d2bDhIZ0JsM1g4WS9tbC9VZksxdThLcUxicnBXQTVoRzNxSE9DbTJo?=
 =?utf-8?B?ZkZPVzF2ZXFJUUZjZmFtKzAxQ1YxSnlDUVlPcmZiQUZUdndKdjNkdTRNSFd2?=
 =?utf-8?B?QWhPSk44QVhDZkNVUDFXWjBrSENzR0NwNkNqRjVEd1VSZFo0N0NvKzhyRWVx?=
 =?utf-8?B?MmFzQ3FOTnlFSFZBejlBSUhFZ3ZqUUhCMEZjc0kzd09QMU85Nm5XaEJoS2NJ?=
 =?utf-8?B?OWtZWWM0RXpJNEowZ2MvZk5mVWNTRGRqeWk4MSs3MGlvaENsbyt3U0xyMDIz?=
 =?utf-8?B?Q2tueTgyYnQ4Vk0zTS83TTlNZHpMQ2dMTWwwTUVXeDZsRW1weWFRVGNvd1hI?=
 =?utf-8?B?N0RjN2ZYRTEzZE5kY3pjdzJ1ZmhjbWwyOWNsTnQ4VWVlNUIwZEZZUWttNzFC?=
 =?utf-8?B?aXViZXlDQmFuOW1kSzVMRkNLOVVyS0Z0am1RSnUyRmRLZ0xLdy9abFY5TWo4?=
 =?utf-8?B?d3FtVWVMNnhFbU43WnZJZzJpd3AyRUYvT0RJQ0ptblAzZ0NxYWhsZEM4Qmp5?=
 =?utf-8?B?aFBWeWIzazhiOHBrOTk5VTdWTnF2azA5V0ltV0xSRHJuZEVVNW1ZSTNJc3hV?=
 =?utf-8?B?bWtBb1FnMDh4VFQrQ2dSK3J0enJjeG8zN3hwdnZJVmh0THdPbjJ0M1VHbHpi?=
 =?utf-8?B?ZkMxUkJpZHJWMEFvY0pnTkkyRTlNbnhNNGNnY1B2Y084YTJZaFVvQUZNRUJT?=
 =?utf-8?B?RWNONy95QWtNK01lV1JudWFQSU9HUTBjbWsxQU1rTWdJOXFxV1lLT2JnRHJV?=
 =?utf-8?B?VnZQa2plMFM2UGUxc2ZPWkF4S3g4S3RNL3BraVo1eTloZTdrMk1oNWlFSW9H?=
 =?utf-8?B?c3BYYXN2RHA3RWxVZHdOSW9pOWhiWGZ1TTlhendVWFVvYUhSajFrZVdkTFhL?=
 =?utf-8?B?ZEx3VWpmNUxyWk1VcHNmbjlhMWtCdEhyUzZXdkhVL3FHc2I0R2xQR0tmeVIy?=
 =?utf-8?B?ZjJkeHI1c3RYdEYzMzFWWTVadkRrV3FlNDBBbG8vZnZ1VGd6OWF2d3k5UVM2?=
 =?utf-8?B?T1dMSjVGT0hiWFNpM0EyaU1WajBMUzJsZ0JCZjZIUW1YNjBUTmVDdStpa3Jn?=
 =?utf-8?B?WlkwVHE5NVI3VkdpY0NCTUZlb2lZNGxERkhTVGZtcE82R3MzMnh0STlOZi9i?=
 =?utf-8?B?b1laZGd2VVFvelY2Y3dkWnZZNE9jN242MzNmNHMxS3c2dXkzYVZseDVqanht?=
 =?utf-8?B?VGZoY0ZpYWhKWlhUMDZnZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWpPdXA5amQyWmtIUHQzTFBxVFdNcDBIb2xjMVFOSTh2YytXcStPWDl4cy9u?=
 =?utf-8?B?dC8vS3UyVDMzb0pGUFdSMFpvai9oc2ZGWnFMSmJ2bjdHSkVpay9YTCs4bVpC?=
 =?utf-8?B?UFdrcWNveG93V3dVMHlGVCtaZTJNQ0pjd1l2b1N5TDBkQzZBRHVBVVBSVjN2?=
 =?utf-8?B?U2xsdEVHRVlQSDhlVzAxamo0S1lQaXlISHBxQit5TzZoc2kzKzR6TVQ2V3Zn?=
 =?utf-8?B?UG9tVmJHNFRaWDcvak5uMEUrQmFJa3duSURhWHFhaGpRdWhRMzFqbEFycnNM?=
 =?utf-8?B?VDFRUldjN3ZJRm4remlBVkxMOFB5VllLU3h0MVVCWVBVM3ZBRjAxYytEMzZS?=
 =?utf-8?B?VE9JVitBUTMycmJOVjBuYTd5K2dLaHpSWlZ4OWlJcUtHRUU3ODhQYW9NbFMy?=
 =?utf-8?B?N0hyaUNvTnhKSStzNTVHdmhvc0FMbDBhTjcxWGVCSU5XbmxZSmgyU016c3ZM?=
 =?utf-8?B?aHVqMHRtUHdGTjZ2dUVCMUVscXRRaVpXZ3hqeXdPdDVzTmZUMEovalpBUzlp?=
 =?utf-8?B?YUlXQVdiaVdQRU8yK0FxRlphSnMxMDI4Wjg2cThneGV6MkRCTll5cHBiM0Iv?=
 =?utf-8?B?cE1YaG9iY0tBNWNMVm5mUm1JVC9RM2ZlOVYvQ2tHZ0U3ZXg2U1dabHBPRWVH?=
 =?utf-8?B?UEEwSmJ1TWluN1k5QXl6VDh4R2E3WVM0MFdrcjFNNUtIK1B3TWhFYnlUZElt?=
 =?utf-8?B?WmtDdG5oUzhIQlhHTHIrejQzMm9OWnEvdTZRYkdWZlp3eDk5M3poTllCdXlk?=
 =?utf-8?B?WVVkNUdpaWpVaHREdC93VTh5SUh4Q3FwTTJIOHBXUFpFQUxMLzFBWFYzOTlE?=
 =?utf-8?B?aEU0SVR6RUdGVkFndXNab2ZMNlhHSllucDYrSmFLNWFQOFFweGdlSkcvS2xJ?=
 =?utf-8?B?bDFMdnJITUtvWUh6SVhUbGowdVEydUhLeWE0R1p1UEZXcWExdU82cWxKVHpF?=
 =?utf-8?B?ejY2bUc2S2V3RDViSHpGWndhSGZ2OHAvSW13OTZpZFhEOXhEMk9qM2ZqWXBr?=
 =?utf-8?B?YUE1aGJiSHhKbG45YUkxRkxHSDhyN0JqaVJuVUJXb1FMaUpmM3RPaHIvRUdy?=
 =?utf-8?B?V1I0Y3lLSG11M1BnSTNBcTNrMno0dFZPMDJKZE9jM1E1VVFybWc5NURmM0NQ?=
 =?utf-8?B?THpCM0R2VVNZdTd0cWpCK3UyNGtGOC9xbWVLL0lBWXRSaklBTlBtUUNJclZS?=
 =?utf-8?B?Sm9HaUFJS0o2eWdUM2hWNm5xTmtWZHd3cDhnOHZWa2dDNktabjlpcTl6RUxI?=
 =?utf-8?B?aUVhdDRodWJzWU02c3VtTjRHMHhjQzV5MVp2VzBLLys0cGlhNlNaMy9MSVlI?=
 =?utf-8?B?c2NsRGlGbFZnK3FoSmZuQ3Q1clNLNHhpVmM4NnY3YkVLdG1LSTBuQ1J2UzRm?=
 =?utf-8?B?WlVFaEQ0dE0rd3BjMDFvcEFRVGFtYmkrZHNvaFdzcjRxbzdUNFRsTWxncVd4?=
 =?utf-8?B?UHpnKzVZeVVidHFKZ2JiK2pYc2lDMU4rYUptckJPWTkvTTQzRmF0MFFTcnlt?=
 =?utf-8?B?MC95bFp0MWd4ZVU2aHE1dTI2UXVIU3plbjR3eU5VZlhSbGhKbkQ0SVZmT1dG?=
 =?utf-8?B?WWxPZFNrUU9HTk8ydzhNM01SblFxclhoOVZsSWMvdlFtQlJ3c25qa1hNNjRp?=
 =?utf-8?B?T1IvK1VxaU9ZK04vSUtINEtYZ0xJbXJYWXBTYTVZcjRhWlYzMWRxRFdJaFI2?=
 =?utf-8?B?NkZ0R3B3Z1Y1Ry9XN0Nad2p1ZndmN0dHNHBxQlAxUHE1MCtHdFk2bTljVnl4?=
 =?utf-8?B?eWh3RzROREF1T2d2YkpDT09ScW1XRDNVeFR1T1J2alRsVlh2THhhWEhvVFdW?=
 =?utf-8?B?WC9BdkZOWHVUTkQwc05IdXBRYVhwU3IxdkdrWS80c1RBMk5mNGkxWmFFbnBr?=
 =?utf-8?B?U3J2L0lVakRJaWtEZkttUjVvb0Y4cEJOMTNaV1pjRDBoV3Z4VjRRWkpoT251?=
 =?utf-8?B?dDVzUENhRGJNbzBvdGhqeUJMd0JpRSs4RGFTTGgvMEVwQ0pGTHFLZVVEVEVw?=
 =?utf-8?B?VHFZQWc4ZVpDaFdQd2hwMVBjakRtRmRsOGpKVVpwWnBGdlMyMnJTVy9UK3BE?=
 =?utf-8?B?ZCtKYThtWTZoSjREMVpvVWpIekNuRFZtRW9WYnl0c01xMjNkcFE1TldjWHZ5?=
 =?utf-8?B?QkVLdlN4UGtoT0lzWVZ1WWxXVkc1dXFZZUJNQjRvWW9qMUQ2QnZsdTNETnNL?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a985112a-1e20-40fb-12e2-08dcdca2f91f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:12:50.5403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyrdFkqiWsY48p7IKFXXTZjcGA1mHCzMs4LfxvU1Xc+W8Xl0GXwNWpIJ9FrncQnRj4oKM7cLaV0DkF43UrNy9XU7Q+T5l7eiZ8NcI6F2Kqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9791

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

LINFlexD UART driver is used by S32 SoC family.
Add clocking support as optional in order to not break
existing support for S32V234 SoC.

A separate patch adding clock definitions to
the S32G2/S32G3 based boards devicetree will be sent
for review.

Ciprian Marian Costea (2):
  dt-bindings: linflexuart: add clock definitions
  serial: fsl_linflexuart: add clock support

 .../bindings/serial/fsl,s32-linflexuart.yaml  | 21 ++++++
 drivers/tty/serial/fsl_linflexuart.c          | 67 ++++++++++++++-----
 2 files changed, 72 insertions(+), 16 deletions(-)

-- 
2.45.2


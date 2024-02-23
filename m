Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CD65DF2E
	for <linux-serial@vger.kernel.org>; Fri, 23 Feb 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681119; cv=fail; b=Ql/cLaFtVTf728IF5xEVTxco7UFdwznWocrRg+UiJFb5x4Aum+mZfnj9QxmQAssI3jFEsHvCQlkAbRXW6QjtvCKGNUkw/ine4PImmbfXAQGMs+vO3zsJhdvtiw+pAZHPQTf4lwVD8GSZTfYzgrfKVVFqi34sm2JsqTLG28oJ/to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681119; c=relaxed/simple;
	bh=JiRbuv5UdepCXfOkxDz1yrX7b6ThGPEh36IIuvRvQkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OKhJXHIiIEjScDBVe5nU6v5Yc4w2yj3v/pAAvdxQRIBSTq5AMjOMx4OP+uGs8rdxIXQToU0Cuc2Q89hoCUpGP+At1KCiSgSJEznttwZ1PYxT0hgP+5oKIumLjajS09TaduwdZqBPbS6qL0UoWpxNHUD2hy4jPEpo/Cpj9e30iQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=I6tcA6Ld; arc=fail smtp.client-ip=40.107.255.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="I6tcA6Ld"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DufxATaIfCUJVqTm3zY4si8DCDYgqybynr+UufOo4bp4U36OfU1axRHvCnSaB/20S3jXj1yJLTiKWB5s0OeeiGrQa/2KspHsxO7THMsb+AqEpKndSj4SxrghGvLsHVRQpnb3I0q+K4uWuCY4+YOlBMyaTEzS7YQttcgrPUbhbDYcCPHggteHbLCvdFzItY4B/Pf2Dy/H0dtdp8RW9XCXyBUtcpAeWWWJ8KYwKgJwhJRiDGNdXnnUSQZ/njYtVm5tJU8SLeYsZcJen5LYXbjfUA3VviJw5oLAJbIAib7zqOZWJ0q+jrThS059Z+JhDO41LlzH4V/C45T1VGd4BZ6ITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBK0aFF26+VG0UcCFXvOV37fc9bFfaBB73Xg3Q0ZMbc=;
 b=AHRmvO9WtkyW2NGv4/kYfQKd9SjwynHbIrAtuwhqTz1T/aJqVsilS7IntGCn8lHgDwHtfqchmjpNpEjrEaU3SNvPddsYmogVFGMQEqahFLMRGo8Hu8UWhI8Gax7ZUs+LOerm1GCkklDVIjQuf3IzKFXIf894umrH0uX98NrlyBMMqruPUqkk8bF//xzj23jFYfc6LX1L9N3aJ34105/W4NeQlbuIjgv/MPxvF1b299iiiFsreNLYNtamaz/vJzZh48DO2wItAXdvPggsggcCMwwJWyEOElHE2rqtNmIdqWYBTix/1J6TFAf8rfbizxdrzCGLuMTXu2Z2Y2wkXPGXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBK0aFF26+VG0UcCFXvOV37fc9bFfaBB73Xg3Q0ZMbc=;
 b=I6tcA6LdX4S1+Gge53x0yGmPkjEYmqqsdwiTJXMBIvYZlZYUfaWZxjZAlBef32bzi14qWSZRBxbWpMVXI92JFz7kr7DnAMyBIzTrFDnp/D+jeBXj1x2bKas5Jc+qQfDjxIoUuklVLfRqdWS3Wlv6oAhIFxcWMnRISY2QKxd/Dsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5749.apcprd01.prod.exchangelabs.com
 (2603:1096:990:46::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 09:38:34 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::33d3:a25f:436b:6b4e]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::33d3:a25f:436b:6b4e%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 09:38:34 +0000
Date: Fri, 23 Feb 2024 17:38:31 +0800
From: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: andy.shevchenko@gmail.com, Federico Vaga <federico.vaga@cern.ch>,
	linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: serial:support: Using 8250 driver With MOXA CP-132EL Device
Message-ID: <Zdhnl6+gHnCeIgeT@moxa-ThinkCentre-M90t>
References: <zmry3u7l7dzh2iqqonxyombv4v2nzpr3fccoe677laxc2jn6nm@mo4afecdt45o>
 <v7jpnrrgmjqgmtwrahwmd6vouv2opuhwxaeo6ouimojql7lv3j@zqhwaky2lqki>
 <ZdfKxqwuJZodRDbz@surfacebook.localdomain>
 <ZdfL68clwFIYI4tG@surfacebook.localdomain>
 <751d67fe-59e5-4159-b674-924de4dfb959@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751d67fe-59e5-4159-b674-924de4dfb959@kernel.org>
X-ClientProxiedBy: TY2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:f6::16) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|JH0PR01MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6e3b42-1b57-4d7d-02dd-08dc34533431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/30PhindOzqAm0Ev5phdpKRNax0D+OCnVwHJxds+Kiqga0t6HVcZ5f222DimPTc734OYo3b0srzvcLSwqaNqSHikeOZjFaW4cbjG/xoLFe1k/tr90tw4QcFOkJkP88+MrT7OGGdfdRId8qOat8Lzw7NAbL3pfBxyg23sHH5SV9BJYkwHmXNccxOLq4Hym2OEPpwOGq5zAqsQCEdaOP3RKl03NRzhZCJWg0eO7LXgnBMO0hjCTJinJ8X/Kj3q0eWN1cz1G28NGHVsuuVO984iKN695gNllNSR4A7i5LxSr5GQmLk/+DqWa9zDpZiWBALS2VYyt8iNsh2hdJtN3+PWkveT/lxonszjlypv1IvjFXaNghJm2xtqEWg4qv6lc1uVQZZosWm0jTe1BM7UGXZiAIwZRvTejzVSmhA8DDi+s/D0JCyRyYb09/TkRSMSLPzstnBX/NHhNIKTR4e1lWKH8cdOMIyOzL1Da9zugIxau6MHW6QWFHH1J8yWPBesPNiQVqlsQN1UAVp8eNO0BvFmofB+OoYKrJDim55kXm9QPic5ENumuBBK0v9Xf8/RFQyh/eFfX9SsY1kE+slwwyJVSR4NGn10+kb2iU3WbpYF0HQ6p8ejtADgH2Bgb15xjIF2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owtHFFiEDtE+BMSShHDqXaL1V0x7D17L1++RoRJSQYzWdk6EKZ2/M934J9B1?=
 =?us-ascii?Q?4I5mFYkm1HpzSBuUFoxfjk++3uF+TKeST44ikLqY/k5NBdhhucF3vxLZ4Vdz?=
 =?us-ascii?Q?asX+i1l1uHUDlvJ9afiXbVsPN+lCP5qffoDtMj0Ub7hhpBJtwK9BKkEeCTZ4?=
 =?us-ascii?Q?FcKear85JjTQG9w61zYffS7F2pgPMX1JkIA3PlLSr7UnmQskFAs4LTZOBfvr?=
 =?us-ascii?Q?BCJZugjHGPGvFFBZveANawJoMAe7+qc/QTzKzC87ajkL+l8FhdKtJ3HIapFO?=
 =?us-ascii?Q?Hnflk24LK6CGjAnEOyIL5tSY5Y2g+sO6AbDraluCECOLWoTzbPWTEQiD2Gxf?=
 =?us-ascii?Q?U4bKyWnI8upISukroaZVJ6z8lMTAAxr9G4XCpf0lMCrmJ6AmMfrjRvRh1GGB?=
 =?us-ascii?Q?qewtEYLT9a27sokMXBVDTiSDI1rzJ0FZeQVEQB8O4FUdxdc0JYeW9y+4Od4Q?=
 =?us-ascii?Q?eDeJ05UDUTqQ961vzvdqV2jwB+PrqYKSdEuCM+G4rd84Oyh/u/8u/1F4YDUq?=
 =?us-ascii?Q?QejT0vJSikor8Cyg5lpI8dErggnYERBKMfuzvbYLcNwU5MsiTrvvXIyldXfn?=
 =?us-ascii?Q?DMtdBrrCQ3LxhAsgJpf3GTdjfQwBV70IpK6RcE9wTy0Znoqe6sFT3MM1Xqnj?=
 =?us-ascii?Q?bjB+8Km1QlkyP7ut1qaCipZm4L03ZqursajsfbFo0xEeS77zwirT8jCkfLHl?=
 =?us-ascii?Q?OB26x3US1x8TZk7fDHcXXarOIR/C54HSvwK9YyoHQRJXolFUSkmp1z2x2mXN?=
 =?us-ascii?Q?EIm0pV1HJZihoEazFsCMj/ylLYymTYDlaQvTsISwLagXHIkMmHJDlMEp67g9?=
 =?us-ascii?Q?xFAmooBXepJh9lUCEXonGh2tP4ryqV+3dSJM868HPkzaVt9wyRk2Fuz/SmQI?=
 =?us-ascii?Q?R/0AhbYJaxu9lqAlunjn4G4zl+q9LGRSza4jJskQhZiqNua0zIPW5zz0XXcw?=
 =?us-ascii?Q?5z3q3rfrlI3cWByOPXEuQ87KP7+gHQz5oMA/RPBfqoWsDeL/NndDqNY3w8R2?=
 =?us-ascii?Q?UOGAGTJ2ucb2Shsx5R+d3EeFyl9wAOSImcUJj9AUHsWMXmMUPtFGSxMgiHGO?=
 =?us-ascii?Q?2ZqlV5p03d6PNgukssrce6xFd+s5k1NwtVvyUR3UCXEIIawpWAUxet4KZjva?=
 =?us-ascii?Q?dqN9k5+kZyJQxUQ7VVwn+upaZFxnso8jJkjzhj1sCgf334EOeXo91yA21EPW?=
 =?us-ascii?Q?mSphCpwDHZWNHaUY1IN4G6xsSUB0jp15SmIgPMvRT7yxRzMwRwPUnwLRlZ7I?=
 =?us-ascii?Q?9ZHEoHTvDDkvkMlEQGJ2/vH6UWDaFrxP4fN0Gi1MYdGDWnEvFehsscGu5YZY?=
 =?us-ascii?Q?IKoW+t1+8Enl5ZZ86asbRguqBBAG1VcUXh+McRXD5YpHzt6PdnUWgDKbI0sz?=
 =?us-ascii?Q?oES0p6fMNeFAKxV5+Mcc++GJtfowJaRcB7pW1xb1e10fypJkixVgTDh7S6Dr?=
 =?us-ascii?Q?v1nV6MJH1kZvzxfQ7oWXz61RQjka9pva7Hir9e24yutZD02YyjFC7AqaIS49?=
 =?us-ascii?Q?ZF9+zNRD4m8jM+Skqm07Njy8GbgV9FZdrMccVKvp59kBts+4Ze1cNmaQx2qq?=
 =?us-ascii?Q?XqPfz274lqKWV3CiK3zlf8/xnsv3Uf7pDHg2zuRif83ypSMg9/oFBLmJCo2h?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6e3b42-1b57-4d7d-02dd-08dc34533431
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 09:38:34.3434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxpx77VGF3TJa2SWsTJsm97bq5p1c4duhXRhzIt6pUWbA3rZ6waCTEBagZdAuf655S/5wRFd+w44raa/tU/mexSK/OVa8zL6zInt4pwZJWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5749

Thank you Jiri for finding the related patch.

On Fri, Feb 23, 2024 at 07:42:06AM +0100, Jiri Slaby wrote:
> Does it magically start working if you set 422/485 manually via TIOCSRS485?
> But I doubt SER_RS485_ENABLED is set anywhere...
> 
> Crescent how are these 422/485 devices supposed to work?
> 
> Oh wait, you may need:
> commit 43f012df3c1e979966524f79b5371fde6545488a
> Author: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> Date:   Thu Dec 14 14:02:34 2023 +0800
> 
>     tty: serial: 8250: Set RS422 interface by default to fix Moxa
> RS422/RS485 PCIe boards

This patch should fix this issue, please let me know if it doesn't.

Perhaps, manually setting RS422/RS485 via TIOCSRS485 could also fix
that, however, the patch of switching interface is not ready for
submitting yet.

---
Sincerely,
Crescent Hsieh

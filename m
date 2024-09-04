Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3A1DB949
	for <linux-serial@vger.kernel.org>; Wed,  4 Sep 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459604; cv=none; b=k/OUW2k2F/2uMFsBYiJwcmj7zSqm90HWjcwvqH5WmirTdbSFoyV1pja72I5zb/XqqVqmangSm5rQBis+h/OZ4uzoQzAK6k42VeK2YoSmPRhxxON9pWRlghCtCmf7AdDISRA3tiYA4vCUya46bkcr+VhlCxJucf9r8RBT4exicZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459604; c=relaxed/simple;
	bh=Qs9zG59m3GKS5ISERXH2aArFzwS4LzmYvbXj2Kq76So=;
	h=Message-ID:Date:Subject:To:References:CC:From:In-Reply-To:
	 MIME-Version:Content-Type; b=dgfVHFPKsukZUaFl19K2EWsvPRxCVxZYxVxXGLeS8/F5Hkk5/iX/JmSX7BwZQ4z/j1az1044/i6ECZ6JQIpZg4ZbevkFEVmh4ddM4PiWIeHvW7SCZ+AfmKifZ6mABkBR7wnG1FnOEwDV1ieN4bPZARA7JhaSi0NVZNsvRCFTvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=QpSZpAt+; arc=none smtp.client-ip=185.58.86.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="QpSZpAt+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1725459600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLcDY1AcEsIrXHTTbq3PqENfmagIT+3GUDyMmhDLtN0=;
	b=QpSZpAt+zoPMORZ5tM3So52EvWiGq9BZU4xJUCyiRA++o5u/kVNxt/SFhKT3Lni7CyGMrH
	kayBc19CDeF0NksLmRSuFJannzOP9Uv0I1cpqLkFIJTsk7cK2TJ27tavtY4GJhg0X529RO
	SGNThgDGTntt33DqsIlLD3OkegoFGnM=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2043.outbound.protection.outlook.com [104.47.85.43]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-309-lqtURnmcPvmSU_GQoVzbBw-1; Wed, 04 Sep 2024 15:18:45 +0100
X-MC-Unique: lqtURnmcPvmSU_GQoVzbBw-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LO8P123MB7972.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 14:18:43 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 14:18:43 +0000
Message-ID: <76e5feba-1107-47af-af3c-57a7cb6b601c@camlingroup.com>
Date: Wed, 4 Sep 2024 16:18:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] serial: sc16is7xx: cosmetic cleanup
To: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
References: <19c7e2b8-7f74-4138-b366-758b65da998b () kernel ! org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 Pawel Lenkow <p.lenkow@camlintechnologies.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>,
 Andy Shevchenko <andy@kernel.org>
From: Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <19c7e2b8-7f74-4138-b366-758b65da998b () kernel ! org>
X-ClientProxiedBy: VI1PR0502CA0009.eurprd05.prod.outlook.com
 (2603:10a6:803:1::22) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LO8P123MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edd49cc-3414-4100-7b50-08dcccec7b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5fw6NHL0lzMNwQMUkNpQ27hRCHOd0vB1ZgUXcBTz6L7L1gDiX8vMWi9a319Y?=
 =?us-ascii?Q?C0kNf6rVOuZnZI2OBOaPmJZds++7kG7YSeLbWjhjon+dsynfZa73sxR5dBiT?=
 =?us-ascii?Q?cYI+oNdXsZD0mI6K9rwTQs/f+77y2AcUfrEMbTRHKuWnQ4o8R4D4LEW5Rmgn?=
 =?us-ascii?Q?9cadzgN6oHYl4BvjIupatgRiYThBOIlTyR8vYxYHLZ43oy70qTCIRaYt467Q?=
 =?us-ascii?Q?m0wwysWdFtbvrzuCT7sG0rb3eH/QFADGgv5pDhyxyfyMU8hRKFkoH33x4Y53?=
 =?us-ascii?Q?V0/6iYOIwjAup0F62B50wveO010pTfJ7FBoboH99dqvINC6Z588mmH0ACn8d?=
 =?us-ascii?Q?PRle4Gpz49Nwda3RONwvsq8xFky5Fw0JE3y1Gp79vCVB6J6SfJ01h/HPLV26?=
 =?us-ascii?Q?QOmSIeP1Pd6qMp0O+w/9OBhKruDmF2OKqPmNdGjJiJxuZIDjyDK1nKLqb5Ft?=
 =?us-ascii?Q?5w5RLQbcn4ViQ5VKBTBdAXfnpHeWTmPIYbWASh+zDAUlbgtxY6cxJ5E4SyZA?=
 =?us-ascii?Q?fCNFxHksiUTM0xhrQ0FBFJLQnHOF4HmK3/4Cad4gqZfhcPdR6dd4Dtx93ck9?=
 =?us-ascii?Q?4WfvqyxVpHgQEulQ4ac6yrpO1x4LboTPKUDzfpB/m1xF+Y0Z1sBIZzHgHeFh?=
 =?us-ascii?Q?JtA8zhBzeG2f8F3U7E+v8TcRBq/Wa/969g8VyXdNNX/Q3W42AwXgwpLmJUMN?=
 =?us-ascii?Q?wMRElItWeET0RwXkVUif5DkrQwTNmnWfB3ROOZ5mUnLDCfjCLt6Zg4X7c4kS?=
 =?us-ascii?Q?XEvfbL3njMU0SN7/iN28eddEUuDv9o9lJHu/khnbrAx5qpdgCpvCPnB74jwo?=
 =?us-ascii?Q?BvT1RA9cIOi9AqsZKRhfcrozOQh67l6Ok6YqIOO38HeCqlGPipqZj3zuezVD?=
 =?us-ascii?Q?zAulXTED1Gx0DMM1LP1TPqBZkyyErfm2IgKhdQ8d8AH0a5QxyRZdNvVpUeH6?=
 =?us-ascii?Q?Lo0IqG9pd679UahRwo+H738lHiyF3/6s+XAAAtwk+2RzvbtxYktLCKy3qPG8?=
 =?us-ascii?Q?1Qa8/e5CwtCy6QnnjEqIYBR+2FTLmicCZJfHJffzsfY+gkZ6ic8c7vTXV+EG?=
 =?us-ascii?Q?BHqn/0hemxg7LeA3EOabDrbfjVPrC0yLD+rv6/HSK/+5tVH1OUlKq33+Un1V?=
 =?us-ascii?Q?H2tkaWFduQiHrZyh8A7tOnG3S0j0lWKUa+RgWjqTcvneqxb+dnoCXr4V+4p1?=
 =?us-ascii?Q?xanzgnr5LlyGwkWElxQnBgz9ylFxNemHVkP3cbE/6B/2keYnUe3bMugX60NT?=
 =?us-ascii?Q?xtJMWL8tparJHUFSv/QmmYFgBXI1zOUXQ1cOgjqSA8qolRCpreDzMV2X1KvP?=
 =?us-ascii?Q?az5w6X8Dk02HRLuuL7y3r0Q0DhsfUy3V64oOByRDUPQHtQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JtUusUP4ReORoGdnoyge59IQJQtWj9qidOlONbyb+mTgpG0AdLVxZB/6iE3W?=
 =?us-ascii?Q?Nd60Y1fG3TzLSSZL5ngtIFDe9a0fWtx5d/Om/HthgCPFI4U3X7l42GadV+MW?=
 =?us-ascii?Q?il19aT5HU7aL4u5VIO/BFXG64dyCE7LwYqI+wTmuqeuF1GeFVETHSIIreeYa?=
 =?us-ascii?Q?QMDtuthZFNIGNkW6o1nwqBmOiZkCMsawSQ1Aelftlg/rBfurHJixPScZ0ig+?=
 =?us-ascii?Q?CVCxlybBg/DefGSLFy9j1z06i7vC/rEu4qziNekQ+NxLUvjveoWbzbHjbyd3?=
 =?us-ascii?Q?2ZU1IIyUjR4fIv2D6oNRuqdP8anuzpGZ+ZWWtFzPH7D4ywmMpSiyF6hGey8I?=
 =?us-ascii?Q?cRyGrQM5lDCfmtLyWOAVMlWGrsuP+9pWehiP+HRqUeYKM9GgxrU3+KNmdy5w?=
 =?us-ascii?Q?Ol7dXvJSGsXahZtVETTFRsi8Kcid3qwxLj2OV7/4Som5E64HeITqJqTWQ89Y?=
 =?us-ascii?Q?Lc8cahEgCsPxZbk5GUuXaYex7r8qsO/FyRa32ZNIegiXAR7NDalZ7bd2Sbnf?=
 =?us-ascii?Q?sedRPrA5LfZDnjX1oh3zVsNpdna5938lBBDTyUsATcFe0BLM2iahaf9mArhs?=
 =?us-ascii?Q?GHxi+5VkH2jxF5d8CVWPse63bOktd30eLgACXyh024zyP8hl9CLC3bXRyd8E?=
 =?us-ascii?Q?5cjzW2AdTXdOxDiMTaiQcEpbBT7H6YEi3heqRXM+TV0ZLyDifoYDYSrLPclg?=
 =?us-ascii?Q?2XTMoQKSAB+n8CyCdljc3RHRsg0Me7QReDZDX06LbHuipaXkQs0rqdNurYzZ?=
 =?us-ascii?Q?1W4Fin/YxVaezPcSWdLRLvgbqbwKwoa2hvpNUeFFigg6DFBmKElwSMuk0ixn?=
 =?us-ascii?Q?q1dntRCCvXyS0p4tNlkgSl62luv9gNSOf/Uaj+eVC2H7vL86BNk7fSLnl16W?=
 =?us-ascii?Q?jlVvfR+Iq0FhsU/8Y1Y/Wm3hJRKTw1Z7sKNMRSjQ1G2tZhDB7vxSeKDeFAkG?=
 =?us-ascii?Q?2TJXoFPMItj+vlH9SzVNQZKvTTnbFJpTe1PhS40E7R3laghPip4JApGeiIx1?=
 =?us-ascii?Q?n65VBUxYLlBNXZRE/upi6BFd7B8FudyvdTjfHC7QVYakaisKQg9KKd2O1x9e?=
 =?us-ascii?Q?1dboiQApRUsRWejiF/sBTbhr73YLqCtMizdwtl++Ww1lUIW/RqcZ6Ofkb99K?=
 =?us-ascii?Q?2dBT1qFwAQocrq4+eRfvLjwQjC5QxEXHv13it8p02Up9OOgKgDuS3Zgpgu0/?=
 =?us-ascii?Q?WPJ/OVjEbkKIQW4bDrxRbkp03UHjZnp+b6A1CESA8fR4h9+X2LgamKryzZeQ?=
 =?us-ascii?Q?IapLsue38qaqiuLnXtxCS8so8YzRqJ7mRQU80whT9xIh/DUpkCyBp0csnQBC?=
 =?us-ascii?Q?8samXh6yA4dOlIwvL0Xh+OnQAKj7z8+Ku+k/E95yzOsej30vZmUbQw5WhGqW?=
 =?us-ascii?Q?m0pAmz5NrK7Vwy1iMXKVgOUMmlZAuH3PN24+7klmzKAJl427dePdrur2uvs3?=
 =?us-ascii?Q?pRdWlngElPJEiziEn4p75TWHmjjBP+qFZUxco8Fs+aWgxUp9cVrI3UDrVtqc?=
 =?us-ascii?Q?AiUiN12e7yQWCdZXy6saeoSIlXrVaQiWGKIsTg4gPzNAbr0fANUNuWeNBfM8?=
 =?us-ascii?Q?Ce6CAWBl+HtdO75OKEPaDILlHcmYLUDctRvGgvzYlYBQji1UJQqfJxlALbYn?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edd49cc-3414-4100-7b50-08dcccec7b47
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:18:43.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AInsZ5WDAOO2jTc6eIiTqBof8yUW69i9B+VE64IWVhqlcIQlZM2EwQQqqDViLRZdkQpAjqGLnvZGzt6a9/Ya8pmtqPAuOseurYXPVh35oN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7972
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Jiri,

W dniu 28.08.2024 o=C2=A006:35, Jiri Slaby pisze:
> On 27. 08. 24, 17:38, Lech Perczak wrote:
>> Only the single expansion of GENMASK proves very hard to analyze in the
>> diff - so I double-checked with a calculator,
>> though all BIT() expansions do match, as does the updated definition.
>> of SC16IS7XX_LSR_BRK_ERROR_MASK.
>=20
> You can diff also the generated .o fed through objdump -d (generated .s=
=20
> usually contains line numbers).

I see that Greg already got the series into tty-next, but for the sake of c=
ompleteness,
I did the check anyway.
This also came to my mind after I posted diff of preprocessed source ;-)

The diff is way, way smaller, but functionality is the same.
On amd64, the sign extension used in BIT() is visible:

--- sc16is7xx.c.asm.1=092024-09-04 16:06:02.523038659 +0200
+++ sc16is7xx.c.asm.2=092024-09-04 16:05:42.103938886 +0200
@@ -289,17 +289,16 @@
      1f9:=09c7 44 24 04 00 00 00 =09movl   $0x0,0x4(%rsp)
      200:=0900=20
      201:=09e8 00 00 00 00       =09call   206 <sc16is7xx_tx_empty+0x36>
-     206:=098b 44 24 04          =09mov    0x4(%rsp),%eax
-     20a:=09c1 e8 06             =09shr    $0x6,%eax
-     20d:=0983 e0 01             =09and    $0x1,%eax
-     210:=0948 8b 54 24 08       =09mov    0x8(%rsp),%rdx
-     215:=0965 48 2b 14 25 28 00 =09sub    %gs:0x28,%rdx
-     21c:=0900 00=20
-     21e:=0975 09                =09jne    229 <sc16is7xx_tx_empty+0x59>
-     220:=0948 83 c4 10          =09add    $0x10,%rsp
-     224:=09e9 00 00 00 00       =09jmp    229 <sc16is7xx_tx_empty+0x59>
-     229:=09e8 00 00 00 00       =09call   22e <sc16is7xx_tx_empty+0x5e>
-     22e:=0966 90                =09xchg   %ax,%ax
+     206:=090f b6 44 24 04       =09movzbl 0x4(%rsp),%eax
+     20b:=0948 c1 e8 06          =09shr    $0x6,%rax
+     20f:=0983 e0 01             =09and    $0x1,%eax
+     212:=0948 8b 54 24 08       =09mov    0x8(%rsp),%rdx
+     217:=0965 48 2b 14 25 28 00 =09sub    %gs:0x28,%rdx
+     21e:=0900 00=20
+     220:=0975 09                =09jne    22b <sc16is7xx_tx_empty+0x5b>
+     222:=0948 83 c4 10          =09add    $0x10,%rsp
+     226:=09e9 00 00 00 00       =09jmp    22b <sc16is7xx_tx_empty+0x5b>
+     22b:=09e8 00 00 00 00       =09call   230 <sc16is7xx_tx_empty+0x60>
      230:=0990                   =09nop
      231:=0990                   =09nop
      232:=0990                   =09nop

>=20
> regards,

--=20
Pozdrawiam/With kind regards,
Lech Perczak

Sr. Software Engineer
Camlin Technologies Poland Limited Sp. z o.o.


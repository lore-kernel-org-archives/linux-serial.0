Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010055.outbound.protection.outlook.com [52.101.229.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B71A9F93;
	Tue, 27 Jan 2026 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512181; cv=fail; b=k9X6MR7wIykoNTIXb3GS5DSYhyp8GgmKnbggxedyRzOuNbqfm/SWXrR8wPFt8WrtvzwVsj/3VyCfgHfekkU/gxgeQ/hPgho5SKdpmRjUlSYZC5mGDre6E++WH6xf0w1IG+Riue1hI6pN9k8GpsQ6CTXTSmtJdznI7yHsIEZMJPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512181; c=relaxed/simple;
	bh=kFGjothfpBePiEuZ7+yGJ29BOIqMVTp46NX4K9sNnL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IM21PhfJCOPJfihslcyTFMau/CXagyJeiqNzJEkKm+QpTonmNDjktJzB8pVNyz8eNt1RX1/IhL/vqwYk/kwad6kFoZNTr2PZ0IBoMufzRbd/lhQyS2AtXQta1/MNiGkQNiq/0CGsLLtwwXzaneOOEtSFs5RbVxKrOPMTFcV0HB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=fail (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=c8Ez4aEo reason="signature verification failed"; arc=fail smtp.client-ip=52.101.229.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="c8Ez4aEo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPGPuVT6rJ86WsknCLCG1+jduq/z31lXK0lvh2nW/HaueTf3uh8wdxk91g28teaCmMxeDIAv1gRD0n94Qb9N0AaePn5Sl5Q5TIs3Xa9OweN3cF8WjTQpagL4GXvDWgqx39R6pRTRMZGTlElcmkhbtSfAAfkUFMbExl4X15ZLpYL6bbwu1EY7gC1eXp6Qp8Xy7Jeb3FmCgtHOATt90LdB/aX+8Osrg8Ho0BOBhlz1PcnSAgra4xxNohPoKO67SoNd4R0SMLoR069rZgWJWV8fYazJM7DAdjYoiySV8R8GTrfqefYHT58CZTTatOOTmcRDjObBISRhsl8rZi2BL8oWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWxj/KoGHLWo4gs5DOQTIeFLJCd/35ljyvNcTZblajE=;
 b=aa0iKNs9+0ym3qCwuG3Tv0LjjqQ5Ozx/f6T50Mny6EYKwmu0VKCbNN9ZwJLiaMVbkUR66pOw+vjHKVZ5fkeroUHB8rRSOLtQOIrG6zveK8Swzh2RIjHN9Ayi2tYOVxdaROowerpzQRYeLKHH5EICzWg61UoXG7+bM78qcElwYy54fbLq4r79TLACWcoY1XTCPwGP6lzoD4UbAu4p20eo6j5+lKLcCW23kA7CbZIR516yrZladVLjJbdTALUEAFH7BLpCkFsmaMEEJBgPZN702Cf44J2SMoCgbT5YyZk2ebb4RMWvqT3cg/COI60Yk7y9918AOpK4C3wo6dtkBNQlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWxj/KoGHLWo4gs5DOQTIeFLJCd/35ljyvNcTZblajE=;
 b=c8Ez4aEodBoR4fgA+SqyWpIFR8EdKBPSH9IUP6mxTV07j+fA20BilKj0CLKrDjPi4mX/l4AOkFyA4wsjLaFQEyECuPDPU0arxmtE5GnkxZxrCyhaBpNz+SGsohbAFhSIXZWt7MqSMNU0QXI83gABHQw+PLaFRThibX2KC2F30T4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB11814.jpnprd01.prod.outlook.com (2603:1096:400:3fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 11:09:33 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 11:09:33 +0000
Date: Tue, 27 Jan 2026 12:09:18 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Xin Zhao <jackzxcui1989@163.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, tj@kernel.org, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v8] tty: tty_port: add workqueue to flip TTY buffer
Message-ID: <aXic3pyl0xfTSYB-@tom-desktop>
References: <20251223034836.2625547-1-jackzxcui1989@163.com>
 <CGME20260127103433eucas1p1ce8d8c194d4fd16d2f1dbbc0e9df28de@eucas1p1.samsung.com>
 <d1942304-ee30-478d-90fb-279519f3ae81@samsung.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1942304-ee30-478d-90fb-279519f3ae81@samsung.com>
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB11814:EE_
X-MS-Office365-Filtering-Correlation-Id: d183f0cf-8847-4e81-6195-08de5d948cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?1OwYTMfyD5CCSUY1JNycSJZ3t+qOVlwCwr4eROJZ63hUvXDFFPqwaEU8x7?=
 =?iso-8859-1?Q?Udczo7cYlOAtpujR/07lSe5HGpRhTqZDVOqAlmXEl7lMWKXEH82x1jDmPW?=
 =?iso-8859-1?Q?CCdvs8+9RkvDAHJ49xc/Uaz4lIwYoV31/6KIUnC1z0y8lh7ANwDsJxY3Ro?=
 =?iso-8859-1?Q?qkk6Nmz4rcgdmvvMOmq4UMBT9Ijxrp+dfM7gB6PiYeAlcTxoDxQom7slJS?=
 =?iso-8859-1?Q?2OHEKpWZigMJIhWUWI2Xokg4H941bm2g1F72PCWkyzLxLT875BTp7ssEaV?=
 =?iso-8859-1?Q?h3rO7lTlCGWAD2kfviP+s4BSGxOKjjEvk8RwWPkdKkCayKlhkBbVjqeZRF?=
 =?iso-8859-1?Q?gXNWXHvPZYoBV7Cif9+9NvQKu7wrMT8XTK8BZkELhoQQl8KekBqBv1XDo9?=
 =?iso-8859-1?Q?6Bb4BlxF1Y6wRfqlx6M/coLcGdGY2snmuXgKZqsTKQjhZRYdbyMNtwqu2E?=
 =?iso-8859-1?Q?MmJtkrBNMkfQWvDipjU8gd4SOMvqdHA8qpPqCsrW4N9Qrh1RLLnS+6j42G?=
 =?iso-8859-1?Q?n1PLXZwMsv553q5/3NI9rKQPma8hNOomyfYt5S8qkTalwZAuVuywCug3Ik?=
 =?iso-8859-1?Q?hLBD236Z7aFocyPALSNc09v2FvXi7aLQUbI7TgHE0Ntq3l7v1318zjN8Fk?=
 =?iso-8859-1?Q?QS4/wGKYvoXMg7SFY34hHy4hPYqVx7RkxV/unFtEJA3Z2M7MGLq8tj7me9?=
 =?iso-8859-1?Q?hlAcqQiiTsrCBxuInl1NYg+UjzbIVfJMzQFCAcJ2A7Wpj/R4nwda6EmwAm?=
 =?iso-8859-1?Q?gv++RdcP6bDXOEjqF/TEoIEeAG8939Ya1eJ1eYtCAj+0eN5YVUJqa/+BgK?=
 =?iso-8859-1?Q?C4j/DYcwSlGqEDiZgJ1qTRV4J5iHt8JlOoj47dVdBmJuLBfvRdtn6Rl33I?=
 =?iso-8859-1?Q?zFdjwM1cfEhfy3DjRiJsb0pVdbIoNFF0WSvYIXpS0hYtQo+YwQhFjVtp/C?=
 =?iso-8859-1?Q?vL077ZDIIO0ayPH7bOYY0DX7VjipqDKiLUBnjHjk4hrHYkzqoUjr67w5ON?=
 =?iso-8859-1?Q?/CnvidQiDjyohLxnoXvsUhrU/860uoc3w+NoxsqobXtucZZSnwoNuxMohn?=
 =?iso-8859-1?Q?t6HyoahPmrDW+guk+q1nUVbqxHUNwF2pZULK0bz05GVnSvHdAvGTPQMQX7?=
 =?iso-8859-1?Q?I/p+pYBa6VvGxIU2XcgthlNkVuvbZ2J84EpX34aOM3k0BKrFjSdxaUt8vW?=
 =?iso-8859-1?Q?POwlxxLUwt/CqmDID5oGl2KFbfVycGsZB8StFQiGOPNDyXXMWJvwFzYV/q?=
 =?iso-8859-1?Q?muuzDnWkFeweBPJKFAH8O3XBQ6IGD/bVNUobRSf3vKCMhyw6HRQSNI2ZVM?=
 =?iso-8859-1?Q?42xqZ3LdkKJv38e+MnA//sGziPuuzV51T02wLU/BWj5QXZ5X1CEs6aEEzI?=
 =?iso-8859-1?Q?+BOBP03MbnQUQCqmK1v+CRVSSN2VG/rnI6PsV9D0Gf4cHSVEtrxlTbzIoe?=
 =?iso-8859-1?Q?d3YORvii++RMoDxM6nTX3yl2EgtwS7MUP/QkuHmOWvnN9b35xDxwrvUBL7?=
 =?iso-8859-1?Q?+hTASbSXH05Mqd4xjYk/6deUSYK+1DvYyk/Qyg1boiIfBwYPYJEloi8lAV?=
 =?iso-8859-1?Q?csfJHfwJm+H4HrZPH3bU0PXzP1J/HiZ6LvVXGoh9Q0bsyghOngdOGTyvr9?=
 =?iso-8859-1?Q?MJ7G992asrCqZ7/H2CJ14o3C231J+DNMdV1oiJvj8kHz7xZzbamEYskSZi?=
 =?iso-8859-1?Q?UoQyKmCoAHhkHl2HLoQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?HNngHlcvdjOX4chQwSW8gSL58mjIKeN2afK2tfL2u4mYV1bPssK3CTM6Vr?=
 =?iso-8859-1?Q?WKP0wZ6Z/qzehtLwgNPe7MumakmkVQB43OiTG49w4rbJjHDH0BRLSbXc1h?=
 =?iso-8859-1?Q?csHUKDTA9Qz0EBGPBa7hPT5yOaZurNmR8d8FRiA1P6b2Mx62xxnlfcQmPf?=
 =?iso-8859-1?Q?NMulGLgLfwMN4I+CH6XBEfx5+VAUMgxljmfKEdw5+xWHe203t8SbQfG4gL?=
 =?iso-8859-1?Q?UNMl8aiggdhRWNasL0S1LCM1fWqaEdUfL79ZpXBsMQpNfGEFukYIKkiplb?=
 =?iso-8859-1?Q?UZYAWmfCkAcDdB09BXX2m2rjNm47yrQZebWjO3dSXGkTrD012Su8Zxa5vJ?=
 =?iso-8859-1?Q?9cQm9rnjGjngOfdTRVAqctg6c50/X7aqj2vK6ljFOyI5i6Ma/NOaf/hUq9?=
 =?iso-8859-1?Q?kCu5BbocRDf6SsBS5j/B1347Ct7Kmm6pSlC4nfQWlqWdW71s96e5O9tlvM?=
 =?iso-8859-1?Q?lrTfdYoKc7vHSfB3Lc5p7HmWrWjvuy9O+5J5wnJ4KDfnP1sR8ehJqfqbh4?=
 =?iso-8859-1?Q?PgZX4UZYPhbkZktJPp1aby73O6czHdk95pTZExyIdgdE6DRoNPHlJYFv1Q?=
 =?iso-8859-1?Q?AUywIPYYleFUzbZxXGMVNNNqabDd4BFkQbUfblTplXqOSsX73orRYUytdW?=
 =?iso-8859-1?Q?ZjukUxk3LA6r8N6K1OimlqSODeyjhW4oIqZTtOHnQV2LzvhsaZ067FW4j6?=
 =?iso-8859-1?Q?4RgCmtqeHuxi1bEDiwwwBtsVUTrc1YSy0uAJiPMLWrZF1ZQ9Q7NLBaxCQh?=
 =?iso-8859-1?Q?8OtdLdu2sVnPzfdr8MEeqgRJzaunqf9Phl5kABGdlSncTVwCghnYtS4ZdD?=
 =?iso-8859-1?Q?LO17lGiqlu1VqFzEVPr6dPzlmftmhMNIc/t9FKzY7AAaTOoZF3T7TjiOnx?=
 =?iso-8859-1?Q?xsFbMKRbuTklIAWboFpoQdU0r+xhZdOCzjto+3WYCasWu+k2WkbrtW1gGZ?=
 =?iso-8859-1?Q?t73pu4hmyjR8soNhIj51VdJKJK4MFh+FkLeHUCBg1UhI6GBKzlObHXoVN/?=
 =?iso-8859-1?Q?Y1YfyilT1H9M02ZMID6qU91PuPuQkbGwl4whnmc4pqP+cr39HgFghIXK33?=
 =?iso-8859-1?Q?wunZ4065lRrY3BQ/ZflWYXc7l3JVxOpjWGiGHxohMF6/+/vwd42umjeyGA?=
 =?iso-8859-1?Q?xaJo/UkM+Nq9dGcviAd+E40592Vq8UTWwxpHF4Bw8lncI+tJA7Z2/qBze3?=
 =?iso-8859-1?Q?he+Yip5IVnNLs5Jk4sBZcNArAjvTqhmV/PBS0LVJkhF/gE+GGlNzOsKuzE?=
 =?iso-8859-1?Q?+SzFq/VbDZ0SJkgFh9fUgFWF0pwcrMeL/Nir7aKOQBp6wjFzKJFcbhiLFS?=
 =?iso-8859-1?Q?W5VwAS4S4E0X6663QRkzkSiYhtJoc1/KZkJGeuIcRAFTwm7kpTFdMBdf8j?=
 =?iso-8859-1?Q?/oyTXW9O2Z5z90uUJ9q//V4p/zsOyXaSnTWHT/u10cucQoTN9rHCwYrwjQ?=
 =?iso-8859-1?Q?F1LnLwUf5asxT7nxNjftpQA4ZAyTSyh9KypoaRg/1bPHM9QqEBbFe3k/2f?=
 =?iso-8859-1?Q?2EsvwzyjlBu56mOX6O299oOgIIzDljXuj6OEai2VVHAK1YUYtY1DBoVK5D?=
 =?iso-8859-1?Q?2JIZaZATVOlwaa3UdeaW6avZDhmZn9O+UY5PClZCzavcbBsFeEqMvzDzfs?=
 =?iso-8859-1?Q?LtAm/wsJaqlIIzLkO1JQnNKBRDSgT9fCoJZbl1vR90/dX0t8B+rQaL7/4n?=
 =?iso-8859-1?Q?3l9AUmym+pctO/NAMmko3Q5a0s+ZAH4+EK7LkRJC2cPAv3/aQpTST6qOyv?=
 =?iso-8859-1?Q?0770FPjrw/dQoPPKQHKyYWpfNqcxO0egs8VR11r+4tVkSdrCsKfEMPUdvs?=
 =?iso-8859-1?Q?YF0kQq5MLsgBO3l9km4KhFzTyyxN1LU26HM8hjKJ847p6uMpIWb2?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d183f0cf-8847-4e81-6195-08de5d948cd8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 11:09:33.6429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4hLGI110HaAb3yyLHWhER928Qq2B7lCo12qQ0hvgXFpOY006NR3sT6kaTaXXeQy3oygcvrsDJeczyvyvKe5eJ+TZnRSFp4/d/ul/cbcgFyI4b6T0DdXzLz5hIUG90Db
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11814

Hi Marek, All,
Thanks for your comment.

On Tue, Jan 27, 2026 at 11:34:32AM +0100, Marek Szyprowski wrote:
> On 23.12.2025 04:48, Xin Zhao wrote:
> > On the embedded platform, certain critical data, such as IMU data, is
> > transmitted through UART. The tty_flip_buffer_push() interface in the TTY
> > layer uses system_dfl_wq to handle the flipping of the TTY buffer.
> > Although the unbound workqueue can create new threads on demand and wake
> > up the kworker thread on an idle CPU, it may be preempted by real-time
> > tasks or other high-prio tasks.
> >
> > flush_to_ldisc() needs to wake up the relevant data handle thread. When
> > executing __wake_up_common_lock(), it calls spin_lock_irqsave(), which
> > does not disable preemption but disables migration in RT-Linux. This
> > prevents the kworker thread from being migrated to other cores by CPU's
> > balancing logic, resulting in long delays. The call trace is as follows:
> >      __wake_up_common_lock
> >      __wake_up
> >      ep_poll_callback
> >      __wake_up_common
> >      __wake_up_common_lock
> >      __wake_up
> >      n_tty_receive_buf_common
> >      n_tty_receive_buf2
> >      tty_ldisc_receive_buf
> >      tty_port_default_receive_buf
> >      flush_to_ldisc
> >
> > In our system, the processing interval for each frame of IMU data
> > transmitted via UART can experience significant jitter due to this issue.
> > Instead of the expected 10 to 15 ms frame processing interval, we see
> > spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
> > be 2 to 3 occurrences of such high jitter, which is quite frequent. This
> > jitter exceeds the software's tolerable limit of 20 ms.
> >
> > Introduce flip_wq in tty_port which can be set by tty_port_link_wq() or as
> > default linked to default workqueue allocated when tty_register_driver().
> > The default workqueue is allocated with flag WQ_SYSFS, so that cpumask and
> > nice can be set dynamically. The execution timing of tty_port_link_wq() is
> > not clearly restricted. The newly added function tty_port_link_driver_wq()
> > checks whether the flip_wq of the tty_port has already been assigned when
> > linking the default tty_driver's workqueue to the port. After the user has
> > set a custom workqueue for a certain tty_port using tty_port_link_wq(), the
> > system will only use this custom workqueue, even if tty_driver does not
> > have %TTY_DRIVER_CUSTOM_WORKQUEUE flag.
> >
> > Introduce %TTY_DRIVER_CUSTOM_WORKQUEUE flag meaning not to create the
> > default single tty_driver workqueue. Two reasons why need to introduce the
> > %TTY_DRIVER_CUSTOM_WORKQUEUE flag:
> > 1. If the WQ_SYSFS parameter is enabled, workqueue_sysfs_register() will
> > fail when trying to create a workqueue with the same name. The pty is an
> > example of this; if both CONFIG_LEGACY_PTYS and CONFIG_UNIX98_PTYS are
> > enabled, the call to tty_register_driver() in unix98_pty_init() will fail.
> > 2. Different tty ports may be used for different tasks, which may require
> > separate core binding control via workqueues. In this case, the workqueue
> > created by default in the tty driver is unnecessary. Enabling this flag
> > prevents the creation of this redundant workqueue.
> >
> > After applying this patch, we can set the related UART TTY flip buffer
> > workqueue by sysfs. We set the cpumask to CPU cores associated with the
> > IMU tasks, and set the nice to -20. Testing has shown significant
> > improvement in the previously described issue, with almost no stuttering
> > occurring anymore.
> >
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> 
> This patch landed in linux-next as commit d000422a46aa ("tty: tty_port: 
> add workqueue to flip TTY buffer"). In my tests I found that it causes 
> some regressions, see the comments in the code below.

Same here, testing on RZ/G3E looks like s2idle is broken:

root@smarc-rzg3e:~# echo s2idle > /sys/power/mem_sleep
eroot@smarc-rzg3e:~# echo mem > /sys/power/state
[  182.263395] PM: suspend entry (s2idle)
[  182.267619] Filesystems sync: 0.000 seconds
[  182.275175] Freezing user space processes
[  182.282334] Freezing user space processes completed (elapsed 0.002 seconds)
[  182.289447] OOM killer disabled.
[  182.292771] Freezing remaining freezable tasks
[  182.299126] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  182.369910] renesas-gbeth 15c30000.ethernet end0: Link is Down
[  182.379217] PM: suspend devices took 0.076 seconds
[  185.039929] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000100
[  185.048725] Mem abort info:
[  185.051530]   ESR = 0x0000000096000004
[  185.055288]   EC = 0x25: DABT (current EL), IL = 32 bits
[  185.060608]   SET = 0, FnV = 0
[  185.063674]   EA = 0, S1PTW = 0
[  185.066825]   FSC = 0x04: level 0 translation fault
[  185.071708] Data abort info:
[  185.074593]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  185.080079]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  185.085136]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  185.090455] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000102465000
[  185.096900] [0000000000000100] pgd=0000000000000000, p4d=0000000000000000
[  185.103723] Internal error: Oops: 0000000096000004 [#1]  SMP
[  185.109389] Modules linked in: sha256 cfg80211 panfrost drm_shmem_helper bluetooth gpu_sched spi_rpc_if rcar_canfd drm_kms_helper can_dev rtc_isl1208 phy_rzg3e_usb3 ecdh_generic renesas_r
pc_if ecc rfkill fuse drm backlight ipv6
[  185.129854] CPU: 0 UID: 0 PID: 384 Comm: sh Not tainted 6.19.0-rc7-next-20260126-00006-gdc83ac04b66e #306 PREEMPT
[  185.140207] Hardware name: Renesas SMARC EVK version 2 based on r9a09g047e57 (DT)
[  185.147683] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  185.154656] pc : __queue_work+0x20/0x474
[  185.158621] lr : queue_work_on+0x8c/0xa8
[  185.162571] sp : ffff80008314bbd0
[  185.165896] x29: ffff80008314bbd0 x28: ffff800082f74268 x27: 0000000000000000
[  185.173083] x26: 0000000000000000 x25: ffff0000cbdf8400 x24: 0000000000000000
[  185.180264] x23: 0000000000000200 x22: 00000000000000c0 x21: 0000000000000000
[  185.187446] x20: 0000000000000000 x19: ffff0000cbdf8410 x18: 0000000000000001
[  185.194629] x17: ffff8000797a8000 x16: ffff800083148000 x15: 00000dad54b1bae4
[  185.201812] x14: 0000000000000000 x13: 0000000000000010 x12: 0000000000000010
[  185.208992] x11: 0000000000000040 x10: 0000000000000031 x9 : ffff0000c0030be8
[  185.216173] x8 : 0000000000000031 x7 : 72ecc8f68fa27bc6 x6 : 0000000000000031
[  185.223353] x5 : ffff0000cbdfb421 x4 : ffff0000cbdf8410 x3 : 0000000000000000
[  185.230534] x2 : ffff0000cbdf8410 x1 : 0000000000000000 x0 : 0000000000000200
[  185.237717] Call trace:
[  185.240176]  __queue_work+0x20/0x474 (P)
[  185.244141]  queue_work_on+0x8c/0xa8
[  185.247753]  tty_flip_buffer_push+0x2c/0x38
[  185.251987]  put_queue+0x64/0xc0
[  185.255261]  k_unicode.part.0+0x84/0xc4
[  185.259141]  k_self+0x30/0x40
[  185.262154]  kbd_event+0x304/0x59c
[  185.265601]  input_handle_events_default+0x4c/0x70
[  185.270437]  input_pass_values+0x130/0x150
[  185.274577]  input_event_dispose+0x134/0x138
[  185.278889]  input_handle_event+0x58/0x84
[  185.282929]  input_event+0x64/0xa4
[  185.286362]  gpio_keys_irq_isr+0x78/0x130
[  185.290414]  __handle_irq_event_percpu+0x44/0x1d8
[  185.295160]  handle_irq_event+0x4c/0xac
[  185.299035]  handle_fasteoi_irq+0x104/0x194
[  185.303246]  handle_irq_desc+0x40/0x58
[  185.307033]  generic_handle_domain_irq+0x18/0x24
[  185.311686]  gic_handle_irq+0x4c/0x10c
[  185.315465]  call_on_irq_stack+0x30/0x48
[  185.319423]  do_interrupt_handler+0x80/0x84
[  185.323645]  el1_interrupt+0x3c/0x60
[  185.327265]  el1h_64_irq_handler+0x18/0x24
[  185.331404]  el1h_64_irq+0x6c/0x70
[  185.334838]  _raw_spin_unlock_irqrestore+0x8/0x44 (P)
[  185.339931]  resume_device_irqs+0x14/0x20
[  185.343983]  dpm_resume_noirq+0x14/0x24
[  185.347860]  suspend_devices_and_enter+0x674/0x738
[  185.352684]  pm_suspend+0x1f0/0x2b4
[  185.356207]  state_store+0x80/0xec
[  185.359641]  kobj_attr_store+0x18/0x2c
[  185.363423]  sysfs_kf_write+0x7c/0x94
[  185.367122]  kernfs_fop_write_iter+0x130/0x1dc
[  185.371596]  vfs_write+0x240/0x370
[  185.375038]  ksys_write+0x70/0x108
[  185.378479]  __arm64_sys_write+0x1c/0x28
[  185.382438]  invoke_syscall+0x48/0x10c
[  185.386237]  el0_svc_common.constprop.0+0xc0/0xe0
[  185.390986]  do_el0_svc+0x1c/0x28
[  185.394350]  el0_svc+0x34/0x108
[  185.397535]  el0t_64_sync_handler+0xa0/0xe4
[  185.401761]  el0t_64_sync+0x198/0x19c
[  185.405475] Code: aa0103f4 aa0203f3 a90363f7 2a0003f7 (b9410020)
[  185.411571] ---[ end trace 0000000000000000 ]---
[  185.416200] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[  185.423072] SMP: stopping secondary CPUs
[  185.427031] Kernel Offset: disabled
[  185.430525] CPU features: 0x1000000,00080005,00230501,0400721b
[  185.436365] Memory Limit: none
[  185.439435] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

Reverting this I'm able to see s2idle work back.
Hope this help.

Thank you!

Kind Regards,
Tommaso

> 
> > ---
> >
> > Change in v8:
> > - Rebase code, use system_dfl_wq instead of system_unbound_wq.
> >
> > Change in v7:
> > - Pty simply link to system_unbound_wq instead of allocating a custom one,
> >    as suggested by Jiri Slaby.
> > - Modify some inappropriate expressions in the code comments,
> >    as suggested by Jiri Slaby.
> > - Link to v7: https://lore.kernel.org/all/20251210125028.4174917-1-jackzxcui1989@163.com/T/#u
> >
> > Change in v6:
> > - Modify many inappropriate expressions in the commit log and code comments,
> >    as suggested by Jiri Slaby.
> > - Add reasons why need to introduce the %TTY_DRIVER_CUSTOM_WORKQUEUE in
> >    commit log.
> > - Modify the error handling related to the allocation failure of workqueue in
> >    tty_register_driver(), as suggested by Jiri Slaby.
> > - Add description of tty_port_link_driver_wq() in the commit log,
> >    as suggested by Jiri Slaby.
> > - Link to v6: https://lore.kernel.org/all/20251210031827.3771327-1-jackzxcui1989@163.com/
> >
> > Change in v5:
> > - Do not allocate workqueue twice when CONFIG_UNIX98_PTYS and
> >    CONFIG_LEGACY_PTYS are all enabled.
> > - Link to v5: https://lore.kernel.org/all/20251205030829.1829987-1-jackzxcui1989@163.com/
> >
> > Change in v4:
> > - Simplify the logic for creating and releasing the workqueue,
> >    as suggested by Tejun Heo.
> > - Allocate single workqueue of one tty_driver as default, link it to
> >    port when tty_port register device or tty_driver.
> > - Introduce tty_port_link_wq() to link specific workqueue to port.
> > - Add driver flag %TTY_DRIVER_CUSTOM_WORKQUEUE meaning not to create the
> >    default single tty_driver workqueue.
> > - Link to v4: https://lore.kernel.org/all/202512041303.7192024b-lkp@intel.com/T/#t
> >
> > Change in v3:
> > - Add tty flip workqueue for all tty ports, as suggested by Greg KH.
> >    Every tty port use an individual flip workqueue, while all pty ports
> >    share the same workqueue created in pty_flip_wq_init().
> > - Modify the commit log to describe the reason for latency spikes in
> >    RT-Linux.
> > - Link to v3: https://lore.kernel.org/all/20251027060929.394053-1-jackzxcui1989@163.com/
> >
> > Change in v2:
> > - Do not add new module parameters
> >    as suggested by Greg KH
> > - Set WQ_SYSFS to allow properties changes from userspace
> >    as suggested by Tejun Heo
> > - Link to v2: https://lore.kernel.org/all/20251024155534.2302590-1-jackzxcui1989@163.com
> > ---
> >   drivers/tty/pty.c          | 14 ++++++++++----
> >   drivers/tty/tty_buffer.c   |  8 ++++----
> >   drivers/tty/tty_io.c       | 21 ++++++++++++++++++++-
> >   drivers/tty/tty_port.c     | 23 +++++++++++++++++++++++
> >   include/linux/tty_buffer.h |  1 +
> >   include/linux/tty_driver.h |  7 +++++++
> >   include/linux/tty_port.h   | 13 +++++++++++++
> >   7 files changed, 78 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> > index 6120d827a..1f17575f8 100644
> > --- a/drivers/tty/pty.c
> > +++ b/drivers/tty/pty.c
> > @@ -403,6 +403,8 @@ static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
> >   	o_tty->link = tty;
> >   	tty_port_init(ports[0]);
> >   	tty_port_init(ports[1]);
> > +	tty_port_link_wq(ports[0], system_dfl_wq);
> > +	tty_port_link_wq(ports[1], system_dfl_wq);
> >   	tty_buffer_set_limit(ports[0], 8192);
> >   	tty_buffer_set_limit(ports[1], 8192);
> >   	o_tty->port = ports[0];
> > @@ -532,14 +534,16 @@ static void __init legacy_pty_init(void)
> >   	pty_driver = tty_alloc_driver(legacy_count,
> >   			TTY_DRIVER_RESET_TERMIOS |
> >   			TTY_DRIVER_REAL_RAW |
> > -			TTY_DRIVER_DYNAMIC_ALLOC);
> > +			TTY_DRIVER_DYNAMIC_ALLOC |
> > +			TTY_DRIVER_CUSTOM_WORKQUEUE);
> >   	if (IS_ERR(pty_driver))
> >   		panic("Couldn't allocate pty driver");
> >   
> >   	pty_slave_driver = tty_alloc_driver(legacy_count,
> >   			TTY_DRIVER_RESET_TERMIOS |
> >   			TTY_DRIVER_REAL_RAW |
> > -			TTY_DRIVER_DYNAMIC_ALLOC);
> > +			TTY_DRIVER_DYNAMIC_ALLOC |
> > +			TTY_DRIVER_CUSTOM_WORKQUEUE);
> >   	if (IS_ERR(pty_slave_driver))
> >   		panic("Couldn't allocate pty slave driver");
> >   
> > @@ -849,7 +853,8 @@ static void __init unix98_pty_init(void)
> >   			TTY_DRIVER_REAL_RAW |
> >   			TTY_DRIVER_DYNAMIC_DEV |
> >   			TTY_DRIVER_DEVPTS_MEM |
> > -			TTY_DRIVER_DYNAMIC_ALLOC);
> > +			TTY_DRIVER_DYNAMIC_ALLOC |
> > +			TTY_DRIVER_CUSTOM_WORKQUEUE);
> >   	if (IS_ERR(ptm_driver))
> >   		panic("Couldn't allocate Unix98 ptm driver");
> >   	pts_driver = tty_alloc_driver(NR_UNIX98_PTY_MAX,
> > @@ -857,7 +862,8 @@ static void __init unix98_pty_init(void)
> >   			TTY_DRIVER_REAL_RAW |
> >   			TTY_DRIVER_DYNAMIC_DEV |
> >   			TTY_DRIVER_DEVPTS_MEM |
> > -			TTY_DRIVER_DYNAMIC_ALLOC);
> > +			TTY_DRIVER_DYNAMIC_ALLOC |
> > +			TTY_DRIVER_CUSTOM_WORKQUEUE);
> >   	if (IS_ERR(pts_driver))
> >   		panic("Couldn't allocate Unix98 pts driver");
> >   
> > diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> > index 1a5673acd..86e1e7178 100644
> > --- a/drivers/tty/tty_buffer.c
> > +++ b/drivers/tty/tty_buffer.c
> > @@ -76,7 +76,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
> >   	mutex_unlock(&buf->lock);
> >   
> >   	if (restart)
> > -		queue_work(system_dfl_wq, &buf->work);
> > +		queue_work(buf->flip_wq, &buf->work);
> >   }
> >   EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
> >   
> > @@ -530,7 +530,7 @@ void tty_flip_buffer_push(struct tty_port *port)
> >   	struct tty_bufhead *buf = &port->buf;
> >   
> >   	tty_flip_buffer_commit(buf->tail);
> > -	queue_work(system_dfl_wq, &buf->work);
> > +	queue_work(buf->flip_wq, &buf->work);
> >   }
> >   EXPORT_SYMBOL(tty_flip_buffer_push);
> >   
> > @@ -560,7 +560,7 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
> >   		tty_flip_buffer_commit(buf->tail);
> >   	spin_unlock_irqrestore(&port->lock, flags);
> >   
> > -	queue_work(system_dfl_wq, &buf->work);
> > +	queue_work(buf->flip_wq, &buf->work);
> >   
> >   	return size;
> >   }
> > @@ -613,7 +613,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
> >   
> >   bool tty_buffer_restart_work(struct tty_port *port)
> >   {
> > -	return queue_work(system_dfl_wq, &port->buf.work);
> > +	return queue_work(port->buf.flip_wq, &port->buf.work);
> >   }
> >   
> >   bool tty_buffer_cancel_work(struct tty_port *port)
> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index e2d92cf70..d64fb08ba 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -3446,10 +3446,23 @@ int tty_register_driver(struct tty_driver *driver)
> >   	if (error < 0)
> >   		goto err;
> >   
> > +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE)) {
> > +		driver->flip_wq = alloc_workqueue("%s-flip-wq", WQ_UNBOUND | WQ_SYSFS,
> > +						  0, driver->name);
> 
> It looks that driver->name is not unique on some systems, see:
> 
> $ git grep ttyMSM drivers/tty/
> drivers/tty/serial/msm_serial.c:        .name = "ttyMSM",
> drivers/tty/serial/msm_serial.c:        .dev_name = "ttyMSM",
> drivers/tty/serial/qcom_geni_serial.c:  .name = "ttyMSM",
> drivers/tty/serial/qcom_geni_serial.c:  .dev_name = "ttyMSM",
> 
> This fails on Qualcomm RB5 boards, breaking the boot process (booting 
> hangs, because drivers try to use the unregistered wq):
> 
> sysfs: cannot create duplicate filename 
> '/devices/virtual/workqueue/ttyMSM-flip-wq'
> CPU: 6 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
> 6.19.0-rc7-next-20260126+ #16440 PREEMPT
> Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> Call trace:
>   show_stack+0x18/0x24 (C)
>   dump_stack_lvl+0xc0/0xd0
>   dump_stack+0x18/0x24
>   sysfs_warn_dup+0x64/0x80
>   sysfs_create_dir_ns+0xe8/0x108
>   kobject_add_internal+0x98/0x270
>   kobject_add+0x94/0x10c
>   device_add+0xec/0x720
>   device_register+0x20/0x30
>   workqueue_sysfs_register+0x8c/0x170
>   __alloc_workqueue+0x554/0x668
>   alloc_workqueue_noprof+0x5c/0xfc
>   tty_register_driver+0x120/0x2d0
>   uart_register_driver+0x120/0x1b0
>   qcom_geni_serial_init+0x20/0xc8
>   do_one_initcall+0x64/0x308
>   kernel_init_freeable+0x284/0x508
>   kernel_init+0x24/0x1dc
>   ret_from_fork+0x10/0x20
> kobject: kobject_add_internal failed for ttyMSM-flip-wq with -EEXIST, 
> don't try to register things with the same name in the same directory.
> 
> Changing the above alloc_workqueue() to use 'driver->driver_name' fixes 
> the boot issue. If keeping the driver->name is desired, then maybe the 
> '"%s-%s-flip-wq", ..., driver->name, driver->driver_name' format is a 
> better one.
> 
> The other issue with this patch I've observed on ARM Juno R1 board. With 
> one of the above fixes for the workqueue name, the boot process is still 
> broken because of the NULL pointer dereference:
> 
> input: gpio-keys as /de ** replaying previous printk message ** input: 
> gpio-keys as /devices/platform/gpio-keys/input/input3 Unable to handle 
> kernel NULL pointer dereference at virtual address 00000000000001c0 Mem 
> abort info: ... [00000000000001c0] user address but active_mm is swapper 
> Internal error: Oops: 0000000096000004 [#1] SMP Modules linked in: CPU: 
> 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0-rc7-next-20260126+ 
> #16443 PREEMPT Hardware name: ARM Juno development board (r1) (DT) 
> pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--) pc : 
> __queue_work+0x30/0x7c4 lr : queue_work_on+0xac/0xdc ... Call trace: 
> __queue_work+0x30/0x7c4 (P) queue_work_on+0xac/0xdc 
> tty_flip_buffer_push+0x2c/0x38 k_fn.part.0+0x7c/0xc8 k_fn+0x20/0x2c 
> kbd_event+0x2d8/0x504 input_handle_events_default+0x50/0x74 
> input_pass_values+0x148/0x2b4 input_handle_event+0xcc/0x5e0 
> input_event+0x64/0xa4 gpio_keys_open+0x9c/0xc4 
> input_open_device+0x8c/0x128 kbd_connect+0x84/0xa0 
> input_attach_handler+0x9c/0xf4 input_register_device+0x308/0x48c 
> gpio_keys_probe+0x40c/0xafc platform_probe+0x5c/0xac 
> really_probe+0xbc/0x298 __driver_probe_device+0x78/0x12c 
> driver_probe_device+0xdc/0x164 __driver_attach+0xe4/0x224 
> bus_for_each_dev+0x74/0xd0 driver_attach+0x24/0x30 
> bus_add_driver+0xe4/0x208 driver_register+0x60/0x128 
> __platform_driver_register+0x24/0x30 gpio_keys_init+0x1c/0x28 
> do_one_initcall+0x64/0x308 kernel_init_freeable+0x284/0x508 
> kernel_init+0x24/0x1dc ret_from_fork+0x10/0x20 Code: a9025bf5 a90573fb 
> aa0203fb 35001843 (b941c260) ---[ end trace 0000000000000000 ]--- note: 
> swapper/0[1] exited with irqs disabled note: swapper/0[1] exited with 
> preempt_count 3 Kernel panic - not syncing: Attempted to kill init! 
> exitcode=0x0000000b SMP: stopping secondary CPUs Kernel Offset: disabled 
> CPU features: 0x1040000,41858004,00020000,0400421b Memory Limit: none 
> ---[ end Kernel panic - not syncing: Attempted to kill init! 
> exitcode=0x0000000b ]---
> 
> Reverting $subject on top of current linux-next fixes this issue.
> 
> > +		if (!driver->flip_wq) {
> > +			error = -ENOMEM;
> > +			goto err_unreg_char;
> > +		}
> > +		for (i = 0; i < driver->num; i++) {
> > +			if (driver->ports[i])
> > +				tty_port_link_driver_wq(driver->ports[i], driver);
> > +		}
> > +	}
> > +
> >   	if (driver->flags & TTY_DRIVER_DYNAMIC_ALLOC) {
> >   		error = tty_cdev_add(driver, dev, 0, driver->num);
> >   		if (error)
> > -			goto err_unreg_char;
> > +			goto err_destroy_wq;
> >   	}
> >   
> >   	scoped_guard(mutex, &tty_mutex)
> > @@ -3475,6 +3488,10 @@ int tty_register_driver(struct tty_driver *driver)
> >   	scoped_guard(mutex, &tty_mutex)
> >   		list_del(&driver->tty_drivers);
> >   
> > +err_destroy_wq:
> > +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE))
> > +		destroy_workqueue(driver->flip_wq);
> > +
> >   err_unreg_char:
> >   	unregister_chrdev_region(dev, driver->num);
> >   err:
> > @@ -3494,6 +3511,8 @@ void tty_unregister_driver(struct tty_driver *driver)
> >   				driver->num);
> >   	scoped_guard(mutex, &tty_mutex)
> >   		list_del(&driver->tty_drivers);
> > +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE))
> > +		destroy_workqueue(driver->flip_wq);
> >   }
> >   EXPORT_SYMBOL(tty_unregister_driver);
> >   
> > diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> > index fe67c5cb0..611f87814 100644
> > --- a/drivers/tty/tty_port.c
> > +++ b/drivers/tty/tty_port.c
> > @@ -99,6 +99,26 @@ void tty_port_init(struct tty_port *port)
> >   }
> >   EXPORT_SYMBOL(tty_port_init);
> >   
> > +/**
> > + * tty_port_link_wq - link tty_port and flip workqueue
> > + * @port: tty_port of the device
> > + * @flip_wq: workqueue to queue flip buffer work on
> > + *
> > + * When %TTY_DRIVER_CUSTOM_WORKQUEUE is used, every tty_port shall be linked to
> > + * a workqueue manually by this function, otherwise tty_flip_buffer_push() will
> > + * see %NULL flip_wq pointer on queue_work.
> > + * When %TTY_DRIVER_CUSTOM_WORKQUEUE is NOT used, the function can be used to
> > + * link a certain port to a specific workqueue, instead of using the workqueue
> > + * allocated in tty_register_driver().
> > + *
> > + * Note that TTY port API will NOT destroy the workqueue.
> > + */
> > +void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq)
> > +{
> > +	port->buf.flip_wq = flip_wq;
> > +}
> > +EXPORT_SYMBOL_GPL(tty_port_link_wq);
> > +
> >   /**
> >    * tty_port_link_device - link tty and tty_port
> >    * @port: tty_port of the device
> > @@ -157,6 +177,7 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
> >   		const struct attribute_group **attr_grp)
> >   {
> >   	tty_port_link_device(port, driver, index);
> > +	tty_port_link_driver_wq(port, driver);
> >   	return tty_register_device_attr(driver, index, device, drvdata,
> >   			attr_grp);
> >   }
> > @@ -183,6 +204,7 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
> >   	struct device *dev;
> >   
> >   	tty_port_link_device(port, driver, index);
> > +	tty_port_link_driver_wq(port, driver);
> >   
> >   	dev = serdev_tty_port_register(port, host, parent, driver, index);
> >   	if (PTR_ERR(dev) != -ENODEV) {
> > @@ -703,6 +725,7 @@ int tty_port_install(struct tty_port *port, struct tty_driver *driver,
> >   		struct tty_struct *tty)
> >   {
> >   	tty->port = port;
> > +	tty_port_link_driver_wq(port, driver);
> >   	return tty_standard_install(driver, tty);
> >   }
> >   EXPORT_SYMBOL_GPL(tty_port_install);
> > diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
> > index 31125e3be..48adcb0e8 100644
> > --- a/include/linux/tty_buffer.h
> > +++ b/include/linux/tty_buffer.h
> > @@ -34,6 +34,7 @@ static inline u8 *flag_buf_ptr(struct tty_buffer *b, unsigned int ofs)
> >   
> >   struct tty_bufhead {
> >   	struct tty_buffer *head;	/* Queue head */
> > +	struct workqueue_struct *flip_wq;
> >   	struct work_struct work;
> >   	struct mutex	   lock;
> >   	atomic_t	   priority;
> > diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
> > index 188ee9b76..9c65854f7 100644
> > --- a/include/linux/tty_driver.h
> > +++ b/include/linux/tty_driver.h
> > @@ -69,6 +69,10 @@ struct serial_struct;
> >    *	Do not create numbered ``/dev`` nodes. For example, create
> >    *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
> >    *	driver for a single tty device is being allocated.
> > + *
> > + * @TTY_DRIVER_CUSTOM_WORKQUEUE:
> > + *	Do not create workqueue when tty_register_driver(). When set, flip
> > + *	buffer workqueue shall be set by tty_port_link_wq() for every port.
> >    */
> >   enum tty_driver_flag {
> >   	TTY_DRIVER_INSTALLED		= BIT(0),
> > @@ -79,6 +83,7 @@ enum tty_driver_flag {
> >   	TTY_DRIVER_HARDWARE_BREAK	= BIT(5),
> >   	TTY_DRIVER_DYNAMIC_ALLOC	= BIT(6),
> >   	TTY_DRIVER_UNNUMBERED_NODE	= BIT(7),
> > +	TTY_DRIVER_CUSTOM_WORKQUEUE	= BIT(8),
> >   };
> >   
> >   enum tty_driver_type {
> > @@ -506,6 +511,7 @@ struct tty_operations {
> >    * @flags: tty driver flags (%TTY_DRIVER_)
> >    * @proc_entry: proc fs entry, used internally
> >    * @other: driver of the linked tty; only used for the PTY driver
> > + * @flip_wq: workqueue to queue flip buffer work on
> >    * @ttys: array of active &struct tty_struct, set by tty_standard_install()
> >    * @ports: array of &struct tty_port; can be set during initialization by
> >    *	   tty_port_link_device() and similar
> > @@ -539,6 +545,7 @@ struct tty_driver {
> >   	unsigned long	flags;
> >   	struct proc_dir_entry *proc_entry;
> >   	struct tty_driver *other;
> > +	struct workqueue_struct *flip_wq;
> >   
> >   	/*
> >   	 * Pointer to the tty data structures
> > diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
> > index 660c254f1..c1b87f3c5 100644
> > --- a/include/linux/tty_port.h
> > +++ b/include/linux/tty_port.h
> > @@ -138,6 +138,7 @@ struct tty_port {
> >   					   kernel */
> >   
> >   void tty_port_init(struct tty_port *port);
> > +void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq);
> >   void tty_port_link_device(struct tty_port *port, struct tty_driver *driver,
> >   		unsigned index);
> >   struct device *tty_port_register_device(struct tty_port *port,
> > @@ -165,6 +166,18 @@ static inline struct tty_port *tty_port_get(struct tty_port *port)
> >   	return NULL;
> >   }
> >   
> > +/*
> > + * Never overwrite the workqueue set by tty_port_link_wq().
> > + * No effect when %TTY_DRIVER_CUSTOM_WORKQUEUE is set, as driver->flip_wq is
> > + * %NULL.
> > + */
> > +static inline void tty_port_link_driver_wq(struct tty_port *port,
> > +					   struct tty_driver *driver)
> > +{
> > +	if (!port->buf.flip_wq)
> > +		port->buf.flip_wq = driver->flip_wq;
> > +}
> > +
> >   /* If the cts flow control is enabled, return true. */
> >   static inline bool tty_port_cts_enabled(const struct tty_port *port)
> >   {
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

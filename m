Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11388C433DB
	for <linux-serial@archiver.kernel.org>; Mon, 28 Dec 2020 17:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D99229C5
	for <linux-serial@archiver.kernel.org>; Mon, 28 Dec 2020 17:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgL1Ri6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Dec 2020 12:38:58 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:54457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgL1Ri5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Dec 2020 12:38:57 -0500
Received: from [192.168.1.167] ([37.4.249.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N1fag-1jsOX310C8-011wS1; Mon, 28 Dec 2020 18:36:09 +0100
Subject: Re: [PATCH] tty: serial: amba-pl011: added RS485 support v2
To:     Ivan Sistik <sistik@3ksolutions.sk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, sbranden@broadcom.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        suravee.suthikulpanit@amd.com, jslaby@suse.com,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
References: <20201228164108.16508-1-sistik@3ksolutions.sk>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdudVBHIHYy
 CgptUUlOQkZ0NmdCTUJFQUN1Yi9wQmV2SHhidkplZnlaRzMySklObW4yYnNFUFgyNVY2ZmVq
 bXlZd21DR0tqRnRMCi9Eb1VNRVZIRHhDSjQ3Qk1YbzM0NGZIVjFDM0FudWRnTjFCZWhMb0J0
 TEh4bW5lQ3pnSDNLY1B0V1c3cHRqNEcKdEp2OUNRRFp5MjdTS29FUHh5YUk4Q0YweWdSeEpj
 NzJNOUk5d21zUFo1YlVIc0x1WVdNcVE3SmNSbVBzNkQ4ZwpCa2srOC95bmdFeU5FeHd4SnBS
 MXlsajVianhXREh5WVF2dUo1THpaS3VPOUxCM2xYVnNjNGJxWEVqYzZWRnVaCkZDQ2svc3lp
 by9ZaHNlOE4rUXN4N01RYWd6NHdLVWtRUWJmWGcxVnFrVG5BaXZYczQyVm5Ja211NWd6SXcv
 MHQKUkp2NTBGUmhIaHhweUtBSThCOG5oTjhRdng3TVZrUGM1dkRmZDN1R1lXNDdKUGhWUUJj
 VXdKd05rLzQ5RjllQQp2ZzJtdE1QRm5GT1JrV1VSdlArRzZGSmZtNitDdk92N1lmUDF1ZXdB
 aTRsbitKTzFnK2dqVklXbC9XSnB5MG5UCmlwZGZlSDlkSGtnU2lmUXVuWWN1Y2lzTXlvUmJG
 OTU1dENna0VZOUVNRWRZMXQ4aUdEaUNnWDZzNTBMSGJpM2sKNDUzdWFjcHhmUVhTYUF3UGtz
 bDhNa0NPc3YyZUVyNElOQ0hZUUR5WmljbEJ1dUNnOEVOYlI2QUdWdFpTUGNRYgplbnpTektS
 Wm9POUNhcUlEK2ZhdkxpQi9kaHptSEErOWJnSWhtWGZ2WFJMRFp6ZThwbzFkeXQzRTFzaFhp
 ZGRaClBBOE51SlZ6RUl0MmxtSTZWOHBaRHBuMjIxcmZLaml2UlFpYW9zNTRUZ1pqak1ZSTdu
 bko3ZTZ4endBUkFRQUIKdENCVGRHVm1ZVzRnVjJGb2NtVnVJRHgzWVdoeVpXNXpkRUJuYlhn
 dWJtVjBQb2tDTndRVEFRZ0FJUVVDWElkYwo0Z0liQXdVTENRZ0hBZ1lWQ0FrS0N3SUVGZ0lE
 QVFJZUFRSVhnQUFLQ1JDVWdld1BFWkR5MjFPVEQvOUdpWkxkCnRSWWNteVJKZ2x0aVFRekFp
 UWRjSUQ3OGxHb1dwL3grci92Y1U2YjZqdVl1ZVR3Z1Iwclc3djdsMklSQnlEN24KSEp4YSt0
 SVNvUVpCZ2hvbE1JZmI5TXRoR09KTENZNzdrL1FoQWhuMzJOR1prZWp3OXR6a3MvNDBtclpT
 VVQ4NApaeWJzUVhyTE0vSFI2VElJL0RlUEIwbktEM0ppcHBzMlVIUUQ5cUQySWpFd1NRUGxI
 akNPckVaaDQ1UFo3bTkrClo5M0x6aVRlc1dabFlRdUxpSndzNHJLcHRIVzFkL3dSZWxzaG1t
 NlFxY0wybDRDL2U0MGVEQjlncTRkU1poOVgKUEVZbGxpeU5RaDdhMkxTZHVtRTFyK2NTd0lq
 RS91ZHRSdmRPOWFLb0psT2JVSzVkTmpTUEg3d0tUYndkWGRZRApHUHdEaFhkNThOQXdyK1BY
 QmxQajB0STFMQ3ErTEJ4ZUt6aFdYK0dWcTlEb2pWanlVREV4Rk5Ga1h1b0M3ZzhtClY5VDB0
 ZUJpdVpSbm91WEt3VjJGcHRaT0hIN0JVRVd0a0t0aGgxZXRmT1dwaWdCemtVN2JQc2ZJWVQr
 cnk5dGIKMW9KK3Y0MVBOYXFaRW1QVXBKeHZmek5UN3Ayd01lRDdaajlmMHJ1YlJQdExBSjJR
 R2pyRkhzdVh3QU9xcHl6ZQoxOEVidHNZazBOMHp1SEVoY2orUEJJQmZoMFlJWWQ1MW9mNkdJ
 aU95UjlxMFhYdHBsVUo3VDIvSDF1UXFrWGxwCitnVzRWa2lmc2NJckl1eWZueFpXMTJlSXZq
 NnlicVdMN2FZS0dZbVQ2aUxDUGJIWXlZY2F5bDRFa0ZjckNGN0UKZTBXVC9zY1ZNaE8vNVgv
 SGFOQTVIQngvcjUycGdMY3Y0aTlNeExRbVUzUmxabUZ1SUZkaGFISmxiaUE4YzNSbApabUZ1
 TG5kaGFISmxia0JwTW5ObExtTnZiVDZKQWpnRUV3RUNBQ0lGQWx0NmdCTUNHd01HQ3drSUJ3
 TUNCaFVJCkFna0tDd1FXQWdNQkFoNEJBaGVBQUFvSkVKU0I3QThSa1BMYmpic1AvamdqYVNz
 NUh0bGtBSXZXUytGcm15N2MKaG5jT0F4TFRWL0Q2UkV3SU95R0poRkt3d29pck55UTJnOXZV
 YTNZQ1lDZjFmSjh3RWhhS09COWQwTHBNUm5MNApkRVQ4ZDgyMzhFL3BLK0hxTktpSXNKaHM2
 SnNLOFpnalZRR3JtbWZua0dyWisxdjBIQnV4ZGljZ0duUC9XdHVBClVsOGw2Mi9BTGJheXlq
 KzYxQ2xyc0V0UklhcU82N0xJWXdQaVBEUkkrWGlNek5pR3pIRi8xUTZHUjAyUkg2YTMKRjg5
 ejhhUHhjSGkxWnZDdDJ5a3o2VUVjaHpQMHI1Z3FGSisvTC9VcHU4ME1YaVk0djVlSWFCNTJn
 VlBnaXlNQQpsTDJkRHMxbUladm5yUkxSWTJ0YjNtQVlOa1Y1QjVJRFQzcGtXeTZrS281T0Nn
 SytZZFlPUjhGTloyb04ydDhPCnJLK1ZudGFLN01NU0tIbG1ZL3NPd3RSbEVoMU9CbXJjQ3dH
 d21wLzA1R2tSNDZmL0lzaFJWZUZPUmF3K0dBcXQKUDIrQ0ZhMkNOQS9JSG5aTm95aWtsRHpQ
 UUhVVUdzck5wcERyaFg5Sm1oQm1nMXYyeXdIMU5YdTFpRGZQMUJBdwpLZ29rdDVmNVVhUkY5
 c0FBNTN2V0V2YlVVTjllZXNGR0x6UFdkSkdRNWhwZC9WSDVJUXk5U0JyaC93SWNla3E1Cm4w
 a042cGJUSHhHRTUyU2kvTVZJa05UdURaM2FwbjJqbERaNHBPdHBCWEkydlAzYlBPK05pcUJa
 anNVM3R4TGkKV2R2MkZqeXp6NlhMUndlV1JZVkw1SGE2TER0eG9yMnZ1NlVQMDdwOXh6MXhS
 WmFPRFczb1lsSEZ6WXBhNFc1ZwpMSGIybEVrSXVVZlNjaWNHYmpqQXRDbFRkR1ZtWVc0Z1Yy
 Rm9jbVZ1SUR4emRHVm1ZVzR1ZDJGb2NtVnVRR2x1CkxYUmxZMmd1WTI5dFBva0NOd1FUQVFn
 QUlRVUNYSWRlaHdJYkF3VUxDUWdIQWdZVkNBa0tDd0lFRmdJREFRSWUKQVFJWGdBQUtDUkNV
 Z2V3UEVaRHkyeUhURC85VUY3UWxEa0d4elE3QWFDSTZOOTVpUWY4LzFvU1VhRE51Mlk2SQpL
 K0R6UXBiMVRiVE9yM1ZKd3dZOGEzT1d6NU5MU09MTVdlVnh0K29zTW1sUUlHdWJEM09EWko4
 aXpQbEcvSnJOCnQ1elNkbU41SUE1ZjNlc1dXUVZLdmdoWkFnVERxZHB2K1pIVzJFbXhuQUox
 dUxGWFhlUWQzVVpjQzVyMy9nL3YKU2FNbzl4ZWszSjVtTnVEbTcxbEVXc0FzL0JBY0ZjK3lu
 TGh4d0JXQld3c3Z3UjhiSHRKNURPTVd2YUt1RHNrcApJR0ZVZS9LYjJCK2pyYXZRM1RuNnMv
 SHFKTTBjZXhTSHo1cGUrMHNHdlArdDlKNzIzNEJGUXdlRkV4cmlleThVCkl4T3I0WEFiYWFi
 U3J5WW5VL3pWSDlVMWkyQUlRWk1XSkFldkN2VmdRL1UrTmVSaFh1ZGU5WVVtRE1EbzJzQjIK
 VkFGRUFxaUYyUVVIUEEybThhN0VPM3lmTDRyTWswaUh6TElLdmg2L3JIOFFDWThpM1h4VE5M
 OWlDTHpCV3UvTgpPbkNBYlMremx2TFphaVNNaDVFZnV4VHR2NFBsVmRFamY2MlArWkhJRDE2
 Z1VEd0VtYXpMQU1yeDY2NmpINWt1ClVDVFZ5bWJMMFR2Qis2TDZBUmw4QU55TTRBRG1rV2tw
 eU0yMmtDdUlTWUFFZlFSM3VXWFo5WWd4YVBNcWJWK3cKQnJoSmc0SGFONkM2eFRxR3YzcjRC
 MmFxYjc3L0NWb1JKMVo5Y3BIQ3dpT3pJYUFtdnl6UFU2TXhDRFhaOEZnWQpsVDR2MjNHNWlt
 SlAyemdYNXMrRjZBQ1VKOVVRUEQwdVRmK0o5RGEycitza2gvc1dPbloreWNvSE5CUXZvY1pF
 Ck5BSFFmN2tDRFFSYmVvQVRBUkFBMkhkMGZzRFZLNzJSTFNESGJ5ME9oZ0RjRGxWQk0yTSto
 WVlwTzNmWDFyKysKc2hpcVBLQ0hWQXNRNWJ4ZTdIbUppbUhhNEtLWXMya3YvbWx0L0NhdUNK
 Ly9wbWN5Y0JNN0d2d25Lem11WHp1QQpHbVZUWkM2V1I1TGtha0ZydEhPelZtc0VHcE52NVJj
 OWw2SFlGcExrYlNrVmk1U1BRWkp5K0VNZ01DRmdqclpmClZGNnlvdHdFMWFmN0hOdE1oTlBh
 TEROMW9VS0Y1aitSeVJnNWl3SnVDRGtuSGp3QlFWNHBndzIvNXZTOEE3WlEKdjJNYlcvVExF
 eXBLWGlmNzhJaGdBelh0RTJYck0xbi9vNlpINzFvUkZGS096NDJsRmR6ZHJTWDBZc3FYZ0hD
 WAo1Z0l0TGZxemoxcHNNYTlvMWVpTlRFbTFkVlFyVHFueXMwbDE4b2FsUk5zd1lsUW1uWUJ3
 cHdDa2FUSExNSHdLCmZHQmJvNWRMUEVzaHRWb3dJNm5zZ3FMVHlRSG1xSFlxVVpZSXBpZ21t
 QzNTd0JXWTFWNmZmVUVta3FwQUFDRW4KTDQvZ1Vnbjd5US81ZDBzZXFuQXEycFNCSE1VVW9D
 Y1R6RVFVV1ZraUR2M1JrN2hURm1oVHNNcTc4eHYyWFJzWApNUjZ5UWhTVFBGWkNZRFVFeEVs
 RXNTbzlGV0hXcjZ6SHlZY2M4cURMRnZHOUZQaG1RdVQyczlCbHg2Z0kzMjNHCm5FcTFsd1dQ
 SlZ6UDRqUWtKS0lBWHdGcHYrVzhDV0xxekRXT3ZkbHJEYVRhVk1zY0ZUZUg1VzZVcHJsNjVq
 cUYKUUdNcGNSR0NzOEdDVVcxM0gwSXlPdFF0d1dYQTRueStTTDgxcHZpQW1hU1hVOGxhS2FS
 dTkxVk9WYUY5ZjRzQQpFUUVBQVlrQ0h3UVlBUUlBQ1FVQ1czcUFFd0liREFBS0NSQ1VnZXdQ
 RVpEeTIrb1hELzljSEhSa0JaT2ZrbVNxCjE0U3Z4MDYyUHRVMEtWNDcwVFNucC9qV29ZSm5L
 SXczRzBtWElSZ3J0SDJkUHdwSWdWanNZeVJTVk1LbVNwdDUKWnJEZjlOdFRiTldnazhWb0xl
 WnpZRW8rSjNvUHFGclRNczNhWVl2N2U0K0pLNjk1WW5tUSttT0Q5bmlhOTE1dApyNUFaajk1
 VWZTVGx5VW15aWMxZDhvdnNmMWZQN1hDVVZSRmNSamZOZkRGMW9ML3BEZ01QNUdaMk93YVRl
 am15CkN1SGpNOElSMUNpYXZCcFlEbUJuVFlrN1B0aHk2YXRXdllsMGZ5L0NxYWpUS3N4Nytw
 OXh6aXU4WmZWWCtpS0IKQ2MrSGUrRURFZEdJRGh2TlovSVFIZk9CMlBVWFdHUytzOUZOVHhy
 L0E2bkxHWG5BOVk2dzkzaVBkWUl3eFM3SwpYTG9LSmVlMTBEamx6c1lzUmZsRk9XMFpPaVNp
 aElDWGlRVjF1cU02dHpGRzlndFJjaXVzNVVBdGhXYU8xT3dVClNDUW1mQ09tNGZ2TUlKSUE5
 cnh0b1M2T3FSUWNpRjNjcm1vMHJKQ3ROMmF3WmZnaThYRWlmN2Q2aGp2MEVLTTkKWFpvaUFa
 WVpEKy9pTG01VGFLV042b0dJdGkwVmpKdjhaWk9aT2ZDYjZ2cUZJa0pXK2FPdTRvclRMRk16
 MjhhbwpVM1F5V3BOQzhGRm1kWXNWdWE4czZnTjFOSWE2eTNxYS9aQjhiQS9pa3k1OUFFejRp
 RElScmdVek1FZzhBazdUCmZtMUtpWWVpVHRCRENvMjVCdlhqYnFzeXhrUUQxbmtSbTZGQVZ6
 RXVPUEllOEp1cVcyeEQ5aXhHWXZqVTVoa1IKZ0pwM2dQNWIrY25HM0xQcXF1UTJFNmdvS1VN
 TEFia0NEUVJiZmw5REFSQUFzRExjYStMbFAydm5mdEVHaHBjQQpCR1ZOUUVGbkdQckNhdVU2
 SGhOODA1V3RQVHRtc1JPdUp6cWdVVDBtcHFXSWZacTZzTXd5dkhLOVRzL0tIM0paClVWYlJD
 M3oyaDNLZmhIL0RhZjk1cGQ2bVBjL2g5dkYvT3kzK2VUV2hnR25QNmNBNWtsUitmTzFXaEc4
 VnJpWHYKck5lUkcyMHN6emplSG9jblNJY1Q1WHVaUjB1REhPaUd4T2l6MXNNUkZUR3h6R095
 MTlSOXJ2dTYzdGlJM2Q3dgpnYzc1T0NBZGtlQi9TZUNFbGFSdzBUZjdMWmJQampzRjI2M0JZ
 bk1mNGtrTkVLdnFXY1UyaWNNcCtxZXpqeW5CCnB2ZXVlMHJDVFFCWUFRbG9GQ1ZUR0hyV1dB
 NkQ0VzVPMkFmSWRJYzF1MUpDWnAyZjVMV1ZvVUZUVklyUW5RUVUKU0hDaWZyOU1aeExUdFBK
 ZFU1Mm9TUHczZGs0aExQOGlKSUx1dnYvYXZhakNzUVlIRXR3WXNiZUZaeGl1TGdscApBN1lj
 Sk5ObXBnQ3BNRDR3VWh2bEN0QUtOQlFXeXIyOTc2OThFUVRuNDZlQmVVNkttMkNpaFhrZ3dD
 eWY4ZXlLCkxFM3NYZXdhcTVrZ1pXdk5xNml1NXFZSVJCOXl3K2NYYzYwZE9aRE9scTkzWDVT
 QVJZemFvZXBrSHo0cmtMa1AKUG8rdENIeUhRUHNHblBYYzlXVDgwREM5Tm5KR2R2VWx5NXJk
 TUk0eHBaeWdlb2tqd293VlFsUFV1Y1M2TXluNwpmOHc4Y2dmQjdDMklBSWNEeDJwUC9IendY
 dmtDT1FOQTdtVjFsTTA4bitnVmtUcnpweGlwNURicTRDSW9ZeDJNCkpaVDhiR1JINlhqY1VE
 S2EwOVFoeVpzQUVRRUFBWWtFUkFRWUFRZ0FEd1VDVzM1ZlF3SWJBZ1VKQThKbkFBSXAKQ1JD
 VWdld1BFWkR5MjhGZElBUVpBUWdBQmdVQ1czNWZRd0FLQ1JCVnhETFBjVk1NamNkc0QvMFJo
 QXN1UVlPeQpyMTNCbDNOaFhrWUFaR3AyWkZER3VrZTdPU2tWOG9qT09UZFR5ei9jT1JHQ2J5
 ZEQrRGd2cUZ5VmRuT1hLZ08wCmxKbUd3ckdlTGRnZ0F2aDBpaHJwNU8wWVVKOWJCU1htR01t
 UVRZSC9BbUxUR2FkYnVqQ1dqNWZGVWtDeXd4aW0KSHV5MFBiMjRwelR2UzUwR1k1WStxSDBG
 SE5haWdka2tpV04zcnVnN0haRXUvQ3lsUFpqT1h6K0QxUVBNckV4dwo3ZC9NS2FiVis5YU5i
 UVlabGRJajk4UXd2VUYxS1N6YThqbFVJdnBoUnEyN0FUOGZER1lHUGZERU1nMmNCT2FlCkty
 N29uUXM0YjdhV082aWZEbHhRVHB6c3pvK0FuODA3Tk1TdFZFRmYrczNBaFZEM2U3bmY4SkJh
 dmJWckFlMGsKb20yNm96elBubnh6K2xxVlZ0dzZVazRYTUl6dGl4L0h3SFl3dUNuY1VYWndL
 MEkzeUFKd2pZd29vck9DaEozUwpFVWJKUVB0R3NneFJERXhWQkZlNk5MUC82MnhQOU82dGFj
 d09kYjBNbVAxYjM5cFJBVEM3YmdkMWxkVUxpNzVaCmxKckowL1NpVkVyb3FOWXk3OXRmbWdB
 WjJVeFptczlTckV5Nm85UVNmc24xYVh2K01QTDlKYUNHbWtQNnpiTFEKTm5kajBKY2FRbmtD
 MHZneWRPMUJtNk11OTZQOXVmbEtaY0FTNndtTE01SWRIT3lqTDg4d0h3anVjakFPQnRjdwpw
 MG9HVG5WT25Sc05ZU084VzhZWi9LZGJ1Nzg1ZGF6TXFKMmlOakFEdUJiZG02TjRqNUVkTW5r
 TG4wQklmUEpwCmRnbTR2bDJVcExqd1JHci9NM3dtbTVwdnMrNnVCN2hrL0ZKaUQvNGxsRU5Q
 NGVNMWg3U200aitWcTZOMSt6VEIKSVhKQWViSXFhc0RwNXlaUzdYcnk0STM2bjg1WEVZZkcw
 MWx0QXlob05WMkRPOFNJUlFwdWkydHErOVJQM1JLMQpKREJ4eEVKWTJFTzVKWjhNeGFQSFEw
 RFQwNWxSRmpLMkFsaGRFSXRqTGpwSjNmVW05c3FMeE1XeHpQNlV6M2lpCjJ1YTR1bnJ0Nk9D
 VHFRd2lqRi8zYlRXaXd2VkFBSG5NRlVpb1hzaEhhb2hWRGNWZm5lSU1mVjBiUUNYWWkzTnAK
 WTB2MFp3Y2lGSCtnU0M3cUQ2WE51aHBWR1NMNElpbGlGeS9TemNhSkV6QUhlTERTaFpQMkNX
 ZG5DNHZnbDM3dApocHg4aDU1WWhKbjZIU3VVelBnaGFLdFZCMmsrajdaZXlaK1NGeHA3SXVi
 SEN3TEhsUWhUNzVSd1EzaUF4S242CjBxajUxY1lUbnF4ZFpYVzZmSDNQa3VNellVNUdwcVIv
 MU9sNWMvd2ZJNmc2QW04eUtXLzBFVUx0K0tuNExGc1MKbTdZM201SDV2MTJVNkpCWXZWK3Ix
 M2paaW9zNEVFREU5M0Q1c05IMk1JeVJ6Q0RxMXpkZHQ0WHV5S0ZqUEtXMQo5aWJaRGZGVjdL
 dUNzdnVMMjNzQmMxc0NNb3ArRTFtVC9ReE9JQTZvRFQxTVFzdHdPVnVReURDdi9PdktTZ2Z6
 CjhGWEdMNkFQY2xqQ3FqOEFKaHhReXN4ZG9pUVA4bS92dStialdHR3Z4dzVzMWxncGlSRFRS
 VVBnY0pKTmFHWTIKVklEclpRaTROU2lOUTBOSWkrZGp1NGZOTW1DcFFxZzh0YkMzY0FhNnl3
 bTZvUUIxU0JobURYMmUxMWdSbGx1SQpPblRHUEUwSFRvM2w3MmxoYmc9PQo9cVpNVgotLS0t
 LUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
Message-ID: <a8b7492c-3724-fd14-9923-473ec3fe221f@i2se.com>
Date:   Mon, 28 Dec 2020 18:36:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201228164108.16508-1-sistik@3ksolutions.sk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:z6OLQhOOywwzp5RcIy2LbGZdNt+A9PCXd06B6dEIy0JGM+ydau4
 WWBJYViZsT7nnXWJdCa9v1Dp/sk9GSBQWV270HOCOr43MXJSwm9I1BymNFD602AZ0+HP2oW
 J3kMGUGakv8GpfPWCivyjH5WwfcDHXGG/lFc8KVmm1eeNYeTkO9jOJZOLjrjuZqhpKc95F0
 iAjqIB2aLdtTPU+JC6PFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uFDJhqbrEUI=:XRCp1xRlgLsAY8U/IVK8Kc
 czBqhJpY7VuDe0uDgl7qxDRlFSIBsOKOacOjvD02pCFKx4J74K7lCpsNRgFN3kNnOaTDEMA84
 M6zi5ZQu8agCIB/SVZEYwazcHuxqN5na/0rkeeFa4VRnfjF6+GyRE/AyI5HFNoDym/2Jw8f9O
 YcE+sxRz7PqJfET9r2u9T33Dwxyz2Nq+hZq4vuTRFJBITAksazTyGrzgzDldQfGQ+w/zPD84K
 SYFhNWj7KCV7Eg0apvE6pFX7m06htXJKvipbrAfKIQyzvGAjBLAH0VozEedZdHcLxK4zN7AKL
 eeUCs5lFdMLOhbkAEr6T/U879itw/TXUqLmnGiIG2HdgJf+Rd6N4w+TGL2hFhO5Fcdsw/pdSy
 ZlrNylhbH+Lmgdn0Gw9o9k4LGV4xGecTEVBNpZlWWsTarjTo1j3OmfBKNtM7mTb2bvL9xH3ui
 93fzgMFJWw==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Ivan,

please place the patch version between [ ... ] in the subject.

Am 28.12.20 um 17:41 schrieb Ivan Sistik:
> AMBA PL011 do not have hardware support for RS485. This implementation is
> for drive enable signal (DE), which switch direction of RS485 driver chip.
> This signal si drived by RTS pin. Correct multiplexor settings have to be
> provided to Device Tree. Usually it is 'ctsrts', which is used for enabling
> of HW flow control, too.
>
> DE signal is switched by starting transmition from serial core and data
> transfer is initiated by first hrtimer if there is delay before send
> enabled.
>
> There is missing FIFO empty interrupt in PL011. It is replaced by second
> hrtimer which is started if there are no more data in port transmit buffer.
> Notice that port transmit buffer is not the same as HW TX FIFO. Time of
> this timmer is set to char send time and it is running until fifo is empty.
> This kind of implementation cause that there can be unwanted delay of one
> timer tick before DE signal is switched. This is used to prevent data loss
> during transmit. Second timer can start first if there is delay after send
> enabled.
>
> Signed-off-by: Ivan Sistik <sistik@3ksolutions.sk>
> ---
>
> Notes:
>     This patch is ported and corrected version of my previous patch which can
>     be reviewed here:
>     https://lore.kernel.org/lkml/20200106235203.27256-1-sistik@3ksolutions.sk/
>     
>     I have been waiting for some time to see if Lukas Wunner <lukas@wunner.de>
>     will create patch with his own solution.
>     
>     Now I am successfully running my imeplementation for almost one year in
>     production environment. There are no problems with it.
Can you please tell which exact platform / config template has been tested?
>  I have made
>     corrections to patch according to notes from Greg Kroah-Hartman
>     <gregkh@linuxfoundation.org>.
>
>  arch/arm/configs/bcm2835_defconfig |   1 +
>  drivers/tty/serial/Kconfig         |  11 +
>  drivers/tty/serial/amba-pl011.c    | 474 ++++++++++++++++++++++++++++-
>  3 files changed, 483 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
> index 519ff58e6..c2f630937 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -86,6 +86,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
>  CONFIG_SERIAL_8250_BCM2835AUX=y
>  CONFIG_SERIAL_AMBA_PL011=y
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> +CONFIG_SERIAL_AMBA_PL011_SOFT_RS485=y
>  CONFIG_SERIAL_DEV_BUS=y
>  CONFIG_TTY_PRINTK=y
>  CONFIG_I2C_CHARDEV=y
This change is fine, but must be a separate patch. In this case, you can
move all your notes and patch changelog in the cover letter.
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index a9751a83d..c33461511 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -75,6 +75,17 @@ config SERIAL_AMBA_PL011_CONSOLE
>  	  your boot loader (lilo or loadlin) about how to pass options to the
>  	  kernel at boot time.)
>  
> +config SERIAL_AMBA_PL011_SOFT_RS485
> +	bool "RS485 software direction switching for ARM AMBA PL011 serial"
> +	depends on SERIAL_AMBA_PL011=y
> +	help
> +	  Enable RS485 software direction switching of driver enable (RTS pin)
> +	  for ARM AMBA PL011 serial. AMBA PL011 does not have HW support for
> +	  RS485. This driver use 2 hrtimers. One is used for rs485 delays.
> +	  Secon one is used for polling of TX FIFO. There is not TX FIFO
Secon +d?
> +	  empty interrupt in PL011. Secondary timer is started by empty
> +	  transmit buffer.
> +
>  config SERIAL_EARLYCON_ARM_SEMIHOST
>  	bool "Early console using ARM semihosting"
>  	depends on ARM64 || ARM
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 16720c97a..f45b9042b 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -46,6 +46,7 @@
>  #include <linux/sizes.h>
>  #include <linux/io.h>
>  #include <linux/acpi.h>
> +#include <linux/math64.h>
>  
>  #include "amba-pl011.h"
>  
> @@ -60,6 +61,18 @@
>  #define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
>  #define UART_DUMMY_DR_RX	(1 << 16)
>  
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
Please try to reduce the amout of these ifdefs. It makes the code harder
to maintain.
> +/*
> + * Enum with current status
> + */
> +enum rs485_status {
> +	rs485_receiving,
> +	rs485_delay_before_send,
> +	rs485_sending,
> +	rs485_delay_after_send
> +};
> +#endif
> +
>  static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
>  	[REG_DR] = UART01x_DR,
>  	[REG_FR] = UART01x_FR,
> @@ -270,6 +283,16 @@ struct uart_amba_port {
>  	unsigned int		old_cr;		/* state during shutdown */
>  	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
>  	char			type[12];
> +
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	enum rs485_status	rs485_current_status; /* status used for RTS */
> +	enum rs485_status	rs485_next_status; /* this status after tick */
> +	struct hrtimer		rs485_delay_timer;
> +	struct hrtimer		rs485_tx_empty_poll_timer;
> +	unsigned long		send_char_time;	/* send char (nanoseconds) */
> +	bool			rs485_last_char_sending;
> +#endif
> +
>  #ifdef CONFIG_DMA_ENGINE
>  	/* DMA stuff */
>  	bool			using_tx_dma;
> @@ -280,6 +303,25 @@ struct uart_amba_port {
>  #endif
>  };
>  
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +
> +static void pl011_rs485_start_rts_delay(struct uart_amba_port *uap);
> +
> +#define RS485_SET_RTS_SIGNAL(pUAP, value)		\
> +	do {						\
> +		unsigned int rts_temp_cr;		\
> +		rts_temp_cr = pl011_read(pUAP, REG_CR);	\
> +		if (!(value))				\
> +			rts_temp_cr |= UART011_CR_RTS;	\
> +		else					\
> +			rts_temp_cr &= ~UART011_CR_RTS;	\
> +		pl011_write(rts_temp_cr, pUAP, REG_CR);	\
> +	} while (0)
Please make this a function
> +
> +#define RS485_TX_FIFO_EMPTY(pUAP)			\
> +	(pl011_read(pUAP, REG_FR) & UART011_FR_TXFE)
> +#endif
> +
>  static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
>  	unsigned int reg)
>  {
> @@ -1301,6 +1343,11 @@ static void pl011_stop_tx(struct uart_port *port)
>  	uap->im &= ~UART011_TXIM;
>  	pl011_write(uap->im, uap, REG_IMSC);
>  	pl011_dma_tx_stop(uap);
> +
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	if (uap->port.rs485.flags & SER_RS485_ENABLED)
> +		pl011_rs485_start_rts_delay(uap);
> +#endif
>  }
>  
>  static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
> @@ -1319,8 +1366,123 @@ static void pl011_start_tx(struct uart_port *port)
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
>  
> -	if (!pl011_dma_tx_start(uap))
> -		pl011_start_tx_pio(uap);
> +#define START_PL011_TX()				\
> +	do {						\
> +		if (!pl011_dma_tx_start(uap))		\
> +			pl011_start_tx_pio(uap);	\
> +	} while (0)
> +
> +#ifndef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	START_PL011_TX();
> +#else
> +
> +#define CANCEL_RS485_TIMERS()						 \
> +	do {								 \
> +		hrtimer_try_to_cancel(&(uap->rs485_delay_timer));	 \
> +		hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));\
> +	} while (0)
> +
> +	if (uap->port.rs485.flags & SER_RS485_ENABLED) {
> +		ktime_t ktime;
> +
> +		switch (uap->rs485_current_status) {
> +		case rs485_delay_after_send:
> +			/* stop old delay timer */
> +			CANCEL_RS485_TIMERS();
> +
> +			/* check if timer expired */
> +			if (uap->rs485_current_status
> +					!= rs485_delay_after_send) {
> +				/* Timer expired and RTS is in wrong state.*/
> +				uap->rs485_current_status
> +					= rs485_delay_before_send;
> +				uap->rs485_next_status = rs485_sending;
> +
> +				/* Set RTS */
Please avoid obvious comments
> +				RS485_SET_RTS_SIGNAL(uap,
> +					uap->port.rs485.flags
> +						& SER_RS485_RTS_ON_SEND);
> +
> +				/* Start timer */
> +				ktime = ktime_set(0,
> +					  uap->port.rs485
> +						.delay_rts_before_send
> +					  * 1000000L);
> +
> +				hrtimer_start(
> +					&(uap->rs485_delay_timer),
> +					ktime,
> +					HRTIMER_MODE_REL);
> +				return;
> +			}
> +
> +			/* timer was stopped and driver can continue sending */
> +			uap->rs485_current_status = rs485_sending;
> +			uap->rs485_next_status = rs485_sending;
> +
> +			/* driver is already in sending state */
> +			START_PL011_TX();
> +			break;
> +
> +
> +		case rs485_sending:
> +			/* stop old timer. There can be running timer	*/
> +			/* which is checking TX FIFO empty flag		*/
> +			CANCEL_RS485_TIMERS();
> +
> +			/* driver is already in sending state */
> +			START_PL011_TX();
> +			break;
> +
> +		case rs485_receiving:
> +		default:
> +			/* stop old timer. There can be running timer	*/
> +			/* which is checking TX FIFO empty flag		*/
> +			CANCEL_RS485_TIMERS();
> +
> +			/* Set RTS */
> +			RS485_SET_RTS_SIGNAL(uap,
> +				     uap->port.rs485.flags
> +					     & SER_RS485_RTS_ON_SEND);
> +
> +			if (uap->port.rs485.delay_rts_before_send == 0) {
> +				/* Change state */
> +				uap->rs485_current_status
> +					= rs485_sending;
> +				uap->rs485_next_status
> +					= rs485_sending;
> +
> +				/* driver is in sending state */
> +				START_PL011_TX();
> +				break;
> +			}
> +
> +			/* Change state */
> +			uap->rs485_current_status
> +				= rs485_delay_before_send;
> +			uap->rs485_next_status = rs485_sending;
> +
> +			/* Start timer */
> +			ktime = ktime_set(0,
> +				  uap->port.rs485.delay_rts_before_send
> +				  * 1000000L);
> +			hrtimer_start(&(uap->rs485_delay_timer),
> +				ktime,
> +				HRTIMER_MODE_REL);
> +			break;
> +
> +		case rs485_delay_before_send:
> +			/* do nothing because delay timer should be running */
> +			break;
> +		}
> +	} else {
> +		START_PL011_TX();
> +	}
> +#undef CANCEL_RS485_TIMERS

Please make this also a function

> +
> +#endif
> +
> +#undef START_PL011_TX
>  }
>  
>  static void pl011_stop_rx(struct uart_port *port)
> @@ -1476,6 +1638,169 @@ static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
>  	dummy_read = pl011_read(uap, REG_ICR);
>  }
>  
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +
> +/*
> + * Change state according to pending delay
> + * Locking: port is locked in this function
> + */
> +static enum hrtimer_restart
> +pl011_rs485_tx_poll_timer(struct hrtimer *timer)
> +{
> +	unsigned long flags;
> +	ktime_t ktime;
> +
> +	struct uart_amba_port *uap =
> +		container_of(timer, struct uart_amba_port,
> +			     rs485_tx_empty_poll_timer);
> +
> +	spin_lock_irqsave(&uap->port.lock, flags);
> +
> +	if (!(uart_circ_empty(&uap->port.state->xmit))) {
> +		spin_unlock_irqrestore(&uap->port.lock, flags);
> +		return HRTIMER_NORESTART;
> +	}
> +
> +	if (!RS485_TX_FIFO_EMPTY(uap) || !uap->rs485_last_char_sending) {
> +		/*
> +		 *  FIFO is empty but there is last char in transmit shift
> +		 * register so we need one more tick
> +		 */
> +		uap->rs485_last_char_sending = RS485_TX_FIFO_EMPTY(uap);
> +
> +		hrtimer_forward_now(timer, ktime_set(0, uap->send_char_time));
> +
> +		spin_unlock_irqrestore(&uap->port.lock, flags);
> +		return HRTIMER_RESTART;
> +	}
> +
> +	/* Check if delay after send is set*/
> +	if (uap->port.rs485.delay_rts_after_send == 0) {
> +		/* Change state */
> +		uap->rs485_current_status = rs485_receiving;
> +		uap->rs485_next_status = rs485_receiving;
> +
> +		/* if there is no delay after send change RTS value*/
> +		RS485_SET_RTS_SIGNAL(uap,
> +			     uap->port.rs485.flags
> +				     & SER_RS485_RTS_AFTER_SEND);
> +
> +		spin_unlock_irqrestore(&uap->port.lock, flags);
> +		return HRTIMER_NORESTART;
> +	}
> +
> +	/* Change state */
> +	uap->rs485_current_status = rs485_delay_after_send;
> +	uap->rs485_next_status = rs485_receiving;
> +
> +	/* RTS will be set in timer handler */
> +
> +	/* Start delay timer */
> +	ktime = ktime_set(0, (uap->port.rs485.delay_rts_after_send
> +			* 1000000L));
> +	hrtimer_start(&(uap->rs485_delay_timer), ktime, HRTIMER_MODE_REL);
> +
> +	spin_unlock_irqrestore(&uap->port.lock, flags);
> +	return HRTIMER_NORESTART;
> +}
> +
> +/*
> + * Change state according to pending delay
> + * Locking: port is locked in this function
> + */
> +static enum hrtimer_restart
> +pl011_rs485_timer(struct hrtimer *timer)
> +{
> +	unsigned long flags;
> +
> +	struct uart_amba_port *uap =
> +		container_of(timer, struct uart_amba_port, rs485_delay_timer);
> +
> +	spin_lock_irqsave(&uap->port.lock, flags);
> +
> +	if (uap->rs485_current_status == uap->rs485_next_status) {
> +		/* timer was canceled or handled */
> +		spin_unlock_irqrestore(&uap->port.lock, flags);
> +		return HRTIMER_NORESTART;
How about moving the two statements at the end of the function, use a
goto here ...
> +	}
> +
> +	switch (uap->rs485_current_status) {
> +	case rs485_delay_before_send:
> +		uap->rs485_current_status = rs485_sending;
> +		uap->rs485_next_status = rs485_sending;
> +		if (!pl011_dma_tx_start(uap))
> +			pl011_start_tx_pio(uap);
> +
> +		spin_unlock_irqrestore(&uap->port.lock, flags);
> +		return HRTIMER_NORESTART;
> +
> +	case rs485_delay_after_send:
> +		uap->rs485_current_status = rs485_receiving;
> +		uap->rs485_next_status = rs485_receiving;
> +		RS485_SET_RTS_SIGNAL(uap,
> +			     uap->port.rs485.flags
> +				     & SER_RS485_RTS_AFTER_SEND);
> +
> +		spin_unlock_irqrestore(&uap->port.lock, flags);
> +		return HRTIMER_NORESTART;
> +
> +	default:
> +		spin_unlock_irqrestore(&uap->port.lock, flags);
> +		return HRTIMER_NORESTART;
> +	}
and simplify all switch cases here.
> +}
> +
> +/*
> + * Evaluate transmit buffer status and start delay to off
> + * Locking: called with port lock held and IRQs disabled
> + */
> +static void pl011_rs485_start_rts_delay(struct uart_amba_port *uap)
> +{
> +	ktime_t ktime;
> +
> +	if (uap->rs485_current_status == rs485_receiving)
> +		return;
> +
> +	/* if there is timeout in progress cancel it and start new */
> +	hrtimer_try_to_cancel(&(uap->rs485_delay_timer));
> +	hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));
> +
> +
> +	if (!RS485_TX_FIFO_EMPTY(uap)
> +			|| uap->port.rs485.delay_rts_after_send == 0) {
> +		/*
> +		 * Schedule validation timer if there is data in TX FIFO
> +		 * because there is not TX FIFO empty interrupt
> +		 */
> +
> +		uap->rs485_current_status = rs485_sending;
> +		uap->rs485_next_status = rs485_sending;
> +
> +		uap->rs485_last_char_sending = false;
> +
> +		ktime = ktime_set(0, uap->send_char_time);
> +		hrtimer_start(&(uap->rs485_tx_empty_poll_timer),
> +			ktime,
> +			HRTIMER_MODE_REL);
> +		return;
> +	}
> +
> +	/* Change state */
> +	uap->rs485_current_status = rs485_delay_after_send;
> +	uap->rs485_next_status = rs485_receiving;
> +
> +	/* RTS will be set in timer handler */
> +
> +	/* Start timer */
> +	ktime = ktime_set(0, (uap->port.rs485.delay_rts_after_send
> +			* 1000000L));
> +
> +	hrtimer_start(&(uap->rs485_delay_timer),
> +		ktime,
> +		HRTIMER_MODE_REL);
> +}
> +#endif
> +
>  static irqreturn_t pl011_int(int irq, void *dev_id)
>  {
>  	struct uart_amba_port *uap = dev_id;
> @@ -1499,9 +1824,11 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
>  				else
>  					pl011_rx_chars(uap);
>  			}
> +
>  			if (status & (UART011_DSRMIS|UART011_DCDMIS|
>  				      UART011_CTSMIS|UART011_RIMIS))
>  				pl011_modem_status(uap);
> +
>  			if (status & UART011_TXIS)
>  				pl011_tx_chars(uap, true);
>  
> @@ -1618,6 +1945,11 @@ static void pl011_quiesce_irqs(struct uart_port *port)
>  	 */
>  	pl011_write(pl011_read(uap, REG_IMSC) & ~UART011_TXIM, uap,
>  		    REG_IMSC);
> +
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	if (uap->port.rs485.flags & SER_RS485_ENABLED)
> +		pl011_rs485_start_rts_delay(uap);
> +#endif
>  }
>  
>  static int pl011_get_poll_char(struct uart_port *port)
> @@ -1690,6 +2022,27 @@ static int pl011_hwinit(struct uart_port *port)
>  		if (plat->init)
>  			plat->init();
>  	}
> +
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	/*
> +	 * Initialize timers used for RS485
> +	 */
> +	hrtimer_init(&(uap->rs485_delay_timer),
> +		CLOCK_MONOTONIC,
> +		HRTIMER_MODE_REL);
> +
> +	uap->rs485_delay_timer.function = &pl011_rs485_timer;
> +
> +	hrtimer_init(&(uap->rs485_tx_empty_poll_timer),
> +		CLOCK_MONOTONIC,
> +		HRTIMER_MODE_REL);
> +
> +	uap->rs485_tx_empty_poll_timer.function = &pl011_rs485_tx_poll_timer;
> +
> +	uap->rs485_current_status = rs485_receiving;
> +	RS485_SET_RTS_SIGNAL(uap, false);
> +#endif
> +
>  	return 0;
>  }
>  
> @@ -1873,6 +2226,16 @@ static void pl011_shutdown(struct uart_port *port)
>  	struct uart_amba_port *uap =
>  		container_of(port, struct uart_amba_port, port);
>  
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	if (uap->port.rs485.flags & SER_RS485_ENABLED) {
> +		hrtimer_try_to_cancel(&(uap->rs485_delay_timer));
> +		hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));
> +
> +		uap->rs485_current_status = rs485_receiving;
> +		RS485_SET_RTS_SIGNAL(uap, true);
> +	}
> +#endif
> +
>  	pl011_disable_interrupts(uap);
>  
>  	pl011_dma_shutdown(uap);
> @@ -1955,6 +2318,24 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>  	unsigned long flags;
>  	unsigned int baud, quot, clkdiv;
>  
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	unsigned int transfer_bit_count;
> +	unsigned long char_transfer_time;
> +
> +	/*
> +	 * Calculate bit count which will be send
> +	 * by UART. It is used for calculation of
> +	 * time required to start timer until TX FIFO (HW) is empty
> +	 * There is not interrupt for FIFO empty in PL011.
> +	 * There is only FIFO empty flag in REG_FR.
> +	 */
> +	transfer_bit_count = 0;
> +
> +#define	ADD_DATA_BITS(bits)	(transfer_bit_count += bits)
> +#else
> +#define	ADD_DATA_BITS(bits)
> +#endif
> +
>  	if (uap->vendor->oversampling)
>  		clkdiv = 8;
>  	else
> @@ -1981,29 +2362,53 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>  	switch (termios->c_cflag & CSIZE) {
>  	case CS5:
>  		lcr_h = UART01x_LCRH_WLEN_5;
> +		ADD_DATA_BITS(7);
>  		break;
>  	case CS6:
>  		lcr_h = UART01x_LCRH_WLEN_6;
> +		ADD_DATA_BITS(8);
>  		break;
>  	case CS7:
>  		lcr_h = UART01x_LCRH_WLEN_7;
> +		ADD_DATA_BITS(9);
>  		break;
>  	default: // CS8
>  		lcr_h = UART01x_LCRH_WLEN_8;
> +		ADD_DATA_BITS(10);
>  		break;
>  	}
> -	if (termios->c_cflag & CSTOPB)
> +
> +	if (termios->c_cflag & CSTOPB) {
>  		lcr_h |= UART01x_LCRH_STP2;
> +		ADD_DATA_BITS(1);
> +	}
> +
>  	if (termios->c_cflag & PARENB) {
>  		lcr_h |= UART01x_LCRH_PEN;
> +		ADD_DATA_BITS(1);
> +
>  		if (!(termios->c_cflag & PARODD))
>  			lcr_h |= UART01x_LCRH_EPS;
> +
>  		if (termios->c_cflag & CMSPAR)
>  			lcr_h |= UART011_LCRH_SPS;
>  	}
> +
> +#undef ADD_DATA_BITS
> +
>  	if (uap->fifosize > 1)
>  		lcr_h |= UART01x_LCRH_FEN;
>  
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	/* Calculate time required to send one char (nanoseconds) */
> +	char_transfer_time =
> +		(unsigned long) div_u64(
> +				mul_u32_u32(
> +					(u32)transfer_bit_count,
> +					(u32)NSEC_PER_SEC),
> +				(u32)baud);
> +#endif
> +
>  	spin_lock_irqsave(&port->lock, flags);
>  
>  	/*
> @@ -2020,6 +2425,11 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>  	old_cr = pl011_read(uap, REG_CR);
>  	pl011_write(0, uap, REG_CR);
>  
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	/* Update send_char_time in locked context */
> +	uap->send_char_time = char_transfer_time;
> +#endif
> +
>  	if (termios->c_cflag & CRTSCTS) {
>  		if (old_cr & UART011_CR_RTS)
>  			old_cr |= UART011_CR_RTSEN;
> @@ -2091,6 +2501,7 @@ static const char *pl011_type(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +
Please avoid unrelated whitespace changes
>  	return uap->port.type == PORT_AMBA ? uap->type : NULL;
>  }
>  
> @@ -2122,6 +2533,47 @@ static void pl011_config_port(struct uart_port *port, int flags)
>  	}
>  }
>  
> +/*
> + * Configure RS485
> + * Locking: called with port lock held and IRQs disabled
> + */
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +static int pl011_config_rs485(struct uart_port *port,
> +			      struct serial_rs485 *rs485)
> +{
> +	bool was_disabled;
> +	struct uart_amba_port *uap =
> +			container_of(port, struct uart_amba_port, port);
> +
> +	was_disabled = !(port->rs485.flags & SER_RS485_ENABLED);
> +
> +	port->rs485.flags = rs485->flags;
> +	port->rs485.delay_rts_after_send = rs485->delay_rts_after_send;
> +	port->rs485.delay_rts_before_send = rs485->delay_rts_before_send;
> +
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		unsigned int cr;
> +
> +		hrtimer_try_to_cancel(&(uap->rs485_delay_timer));
> +		hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));
> +
> +		/* If RS485 is enabled, disable auto RTS */
> +		cr = pl011_read(uap, REG_CR);
> +		cr &= ~UART011_CR_RTSEN;
> +		pl011_write(cr, uap, REG_CR);
> +
> +		uap->rs485_current_status = rs485_receiving;
> +		RS485_SET_RTS_SIGNAL(uap,
> +			     port->rs485.flags
> +				     & SER_RS485_RTS_AFTER_SEND);
> +	} else {
> +		RS485_SET_RTS_SIGNAL(uap, true);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  /*
>   * verify the new serial_struct (for TIOCSSERIAL).
>   */
> @@ -2647,6 +3099,12 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  	uap->port.irq = dev->irq[0];
>  	uap->port.ops = &amba_pl011_pops;
>  
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	uap->port.rs485_config = &pl011_config_rs485;
> +	uap->port.rs485.flags = 0;	/* RS485 is not enabled by default */
> +	dev_info(&dev->dev, "Software switching for RS485 enabled\n");
> +#endif
> +
>  	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
>  
>  	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
> @@ -2819,10 +3277,15 @@ static struct amba_driver pl011_driver = {
>  
>  static int __init pl011_init(void)
>  {
> +#ifndef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
>  	printk(KERN_INFO "Serial: AMBA PL011 UART driver\n");
> +#else
> +	printk(KERN_INFO "Serial: AMBA PL011 UART driver with soft RS485 support\n");
> +#endif

I think one log message about RS485 support is enough, so please drop
the new dev_info above. An alternative solution for this ifdef could be
the usage of IS_ENABLED()

Thanks
Stefan

>  
>  	if (platform_driver_register(&arm_sbsa_uart_platform_driver))
>  		pr_warn("could not register SBSA UART platform driver\n");
> +
>  	return amba_driver_register(&pl011_driver);
>  }
>  
> @@ -2832,6 +3295,11 @@ static void __exit pl011_exit(void)
>  	amba_driver_unregister(&pl011_driver);
>  }
>  
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +#undef RS485_SET_RTS_SIGNAL
> +#undef RS485_TX_FIFO_EMPTY
> +#endif
> +
>  /*
>   * While this can be a module, if builtin it's most likely the console
>   * So let's leave module_exit but move module_init to an earlier place


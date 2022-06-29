Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E3C43334
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jun 2022 00:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiF2Acw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 20:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiF2Acv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 20:32:51 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F12E2DD67
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 17:32:50 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220629003247epoutp02ab0d5cab51a86e3dbe229514d495151d~88Bxa1ILI1548015480epoutp02x
        for <linux-serial@vger.kernel.org>; Wed, 29 Jun 2022 00:32:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220629003247epoutp02ab0d5cab51a86e3dbe229514d495151d~88Bxa1ILI1548015480epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656462767;
        bh=ofVAh8MVafb5k8TnL4zE4vslop8U8RPb3cE8H73vFP8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rxECzpa2vQLikBCOLBA3klZmApYvUlUzCM+GOUnoQkOvM2KIyD/l5PMNnjQfnel+h
         hB2TvbY4Uwcwd3jfiWyCQqeKe13YN+eLtfapMXfeZ6AIxHYJVMuBw2ka7h3ord2RkC
         veomcB3uxGfvX/HjGjKz6ja3/Z0WFalQVOLimgV0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220629003246epcas2p4ac444e7761a42a9875b7d056dea915f9~88Bw15eil0753607536epcas2p47;
        Wed, 29 Jun 2022 00:32:46 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LXj9B3qGDz4x9Q2; Wed, 29 Jun
        2022 00:32:46 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.86.09642.EAD9BB26; Wed, 29 Jun 2022 09:32:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220629003245epcas2p14039a5884417006d032849b2cef82e70~88Bv1jyt20897208972epcas2p1x;
        Wed, 29 Jun 2022 00:32:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220629003245epsmtrp21a4e18658e68c53f9093f3d6074652ad~88Bv0thvz1059210592epsmtrp2K;
        Wed, 29 Jun 2022 00:32:45 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-f0-62bb9dae97fc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.9C.08905.DAD9BB26; Wed, 29 Jun 2022 09:32:45 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220629003245epsmtip13e51c41f9466c06976b06d1df1b627d4~88BvmdQ5k2377023770epsmtip1O;
        Wed, 29 Jun 2022 00:32:45 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Jiri Slaby'" <jirislaby@kernel.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Hector Martin'" <marcan@marcan.st>,
        "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'Vincent Whitchurch'" <vincent.whitchurch@axis.com>,
        =?iso-8859-1?Q?'Ilpo_J=E4rvinen'?= <ilpo.jarvinen@linux.intel.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <YrsHaUqM03I6I9Om@kroah.com>
Subject: RE: [PATCH v2] tty: serial: samsung_tty: loopback mode support
Date:   Wed, 29 Jun 2022 09:32:45 +0900
Message-ID: <012501d88b4f$c08a5c80$419f1580$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQLQReUt4gszEHpOmY4yS3t4neww3AL4ITK4AbqNgIOrUH2AoA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmue66ubuTDDYclLV4MG8bm0Xz4vVs
        Fp07elgsdjQcYbV4N1fGYu/rrewWmx5fY7WYcX4fk8WZxb3sFqevLWC3OL/N34Hb4/q6AI9N
        qzrZPO5c28PmMe9koMf+uWvYPTYvqfdYvGwnm0ffllWMHp83yQVwRmXbZKQmpqQWKaTmJeen
        ZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdqqRQlphTChQKSCwuVtK3synK
        Ly1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzuiffIW1oJWlYvHRRUwN
        jO3MXYycHBICJhKvW+YB2VwcQgI7GCWmnHnBBOF8YpRYOKWbEcL5xihx5/h0NpiWi0/usUEk
        9jJKzPw0E6rqBaPE284tYIPZBPQlXnZsYwWxRQTMJeY+PM4OUsQscIlZYveNHSwgCU4BTYkT
        E06C2cIC7hI3jvwBa2ARUJU4tbaPEcTmFbCU2DpzLwuELShxcuYTMJtZQE/ixtQpbBC2vMT2
        t3OgPlKQ+Pl0GStEXERidmcbM8QRThLvrn4Ce05C4ASHxJE3LVANLhLT5vVB/SYs8er4FnYI
        W0ri87u9UPFiiaWzYJobGCUub/sFlTCWmPWsHehSDiBbWeLILajj+CQ6Dv9lhwjzSnS0CUFU
        q0sc2D6dBcKWleie85l1AqPSLCSvzULy2iwkr81C8s4CRpZVjGKpBcW56anFRgXG8AhPzs/d
        xAhOyFruOxhnvP2gd4iRiYPxEKMEB7OSCO/CMzuThHhTEiurUovy44tKc1KLDzGaAkN7IrOU
        aHI+MCfklcQbmlgamJiZGZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgmtuY+CjR
        TjjXzc9gzi9/T+9KC6dDRndVWadbPgk0eXbm73+vdRPu6nyYeDwmbPEqhaRZZSy1RV3xrdmH
        TxU+Wrl3H1/sy9D3iV+m8a9ZmrF5L3Pnun2cRd56i3e8mRMlFV0npMfH7bxVKbL0P8/GtzFX
        z9fyXQrmu3D7ct6slrDNXzVUCp827sqrDJcwepLhzpG4NkdzS0XBrkgPmc89ex7mLJa4avnX
        ekVXx1PhDmHfWqusY365t2/f6xGKbZpp+Pak7YkvGwWezHu4xN7v3cZdxrc2e+2zvSiin1da
        OFtm381nHnd3cHCUaFp7mPInWL1kSzjCM1PdJo7Z+2HyX76yk+khiraPGbQ1Lt5TYinOSDTU
        Yi4qTgQAid/G8lEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnO7aubuTDBZ0aVs8mLeNzaJ58Xo2
        i84dPSwWOxqOsFq8mytjsff1VnaLTY+vsVrMOL+PyeLM4l52i9PXFrBbnN/m78DtcX1dgMem
        VZ1sHneu7WHzmHcy0GP/3DXsHpuX1HssXraTzaNvyypGj8+b5AI4o7hsUlJzMstSi/TtErgy
        +idfYS1oZalYfHQRUwNjO3MXIyeHhICJxMUn99i6GLk4hAR2M0ocnbOTCSIhK/Hs3Q52CFtY
        4n7LEVaIomeMEk8PTgfrZhPQl3jZsY0VxBYRMJeY+/A4O0gRs8ANZomdB/ugOtYxSrSe3swC
        UsUpoClxYsJJMFtYwF3ixpE/YN0sAqoSp9b2MYLYvAKWEltn7mWBsAUlTs58AmYzCxhI3D/U
        wQphy0tsfzsH6gcFiZ9Pl0HFRSRmd7YxQ1zkJPHu6iemCYzCs5CMmoVk1Cwko2YhaV/AyLKK
        UTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4MrU0dzBuX/VB7xAjEwfjIUYJDmYlEd6F
        Z3YmCfGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cC04/HO
        aSf8N0hKmU4q/zBD6WX7htv2B6XsmX0+/Gs57Rn/aU3kvDO8uRL7Ey5xPKhXPSwbEu88fd3m
        za0HZX5Ke/mdDlmU/2nfBvXos4XdDBrdj+STq8/bqe+uTBdNL/JeXGcUWeLXcVuZk3lTxuJ7
        W2W2mJ9eMHNt9CRpkUOOG3R3TIpL8rdcupVJo8zqJ/s6x59ePD2znZjfpL3YfHF9huaKC7zN
        3VyHD1QE6qSu+Wp+WPwua/WKT87OcVIib2uzCo7uYeYu2xOXdOGgGe/25yXJhkncTtFZIr28
        H551OOztdzqg/ufFcm0Zs8K5m69vLpb7GWC+vvXpbDa1PWknd15m+HCtT+KLy7/ouOtKLMUZ
        iYZazEXFiQDRzvaqOwMAAA==
X-CMS-MailID: 20220629003245epcas2p14039a5884417006d032849b2cef82e70
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220628124300epcas2p45f1e3a7051bb93ecba778cf7d96720d3
References: <CGME20220628124300epcas2p45f1e3a7051bb93ecba778cf7d96720d3@epcas2p4.samsung.com>
        <20220628124050.144398-1-chanho61.park@samsung.com>
        <YrsHaUqM03I6I9Om@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > We can test it by linux-serial-test program with -k option. The tool
> > will set TIOCM_LOOP mode when the option is specified.
> > -k, --loopback     Use internal hardware loop back
> 
> Again, what does this line mean in a changelog text?

I put the option to refer how the tool can use. I can see it is not related
with this commit.
I'll remove them next patch.

> 
> And properly wrap your lines at 72 columns.

I'll keep that in mind.
Thanks for your review :)

Best Regards,
Chanho Park


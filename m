Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9886EC43334
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jul 2022 00:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiGLAov (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Jul 2022 20:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiGLAou (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Jul 2022 20:44:50 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DA41DA47
        for <linux-serial@vger.kernel.org>; Mon, 11 Jul 2022 17:44:48 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220712004444epoutp04da69e3d6aebc5ff11ddf3033fc8d115b~A7k64iTK31160411604epoutp04z
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 00:44:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220712004444epoutp04da69e3d6aebc5ff11ddf3033fc8d115b~A7k64iTK31160411604epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657586684;
        bh=g7qThUYqQDqVCCtdN+VQa7ZpmaBxySjHyZMA6TEKmCM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=s1mEhbRDgWqNN900rJW+a4S5HzRDpY2GPXb/2hGcBt0jtBk/BnQAzaY3dPEAtmvh2
         YE83BPH4TBNAnG43+upRfF3vozn9uYnYAKolgKOhEo099SRKGqOU7pGptjMi2plvYp
         THxZJ4AolfduhRx69a3Gc4Egejbxre7xUiS4Ak7s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220712004444epcas2p34c22b883aa9d033c803b958ba397b6e7~A7k6O0cCP0544605446epcas2p3S;
        Tue, 12 Jul 2022 00:44:44 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lhhpz4bbBz4x9Q1; Tue, 12 Jul
        2022 00:44:43 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.47.09642.BF3CCC26; Tue, 12 Jul 2022 09:44:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220712004443epcas2p4ed1e9ac5497517407000b08623556801~A7k5Xov-w0800008000epcas2p4O;
        Tue, 12 Jul 2022 00:44:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220712004443epsmtrp2d4263dc594ee503be415c6af648f64b2~A7k5WZqvb2162821628epsmtrp2c;
        Tue, 12 Jul 2022 00:44:43 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-fd-62ccc3fbbad2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.65.08905.AF3CCC26; Tue, 12 Jul 2022 09:44:42 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220712004442epsmtip2e247ae5c2e3a0a11c3170f5ebed262d3~A7k5GirzM0309003090epsmtip2a;
        Tue, 12 Jul 2022 00:44:42 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Jiri Slaby'" <jirislaby@kernel.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Hector Martin'" <marcan@marcan.st>,
        "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'Vincent Whitchurch'" <vincent.whitchurch@axis.com>,
        =?utf-8?Q?'Ilpo_J=C3=A4rvinen'?= <ilpo.jarvinen@linux.intel.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <4fb8c922-08aa-2ee3-8073-95b8a26bf5db@samsung.com>
Subject: RE: [PATCH v3] tty: serial: samsung_tty: loopback mode support
Date:   Tue, 12 Jul 2022 09:44:42 +0900
Message-ID: <000001d89588$936d14c0$ba473e40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLzDSGin7fZbeDDkoOCu4DD8KtQ/QLMCkYfAQCTfcqrJo9MMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmhe7vw2eSDOYdVrZ4MG8bm0Xz4vVs
        Fp07elgsdjQcYbV4N1fGYu/rrewWmx5fY7WYcX4fk8WZxb3sFmuP3GW3OH1tAbvF+W3+Djwe
        19cFeGxa1cnmcefaHjaPeScDPfbPXcPusXlJvcfiZTvZPPq2rGL0+LxJLoAzKtsmIzUxJbVI
        ITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hcJYWyxJxSoFBAYnGx
        kr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xsu7j5kKXrNV
        tG14yNzAOJe1i5GDQ0LAROLQJqEuRi4OIYEdjBJzZv5lh3A+MUqcOr6eDcL5xigxe/90li5G
        TrCOF9O7WSESexklNk1ZzQjhvGCUmLTnBhNIFZuAvsTLjm1gVSICyxglLvYvYgFxmAWmMEuc
        XHuQFaSKU8BeYlbnLHYQW1jAXWJ18ztmEJtFQFXiz/VHYDavgKXEnxWbmCBsQYmTM5+A3cEs
        oC2xbOFrZoibFCR+Pl0GNlNEwEni5vJ1TBA1IhKzO9uYQRZLCJzhkHjYvoURosFF4vKyZ2wQ
        trDEq+Nb2CFsKYnP7/ZCxYslls76xATR3MAocXnbL6iEscSsZ+2MoPBjFtCUWL9LHxKUyhJH
        bkHdxifRcRgUkiBhXomONiGIRnWJA9thwSgr0T3nM+sERqVZSD6bheSzWUg+mIWwawEjyypG
        sdSC4tz01GKjAmN4dCfn525iBKdlLfcdjDPeftA7xMjEwXiIUYKDWUmE98/ZU0lCvCmJlVWp
        RfnxRaU5qcWHGE2BYT2RWUo0OR+YGfJK4g1NLA1MzMwMzY1MDcyVxHm9UjYkCgmkJ5akZqem
        FqQWwfQxcXBKNTAJV/UvDt5n6PvdcqKb9uG1q7sTb86+fPWUSJlvopZ/xZsH1n8CBXvzw3pK
        pm4vqekzsaqq+sUm3h7QdOtmHvsLMxl7picb6sJeTPB7oPbf6qDmN+Z/q849fPbrN9f6l6tN
        BG9tNPbqYDlh5fhrb5z7Et7pe55uvnbbQjC0T+/vs2aO5yvlXOYKCR9dN0/+itilr+mXvFZt
        Zr7/k7VqGq8v9x3HSPEv529fny/zvnhXYlN88sTjqzVrO71UUlmUe/SqOJ/mz/tplnRDaJmU
        WWeaMsua6Q6V39ar88qr/Lv8pk3U3mLD9PrmI5ZyGR1ZzhM3WP2pqohxnJv2cN5d07Vzz75v
        Kv4Xm7uRv/kNR5USS3FGoqEWc1FxIgCuPOFZVAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWy7bCSvO6vw2eSDN5utrJ4MG8bm0Xz4vVs
        Fp07elgsdjQcYbV4N1fGYu/rrewWmx5fY7WYcX4fk8WZxb3sFmuP3GW3OH1tAbvF+W3+Djwe
        19cFeGxa1cnmcefaHjaPeScDPfbPXcPusXlJvcfiZTvZPPq2rGL0+LxJLoAzissmJTUnsyy1
        SN8ugSvjYNML9oKnbBWTmz+zNDBOZu1i5OSQEDCReDG9G8jm4hAS2M0oMat1PTtEQlbi2bsd
        ULawxP2WI1BFzxglPq26DZZgE9CXeNmxDWySiMAyRomHDTEgRcwCs5glHtzfyATRcZhR4ujF
        p0wgVZwC9hKzOmeBdQsLuEusbn7HDGKzCKhK/Ln+CMzmFbCU+LNiExOELShxcuYTFhCbWUBb
        4unNp3D2soWvmSHOU5D4+XQZ1BVOEjeXr2OCqBGRmN3ZxjyBUXgWklGzkIyahWTULCQtCxhZ
        VjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMeoluYOxu2rPugdYmTiYDzEKMHBrCTC
        ++fsqSQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamIrS
        VikGp5rJfFz4r/+1tVLjQYY9MmvPWh21PF07o2/BKY/r7z4+mDd54s7DTpsuTC7/kPBJ1Tsn
        3Xj6WoMNn9Me3k/+7vRg/vWSPNMjfJrGKy/a8/3RWvNLvuTi3LP5F+aK3bbYKrbwy4ee850u
        V48VvVh76/uGyQczc5qXldty6RV+y3l8vLD92PNL7KyOZ2cKiuTotzovfTmJ8/KKh2yiSvEh
        3Je3as1iWrH3lZTx+s6HS1IsrRYdd4423fsj6id/T32v9lSWBS6nOeQy9/F3BHgZN3I8XjP/
        iu6Ghe8uJ9WcFXKf8WS/a9SP65qqYu/SBDtXtQRx853tta2+ou4vbjrH2UVvXqfEnyePvI4o
        sRRnJBpqMRcVJwIAak46/0ADAAA=
X-CMS-MailID: 20220712004443epcas2p4ed1e9ac5497517407000b08623556801
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc
References: <CGME20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc@epcas2p4.samsung.com>
        <20220629004141.51484-1-chanho61.park@samsung.com>
        <4fb8c922-08aa-2ee3-8073-95b8a26bf5db@samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > +	if (mctrl & TIOCM_LOOP)
> > +		ucon =7C=3D S3C2410_UCON_LOOPBACK;
> > +	else
> > +		ucon &=3D =7ES3C2410_UCON_LOOPBACK;
> > +
> > +	wr_regl(port, S3C2410_UCON, ucon);
>=20
> S3C2410_UCON must be modified at least under the local_irq_save() or port
> lock, otherwise it breaks kernel console operation on older Exynos SoCs
> (especially when DMA mode is used).
>=20
> The above read-modify-write sequence should be replaced with the followin=
g
> pattern:
>=20
>          if (mctrl & TIOCM_LOOP)
>                  s3c24xx_set_bit(port, S3C2410_UCON_LOOPBACK, S3C2410_UCO=
N);
>          else
>                  s3c24xx_clear_bit(port, S3C2410_UCON_LOOPBACK, S3C2410_U=
CON);

All the set_mctrl() call can be protected by spin_=5Bun=5Dlock_irq=5Bsave/r=
estore=5D with port->lock.
So, I think it is not required.

Best Regards,
Chanho Park


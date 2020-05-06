Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E6CC4724C
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 07:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E83020663
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 07:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WN5FIa4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgEFHSh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 03:18:37 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:35482 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgEFHSh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 03:18:37 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200506071832epoutp042310ea0ca14fc17fd9fc2539cc1c6123~MX0OZGqOU0788607886epoutp04A
        for <linux-serial@vger.kernel.org>; Wed,  6 May 2020 07:18:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200506071832epoutp042310ea0ca14fc17fd9fc2539cc1c6123~MX0OZGqOU0788607886epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588749512;
        bh=6YcEGcpOH8qmtVkMgckjOe2MxID1528yYGTjyUVC0OQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WN5FIa4HIJR3ZS5N8K1SWK6cS5wWJRwW+UmqZbIwHvwLtLi6s0n3Pd/OmKiD4Y/jd
         lP3qeamMXGySg6iThwHngccVeJ8FHOmPGg6oh1vaghz/Nb1C/S2mYtzryOZVNWi0hj
         SSvmaES8KMcHGjVDuiDZrwmUg8TpE5ujsplgftJU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20200506071832epcas2p229b83b9a27474c241d0f9efd0f1b0b12~MX0N-Plp51506915069epcas2p2c;
        Wed,  6 May 2020 07:18:32 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.187]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49H7HB1DVwzMqYm6; Wed,  6 May
        2020 07:18:30 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.2B.04647.5C462BE5; Wed,  6 May 2020 16:18:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200506071829epcas2p26dcd37cb7162bf1f62b1789419981361~MX0Lcr_821506915069epcas2p2a;
        Wed,  6 May 2020 07:18:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200506071829epsmtrp148d90a1ebb7caa57f3ed948cdded7a05~MX0Lbuxfq0634006340epsmtrp1H;
        Wed,  6 May 2020 07:18:29 +0000 (GMT)
X-AuditID: b6c32a48-dd9099e000001227-3b-5eb264c5b09a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.CA.18461.5C462BE5; Wed,  6 May 2020 16:18:29 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.155.199]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200506071829epsmtip13c5c73b45d9c619de524330e95bb7537~MX0LNB4zA0070400704epsmtip1Y;
        Wed,  6 May 2020 07:18:29 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Kukjin Kim'" <kgene@kernel.org>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Jiri Slaby'" <jslaby@suse.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200506063105.GA2246050@kroah.com>
Subject: RE: [PATCH v8 1/3] serial: samsung: Replace rd_regb/wr_regb with
 rd_reg/wr_reg
Date:   Wed, 6 May 2020 16:18:28 +0900
Message-ID: <003b01d62376$8a602c40$9f2084c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI0UxSWHSK28Xy0fHrtncuuBEPq6wLkGOxnAlyD66ICotlktAF3atYFp5NuywA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmme6xlE1xBpNqLJoXr2ezmLLhA5NF
        /+PXzBbnz29gt9j0+BqrxeVdc9gsZpzfx2RxZnEvuwOHx6ZVnWwe++euYffYvKTeY/2Wqywe
        nzfJBbBG5dhkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXm
        AF2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwNCzQK07MLS7NS9dLzs+1MjQw
        MDIFqkzIybhzpJG9oEOo4vukdpYGxmsCXYycHBICJhL9x86wdDFycQgJ7GCUaJq4nw3C+cQo
        sfXNInYI5xujxJzmx2wwLa8PPWKFSOxllOj+c4ARwnnJKHH/6XUWkCo2AV2Jy4ufMIHYIgLm
        EnMfHgcbxSzQyiTx4M10sCJOAUOJX1fegtnCApESq5+tYAexWQRUJHZMmwEW5xWwlLhy9TAr
        hC0ocXLmE7A4s4C2xLKFr5khTlKQ+Pl0GSvEMj+JN88nsEPUiEjM7myDqpnJITGpgQPCdpFY
        fvkO1DvCEq+Ob2GHsKUkXva3Qdn1EvvaJoIdLSHQwyjx88NTVoiEscSsZ+1AL3MALdCUWL9L
        H8SUEFCWOHIL6jQ+iY7Df9khwrwSHW1CEI1qEuu+vWCCsGUk1jzdxT6BUWkWksdmIXlsFpIH
        ZiHsWsDIsopRLLWgODc9tdiowAQ5tjcxgpOplscOxgPnfA4xCnAwKvHwGrhvjBNiTSwrrsw9
        xCjBwawkwsvzAyjEm5JYWZValB9fVJqTWnyI0RQY7hOZpUST84GJPq8k3tDUyMzMwNLUwtTM
        yEJJnHcT980YIYH0xJLU7NTUgtQimD4mDk6pBsbQ2dtepDBolE5Zdkcx+lr5HyUuDt1HX7uN
        fG9eVVoQL2z0OcsioqXtrf679iuF1yNy+t8v+cGb37P5wML2MCv/55vPbmt+78r26PHazkte
        dVv3Pd+ic/hxwvodmx1KcuriZV5H3w369Ulve0VB4D9R+ZoHbJNNHZKDv7AXrcxrD/e9ESdX
        oKLEUpyRaKjFXFScCADhMydLvAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTvdoyqY4g+VfuSyaF69ns5iy4QOT
        Rf/j18wW589vYLfY9Pgaq8XlXXPYLGac38dkcWZxL7sDh8emVZ1sHvvnrmH32Lyk3mP9lqss
        Hp83yQWwRnHZpKTmZJalFunbJXBlfPm7kL1gGW/F2+sfWRsYZ3F1MXJySAiYSLw+9Ii1i5GL
        Q0hgN6PElIn72CESMhITXixhhrCFJe63HIEqes4o0XGznRUkwSagK3F58RMmEFtEwFxi7sPj
        7CBFzALdTBLHNx5ggehoY5JY83sv2FhOAUOJX1fesoDYwgLhEtuetoLZLAIqEjumzQCzeQUs
        Ja5cPcwKYQtKnJz5BCzOLKAt0fuwlRHGXrbwNdR5ChI/ny5jhbjCT+LN8wnsEDUiErM725gn
        MArPQjJqFpJRs5CMmoWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjODY0tLc
        wbh91Qe9Q4xMHIyHGCU4mJVEeHl+bIwT4k1JrKxKLcqPLyrNSS0+xCjNwaIkznujcGGckEB6
        YklqdmpqQWoRTJaJg1Oqgam+/HJxwsKDF6pmM1yduFUw7q3BDc6G+ntf1Pqk566SEtk73SGN
        Z67y+aO35zDxS7kFRtZlROasrIn0ELOyNuJfMvOd++6rppwu1mee5gnPFhQy4JNbVdpts+Ln
        jzkvrzqqlc2/Kt9rdydjL4tG2YI1H+OmbGJ6xSN7LCisfbFf3C/ZDQJdkzU/f+sV+zPz7ckd
        t/jDnn+Janypp/jsy1Fhrq3/r83Z+fZUbpbxwZlW79eJGeXfaf1uJb02c8dSGV+Xpr1HEh3/
        6ZxNNw948qp1ST7bj/hyUeX0crkX4gu3CD232O/kGb35pIRWxs9D1hfTOi0tVlzhCo6ef4j/
        +rqOmp0z7PrjDd86lW44X63EUpyRaKjFXFScCABgebuZHAMAAA==
X-CMS-MailID: 20200506071829epcas2p26dcd37cb7162bf1f62b1789419981361
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200420013322epcas2p263e72997dd4ebdaf00b095a83a6b6651
References: <CGME20200420013322epcas2p263e72997dd4ebdaf00b095a83a6b6651@epcas2p2.samsung.com>
        <20200420013300.17249-1-hyunki00.koo@samsung.com>
        <20200505142325.GA816056@kroah.com>
        <000001d62335$33d03410$9b709c30$@samsung.com>
        <20200506063105.GA2246050@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tuesday, May 5, 2020 at 2020 03:31:00 PM +0900, Greg Kroah-Hartman
> On Wed, May 06, 2020 at 08:30:46AM +0900, Hyunki Koo wrote:
> > On Tuesday, May 5, 2020 at 2020 11:23:00 PM +0900, Greg Kroah-Hartman
> Hartman wrote:
> > > On Mon, Apr 20, 2020 at 10:32:56AM +0900, Hyunki Koo wrote:
> > > > This patch change the name of macro for general usage.
> > > >
> > > > Signed-off-by: Hyunki Koo <hyunki00.koo=40samsung.com>
> > >
> > > This patch series creates the following build error, which is not
> > > allowed:
> > >
> > >   CC =5BM=5D  drivers/tty/serial/samsung_tty.o
> > > drivers/tty/serial/samsung_tty.c:186:13: warning: =E2=80=98wr_reg_bar=
rier=E2=80=99=0D=0A>=20>=20>=20defined=20but=20not=20used=20=5B-Wunused-fun=
ction=5D=0D=0A>=20>=20>=20=20=20186=20=7C=20static=20void=20wr_reg_barrier(=
struct=20uart_port=20*port,=20u32=20reg,=20u32=0D=0A>=20val)=0D=0A>=20>=20>=
=20=20=20=20=20=20=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=5E=7E=7E=7E=
=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=0D=0A>=20>=20>=0D=0A>=20>=20>=20Please=20fix=
=20up=20and=20resend.=20=20Always=20make=20sure=20you=20keep=20the=20review=
ed-by=0D=0A>=20>=20>=20tags=20from=20others=20as=20well.=0D=0A>=20>=20>=0D=
=0A>=20>=20>=20greg=20k-h=0D=0A>=20>=0D=0A>=20>=20I=20tested=20on=20latest=
=20kernel=20today=20one=20more=20time,=20there=20is=20no=20error=20and=0D=
=0A>=20warning=20on=20my=20side,=20not=20only=20patch=201/3=20and=20patch=
=203/3=0D=0A>=20>=20Line=201735:=20=20=20CC=20=20=20=20=20=20drivers/tty/se=
rial/samsung_tty.o=0D=0A>=20>=20Line=20343:=20=20=20CC=20=20=20=20=20=20dri=
vers/tty/serial/samsung_tty.o=0D=0A>=20>=0D=0A>=20>=20wr_reg_barrier=20is=
=20not=20defined=20in=20patch=201/3,=20and=20wr_reg_barrier=20is=0D=0A>=20>=
=20define=20and=20used=20in=20patch3/3=20it=20might=20be=20no=20warning.=0D=
=0A>=20=0D=0A>=20After=20I=20apply=20this=20series,=20I=20got=20the=20above=
=20build=20warning=20on=20my=20normal=0D=0A>=20x86=20system,=20so=20I=20can=
=20not=20take=20the=20patches.=20=20Please=20fix=20up=20and=20resend.=0D=0A=
>=20=0D=0A>=20greg=20k-h=0D=0A=0D=0AI'm=20so=20sorry,=20=0D=0AThere=20is=20=
an=20warning=20if=20CONFIG_SERIAL_SAMSUNG_CONSOLE=20=20is=20not=20enabled.=
=0D=0AI've=20fix=20the=20patch=20and=20resend=0D=0AThank=20you=20in=20advan=
ce.=0D=0A=0D=0A

Return-Path: <SRS0=jHyV=6T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDA8C47254
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 23:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86092206B8
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 23:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g4X0UMrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgEEXa7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 May 2020 19:30:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:46271 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgEEXa6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 May 2020 19:30:58 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200505233055epoutp0233a840bdd50e8702cde24c266a06553c~MRb8rUk7B1002510025epoutp02s
        for <linux-serial@vger.kernel.org>; Tue,  5 May 2020 23:30:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200505233055epoutp0233a840bdd50e8702cde24c266a06553c~MRb8rUk7B1002510025epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588721455;
        bh=d4lcTLfAO29mx7hYn/SJR08/ixSOGb0Quek7/I4UYmY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=g4X0UMrcjenTD8M+hbeLpWXvuGlsvoYLKHNWIgkSPx70zpzKOEe7p7Ov27M6OsP3g
         2g2+VnxAkUpIvgfsniCGWXKkUIptIVsCl0K8L3JyTcEJcTCgk5dBFUXPpY50u9zTsP
         4/FNoFqbRGJjJf+kfxjq6vKieBrhaFrCNFL+/gnU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200505233053epcas2p4379fee68d60693f0130194fd5b6ca6ae~MRb6Sbs-V3256232562epcas2p4G;
        Tue,  5 May 2020 23:30:53 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.189]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49Gwvb2krvzMqYkt; Tue,  5 May
        2020 23:30:51 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.47.49908.927F1BE5; Wed,  6 May 2020 08:30:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200505233046epcas2p1e341b8367b27486978dfdb61f59bd3ab~MRb0Ifnhh2682226822epcas2p1L;
        Tue,  5 May 2020 23:30:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200505233046epsmtrp280475699a3a55e90fcdbb0090788c6e8~MRb0HYxw93225832258epsmtrp2x;
        Tue,  5 May 2020 23:30:46 +0000 (GMT)
X-AuditID: b6c32a45-ae1ff7000000c2f4-80-5eb1f72910b2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.F1.18461.627F1BE5; Wed,  6 May 2020 08:30:46 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.155.199]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200505233046epsmtip1ac1324aa8527edead18fd60a30bcfa80~MRbz9LN7T0624706247epsmtip1H;
        Tue,  5 May 2020 23:30:46 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Kukjin Kim'" <kgene@kernel.org>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Jiri Slaby'" <jslaby@suse.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505142325.GA816056@kroah.com>
Subject: RE: [PATCH v8 1/3] serial: samsung: Replace rd_regb/wr_regb with
 rd_reg/wr_reg
Date:   Wed, 6 May 2020 08:30:46 +0900
Message-ID: <000001d62335$33d03410$9b709c30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI0UxSWHSK28Xy0fHrtncuuBEPq6wLkGOxnAlyD66Kns7aKkA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmua7m941xBi2rDC2aF69ns5iy4QOT
        Rf/j18wW589vYLfY9Pgaq8XlXXPYLGac38dkcWZxL7sDh8emVZ1sHvvnrmH32Lyk3mP9lqss
        Hp83yQWwRuXYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQs0CtOzC0uzUvXS87PtTI0
        MDAyBapMyMn4OLW+oJ2nYuKmk8wNjNO4uxg5OSQETCQez+pl72Lk4hAS2MEoMXnpY0YI5xOj
        xPSpv6Ay3xglJh2bwg7T8nnPBqjEXkaJQ+/PQbW8ZJT4+WQaC0gVm4CuxOXFT5hAbBEBc4m5
        D4+DdTALtDJJPHgzHayIU8BAYsWi52BjhQUiJVY/WwFmswioSDxr/cUIYvMKWEq0/exghbAF
        JU7OfALWyyygLbFs4WtmiJMUJH4+XcYKscxJYuOPg2wQNSISszvbmEEWSwhM5ZC4+WAW1A8u
        Es8WrmOFsIUlXh3fAhWXkvj8bi8bhF0vsa9tIjtEcw/Qax+eQjUYS8x61g50HQfQBk2J9bv0
        QUwJAWWJI7egbuOT6Dj8lx0izCvR0SYE0agmse7bCyYIW0ZizdNd7BMYlWYh+WwWks9mIflg
        FsKuBYwsqxjFUguKc9NTi40KDJFjexMjOJ1que5gnHHO5xCjAAejEg+vgfvGOCHWxLLiytxD
        jBIczEoivD4fgEK8KYmVValF+fFFpTmpxYcYTYEBP5FZSjQ5H5jq80riDU2NzMwMLE0tTM2M
        LJTEeTdz34wREkhPLEnNTk0tSC2C6WPi4JRqYOQ506R3dc7+K/Md/66UPqPIMlFz24TVG4p3
        fjwvGhu5iTnOUurfbT/u737WG+MS+tjvrXwuO/GTzbE1E3oSxB5e6yyq3yWtZWwYVlUflRe+
        +P8Bh7fRjG8iug3nF0RcFjA24vScx2qQx/UjY7ewvvZ3y11L+xNeSj38xabzZfq88H875191
        iFJiKc5INNRiLipOBAD3/OVDvQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTlft+8Y4g57jmhbNi9ezWUzZ8IHJ
        ov/xa2aL8+c3sFtsenyN1eLyrjlsFjPO72OyOLO4l92Bw2PTqk42j/1z17B7bF5S77F+y1UW
        j8+b5AJYo7hsUlJzMstSi/TtErgyviy8yFTQwFnxesF+lgbGLvYuRk4OCQETic97NgDZXBxC
        ArsZJS42f2CGSMhITHixBMoWlrjfcoQVoug5o8Sn89fBEmwCuhKXFz9hArFFBMwl5j48DjaJ
        WaCbSeL4xgMsEB2bGSUO7bnFCFLFKWAgsWLRc7DdwgLhEtuetrKA2CwCKhLPWn+B1fAKWEq0
        /exghbAFJU7OfAJWwyygLfH05lM4e9nC11DnKUj8fLqMFeIKJ4mNPw6yQdSISMzubGOewCg8
        C8moWUhGzUIyahaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYJjS0tzB+P2
        VR/0DjEycTAeYpTgYFYS4fX5sDFOiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+NwoVxQgLpiSWp
        2ampBalFMFkmDk6pBqZLdd9/ZWnWZDDLWy/T/VQy9SPLV9nndssT5p96ZxN7a4H3vYTvNUeP
        lM89w8w/a8HPbaENXNtXLzgfMoOrRHr9TbNbSzZtKHE6y7WIK3mlRQvHxZDNPlfX/f1wdR3D
        9fkh3Hnu+n56Nmv3cB2ZUVaoof3zvHn4C6ui7zbCGVKCcmUefV5HzQ02X1ikIRP7vMnR+AT/
        sXfdp4U9D2y7zCxkz+BT/ETkW4mE0Dx3r0UnbgUfszj0wHfJ2e/8Jwz3sZ+9ufCRdOqn+8kM
        d1P3hi6SXZN+a1PU+e//2jYtWb/H+2fzC/1+ix9r5YvLdrkw7Hj7Km3Ptjti0mYhbLvsj/69
        +rDoblmIQM/3fylq7asVlViKMxINtZiLihMBZSLuEBwDAAA=
X-CMS-MailID: 20200505233046epcas2p1e341b8367b27486978dfdb61f59bd3ab
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
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tuesday, May 5, 2020 at 2020 11:23:00 PM +0900, Greg Kroah-Hartman wrote=
:
> On Mon, Apr 20, 2020 at 10:32:56AM +0900, Hyunki Koo wrote:
> > This patch change the name of macro for general usage.
> >
> > Signed-off-by: Hyunki Koo <hyunki00.koo=40samsung.com>
>=20
> This patch series creates the following build error, which is not
> allowed:
>=20
>   CC =5BM=5D  drivers/tty/serial/samsung_tty.o
> drivers/tty/serial/samsung_tty.c:186:13: warning: =E2=80=98wr_reg_barrier=
=E2=80=99=0D=0A>=20defined=20but=20not=20used=20=5B-Wunused-function=5D=0D=
=0A>=20=20=20186=20=7C=20static=20void=20wr_reg_barrier(struct=20uart_port=
=20*port,=20u32=20reg,=20u32=20val)=0D=0A>=20=20=20=20=20=20=20=7C=20=20=20=
=20=20=20=20=20=20=20=20=20=20=5E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=0D=
=0A>=20=0D=0A>=20Please=20fix=20up=20and=20resend.=20=20Always=20make=20sur=
e=20you=20keep=20the=20reviewed-by=0D=0A>=20tags=20from=20others=20as=20wel=
l.=0D=0A>=20=0D=0A>=20greg=20k-h=0D=0A=0D=0AI=20tested=20on=20latest=20kern=
el=20today=20one=20more=20time,=20there=20is=20no=20error=20and=20warning=
=20on=20my=20side,=20not=20only=20patch=201/3=20and=20patch=203/3=0D=0ALine=
=201735:=20=20=20CC=20=20=20=20=20=20drivers/tty/serial/samsung_tty.o=0D=0A=
Line=20343:=20=20=20CC=20=20=20=20=20=20drivers/tty/serial/samsung_tty.o=0D=
=0A=0D=0Awr_reg_barrier=20is=20not=20defined=20in=20patch=201/3,=20=0D=0Aan=
d=20wr_reg_barrier=20is=20define=20and=20used=20in=20patch3/3=0D=0Ait=20mig=
ht=20be=20no=20warning.=0D=0A=0D=0A=0D=0A

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A22C4332F
	for <linux-serial@archiver.kernel.org>; Wed, 16 Feb 2022 00:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbiBPATd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:19:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244978AbiBPATS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Feb 2022 19:19:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223AEDD460;
        Tue, 15 Feb 2022 16:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644970725;
        bh=p8QMhzf5BXOGOgdpvzQpYcOARim4oxi/fBzc9Njmipc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CpVK4e7q8OypWMAKUrl1FHsiB2ucyfwSCBGbLCveYOvPBOtFsqNlO2ko3PRm1u+DC
         wKV5Yqo2CZMDS0BHUe+gF58uUsdbiwKrflMwOIIQjmQLbSPnmDFucjsaE0yad3gCXw
         JK5jdTSD/Vag8AO3jqSfeeMI99P52catderNOcFo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b6l-1nLXD617jZ-00835i; Wed, 16
 Feb 2022 01:18:45 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 2 7/9] serial: imx: remove redundant assignment in rs485_config
Date:   Wed, 16 Feb 2022 01:18:01 +0100
Message-Id: <20220216001803.637-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216001803.637-1-LinoSanfilippo@gmx.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ifqonzAg/uOEZqJ5tzZdRX/mbDQweIG/xNMJGv13ZEz4LKelJp+
 AVB9rxaJPrOXTC8FQFCMiv0QNx479OQdXZgsHF7YJJKPGI/r+2TdRrQRigWD88Kw3dU7xdj
 l6uMtxsjlSdyxeYuZ3rj8e8mNAgCv7++KKHGEA7Nvu242Q0Qo0CmigcDtVpNXfWYMS2FTVM
 qGy32Szlz3qnmwh7Yt2xA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ix5KGaxI8GU=:a/XP+OGQKZMZgoHSmS2tK2
 t+rYXpeNE4KPdUsdhJv8p8uAS7531rSr768CYZl/9JAP9qwORBpzs3JDnDEYjpdPRENmJkatZ
 T+ZGFsjgkwlzcBSqNP2vftImjX8Go7Bm4SG48WBxK/XGzkCeFi/AskettlRfi/egXNIHQ9+c3
 ZQDeyCsxVQAdCo1p5JvwnsOkgn/8/y1KsKcwmQ7luf22eByxSqqeUfxJmtYSMxT+6fDwuitJ8
 nkDj4qRBtKRfldKmeS+7/1LWPX9IP0DebooSoqsaVvqIz03IXOiZEoGuBy5BSgNwHmA6ejLLk
 t1EWpWsnlQGxCgH87p50GT3Box/+e93jm3orusdfYooWzbcTOgGGgibsat2uldFMRTRiHD2pm
 eR1erqM086jSjDV3Qqsn0GtNU4fvGqZNl+WB82FjXHTtgwLfxZ1+NGjTdlJcix5yWAnDYVe6j
 gBL9ylRelbKA+wygM7L2D0cBGAmRlVL5DuOGVBzDhdXX8n4WU5OEcz5MbmTPG6mTN7LBOlVZJ
 2T4dazfyfm8f9UPw1bPv0rgGsUSWUGCHS9yU+YN0RWT0xLYfb1EHjc6TuOJiueYQX0DWd1U0O
 GvYeXOqsG1y+RFg1C3TlDS2nhY9EfgEKihnFk6khx7Qr4gbQ8y55m7IMzrTWun/VQqkx0y+H/
 huuvuAsDjQT+0NKnVNQUANCHib1c7cqClRkSEigEWk3F8dQiJgycbQ1wfEb8ms4wlWyxSY/5d
 RtJqor29Dqb+HUg9x8icqWd0sgN3OyJLMr/FrDI/JytHbQ1Qyi3klcT5f0Obpxr2NRKF0mZ2c
 PkDdIo+I1yClRGjRWNgS2BnYKhs9clvK9S1+dhRrkoNDNWDomsxATfPs2PVdbghFdEVqHuQYY
 xJ3G7KtV8/YRSS5cYEHuXuVQrMXFiZO/vQYC0rSaPvwu7yuUUtm2TNdv3dvPKi7vBaD/Fc8TX
 INak2TvnmG6D5KZdMi335mz6AeZ/yMVMGrr7dkh7VItPl3/HuLrzKH8BdKiYi7BWsVAjTT8Cf
 psbi0HqxkI8M+AKWtK3N7zcFDXn5Dhhl8kqxMzyhuJMFaGitvATK5C0M9NrRsMP+nSE+4mYTJ
 moOCkvYcTX4n08=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgdGhlIHNlcmlhbCBjb3JlIGFscmVhZHkgYXNzaWdu
cyB0aGUgcGFzc2VkCnNlcmlhbF9yczQ4NSBzdHJ1Y3QgdG8gdGhlIHVhcnQgcG9ydC4KClNvIHJl
bW92ZSB0aGUgYXNzaWdubWVudCBpbiB0aGUgZHJpdmVycyByczQ4NV9jb25maWcoKSBmdW5jdGlv
biB0byBhdm9pZApyZWR1bmNhbmN5LgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxM
aW5vU2FuZmlsaXBwb0BnbXguZGU+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIHwgMiAt
LQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90
dHkvc2VyaWFsL2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCmluZGV4IDBiNDY3Y2U4
ZDczNy4uYWI1NmZmMjNlOGE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMK
KysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCkBAIC0xOTM3LDggKzE5MzcsNiBAQCBzdGF0
aWMgaW50IGlteF91YXJ0X3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAogCSAg
ICByczQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X1JYX0RVUklOR19UWCkKIAkJaW14X3VhcnRf
c3RhcnRfcngocG9ydCk7CiAKLQlwb3J0LT5yczQ4NSA9ICpyczQ4NWNvbmY7Ci0KIAlyZXR1cm4g
MDsKIH0KIAotLSAKMi4zNC4xCgo=

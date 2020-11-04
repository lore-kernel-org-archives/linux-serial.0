Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76BCC388F7
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 11:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902EC221F8
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 11:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgKDLZe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 06:25:34 -0500
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:52877 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgKDLZe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 06:25:34 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 06:25:32 EST
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id 95C211A3CC9;
        Wed,  4 Nov 2020 19:17:56 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AM2AyQC0Da1dbRopcUQABart.3.1604488676603.Hmail.bernard@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCAwLzJdIGRyaXZlcnMvdHR5OiBkZWxldGUgYnJlYWsgYWZ0ZXIgcmV0dXJuIG9yIGdvdG8=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.124
In-Reply-To: <20201104110253.GB1688848@kroah.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.124) ] by ajax-webmail ( [127.0.0.1] ) ; Wed, 4 Nov 2020 19:17:56 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Wed, 4 Nov 2020 19:17:56 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQhgfGkhOTENLTEJCVkpNS09PQ0NNTE1NTkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU5CTk9PTEhCTkpPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Nkk6Aio4Sz8aSh8ZKRQLGC4qOjkaCQ9VSFVKTUtPT0NDTUxMS05MVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSU9ZV1kIAVlBT05OTDcG
X-HM-Tid: 0a7592fa450c93b4kuws95c211a3cc9
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

CgpGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgpE
YXRlOiAyMDIwLTExLTA0IDE5OjAyOjUzClRvOiAgQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8u
Y29tPgpDYzogIEppcmkgU2xhYnkgPGppcmlzbGFieUBrZXJuZWwub3JnPixTaGF3biBHdW8gPHNo
YXduZ3VvQGtlcm5lbC5vcmc+LFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4s
UGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT4sRmFiaW8gRXN0
ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPixOWFAgTGludXggVGVhbSA8bGludXgtaW14QG54cC5j
b20+LGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsbGludXgtc2VyaWFsQHZnZXIua2VybmVs
Lm9yZyxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsb3BlbnNvdXJjZS5rZXJu
ZWxAdml2by5jb20KU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIGRyaXZlcnMvdHR5OiBkZWxldGUg
YnJlYWsgYWZ0ZXIgcmV0dXJuIG9yIGdvdG8+T24gV2VkLCBOb3YgMDQsIDIwMjAgYXQgMDI6NTM6
MjlBTSAtMDgwMCwgQmVybmFyZCBaaGFvIHdyb3RlOgo+PiBUaGlzIHBhdGNoIHNlcmVpZXMgb3B0
aW1pc2UgY29kZSBsaWtlOgo+PiB7Cj4+IGNhc2UgWFhYOgo+PiAJcmV0dXJuIFhYWDsKPj4gCWJy
ZWFrOyAvL1RoZSBicmVhayBpcyBtZWFubGVzcywgc28ganVzdCBkZWxldGUgaXQuCj4+IGNhc2Ug
WVlZOgo+PiAJZ290byBZWVk7Cj4+IAlicmVhazsgLy9UaGUgYnJlYWsgaXMgbWVhbmxlc3MsIHNv
IGp1c3QgZGVsZXRlIGl0Lgo+PiAuLi4uLi4KPj4gfQo+PiAKPj4gU2lnbmVkLW9mZi1ieTogQmVy
bmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPgo+PiAKPj4gLS0tCj4+IEJlcm5hcmQgWmhhbyAo
Mik6Cj4+ICAgZHJpdmVycy90dHkvbm96b21pLmM6IGRlbGV0ZSBubyB1c2UgYnJlYWsgYWZ0ZXIg
Z290bwo+PiAgIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYzogZGVsZXRlIG5vIHVzZSBicmVhayBh
ZnRlciByZXR1cm4KPgo+VGhhdCBpcyBub3QgdGhlIHN1YmplY3Qgb2YgdGhlIHBhdGNoZXMgeW91
IHNlbnQgb3V0LCB3aGF0IGJyb2tlPwoKSGk6CgpJIGFtIHNvcnJ5IHRoYXQgSSBhbSBhIGxpdHRs
ZSBjb25mdXNlZDoKVGhlIHBhdGNoIHNlcmllc2BzIHN1YmplY3QgaXMgImRyaXZlcnMvdHR5OiBk
ZWxldGUgYnJlYWsgYWZ0ZXIgcmV0dXJuIG9yIGdvdG8iCmFuZCB0aGUgYmx1cmIgaXM6ClRoaXMg
cGF0Y2ggc2VyZWllcyBvcHRpbWlzZSBjb2RlIGxpa2U6CnsKY2FzZSBYWFg6CglyZXR1cm4gWFhY
OwoJYnJlYWs7IC8vVGhlIGJyZWFrIGlzIG1lYW5sZXNzLCBzbyBqdXN0IGRlbGV0ZSBpdC4KY2Fz
ZSBZWVk6Cglnb3RvIFlZWTsKCWJyZWFrOyAvL1RoZSBicmVhayBpcyBtZWFubGVzcywgc28ganVz
dCBkZWxldGUgaXQuCi4uLi4uLgp9Cmxhc3QsIHRoZSBtb2RpZmllZCBmaWxlcyBhcmU6CkJlcm5h
cmQgWmhhbyAoMik6CiAgZHJpdmVycy90dHkvbm96b21pLmM6IGRlbGV0ZSBubyB1c2UgYnJlYWsg
YWZ0ZXIgZ290bwogIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYzogZGVsZXRlIG5vIHVzZSBicmVh
ayBhZnRlciByZXR1cm4KCklzIHRoZXJlIHNvbWV0aGluZyB3cm9uZyB0aGF0IEkgZGlkbmB0IGNh
dGNoPwoKQlIvL0Jlcm5hcmQKDQoNCg==

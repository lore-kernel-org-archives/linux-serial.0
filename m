Return-Path: <SRS0=O7Uh=46=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC14C10DCE
	for <linux-serial@archiver.kernel.org>; Fri, 13 Mar 2020 07:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9648206B1
	for <linux-serial@archiver.kernel.org>; Fri, 13 Mar 2020 07:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgCMHgy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:36:54 -0400
Received: from m177129.mail.qiye.163.com ([123.58.177.129]:40714 "EHLO
        m177129.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCMHgy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Mar 2020 03:36:54 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Mar 2020 03:36:43 EDT
Received: from vivo.com (wm-2.qy.internal [127.0.0.1])
        by m177129.mail.qiye.163.com (Hmail) with ESMTP id 235F75C18CB;
        Fri, 13 Mar 2020 15:30:14 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AHwAvQBlCNaKiAIB0AO0Aaoi.3.1584084614127.Hmail.wenhu.wang@vivo.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gc2VyaWFsOiBwbDAxMTogZm9ybWF0IGxvbmcgbWVzc2FnZSBzdHJpbmcgaW50byBsaW5lcw==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.227
In-Reply-To: <8eee8b07-3cc3-6ab8-b50f-89cbac0f69ae@suse.cz>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.227) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 13 Mar 2020 15:30:14 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date:   Fri, 13 Mar 2020 15:30:14 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VCSktCQkJMTE9CSElDTVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhNTUxPTkNDTEtLN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Mww6DSo5Fzg1GjASOjI5Szo0SzoaFBJVSFVKTkNPS0NPTUpNT01LVTMWGhIXVQweFRMOVQwa
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlMWVdZCAFZQU9PTkg3Bg++
X-HM-Tid: 0a70d2ccfc0a6447kurs235f75c18cb
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogSmlyaSBTbGFieSA8anNsYWJ5QHN1c2UuY3o+CkRhdGU6IDIwMjAtMDMtMTMgMTU6MDM6
MDUKVG86ICBXQU5HIFdlbmh1IDx3ZW5odS53YW5nQHZpdm8uY29tPixSdXNzZWxsIEtpbmcgPGxp
bnV4QGFybWxpbnV4Lm9yZy51az4sR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4sbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZyxsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnCkNjOiAgdHJpdmlhbEBrZXJuZWwub3JnClN1YmplY3Q6IFJlOiBbUEFUQ0hd
IHNlcmlhbDogcGwwMTE6IGZvcm1hdCBsb25nIG1lc3NhZ2Ugc3RyaW5nIGludG8gbGluZXM+T24g
MTMuIDAzLiAyMCwgNzo1NiwgV0FORyBXZW5odSB3cm90ZToKPj4gU2VwYXJhdGUgdGhlIG1lc3Nh
Z2Ugc3RyaW5nIGludG8gbGluZXMgZm9yIHBsMDExX3Byb2JlX2R0X2FsaWFzKCkKPj4gdG8gbWFr
ZSBpdCBiZXR0ZXIgY29tcGx5IHdpdGgga2VybmVsIGNvZGluZyBzdHlsZSwgYW5kIGFsc28sIG1h
a2UKPj4gaXQgbW9yZSByZWFkYWJsZS4KPj4gCj4+IEl0IHdvdWxkIHN0aWxsIGJlIGdyZXAgZnJp
ZW5kbHkgZm9yIHRoZSBzZXBhcmF0ZWQgZm9ybWF0Lgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogV0FO
RyBXZW5odSA8d2VuaHUud2FuZ0B2aXZvLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL3R0eS9zZXJp
YWwvYW1iYS1wbDAxMS5jIHwgMyArKy0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwv
YW1iYS1wbDAxMS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYwo+PiBpbmRleCAy
Mjk2YmIwZjk1NzguLmU2OTNiN2FjNWEzYSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy90dHkvc2Vy
aWFsL2FtYmEtcGwwMTEuYwo+PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYW1iYS1wbDAxMS5j
Cj4+IEBAIC0yNTIzLDcgKzI1MjMsOCBAQCBzdGF0aWMgaW50IHBsMDExX3Byb2JlX2R0X2FsaWFz
KGludCBpbmRleCwgc3RydWN0IGRldmljZSAqZGV2KQo+PiAgCX0KPj4gIAo+PiAgCWlmIChzZWVu
X2Rldl93aXRoX2FsaWFzICYmIHNlZW5fZGV2X3dpdGhvdXRfYWxpYXMpCj4+IC0JCWRldl93YXJu
KGRldiwgImFsaWFzZWQgYW5kIG5vbi1hbGlhc2VkIHNlcmlhbCBkZXZpY2VzIGZvdW5kIGluIGRl
dmljZSB0cmVlLiBTZXJpYWwgcG9ydCBlbnVtZXJhdGlvbiBtYXkgYmUgdW5wcmVkaWN0YWJsZS5c
biIpOwo+PiArCQlkZXZfd2FybihkZXYsICJhbGlhc2VkIGFuZCBub24tYWxpYXNlZCBzZXJpYWwg
ZGV2aWNlcyBmb3VuZCBpbiBkZXZpY2UgdHJlZS4iIFwKPj4gKwkJCSJTZXJpYWwgcG9ydCBlbnVt
ZXJhdGlvbiBtYXkgYmUgdW5wcmVkaWN0YWJsZS5cbiIpOwo+Cj4xKSBZb3UgcmVtb3ZlZCBhIHNw
YWNlIGFmdGVyIHRoZSBkb3QKPjIpIHRoZSBiYWNrc2xhc2ggaXMgc3VwZXJmbHVvdXMKPjMpIENv
ZGluZ1N0eWxlIGNsZWFybHkgc3RhdGVzOgo+IiIiCj5Ib3dldmVyLCBuZXZlciBicmVhayB1c2Vy
LXZpc2libGUgc3RyaW5ncyBzdWNoIGFzCj5wcmludGsgbWVzc2FnZXMsIGJlY2F1c2UgdGhhdCBi
cmVha3MgdGhlIGFiaWxpdHkgdG8gZ3JlcCBmb3IgdGhlbS4KPiIiIgo+Cj5Tbywgc29ycnk6Cj5O
YWNrZWQtYnk6IEppcmkgU2xhYnkgPGpzbGFieUBzdXNlLmN6Pgo+ClN1cmVseSwgc29ycnkgZm9y
IG15IGZhdWx0LiBPdXQgdG8gcmVmZXJlbmNlIGNvZGluZyBzdHlsZSBvbmNlIG1vcmUgaW4gZGV0
YWlsLiAKVGhhbmtzLgo+PiAgCj4+ICAJcmV0dXJuIHJldDsKPj4gIH0KPj4gCj4KPgo+LS0gCj5q
cwo+c3VzZSBsYWJzCgpXZW5odQ0KDQo=

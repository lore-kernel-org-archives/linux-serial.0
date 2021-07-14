Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC3C07E95
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 02:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 081336135A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 02:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhGNCjA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jul 2021 22:39:00 -0400
Received: from mail.loongson.cn ([114.242.206.163]:41304 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237457AbhGNCjA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jul 2021 22:39:00 -0400
Received: by ajax-webmail-mail.loongson.cn (Coremail) ; Wed, 14 Jul 2021
 10:36:05 +0800 (GMT+08:00)
X-Originating-IP: [112.20.113.90]
Date:   Wed, 14 Jul 2021 10:36:05 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To:     andy@surfacebook.localdomain
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "Jianmin Lv" <lvjianmin@loongson.cn>, chenhuacai@gmail.com
Subject: Re: Re: [PATCH V2] serial: 8250_pnp: Support configurable clock
 frequency
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10a build 20191018(4c4f6d15)
 Copyright (c) 2002-2021 www.mailtech.cn .loongson.cn
In-Reply-To: <YOynYT29jF6JwgN/@surfacebook.localdomain>
References: <20210705130010.1231798-1-chenhuacai@loongson.cn>
 <YOynYT29jF6JwgN/@surfacebook.localdomain>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <45d828b0.bcb4.17aa2df0f81.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf9BxsOKVTe5g8MofAA--.13900W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQACBl3QvNqacAABsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGksIEFuZHkKCgomZ3Q7IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KJmd0OyDlj5Hku7bkuro6IGFu
ZHlAc3VyZmFjZWJvb2subG9jYWxkb21haW4KJmd0OyDlj5HpgIHml7bpl7Q6IDIwMjEtMDctMTMg
MDQ6MzQ6NDEgKOaYn+acn+S6jCkKJmd0OyDmlLbku7bkuro6ICJIdWFjYWkgQ2hlbiIgPGNoZW5o
dWFjYWlAbG9vbmdzb24uY24+CiZndDsg5oqE6YCBOiAiR3JlZyBLcm9haC1IYXJ0bWFuIiA8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+LCBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnLCAi
WHVlZmVuZyBMaSIgPGxpeHVlZmVuZ0Bsb29uZ3Nvbi5jbj4sICJKaWF4dW4gWWFuZyIgPGppYXh1
bi55YW5nQGZseWdvYXQuY29tPiwgIkppYW5taW4gTHYiIDxsdmppYW5taW5AbG9vbmdzb24uY24+
CiZndDsg5Li76aKYOiBSZTogW1BBVENIIFYyXSBzZXJpYWw6IDgyNTBfcG5wOiBTdXBwb3J0IGNv
bmZpZ3VyYWJsZSBjbG9jayBmcmVxdWVuY3kKJmd0OyAKJmd0OyBNb24sIEp1bCAwNSwgMjAyMSBh
dCAwOTowMDoxMFBNICswODAwLCBIdWFjYWkgQ2hlbiBraXJqb2l0dGk6CiZndDsgJmd0OyBGcm9t
OiBKaWFubWluIEx2IDxsdmppYW5taW5AbG9vbmdzb24uY24+CiZndDsgJmd0OyAKJmd0OyAmZ3Q7
IEFDUEktYmFzZWQgTG9vbmdzb24gYm9hcmRzIG5lZWQgY29uZmlndXJhYmxlIHJhdGhlciB0aGFu
IGZpeGVkIGNsb2NrCiZndDsgJmd0OyBmcmVxdWVuY3kgZm9yIHNlcmlhbCBwb3J0cy4KJmd0OyAK
Jmd0OyAuLi4KJmd0OyAKJmd0OyAmZ3Q7ICAjaW5jbHVkZSA8bGludXgga2VybmVsLmg9IiI+CiZn
dDsgJmd0OyAgI2luY2x1ZGUgPGxpbnV4IHNlcmlhbF9jb3JlLmg9IiI+CiZndDsgJmd0OyAgI2lu
Y2x1ZGUgPGxpbnV4IGJpdG9wcy5oPSIiPgomZ3Q7ICZndDsgKyNpbmNsdWRlIDxsaW51eCBwcm9w
ZXJ0eS5oPSIiPgomZ3Q7IAomZ3Q7IENhbiB5b3UgdHJ5IHRvIGtlZXAgaXQgb3JkZXJlZCAodG8g
c29tZSBleHRlbmQpLCBwbGVhc2U/CkV4aXN0aW5nIGhlYWRlcnMgaXMgbm90IGluIG9yZGVyLCBz
aG91bGQgSSBzb3J0IHRoZW0gY29tcGxldGVseT8KCiZndDsgCiZndDsgLi4uCiZndDsgCiZndDsg
Jmd0OyAgCXVhcnQucG9ydC5mbGFncyB8PSBVUEZfU0tJUF9URVNUIHwgVVBGX0JPT1RfQVVUT0NP
TkY7CiZndDsgJmd0OyAgCWlmIChwbnBfaXJxX2ZsYWdzKGRldiwgMCkgJmFtcDsgSU9SRVNPVVJD
RV9JUlFfU0hBUkVBQkxFKQomZ3Q7ICZndDsgIAkJdWFydC5wb3J0LmZsYWdzIHw9IFVQRl9TSEFS
RV9JUlE7CiZndDsgJmd0OyAtCXVhcnQucG9ydC51YXJ0Y2xrID0gMTg0MzIwMDsKJmd0OyAmZ3Q7
ICsJaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMigmYW1wO2Rldi0mZ3Q7ZGV2LCAiY2xvY2st
ZnJlcXVlbmN5IiwgJmFtcDt1YXJ0LnBvcnQudWFydGNsaykpCiZndDsgJmd0OyArCQl1YXJ0LnBv
cnQudWFydGNsayA9IDE4NDMyMDA7CiZndDsgJmd0OyAgCXVhcnQucG9ydC5kZXYgPSAmYW1wO2Rl
di0mZ3Q7ZGV2OwomZ3Q7IAomZ3Q7IFlvdSBjYW4gYXZvaWQgY29uZGl0aW9uYWwgY29tcGxldGVs
eSBieSBjYWxsaW5nIAomZ3Q7IAomZ3Q7IAlkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoJmFtcDtk
ZXYtJmd0O2RldiwgImNsb2NrLWZyZXF1ZW5jeSIsICZhbXA7dWFydC5wb3J0LnVhcnRjbGspOwpJ
IHdhbnQgdG8gZ2V0IHRoZSBwcm9wZXJ0eSBieSB0aGlzIGZ1bmN0aW9uLCBhbmQgc2V0IHRvIGRl
ZmF1bHQgdmFsdWUgKDE4NDMyMDApIGlmIGZhaWxzLiBJZiByZW1vdmUgdGhlIGNvbmRpdGlvbiwg
aG93IHRvIHNldCB0aGUgZGVmYXVsdD8gVGhhbmtzLgoKSHVhY2FpCiZndDsgCiZndDsgaGVyZS4K
Jmd0OyAKJmd0OyAtLSAKJmd0OyBXaXRoIEJlc3QgUmVnYXJkcywKJmd0OyBBbmR5IFNoZXZjaGVu
a28KJmd0OyAKPC9saW51eD48L2xpbnV4PjwvbGludXg+PC9saW51eD48L2x2amlhbm1pbkBsb29u
Z3Nvbi5jbj48L2x2amlhbm1pbkBsb29uZ3Nvbi5jbj48L2ppYXh1bi55YW5nQGZseWdvYXQuY29t
PjwvbGl4dWVmZW5nQGxvb25nc29uLmNuPjwvZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+PC9j
aGVuaHVhY2FpQGxvb25nc29uLmNuPg==

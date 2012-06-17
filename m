From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] serial/amba-pl011: use devm_* allocators
Date: Sun, 17 Jun 2012 11:13:28 -0300
Message-ID: <CAOMZO5DGxPQyHpPLLJk1P5kmyfB+9jct1rwEZj918wM84ePRKA@mail.gmail.com>
References: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48579 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757374Ab2FQON3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Jun 2012 10:13:29 -0400
Received: by bkcji2 with SMTP id ji2so3384521bkc.19
        for <linux-serial@vger.kernel.org>; Sun, 17 Jun 2012 07:13:28 -0700 (PDT)
In-Reply-To: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org

T24gU3VuLCBKdW4gMTcsIDIwMTIgYXQgMTA6NDQgQU0sIExpbnVzIFdhbGxlaWoKPGxpbnVzLndh
bGxlaWpAc3Rlcmljc3Nvbi5jb20+IHdyb3RlOgoKPiDCoCDCoCDCoCDCoHVhcC0+cGluY3RybCA9
IGRldm1fcGluY3RybF9nZXQoJmRldi0+ZGV2KTsKPiDCoCDCoCDCoCDCoGlmIChJU19FUlIodWFw
LT5waW5jdHJsKSkgewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gUFRSX0VSUih1YXAt
PnBpbmN0cmwpOwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byB1bm1hcDsKPiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGdvdG8gb3V0Owo+IMKgIMKgIMKgIMKgfQo+IMKgIMKgIMKgIMKgdWFw
LT5waW5zX2RlZmF1bHQgPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZSh1YXAtPnBpbmN0cmwsCj4gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgUElOQ1RSTF9TVEFURV9ERUZBVUxUKTsKPiBAQCAtMTkxNSw3ICsxOTE3LDcg
QEAgc3RhdGljIGludCBwbDAxMV9wcm9iZShzdHJ1Y3QgYW1iYV9kZXZpY2UgKmRldiwgY29uc3Qg
c3RydWN0IGFtYmFfaWQgKmlkKQo+IMKgIMKgIMKgIMKgdWFwLT5jbGsgPSBjbGtfZ2V0KCZkZXYt
PmRldiwgTlVMTCk7CgpNYXliZSB5b3UgY2FuIHVzZSBkZXZtX2Nsa19nZXQgaGVyZSB0b28uCg==

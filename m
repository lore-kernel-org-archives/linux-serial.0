From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC 7/8] ARM: VIC: Add vic_set_fiq function to select if an
 interrupt should generate an IRQ or FIQ
Date: Wed, 14 May 2014 16:58:44 +0100
Message-ID: <1400083125-1464-8-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, Frederic Weisbecker <fweisbec@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@lin>
List-Id: linux-serial@vger.kernel.org

RnJvbTogQXJ2ZSBIasO4bm5ldsOlZyA8YXJ2ZUBhbmRyb2lkLmNvbT4KClNpZ25lZC1vZmYtYnk6
IEFydmUgSGrDuG5uZXbDpWcgPGFydmVAYW5kcm9pZC5jb20+ClNpZ25lZC1vZmYtYnk6IERhbmll
bCBUaG9tcHNvbiA8ZGFuaWVsLnRob21wc29uQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9pcnFj
aGlwL2lycS12aWMuYyAgICAgICB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrCiBpbmNsdWRl
L2xpbnV4L2lycWNoaXAvYXJtLXZpYy5oIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL2lycS12aWMuYyBiL2RyaXZl
cnMvaXJxY2hpcC9pcnEtdmljLmMKaW5kZXggN2QzNTI4Ny4uM2VhYTJlNCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9pcnFjaGlwL2lycS12aWMuYworKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLXZpYy5j
CkBAIC0zMzcsNiArMzM3LDI5IEBAIHN0YXRpYyB2b2lkIHZpY191bm1hc2tfaXJxKHN0cnVjdCBp
cnFfZGF0YSAqZCkKIAl3cml0ZWwoMSA8PCBpcnEsIGJhc2UgKyBWSUNfSU5UX0VOQUJMRSk7CiB9
CiAKK3N0YXRpYyBERUZJTkVfU1BJTkxPQ0sodmljX2ludHNlbGVjdF9sb2NrKTsKK2ludCB2aWNf
c2V0X2ZpcSh1bnNpZ25lZCBpbnQgaXJxLCBib29sIGVuYWJsZSkKK3sKKwl1MzIgaW50X3NlbGVj
dDsKKwl1MzIgbWFzazsKKwl1bnNpZ25lZCBsb25nIGlycV9mbGFnczsKKwl2b2lkIF9faW9tZW0g
KmJhc2UgPSBpcnFfZ2V0X2NoaXBfZGF0YShpcnEpOworCWlycSAmPSAzMTsKKwltYXNrID0gMSA8
PCBpcnE7CisKKwlzcGluX2xvY2tfaXJxc2F2ZSgmdmljX2ludHNlbGVjdF9sb2NrLCBpcnFfZmxh
Z3MpOworCWludF9zZWxlY3QgPSByZWFkbChiYXNlICsgVklDX0lOVF9TRUxFQ1QpOworCWlmIChl
bmFibGUpCisJCWludF9zZWxlY3QgfD0gbWFzazsKKwllbHNlCisJCWludF9zZWxlY3QgJj0gfm1h
c2s7CisJd3JpdGVsKGludF9zZWxlY3QsIGJhc2UgKyBWSUNfSU5UX1NFTEVDVCk7CisJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmdmljX2ludHNlbGVjdF9sb2NrLCBpcnFfZmxhZ3MpOworCisJcmV0
dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MKHZpY19zZXRfZmlxKTsKKwogI2lmIGRlZmluZWQoQ09O
RklHX1BNKQogc3RhdGljIHN0cnVjdCB2aWNfZGV2aWNlICp2aWNfZnJvbV9pcnEodW5zaWduZWQg
aW50IGlycSkKIHsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaXJxY2hpcC9hcm0tdmljLmgg
Yi9pbmNsdWRlL2xpbnV4L2lycWNoaXAvYXJtLXZpYy5oCmluZGV4IGJhNDZjNzkuLjYxZWU0Yzkg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaXJxY2hpcC9hcm0tdmljLmgKKysrIGIvaW5jbHVk
ZS9saW51eC9pcnFjaGlwL2FybS12aWMuaApAQCAtMzQsNSArMzQsNiBAQCB2b2lkIF9fdmljX2lu
aXQodm9pZCBfX2lvbWVtICpiYXNlLCBpbnQgcGFyZW50X2lycSwgaW50IGlycV9zdGFydCwKIHZv
aWQgdmljX2luaXQodm9pZCBfX2lvbWVtICpiYXNlLCB1bnNpZ25lZCBpbnQgaXJxX3N0YXJ0LCB1
MzIgdmljX3NvdXJjZXMsIHUzMiByZXN1bWVfc291cmNlcyk7CiBpbnQgdmljX2luaXRfY2FzY2Fk
ZWQodm9pZCBfX2lvbWVtICpiYXNlLCB1bnNpZ25lZCBpbnQgcGFyZW50X2lycSwKIAkJICAgICAg
dTMyIHZpY19zb3VyY2VzLCB1MzIgcmVzdW1lX3NvdXJjZXMpOworaW50IHZpY19zZXRfZmlxKHVu
c2lnbmVkIGludCBpcnEsIGJvb2wgZW5hYmxlKTsKIAogI2VuZGlmCi0tIAoxLjkuMAoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

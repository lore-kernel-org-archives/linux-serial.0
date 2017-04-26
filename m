From: Romain Perier <romain.perier@collabora.com>
Subject: Re: [PATCH] serial: imx: Enable RTSD only when needed
Date: Wed, 26 Apr 2017 09:17:50 +0200
Message-ID: <77d20ce7-d953-6de1-330a-b7a29811ca8f@collabora.com>
References: <20170412133015.23185-1-romain.perier@collabora.com>
 <CAOMZO5Anz_C-pxPke_mqCtD_D9LBxTRWSk5fAZrr6KaMeMZGqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5Anz_C-pxPke_mqCtD_D9LBxTRWSk5fAZrr6KaMeMZGqQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nandor Han <nandor.han@ge.com>
List-Id: linux-serial@vger.kernel.org

SGVsbG8gYWxsLAoKCkxlIDEyLzA0LzIwMTcgw6AgMTU6MzgsIEZhYmlvIEVzdGV2YW0gYSDDqWNy
aXQgOgo+IE9uIFdlZCwgQXByIDEyLCAyMDE3IGF0IDEwOjMwIEFNLCBSb21haW4gUGVyaWVyCj4g
PHJvbWFpbi5wZXJpZXJAY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4+IEZyb206IE5hbmRvciBIYW4g
PG5hbmRvci5oYW5AZ2UuY29tPgo+Pgo+PiBDdXJyZW50bHksIHRoaXMgSVJRIGlzIGFsd2F5cyBl
bmFibGVkLiBTb21lIGRldmljZXMgbWlnaHQgbXV4IHRoZXNlIHBpbnMKPj4gdG8gb3RoZXIgSS9P
cywgbGlrZSBJMkMuIFRoaXMgY291bGQgbGVhZCB0byBzcHVyaW91cyBpbnRlcnJ1cHRzLgo+Pgo+
PiBUaGlzIGNvbW1pdCBtYWtlcyB0aGlzIElSUSBvcHRpb25hbCwgYnkgdXNpbmcgdGhlIGZpZWxk
IGhhdmVfcnRzY3RzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOYW5kb3IgSGFuIDxuYW5kb3IuaGFu
QGdlLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogUm9tYWluIFBlcmllciA8cm9tYWluLnBlcmllckBj
b2xsYWJvcmEuY29tPgo+IFJldmlld2VkLWJ5OiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFt
QG54cC5jb20+CgpObyBtb3JlIGZlZWRiYWNrIG9uIHRoaXMgcGF0Y2ggPwoKUmVnYXJkcywKUm9t
YWluCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=

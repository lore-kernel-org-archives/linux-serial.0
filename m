From: Ed Blake <ed.blake-56FIPCJpnYtBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH][RFC] 8250_dw: unregister dw8250_set_termios for rk3188
 chip
Date: Tue, 21 Nov 2017 17:33:47 +0000
Message-ID: <f834a0a4-3d1e-6f97-6ff3-1d52d609f510@sondrel.com>
References: <20171120144045.juwm64m2j736h5ps@home.dogben.com>
 <20171120161455.orvooleyzfsslon3@home.dogben.com>
 <0a4ce349-d386-0f1b-e973-e77af7f75d23@sondrel.com> <1854299.UNFOX8ncyA@diego>
 <20171121030949.a6bsapueiicdbonj@home.dogben.com>
 <4010bd84-7c88-5410-820f-bd3d04f1fbb5@sondrel.com>
 <20171121171712.GA4462@home.dogben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20171121171712.GA4462-ZQaglsx1qnHXWvwwbwmGMg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shuyu Wei <wsy-flSAGy4ZnMjQT0dZR+AlfA@public.gmane.org>
Cc: wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

T24gMjEvMTEvMTcgMTc6MTcsIFNodXl1IFdlaSB3cm90ZToKPgo+PiBXaGF0IGJhdWQgcmF0ZSBp
cyBiZWluZyBzZXQsIGFuZCB3aGF0IHJhdGUgZG9lcyBjbGtfcm91bmRfcmF0ZSgpIHJldHVybgo+
PiBpbiBkdzgyNTBfc2V0X3Rlcm1pb3MoKT8KPiBJJ20gdXNpbmcgYmF1ZCAxMTUyMDAsIGNsa19y
b3VuZF9yYXRlKCkgcmV0dXJucyAxODQzMjAwLgoKU28gZHc4MjUwX3NldF90ZXJtaW9zKCkgcmVx
dWVzdHMgYSByYXRlIG9mIDE4NDMyMDAgKGJhdWQgKiAxNikgZnJvbQpjbGtfcm91bmRfcmF0ZSgp
LCB3aGljaCByZXR1cm5zIHRoZSBleGFjdCBmcmVxdWVuY3kgcmVxdWVzdGVkLsKgIElmIGl0CnJl
YWxseSBpcyBjYXBhYmxlIG9mIGJlaW5nIHNldCB0byB0aGF0IGZyZXF1ZW5jeSwgSSBjYW4ndCBz
ZWUgd2h5IHRoaXMKd291bGRuJ3Qgd29yay7CoCBPciBjbGtfcm91bmRfcmF0ZSgpIGlzIGluY29y
cmVjdGx5IHJlcG9ydGluZyB0aGF0IGl0J3MKY2FwYWJsZSBvZiB0aGF0IHJhdGUsIGluIHdoaWNo
IGNhc2UgdGhlIGNsb2NrIGRyaXZlciBuZWVkcyBmaXhpbmcuCgpEbyB5b3UgaGF2ZSBhbnkgd2F5
IG9mIHZlcmlmeWluZyB0aGUgYWN0dWFsIGNsb2NrIHJhdGUgZ29pbmcgaW50byB0aGUgVUFSVD8K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LXJv
Y2tjaGlwIG1haWxpbmcgbGlzdApMaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcm9ja2NoaXAK

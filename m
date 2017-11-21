From: Ed Blake <ed.blake-56FIPCJpnYtBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH][RFC] 8250_dw: unregister dw8250_set_termios for rk3188
 chip
Date: Tue, 21 Nov 2017 10:23:17 +0000
Message-ID: <4010bd84-7c88-5410-820f-bd3d04f1fbb5@sondrel.com>
References: <20171120144045.juwm64m2j736h5ps@home.dogben.com>
 <20171120161455.orvooleyzfsslon3@home.dogben.com>
 <0a4ce349-d386-0f1b-e973-e77af7f75d23@sondrel.com> <1854299.UNFOX8ncyA@diego>
 <20171121030949.a6bsapueiicdbonj@home.dogben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20171121030949.a6bsapueiicdbonj-ZQaglsx1qnHXWvwwbwmGMg@public.gmane.org>
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
To: Shuyu Wei <wsy-flSAGy4ZnMjQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

T24gMjEvMTEvMTcgMDM6MDksIFNodXl1IFdlaSB3cm90ZToKPiBPbiBNb24sIE5vdiAyMCwgMjAx
NyBhdCAwNjo1MTozN1BNICswMTAwLCBIZWlrbyBTdMO8Ym5lciB3cm90ZToKPiAgCj4+IEFsc28s
IHRoZSByazMxODggdWFydHMgYXJlIGRlZmluaXRseSBub3QgZml4ZWQgYXQgMjRNSHogYW5kIGNh
biB1c2Ugb3RoZXIgCj4+IHNvdXJjZXMgYXMgd2VsbC4gU28gSSdtIHB1enpsZWQgYmVjYXVzZSBh
dCBsZWFzdCB0aGUgc2VyaWFsIGNvbnNvbGUgb24gbXkgCj4+IHJrMzE4OCByYWR4YXJvY2sgd29y
a3Mgd2l0aG91dCBpc3N1ZXMuCj4+Cj4+IENhbiB5b3UgdGVsbCB1cyB3aGljaCB1YXJ0IHlvdSBh
cmUgZmFpbGluZyB0byBjb250cm9sIGNvcnJlY3RseT8KPj4KPj4KPj4gSSBkbyByZW1lbWJlciB0
aGF0IEkgcmFuIGludG8gcHJvYmxlbXMgd2hlbiB0aGUgc2V0X3Rlcm1pb3MgY2hhbmdlCj4+IHdh
cyBpbnRyb2R1Y2VkIG9yaWdpbmFsbHksIHJlc3VsdGluZyBpbiB0aGUgcGF0Y2gKPj4gCSJzZXJp
YWw6IDgyNTBfZHc6IEhvbm9yIGNsa19yb3VuZF9yYXRlIGVycm9ycyBpbiBkdzgyNTBfc2V0X3Rl
cm1pb3MiIFswXQo+PiBidXQgdGhhdCBpcyBpbiBtYWlubGluZSBmb3IgcXVpdGUgc29tZSB0aW1l
IG5vdy4KPj4KPj4gWzBdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvOTU5NDY1
Ny8KPj4KPj4KPj4gSGVpa28KPiBIaSBIZWlrbywKPgo+IEknbSB1c2luZyB0dHlTMih1YXJ0Miku
Cj4gTXkgYm9hcmQgc3RhcnRzIHRvIGZhaWwgb24gbWFpbmxpbmUgc2luY2UgdGhlIGV4YWN0IGNv
bW1pdCAzN2M4NTk2LAo+IHRoYXQncyB3aHkgSSB0cnkgdG8gcmVtb3ZlIGR3ODI1MF9zZXRfdGVy
bWlvcygpIGFuZCBpdCB3b3JrZWQuCgpJcyB0aGlzIG9uIDQuMTQgb3IgbmV4dD8KCldoYXQgYmF1
ZCByYXRlIGlzIGJlaW5nIHNldCwgYW5kIHdoYXQgcmF0ZSBkb2VzIGNsa19yb3VuZF9yYXRlKCkg
cmV0dXJuCmluIGR3ODI1MF9zZXRfdGVybWlvcygpPwoKQ2FuIHlvdSB0cnkgYXBwbHlpbmcgdGhp
cyBwYXRjaCBzZXJpZXMgYW5kIHNlZSBpZiBpdCBmaXhlcyB0aGUgcHJvYmxlbT8KCmh0dHBzOi8v
d3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXNlcmlhbC9tc2cyNzY3Mi5odG1sCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtcm9ja2NoaXAg
bWFpbGluZyBsaXN0CkxpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yb2NrY2hpcAo=

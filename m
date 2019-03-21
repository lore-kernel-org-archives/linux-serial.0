From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] Disable kgdboc failed by echo space to
 /sys/module/kgdboc/parameters/kgdboc
Date: Thu, 21 Mar 2019 10:33:43 +0000
Message-ID: <20190321103343.oxzt43q734o3pcur@holly.lan>
References: <HK0PR03MB2817154ABAB39937BFF0AB9BCB4D0@HK0PR03MB2817.apcprd03.prod.outlook.com>
 <20190319142306.GA13458@kroah.com>
 <KU1PR03MB2824C0511DA1CD5025CC47DECB410@KU1PR03MB2824.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <KU1PR03MB2824C0511DA1CD5025CC47DECB410@KU1PR03MB2824.apcprd03.prod.outlook.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/kgdb-bugreport>,
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: =?utf-8?B?546LIOaWh+a2mw==?= <wwthappy@hotmail.com>
Cc: "kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jason.wessel@windriver.com" <jason.wessel@windriver.com>
List-Id: linux-serial@vger.kernel.org

T24gV2VkLCBNYXIgMjAsIDIwMTkgYXQgMDM6MzA6MzlQTSArMDAwMCwg546LIOaWh+a2myB3cm90
ZToKPiBGcm9tOiBXZW50YW8gV2FuZyA8d2l0YWxsd2FuZ0BnbWFpbC5jb20+Cj4gCj4gRWNobyAi
IiB0byAvc3lzL21vZHVsZS9rZ2Rib2MvcGFyYW1ldGVycy9rZ2Rib2Mgd2lsbCBmYWlsIHdpdGgg
Ik5vIHN1Y2ggZGV2aWNl4oCdIGVycm9yLgo+IAo+IFRoaXMgaXMgY2F1c2VkIGJ5IGZ1bmN0aW9u
ICJjb25maWd1cmVfa2dkYm9jIiB3aG8gaW5pdCBlcnIgdG8gRU5PREVWIHdoZW4gdGhlIGNvbmZp
Zwo+IGlzIGVtcHR5IChsZWdhbCBpbnB1dCkgdGhlIGNvZGUgZ28gb3V0IHdpdGggRU5PREVWIHJl
dHVybmVkLgo+IAo+IEZpeGVzOiAyZGQ0NTMxNjg2NDNkICgia2dkYm9jOiBGaXggcmVzdHJpY3Qg
ZXJyb3IiKQo+IAo+IFNpZ25lZC1vZmYtYnk6IFdlbnRhbyBXYW5nIDx3aXRhbGx3YW5nQGdtYWls
LmNvbT4KCkFja2VkLWJ5OiBEYW5pZWwgVGhvbXBzb24gPGRhbmllbC50aG9tcHNvbkBsaW5hcm8u
b3JnPgoKClRoYW5rcyEKCkRhbmllbC4KCj4gLS0tCj4gIGRyaXZlcnMvdHR5L3NlcmlhbC9rZ2Ri
b2MuYyB8IDQgKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9rZ2Rib2MuYyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9rZ2Rib2MuYwo+IGluZGV4IDZmYjMxMmUuLmJmZTVlOWUgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2tnZGJvYy5jCj4gKysrIGIvZHJpdmVycy90dHkv
c2VyaWFsL2tnZGJvYy5jCj4gQEAgLTE0OCw4ICsxNDgsMTAgQEAgc3RhdGljIGludCBjb25maWd1
cmVfa2dkYm9jKHZvaWQpCj4gIAljaGFyICpjcHRyID0gY29uZmlnOwo+ICAJc3RydWN0IGNvbnNv
bGUgKmNvbnM7Cj4gIAo+IC0JaWYgKCFzdHJsZW4oY29uZmlnKSB8fCBpc3NwYWNlKGNvbmZpZ1sw
XSkpCj4gKwlpZiAoIXN0cmxlbihjb25maWcpIHx8IGlzc3BhY2UoY29uZmlnWzBdKSkgewo+ICsJ
CWVyciA9IDA7Cj4gIAkJZ290byBub2NvbmZpZzsKPiArCX0KPiAgCj4gIAlrZ2Rib2NfaW9fb3Bz
LmlzX2NvbnNvbGUgPSAwOwo+ICAJa2dkYl90dHlfZHJpdmVyID0gTlVMTDsKPiAtLSAKPiAyLjcu
NAo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCktn
ZGItYnVncmVwb3J0IG1haWxpbmcgbGlzdApLZ2RiLWJ1Z3JlcG9ydEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8va2dkYi1i
dWdyZXBvcnQK

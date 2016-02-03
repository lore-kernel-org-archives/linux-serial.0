From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 01/10] serial: mvebu-uart: initial support for Armada-3700
 serial port
Date: Wed, 03 Feb 2016 17:36:01 +0100
Message-ID: <87mvrh4uq6.fsf@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
 <5687888.WDl8xbENFR@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5687888.WDl8xbENFR@wuerfel> (Arnd Bergmann's message of "Tue, 02
 Feb 2016 22:07:17 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jslaby@suse.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, arm@kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wilson Ding <dingwei@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-serial@vger.kernel.org

SGkgQXJuZCwKIAogT24gbWFyLiwgZsOpdnIuIDAyIDIwMTYsIEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+IHdyb3RlOgoKPiBPbiBUdWVzZGF5IDAyIEZlYnJ1YXJ5IDIwMTYgMTk6MDc6Mzkg
R3JlZ29yeSBDTEVNRU5UIHdyb3RlOgo+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJp
YWwvS2NvbmZpZyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9LY29uZmlnCj4+IGluZGV4IDM5NzIxZWM0
ZjQxNS4uYjI5MWY5MzRkNTFiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvS2Nv
bmZpZwo+PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvS2NvbmZpZwo+PiBAQCAtMTYwNiw2ICsx
NjA2LDI4IEBAIGNvbmZpZyBTRVJJQUxfU1RNMzJfQ09OU09MRQo+PiAgCWRlcGVuZHMgb24gU0VS
SUFMX1NUTTMyPXkKPj4gIAlzZWxlY3QgU0VSSUFMX0NPUkVfQ09OU09MRQo+PiAgCj4+ICtjb25m
aWcgU0VSSUFMX01WRUJVX1VBUlQKPj4gKwlib29sICJNYXJ2ZWxsIEVCVSBzZXJpYWwgcG9ydCBz
dXBwb3J0Igo+Cj4gQ291bGQgdGhpcyBiZSBhIGxvYWRhYmxlIG1vZHVsZT8KCkkgZG9uJ3Qgc2Vl
IGFueSByZWFzb24gdG8gbm90IGJlaW5nIGFibGUgdG8gdXNlIGl0IGFzIGEgbW9kdWxlLiBCdXQg
SQpkaWRuJ3QgdGVzdCBpdCBiZWNhdXNlIGN1cnJlbnRseSB0ZSBzZXJpYWwgcG9ydCBpcyB0aGUg
b25seSB3YXkgcm8KY2ltbXVuaWNhdGUgd2l0aCB0aGUgYm9hcmQuCgo+Cj4+ICtjb25maWcgU0VS
SUFMX01WRUJVX0NPTlNPTEUKPj4gKwlib29sICJDb25zb2xlIG9uIE1hcnZlbGwgRUJVIHNlcmlh
bCBwb3J0Igo+PiArCWRlcGVuZHMgb24gU0VSSUFMX01WRUJVX1VBUlQKPgo+IElmIHllcywgdGhp
cyB3b3VsZCBiZWNvbWUgCj4KPiAJZGVwZW5kcyBvbiBTRVJJQUxfTVZFQlVfVUFSVD15CgpPSywg
bGV0J3MgdHJ5IHRvIGVuYWJsZSBpdC4KClRoYW5rcywKCkdyZWdvcnkKCj4KPiAJQXJuZAo+Cgot
LSAKR3JlZ29yeSBDbGVtZW50LCBGcmVlIEVsZWN0cm9ucwpLZXJuZWwsIGRyaXZlcnMsIHJlYWwt
dGltZSBhbmQgZW1iZWRkZWQgTGludXgKZGV2ZWxvcG1lbnQsIGNvbnN1bHRpbmcsIHRyYWluaW5n
IGFuZCBzdXBwb3J0LgpodHRwOi8vZnJlZS1lbGVjdHJvbnMuY29tCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

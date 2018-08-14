From: He Zhe <zhe.he@windriver.com>
Subject: Re: [PATCH v2 2/2] kgdboc: Change printk to the
 right fashion
Date: Tue, 14 Aug 2018 23:39:35 +0800
Message-ID: <e7e52f01-0ea6-094f-d9e9-cd2115311962@windriver.com>
References: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
 <1534250761-824-2-git-send-email-zhe.he@windriver.com>
 <20180814133536.bfpygzwnmlqfsee5@holly.lan>
 <1678613360b7aebbf1ab42dd89139cb666ee8cd9.camel@perches.com>
 <20180814144132.mpqzz3sxdbfzn7fe@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
In-Reply-To: <20180814144132.mpqzz3sxdbfzn7fe@holly.lan>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/kgdb-bugreport>,
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Daniel Thompson <daniel.thompson@linaro.org>, Joe Perches <golf@perches.com>
Cc: kgdb-bugreport@lists.sourceforge.net, jslaby@suse.com, linux-kernel@vger.kernel.org, jason.wessel@windriver.com, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-serial@vger.kernel.org

CgpPbiAyMDE45bm0MDjmnIgxNOaXpSAyMjo0MSwgRGFuaWVsIFRob21wc29uIHdyb3RlOgo+IE9u
IFR1ZSwgQXVnIDE0LCAyMDE4IGF0IDA3OjA0OjExQU0gLTA3MDAsIEpvZSBQZXJjaGVzIHdyb3Rl
Ogo+PiBPbiBUdWUsIDIwMTgtMDgtMTQgYXQgMTQ6MzUgKzAxMDAsIERhbmllbCBUaG9tcHNvbiB3
cm90ZToKPj4+IE9uIFR1ZSwgQXVnIDE0LCAyMDE4IGF0IDA4OjQ2OjAxUE0gKzA4MDAsIHpoZS5o
ZUB3aW5kcml2ZXIuY29tIHdyb3RlOgo+Pj4+IEZyb206IEhlIFpoZSA8emhlLmhlQHdpbmRyaXZl
ci5jb20+Cj4+Pj4KPj4+PiBwcl8qIGlzIHByZWZlcnJlZCBhY2NvcmRpbmcgdG8gc2NyaXB0cy9j
aGVja3BhdGNoLnBsLgo+PiBbXQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwv
a2dkYm9jLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwva2dkYm9jLmMKPj4gW10KPj4+PiBAQCAtMTM2
LDcgKzEzNiw3IEBAIHN0YXRpYyBpbnQga2dkYm9jX29wdGlvbl9zZXR1cChjaGFyICpvcHQpCj4+
Pj4gIAl9Cj4+Pj4gIAo+Pj4+ICAJaWYgKHN0cmxlbihvcHQpID49IE1BWF9DT05GSUdfTEVOKSB7
Cj4+Pj4gLQkJcHJpbnRrKEtFUk5fRVJSICJrZ2Rib2M6IGNvbmZpZyBzdHJpbmcgdG9vIGxvbmdc
biIpOwo+Pj4+ICsJCXByX2Vycigia2dkYm9jOiBjb25maWcgc3RyaW5nIHRvbyBsb25nXG4iKTsK
Pj4+IExvb2tzIGxpa2UgeW91IHNob3VsZCByZW1vdmUgdGhlIHRhZ3MgZnJvbSBwcl9lcnIgYW5k
IHVzZSBwcl9mbXQoZm10KSB0bwo+Pj4gcHV0IHRhZ3Mgb24gdGhlIG1lc3NhZ2VzOgo+Pj4KPj4+
ICNkZWZpbmUgcHJfZm10KGZtdCkgImtnZGJvYzogIiBmbXQKPj4gVHJ1ZSBhbmQgaXQncyBwcm9i
YWJseSBiZXR0ZXIgdG8gdXNlOgo+Pgo+PiAjZGVmaW5lIHByX2ZtdChmbXQpIEtCVUlMRF9NT0RO
QU1FICI6ICIgZm10Cj4gR29vZCBwb2ludCEgVGhhbmtzLgoKRGFuaWVsLCBKb2UsIHRoYW5rcyBm
b3IgeW91ciBnb29kIHN1Z2dlc3Rpb25zLiB2MyBpcyBzZW50LgoKWmhlCgo+Cj4KPiBEYW5pZWwu
Cj4KCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQ2hlY2sgb3V0IHRoZSB2aWJyYW50IHRlY2ggY29t
bXVuaXR5IG9uIG9uZSBvZiB0aGUgd29ybGQncyBtb3N0CmVuZ2FnaW5nIHRlY2ggc2l0ZXMsIFNs
YXNoZG90Lm9yZyEgaHR0cDovL3NkbS5saW5rL3NsYXNoZG90Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCktnZGItYnVncmVwb3J0IG1haWxpbmcgbGlzdApL
Z2RiLWJ1Z3JlcG9ydEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8va2dkYi1idWdyZXBvcnQK

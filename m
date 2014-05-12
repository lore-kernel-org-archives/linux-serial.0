From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/5] serial: imx: remove unneeded imx_transmit_buffer()
 from imx_start_tx()
Date: Mon, 12 May 2014 16:17:16 +0800
Message-ID: <5370838C.4060300@freescale.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
 <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com>
 <537042B5.2040600@freescale.com> <53706014.8010203@de.bosch.com>
 <53706A9A.6060707@freescale.com> <53706CC3.4030907@de.bosch.com>
 <53706FD8.6090201@freescale.com> <53708049.8060108@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53708049.8060108@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>
List-Id: linux-serial@vger.kernel.org

5LqOIDIwMTTlubQwNeaciDEy5pelIDE2OjAzLCBEZWFuIEplbmtpbnMg5YaZ6YGTOgo+IFdlbGws
IHRoZSBsb2NraW5nIG1pZ2h0IG5vdyBiZSBPSyBidXQgZHVlIHRvIGFuIGV4aXN0aW5nIGlzc3Vl
IHRoZSBUWCAKPiB3aWxsIGJlIHdva2VuIHVwIGV4Y2Vzc2l2ZWx5IHdpdGggbm8gbmV3IGNoYXJh
Y3RlcnMgdG8gdHJhbnNtaXQgc28gCj4gdGhlcmUgd2lsbCBiZSBleGNlc3NpdmUgY29udGV4dCBz
d2l0Y2hpbmcgd2l0aCB0aGUgbmV3IHdvcmsgcXVldWUgdGhhdCAKPiByZXN1bHRzIGluIG5vIHVz
ZWZ1bCB3b3JrIGRvbmUuIFRoZXJlIGlzIGFuIEFQSSBpc3N1ZSBpbiBIQ0kgTERJU0MgCj4gYmVj
YXVzZSBUVFlfRE9fV1JJVEVfV0FLRVVQIGlzIHNldCBCRUZPUkUgY2hlY2tpbmcgd2hldGhlciBh
bnkgCj4gY2hhcmFjdGVycyByZW1haW4gcGVuZGluZyB0byBiZSBzZW50LiBUaGlzIG1lYW5zIG1v
c3Qgb2YgdGhlIHRpbWUgCj4gaGNpX3VhcnRfdHhfd2FrZXVwKCkgaXMgdW5uZWNlc3NhcmlseSBj
YWxsZWQgd2lsbCBubyBjaGFuY2Ugb2Ygc2VlaW5nIAo+IGFueSByZW1haW4gcGVuZGluZyBjaGFy
YWN0ZXJzIHRvIGJlIHByb2Nlc3MuIFRoaXMgd2Vha25lc3MgY29udHJpYnV0ZWQgCj4gdG8gdHJp
Z2dlcmluZyBsb2NrdXAgaXNzdWUuCj4KWW91IGNhbiBzZW5kIGEgcGF0Y2ggdG8gZml4IHRoZSBC
bHVldG9vdGggY29kZS4gOikKSSBhbSBoYXBweSBpZiB5b3UgY2FuIGltcHJvdmUgdGhlIEJsdWV0
b290aC4KCnRoYW5rcwpIdWFuZyBTaGlqaWUKCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

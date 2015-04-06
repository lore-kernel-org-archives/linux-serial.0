From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
Date: Sun, 5 Apr 2015 18:36:37 -0700
Message-ID: <0838dec2-0adf-4e5e-a26c-f0752a0fd2f9@BL2FFO11FD031.protection.gbl>
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1428258294.2775.69.camel@perches.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joe Perches <joe@perches.com>
Cc: linux-ia64@vger.kernel.org, kernel@stlinux.com, Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>, Stefan Agner <stefan@agner.ch>, Patrice Chotard <patrice.chotard@st.com>, Pat Gefre <pfg@sgi.com>, Laxman Dewangan <ldewangan@nvidia.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Daniel Walker <dwalker@fifo99.com>, sparclinux@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Sonic Zhang <sonic.zhang@analog.com>, Jiri Slaby <jslaby@suse.cz>, Alexandre Courbot <gnurou@gmail.com>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>, linux-tegra@vger.kernel.org, David Brown <davidb@codeau>
List-Id: linux-serial@vger.kernel.org

T24gU3VuLCAyMDE1LTA0LTA1IGF0IDExOjI0QU0gLTA3MDAsIEpvZSBQZXJjaGVzIHdyb3RlOgo+
IFRoZXNlIHN0cnVjdHMgY2FuIGJlIGNvbnN0LCBzbyBtYWtlIHRoZW0gY29uc3QuCj4gCj4gTWlz
Y2VsbGFuZWE6Cj4gCj4gbyBBZGQgc3RhdGljIHRvIHN0cnVjdCB1YXJ0X29wcyBkZWNsYXJhdGlv
biBpbiBiZmluX3Nwb3J0X3VhcnQKPiAKPiBTaWduZWQtb2ZmLWJ5OiBKb2UgUGVyY2hlcyA8am9l
QHBlcmNoZXMuY29tPgo+IC0tLQpbLi4uXQoKRm9yOgo+ICBkcml2ZXJzL3R0eS9zZXJpYWwveGls
aW54X3VhcnRwcy5jICAgICAgICAgIHwgMiArLQoKVGVzdGVkLWJ5OiBTw7ZyZW4gQnJpbmttYW5u
IDxzb3Jlbi5icmlua21hbm5AeGlsaW54LmNvbT4KCglTw7ZyZW4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

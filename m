From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX 0/6] Second part of xuartps fixes
Date: Mon, 11 Jan 2016 17:41:35 -0800
Message-ID: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

SGksCgp0aGlzIGlzIHRoZSBzZWNvbmQgcGFydCBvZiBmaXhlcyBmb3IgeHVhcnRwcyB0aGF0IGV2
b2x2ZWQgZnJvbSB0aGlzCnNlcmllczogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTUvMTIvMjYv
MjYuCgpUaGlzIHNlcmllcywgb2J2aW91c2x5LCBkZXBlbmRzIG9uIHRoZSBwYXRjaGVzIG1lbnRp
b25lZCBhYm92ZS4gSXQKaW5jbHVkZXMgc2V2ZXJhbCBtaW5vciBpbXByb3ZlbWVudHMgYW5kIHJl
ZmFjdG9yaW5nIGFuZCB0aGUgcmVmYWN0b3JpbmcKb2YgdGhlIElSUSBtYW5hZ2VtZW50LCB3aGlj
aCBwcmV2ZW50cyBsb2NrIHVwcyB0aGF0IGNvdWxkIGhhcHBlbiB3aGVuClJYLXJlbGF0ZWQgSVJR
cyBmaXJlZCB3aGlsZSB0aGUgcmVjZWl2ZXIgd2FzIGRpc2FibGVkLgoKCVRoYW5rcywKCVPDtnJl
bgoKU8O2cmVuIEJyaW5rbWFubiAoNik6CiAgdHR5OiB4dWFydHBzOiBNb3ZlIHJlcXVlc3RfaXJx
IHRvIGFmdGVyIHNldHRpbmcgdXAgdGhlIEhXCiAgdHR5OiB4dWFydHBzOiBSZWZhY3RvciBJUlEg
aGFuZGxpbmcKICB0dHk6IHh1YXJ0cHM6IENsZWFudXA6IFJlZm9ybWF0IGlmLWVsc2UKICB0dHk6
IHh1YXJ0cHM6IEltcHJvdmUgc3lzcnEgaGFuZGxpbmcKICB0dHk6IHh1YXJ0cHM6IFJlbW92ZSAn
X09GRlNFVCcgc3VmZml4IGZyb20gI2RlZmluZXMKICB0dHk6IHh1YXJ0cHM6IENvbnNvbGlkYXRl
IFRYIGhhbmRsaW5nCgogZHJpdmVycy90dHkvc2VyaWFsL3hpbGlueF91YXJ0cHMuYyB8IDQ2MCAr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjE2
IGluc2VydGlvbnMoKyksIDI0NCBkZWxldGlvbnMoLSkKCi0tIAoyLjcuMC4zLmc0OTdlYTFlCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=

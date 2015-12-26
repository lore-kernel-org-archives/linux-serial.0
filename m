From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v5 0/8] tty: xuartps: Fix lock ups
Date: Sat, 26 Dec 2015 02:43:48 -0800
Message-ID: <1451126636-13699-1-git-send-email-soren.brinkmann@xilinx.com>
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
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

SGksCgphcyByZXF1ZXN0ZWQgYnkgUGV0ZXIsIHRoaXMgaXMgdGhlIGZpcnN0IHBhcnQgb2YgbXkg
c2VyaWVzIHdoaWNoIGhhcyB0aGUKcGF0Y2hlcyByZXZpZXdlZCBieSBQZXRlci4gSSdsbCBzdWJt
aXQgdGhlIHNlY29uZCBwYXJ0IHNlcGFyYXRlbHkuIFRoZXJlCmFyZSBubyBuZXcgY2hhbmdlcyB3
aXRoaW4gdGhlIHBhdGNoZXMuCgoJVGhhbmtzLAoJU8O2cmVuCgpTw7ZyZW4gQnJpbmttYW5uICg4
KToKICB0dHk6IHh1YXJ0cHM6IEJlYXV0aWZ5IHJlYWQtbW9kaWZ5IHdyaXRlcwogIHR0eTogeHVh
cnRwczogVXNlIHNwaW5sb2NrIHRvIHNlcmlhbGl6ZSBIVyBhY2Nlc3MKICB0dHk6IHh1YXJ0cHM6
IERvbid0IGNvbnNpZGVyIGNpcmN1bGFyIGJ1ZmZlciB3aGVuIGVuYWJsaW5nIHRyYW5zbWl0dGVy
CiAgdHR5OiB4dWFydHBzOiBDbGVhciBpbnRlcnJ1cHQgc3RhdHVzIHJlZ2lzdGVyIGluIHNodXRk
b3duCiAgdHR5OiB4dWFydHBzOiBJbXByb3ZlIHN0YXJ0dXAgZnVuY3Rpb24KICB0dHk6IHh1YXJ0
cHM6IEtlZXAgbG9jayBmb3Igd2hvbGUgSVNSCiAgdHR5OiB4dWFydHBzOiBBY3F1aXJlIHBvcnQg
bG9jayBmb3Igc2h1dGRvd24KICB0dHk6IHh1YXJ0cHM6IE1vdmUgUlggcGF0aCBpbnRvIGhlbHBl
ciBmdW5jdGlvbgoKIGRyaXZlcnMvdHR5L3NlcmlhbC94aWxpbnhfdWFydHBzLmMgfCAxMTcgKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDY2IGlu
c2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQoKLS0gCjIuNi4zLjMuZzliYjk5NmEKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==

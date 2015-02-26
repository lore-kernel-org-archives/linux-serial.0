From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH v2 10/11] tty: kconfig: remove the superfluous dependency on
 PPC_OF
Date: Thu, 26 Feb 2015 20:08:22 +0800
Message-ID: <1424952503-8247-11-git-send-email-haokexin@gmail.com>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

SW4gdGhlIGN1cnJlbnQga2VybmVsLCB0aGUgQ09ORklHX1BQQ19PRiBpcyBhbHdheXMgJ3knIGZv
ciB0aGUgcHBjCmFyY2guIFNvIHdlIGRvbid0IG5lZWQgdG8gY2hlY2sgaXQgd2l0aCBvdGhlciBw
cGMgc3BlY2lmaWMgb3B0aW9ucy4KClNpZ25lZC1vZmYtYnk6IEtldmluIEhhbyA8aGFva2V4aW5A
Z21haWwuY29tPgotLS0KdjI6IE5vIGNoYW5nZS4KCiBkcml2ZXJzL3R0eS9zZXJpYWwvS2NvbmZp
ZyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvS2NvbmZpZyBiL2RyaXZlcnMvdHR5
L3NlcmlhbC9LY29uZmlnCmluZGV4IGQyNTAxZjAxY2QwMy4uNzc0NzFkM2RiOGQzIDEwMDY0NAot
LS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvS2NvbmZpZworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
S2NvbmZpZwpAQCAtODM1LDcgKzgzNSw3IEBAIGNvbmZpZyBTRVJJQUxfTUNGX0NPTlNPTEUKIAog
Y29uZmlnIFNFUklBTF9QTUFDWklMT0cKIAl0cmlzdGF0ZSAiTWFjIG9yIFBvd2VyTWFjIHo4NWMz
MCBFU0NDIHN1cHBvcnQiCi0JZGVwZW5kcyBvbiAoTTY4SyAmJiBNQUMpIHx8IChQUENfT0YgJiYg
UFBDX1BNQUMpCisJZGVwZW5kcyBvbiAoTTY4SyAmJiBNQUMpIHx8IFBQQ19QTUFDCiAJc2VsZWN0
IFNFUklBTF9DT1JFCiAJaGVscAogCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgdGhlIFppbG9nIHo4
NUMzMCBzZXJpYWwgcG9ydHMgZm91bmQgb24KQEAgLTExNTMsNyArMTE1Myw3IEBAIGNvbmZpZyBT
RVJJQUxfT01BUF9DT05TT0xFCiAKIGNvbmZpZyBTRVJJQUxfT0ZfUExBVEZPUk1fTldQU0VSSUFM
CiAJdHJpc3RhdGUgIk5XUCBzZXJpYWwgcG9ydCBkcml2ZXIiCi0JZGVwZW5kcyBvbiBQUENfT0Yg
JiYgUFBDX0RDUgorCWRlcGVuZHMgb24gUFBDX0RDUgogCXNlbGVjdCBTRVJJQUxfT0ZfUExBVEZP
Uk0KIAlzZWxlY3QgU0VSSUFMX0NPUkVfQ09OU09MRQogCXNlbGVjdCBTRVJJQUxfQ09SRQotLSAK
MS45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0
cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==

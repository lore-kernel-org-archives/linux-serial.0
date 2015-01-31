From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 13/15] tty: kconfig: remove the superfluous dependency on
 PPC_OF
Date: Sat, 31 Jan 2015 21:47:43 +0800
Message-ID: <1422712065-9403-14-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
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
To: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hao <haokexin@gmail.com>
List-Id: linux-serial@vger.kernel.org

SW4gdGhlIGN1cnJlbnQga2VybmVsLCB0aGUgQ09ORklHX1BQQ19PRiBpcyBhbHdheXMgJ3knIGZv
ciB0aGUgcHBjCmFyY2guIFNvIHdlIGRvbid0IG5lZWQgdG8gY2hlY2sgaXQgd2l0aCBvdGhlciBw
cGMgc3BlY2lmaWMgb3B0aW9ucy4KClNpZ25lZC1vZmYtYnk6IEtldmluIEhhbyA8aGFva2V4aW5A
Z21haWwuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9LY29uZmlnIHwgNCArKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdHR5L3NlcmlhbC9LY29uZmlnIGIvZHJpdmVycy90dHkvc2VyaWFsL0tjb25maWcK
aW5kZXggNTkzMzJhZmM3MmU5Li4xMTdhZTI1MmQ2MjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5
L3NlcmlhbC9LY29uZmlnCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9LY29uZmlnCkBAIC04NDQs
NyArODQ0LDcgQEAgY29uZmlnIFNFUklBTF9NQ0ZfQ09OU09MRQogCiBjb25maWcgU0VSSUFMX1BN
QUNaSUxPRwogCXRyaXN0YXRlICJNYWMgb3IgUG93ZXJNYWMgejg1YzMwIEVTQ0Mgc3VwcG9ydCIK
LQlkZXBlbmRzIG9uIChNNjhLICYmIE1BQykgfHwgKFBQQ19PRiAmJiBQUENfUE1BQykKKwlkZXBl
bmRzIG9uIChNNjhLICYmIE1BQykgfHwgUFBDX1BNQUMKIAlzZWxlY3QgU0VSSUFMX0NPUkUKIAlo
ZWxwCiAJICBUaGlzIGRyaXZlciBzdXBwb3J0cyB0aGUgWmlsb2cgejg1QzMwIHNlcmlhbCBwb3J0
cyBmb3VuZCBvbgpAQCAtMTE1Miw3ICsxMTUyLDcgQEAgY29uZmlnIFNFUklBTF9PTUFQX0NPTlNP
TEUKIAogY29uZmlnIFNFUklBTF9PRl9QTEFURk9STV9OV1BTRVJJQUwKIAl0cmlzdGF0ZSAiTldQ
IHNlcmlhbCBwb3J0IGRyaXZlciIKLQlkZXBlbmRzIG9uIFBQQ19PRiAmJiBQUENfRENSCisJZGVw
ZW5kcyBvbiBQUENfRENSCiAJc2VsZWN0IFNFUklBTF9PRl9QTEFURk9STQogCXNlbGVjdCBTRVJJ
QUxfQ09SRV9DT05TT0xFCiAJc2VsZWN0IFNFUklBTF9DT1JFCi0tIAoxLjkuMwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxp
bmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFi
cy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

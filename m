From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2] earlycon: 8250: Fix command line regression
Date: Fri, 3 Apr 2015 23:05:09 -0700
Message-ID: <CAE9FiQWpkGbbVT=vbKXLZchE3H3KnG0X8QQjcdGpw5xk4XOPRw@mail.gmail.com>
References: <1428102229-26103-1-git-send-email-peter@hurleysoftware.com>
	<1428105875-4038-1-git-send-email-peter@hurleysoftware.com>
	<CAE9FiQWvxfg_mG4pab=yBHKbq8C+_ujiHtx2mmzS6aEfMzG8Jw@mail.gmail.com>
	<CAE9FiQV_TC1Xd6+7e2mHNCEZG8PDTQtZfUoWsWmLhmLnu2CeSQ@mail.gmail.com>
	<551F5742.70508@hurleysoftware.com>
	<CAE9FiQV+8sjq6DSqojQ9vyziPiriqtMVJonW7uevPFHBsjKOWA@mail.gmail.com>
	<551F5B45.6030806@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1141bd00f037ff0512dfd84b
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <551F5B45.6030806@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

--001a1141bd00f037ff0512dfd84b
Content-Type: text/plain; charset=UTF-8

On Fri, Apr 3, 2015 at 8:32 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 04/03/2015 11:24 PM, Yinghai Lu wrote:
>> On Fri, Apr 3, 2015 at 8:15 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> On 04/03/2015 11:09 PM, Yinghai Lu wrote:
>>>> On Fri, Apr 3, 2015 at 7:19 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>>> On Fri, Apr 3, 2015 at 5:04 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>>> Restore undocumented behavior of kernel command line parameters of
>>>>>> the forms:
>>>>>>     console=uart[8250],io|mmio|mmio32,<addr>[,options]
>>>>>>     console=uart[8250],<addr>[,options]
>>>>>> where 'options' have not been specified; in this case, the hardware
>>>>>> is assumed to be initialized.
>>>>>
>>>>>
>>>>> This patch fix regression for the hand over.  Thanks.
>>>>
>>>> Just now noticed, this patch only fix partial problem. Kernel console is ok.
>>>>
>>>> But later initrd/init scripts revert back to 9600 again.
>>>

I updated my fix a little bit. please check attached.

Thanks

Yinghai

--001a1141bd00f037ff0512dfd84b
Content-Type: text/x-patch; charset=US-ASCII; name="fix_earlycon_console_handover_v2.patch"
Content-Disposition: attachment;
	filename="fix_earlycon_console_handover_v2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i82m6s3k0

U3ViamVjdDogW1BBVENIIC12Ml0gZWFybHljb246IEZpeCBlYXJseWNvbi9jb25zb2xlIGhhbmRv
dmVyIHdpdGhvdXQgb3B0aW9ucwoKY29tbWl0IGM3Y2VmMGE4NDkxMiAoImNvbnNvbGU6IEFkZCBl
eHRlbnNpYmxlIGNvbnNvbGUgbWF0Y2hpbmciKQpicm9rZSB0aGUgZWFybHljb24vaGFuZG92ZXIg
d2hlbiBib290aW5nCmNvbnNvbGU9dWFydDgyNTAsaW8sMHgzZjgKCnRoZSBib290bG9hZGVyIGlz
IHVzaW5nIDExNTIwMCwgYW5kIHRoZSBlYXJseWNvbiBjb250aW51ZQp1c2UgMTE1MjAwLCBidXQg
Y29uc29sZSByZXZlcnQgYmFjayB0byA5NjAwLgoKQmVmb3JlIHRoZSBjb21taXQsIHByb2JlZCBi
YXVkIHJhdGUgaXMgcGFzc2VkIHZpYSBjb25zb2xlX2NtZGxpbmUKZnJvbSBlYXJseWNvbiB0byBu
b3JtYWwgY29uc29sZS4KVGhhdCBjb21taXQgcmVtb3ZlIHRoYXQgYW5kIG9ubHkgY2hlY2sgYm9v
dCBjb21tYW5kIGxpbmUuCgpUaGlzIHBhdGNoIHVzZSBwb3J0IG1hdGNoIHRvIGdldCBob2xkIGVh
cmx5Y29uLCBhbmQgdXNlIGVhcmx5Y29uCmRldmljZSBvcHRpb25zIHRvIHVwZGF0ZSBvcHRpb25z
IGZvciBjb25zb2xlLgoKRml4ZXM6IGNvbW1pdCBjN2NlZjBhODQ5MTIgKCJjb25zb2xlOiBBZGQg
ZXh0ZW5zaWJsZSBjb25zb2xlIG1hdGNoaW5nIikKU2lnbmVkLW9mZi1ieTogWWluZ2hhaSBMdSA8
eWluZ2hhaUBrZXJuZWwub3JnPgoKLS0tCi12Mjogc2ltcGxpZnkgc2VyaWFsODI1MF9nZXRfZWFy
bHljb25fb3B0aW9ucyBhbmQgZG9uJ3QgdXBkYXRlCiAgICAgY29uc29sZV9jbWRsaW5lLgotLS0K
IGRyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfY29yZS5jICB8ICAgIDQgKysrKwogZHJpdmVy
cy90dHkvc2VyaWFsLzgyNTAvODI1MF9lYXJseS5jIHwgICAxNyArKysrKysrKysrKysrKysrKwog
aW5jbHVkZS9saW51eC9zZXJpYWxfODI1MC5oICAgICAgICAgIHwgICAgMSArCiAzIGZpbGVzIGNo
YW5nZWQsIDIyIGluc2VydGlvbnMoKykKCkluZGV4OiBsaW51eC0yLjYvZHJpdmVycy90dHkvc2Vy
aWFsLzgyNTAvODI1MF9jb3JlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVy
cy90dHkvc2VyaWFsLzgyNTAvODI1MF9jb3JlLmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3R0eS9z
ZXJpYWwvODI1MC84MjUwX2NvcmUuYwpAQCAtMzQ5MSw2ICszNDkxLDEwIEBAIHN0YXRpYyBpbnQg
dW5pdjgyNTBfY29uc29sZV9tYXRjaChzdHJ1Y3QKIAkJCWNvbnRpbnVlOwogCiAJCWNvLT5pbmRl
eCA9IGk7CisKKwkJaWYgKCFvcHRpb25zKQorCQkJb3B0aW9ucyA9IHNlcmlhbDgyNTBfZ2V0X2Vh
cmx5Y29uX29wdGlvbnMocG9ydCk7CisKIAkJcmV0dXJuIHVuaXY4MjUwX2NvbnNvbGVfc2V0dXAo
Y28sIG9wdGlvbnMpOwogCX0KIApJbmRleDogbGludXgtMi42L2RyaXZlcnMvdHR5L3NlcmlhbC84
MjUwLzgyNTBfZWFybHkuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL3R0
eS9zZXJpYWwvODI1MC84MjUwX2Vhcmx5LmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3R0eS9zZXJp
YWwvODI1MC84MjUwX2Vhcmx5LmMKQEAgLTEwNSw2ICsxMDUsMjIgQEAgc3RhdGljIHZvaWQgX19p
bml0IGVhcmx5X3NlcmlhbDgyNTBfd3JpdAogCQlzZXJpYWw4MjUwX2Vhcmx5X291dChwb3J0LCBV
QVJUX0lFUiwgaWVyKTsKIH0KIAorc3RhdGljIHN0cnVjdCBlYXJseWNvbl9kZXZpY2UgKmVhcmx5
X2RldmljZTsKKworY2hhciAqc2VyaWFsODI1MF9nZXRfZWFybHljb25fb3B0aW9ucyhzdHJ1Y3Qg
dWFydF9wb3J0ICp1cCkKK3sKKwlzdHJ1Y3QgZWFybHljb25fZGV2aWNlICpkZXZpY2UgPSBlYXJs
eV9kZXZpY2U7CisJc3RydWN0IHVhcnRfcG9ydCAqcG9ydCA9IGRldmljZSA/ICZkZXZpY2UtPnBv
cnQgOiBOVUxMOworCisJaWYgKCFwb3J0IHx8ICghcG9ydC0+bWVtYmFzZSAmJiAhcG9ydC0+aW9i
YXNlKSkKKwkJcmV0dXJuIE5VTEw7CisKKwlpZiAoIXVhcnRfbWF0Y2hfcG9ydCh1cCwgcG9ydCkp
CisJCXJldHVybiBOVUxMOworCisJcmV0dXJuIGRldmljZS0+b3B0aW9uczsKK30KKwogc3RhdGlj
IHVuc2lnbmVkIGludCBfX2luaXQgcHJvYmVfYmF1ZChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQog
ewogCXVuc2lnbmVkIGNoYXIgbGNyLCBkbGwsIGRsbTsKQEAgLTE2MSw2ICsxNzcsNyBAQCBzdGF0
aWMgaW50IF9faW5pdCBlYXJseV9zZXJpYWw4MjUwX3NldHVwCiAJfSBlbHNlCiAJCWluaXRfcG9y
dChkZXZpY2UpOwogCisJZWFybHlfZGV2aWNlID0gZGV2aWNlOwogCWRldmljZS0+Y29uLT53cml0
ZSA9IGVhcmx5X3NlcmlhbDgyNTBfd3JpdGU7CiAJcmV0dXJuIDA7CiB9CkluZGV4OiBsaW51eC0y
LjYvaW5jbHVkZS9saW51eC9zZXJpYWxfODI1MC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi5v
cmlnL2luY2x1ZGUvbGludXgvc2VyaWFsXzgyNTAuaAorKysgbGludXgtMi42L2luY2x1ZGUvbGlu
dXgvc2VyaWFsXzgyNTAuaApAQCAtMTM1LDYgKzEzNSw3IEBAIHZvaWQgc2VyaWFsODI1MF9yZXN1
bWVfcG9ydChpbnQgbGluZSk7CiAKIGV4dGVybiBpbnQgZWFybHlfc2VyaWFsX3NldHVwKHN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQpOwogCitleHRlcm4gY2hhciAqc2VyaWFsODI1MF9nZXRfZWFybHlj
b25fb3B0aW9ucyhzdHJ1Y3QgdWFydF9wb3J0ICp1cCk7CiBleHRlcm4gdW5zaWduZWQgaW50IHNl
cmlhbDgyNTBfZWFybHlfaW4oc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgaW50IG9mZnNldCk7CiBl
eHRlcm4gdm9pZCBzZXJpYWw4MjUwX2Vhcmx5X291dChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBp
bnQgb2Zmc2V0LCBpbnQgdmFsdWUpOwogZXh0ZXJuIHZvaWQgc2VyaWFsODI1MF9kb19zZXRfdGVy
bWlvcyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LAo=
--001a1141bd00f037ff0512dfd84b--

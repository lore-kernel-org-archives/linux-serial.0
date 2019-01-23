From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] 8250_pci.c: Update NI specific devices class to multi serial
Date: Wed, 23 Jan 2019 18:06:33 +0200
Message-ID: <CAHp75Vd+p8d87v_YEkzMLh8sxmvPYk3XeFdkpsrY_jTsC2zHCQ@mail.gmail.com>
References: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com> <CAHp75VcxtSi64qsK6tHx+vtEeRsX3ZVwfzRYOVuyS=qSTnK0qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000d11e1b0580224740"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcxtSi64qsK6tHx+vtEeRsX3ZVwfzRYOVuyS=qSTnK0qQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Yung Tseng <guan.yung.tseng@ni.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

--000000000000d11e1b0580224740
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 23, 2019 at 5:18 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jan 14, 2019 at 4:13 PM Guan Yung Tseng <guan.yung.tseng@ni.com> wrote:
> >
> > Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> > The reason of doing this is because all NI multi port serial cards
> > use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
> > serial_pci_is_class_communication test added in the commit 7d8905d06405
> > ("serial: 8250_pci: Enable device after we check black list").
>
> Guan, can you provide an output of the
>
> lspci -nk -xx -vv -s <BDF>
>
> of your device, where <BDF> is a PCI address in a form of bus:device.function?

While I'm still wondering of the above, can you also test the bellow
patch if it fixes your issue?




-- 
With Best Regards,
Andy Shevchenko

--000000000000d11e1b0580224740
Content-Type: text/x-patch; charset="US-ASCII"; name="8250-pci-1.diff"
Content-Disposition: attachment; filename="8250-pci-1.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jr9ds4ir0>
X-Attachment-Id: f_jr9ds4ir0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcGNpLmMgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX3BjaS5jCmluZGV4IGY4MGEzMDBiNWQ2OC4uNDhiZDY5NGE1
ZmExIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BjaS5jCisrKyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcGNpLmMKQEAgLTM0MjAsNiArMzQyMCwxMSBA
QCBzdGF0aWMgaW50CiBzZXJpYWxfcGNpX2d1ZXNzX2JvYXJkKHN0cnVjdCBwY2lfZGV2ICpkZXYs
IHN0cnVjdCBwY2lzZXJpYWxfYm9hcmQgKmJvYXJkKQogewogCWludCBudW1faW9tZW0sIG51bV9w
b3J0LCBmaXJzdF9wb3J0ID0gLTEsIGk7CisJaW50IHJjOworCisJcmMgPSBzZXJpYWxfcGNpX2lz
X2NsYXNzX2NvbW11bmljYXRpb24oZGV2KTsKKwlpZiAocmMpCisJCXJldHVybiByYzsKIAogCS8q
CiAJICogU2hvdWxkIHdlIHRyeSB0byBtYWtlIGd1ZXNzZXMgZm9yIG11bHRpcG9ydCBzZXJpYWwg
ZGV2aWNlcyBsYXRlcj8KQEAgLTM2NDcsMTAgKzM2NTIsNiBAQCBwY2lzZXJpYWxfaW5pdF9vbmUo
c3RydWN0IHBjaV9kZXYgKmRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkKIAog
CWJvYXJkID0gJnBjaV9ib2FyZHNbZW50LT5kcml2ZXJfZGF0YV07CiAKLQlyYyA9IHNlcmlhbF9w
Y2lfaXNfY2xhc3NfY29tbXVuaWNhdGlvbihkZXYpOwotCWlmIChyYykKLQkJcmV0dXJuIHJjOwot
CiAJcmMgPSBzZXJpYWxfcGNpX2lzX2JsYWNrbGlzdGVkKGRldik7CiAJaWYgKHJjKQogCQlyZXR1
cm4gcmM7Cg==
--000000000000d11e1b0580224740--

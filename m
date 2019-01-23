From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] 8250_pci.c: Update NI specific devices class to multi serial
Date: Wed, 23 Jan 2019 17:18:48 +0200
Message-ID: <CAHp75VcxtSi64qsK6tHx+vtEeRsX3ZVwfzRYOVuyS=qSTnK0qQ@mail.gmail.com>
References: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Yung Tseng <guan.yung.tseng@ni.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 14, 2019 at 4:13 PM Guan Yung Tseng <guan.yung.tseng@ni.com> wrote:
>
> Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> The reason of doing this is because all NI multi port serial cards
> use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
> serial_pci_is_class_communication test added in the commit 7d8905d06405
> ("serial: 8250_pci: Enable device after we check black list").

Guan, can you provide an output of the

lspci -nk -xx -vv -s <BDF>

of your device, where <BDF> is a PCI address in a form of bus:device.function?

-- 
With Best Regards,
Andy Shevchenko

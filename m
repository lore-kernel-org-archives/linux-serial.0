From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 13/36] nds32: Device specific operations
Date: Mon, 18 Dec 2017 12:26:23 +0100
Message-ID: <CAK8P3a0xQ4mYnkxjWTTEcvpJg6SfcA4WZKNkopa93_6Mz_YOGw@mail.gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com> <ec54d5ac8067e2ff542f69fc2967182922870b83.1513577007.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <ec54d5ac8067e2ff542f69fc2967182922870b83.1513577007.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, ren_guo@c-sky.com, Philip
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 18, 2017 at 7:46 AM, Greentime Hu <green.hu@gmail.com> wrote:

> +#define __ASM_NDS32_IO_H
> +
> +extern void iounmap(void __iomem *addr);

The prototype here should probably include 'volatile' to avoid warnings in an
allmodconfig build.

      Arnd

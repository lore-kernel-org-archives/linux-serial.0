From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Sun, 20 Dec 2015 17:05:54 +0200
Message-ID: <CAHp75VcuUrpmfEHcNqtgOkOT3wf52KnF4=R0JF80+2X2AVhMNQ@mail.gmail.com>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
	<CAHp75Vfn_mr0hW71xsTCvDGX87ktPaN2E1TVTNjdbxR83-nxcg@mail.gmail.com>
	<20151220144722.GA26499@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151220144722.GA26499@sudip-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 20, 2015 at 4:47 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> On Sun, Dec 20, 2015 at 04:18:17PM +0200, Andy Shevchenko wrote:
>> On Sun, Dec 20, 2015 at 3:24 PM, Sudip Mukherjee
>> <sudipm.mukherjee@gmail.com> wrote:
>> > Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
>> > can be controlled using gpio interface.
>> > Add support to use these pins and select GPIO_SYSFS also so that these
>> > pins can be used from the userspace through sysfs.


>> > +err_destroy:
>> > +       mutex_unlock(&exar_mtx);
>> > +       mutex_destroy(&exar_gpio->lock);
>> > +err_unmap:
>> > +       iounmap(p);
>>
>> pci_iounmap?
>
> I thought about pci_iounmap but I saw that most of the code in
> 8250_pci.c is using iounmap, so i went in favor of the majority.
> Will change it.

Okay, let maintainers speak about it,

>> > +static void __exit exar_gpio_exit(void)
>> > +{
>> > +}
>> > +
>> > +module_exit(exar_gpio_exit);
>> > +
>> > +static int __init exar_gpio_init(void)
>> > +{
>> > +       return 0;
>> > +}
>> > +
>> > +module_init(exar_gpio_init);
>> > +
>>
>> Useless for now. You are using it as a library.
>
> Main doubt here. If I do not give the module_init() and module_exit()
> then what entry do i keep in the Kconfig?

I don't see any problem. It's already somehow classical approach in
the drivers when core part is represented as a library (one example
comes immediately to my mind is drivers/dma/dw/core.c, I think you may
find much more in the kernel sources).

> In this v3, it is kept as
> tristate. Should that be bool then?

No, why?


-- 
With Best Regards,
Andy Shevchenko

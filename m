From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 0/6] UART slave devices using serio
Date: Tue, 1 Nov 2016 22:49:04 -0500
Message-ID: <CAL_JsqLB+1jtHMK-jvmnsFMX_bO=CwzxgPjBZu=6JksL4r=yfQ@mail.gmail.com>
References: <20160824232437.9446-1-robh@kernel.org> <20161025215521.5a5uxjpujmoatgor@earth>
 <CAL_JsqJQqkyz99SY=RcQ22ZzsQSuCjFkjEPLdEqLmJU-usBf-g@mail.gmail.com>
 <CAKU3ayV7vLSaNJGzV2MoCyT2GopReS55DCH4MPtSmGiHEUKdXw@mail.gmail.com> <CAL_JsqKhq9vVV9yvzd3OFUbNvHwj+3Ta9eHrWg97xLRfTxPCPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKhq9vVV9yvzd3OFUbNvHwj+3Ta9eHrWg97xLRfTxPCPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 31, 2016 at 10:40 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Oct 31, 2016 at 3:00 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On Tue, Oct 25, 2016 at 4:02 PM, Rob Herring <robh@kernel.org> wrote:
>>>
>>> > Maybe you can try to find some minutes at the Kernel Summit to talk
>>> > about this?
>>>
>>> Still waiting for my invite...
>>>
>>> But I will be at Plumbers if folks want to discuss this.
>>
>>
>> Hey Rob,
>>
>> I'm here so let's make time to discuss this.
>
> Tomorrow should be good for me after the complex device dependencies discussion.

I have a somewhat working branch using ttyport and serio here[1]. It
works with a BT device to the level the device works with my PC which
is only identifying the BCM device and loading the firmware.

I'm still not sure using serio really buys us much. We probably want
to hide some of the sysfs files when using DT binding. It also
provides a file to reconnect devices. I suppose this is because there
is typically no hotplug detection on PS/2 ports? Serio also provides
its own async binding mechanism. Perhaps this can be updated to use
async probing?

The registration of serio ports is a bit problematic. I had the tty
port registration call into the serio ttyport driver to register, but
this broke serio working as a module. While serial drivers can be
modules, the tty_port code is always built-in. So the serio ttyport
driver will request a callback for all tty ports when the serio driver
is loaded. This means any tty driver hotplugged after serio will not
be registered with serio. The only other solution I see is serio would
have to be built-in.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git serio-tty-slave

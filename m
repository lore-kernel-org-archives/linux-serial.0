From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/9] tty: tty_struct dependency clean-ups
Date: Sun, 11 Sep 2016 22:05:07 -0500
Message-ID: <CAL_Jsq+tk2_p=pqJz_4iM-xcN5Ecfqhpc_oa0zbBRgS2dOpbOg@mail.gmail.com>
References: <20160909223711.26238-1-robh@kernel.org> <20160911221424.2d56682a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160911221424.2d56682a@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Sep 11, 2016 at 4:14 PM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
> On Fri,  9 Sep 2016 17:37:01 -0500
> Rob Herring <robh@kernel.org> wrote:
>
>> This patch series removes or prepares to remove some of the dependencies
>> on tty_struct within tty_port drivers. This will allow using tty_ports
>> directly for so called UART slave devices.
>
> You can create a tty_struct kernel side with the two tiny changes I
> posted before. Why do you want to do invasive tree wide changes when you
> can do simple ones ?

Well, I don't want to do invasive changes, but I thought the idea was
to use tty_port struct without a tty_struct.

>> Next up after this are moving some functions to the tty_port ops. I've
>> got some WIP patches for some of that, but nothing ready to send out
>> quite yet.
>
> I think before this lot happens you need to decide where these structures
> belong. Termios and termios_locked for example could live in the tty_port
> as the physical tty is incapable of having multiple sets of terminal data
> at once.

I was planning to keep termios out of tty_port and make clients of
tty_port carry it if for nothing else not quite understanding all the
details around the lifetime, init and locking of it. If there's always
a tty_struct then there's not much point moving it other than which
struct makes more sense. But that would cause some churn.

Rob

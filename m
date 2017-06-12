From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC, PATCH] imx: serial: Take tty->files_lock opportunistically
Date: Sun, 11 Jun 2017 21:33:13 -0300
Message-ID: <CAOMZO5A_hLkuQkmfQFmCmLtCFimf0i70WbtYMr0o811vpreKbA@mail.gmail.com>
References: <20170530123726.18598-1-andrew.smirnov@gmail.com>
 <CAL_JsqJUF8NhEhGY2FPPX5GUF3oP9XONQJy9sj42uPYATskz9A@mail.gmail.com>
 <20170530144213.48df2a1c@alans-desktop> <20170530134427.GD6786@collabora.com> <20170603093048.GA9120@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170603093048.GA9120@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Senna Tschudin <peter.senna@collabora.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rob Herring <robherring2@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Chris Healy <cphealy@gmail.com>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

On Sat, Jun 3, 2017 at 6:30 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, May 30, 2017 at 03:44:27PM +0200, Peter Senna Tschudin wrote:
>> On Tue, May 30, 2017 at 02:42:13PM +0100, Alan Cox wrote:
>>
>> I sent a second patch recently:
>>
>> https://patchwork.kernel.org/patch/9725625/
>
> And it's already in linux-next so all should be good here.

linux-next is good, but mainline is not.

Actually we need 4dec2f119e86f9c9 ("imx-serial: RX DMA startup
latency") to be applied to 4.12-rc as well.

Thanks

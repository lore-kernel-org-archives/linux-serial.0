From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC, PATCH] imx: serial: Take tty->files_lock opportunistically
Date: Sat, 3 Jun 2017 18:30:48 +0900
Message-ID: <20170603093048.GA9120@kroah.com>
References: <20170530123726.18598-1-andrew.smirnov@gmail.com>
 <CAL_JsqJUF8NhEhGY2FPPX5GUF3oP9XONQJy9sj42uPYATskz9A@mail.gmail.com>
 <20170530144213.48df2a1c@alans-desktop>
 <20170530134427.GD6786@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170530134427.GD6786@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Senna Tschudin <peter.senna@collabora.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rob Herring <robherring2@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Chris Healy <cphealy@gmail.com>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 30, 2017 at 03:44:27PM +0200, Peter Senna Tschudin wrote:
> On Tue, May 30, 2017 at 02:42:13PM +0100, Alan Cox wrote:
> 
> I sent a second patch recently:
> 
> https://patchwork.kernel.org/patch/9725625/

And it's already in linux-next so all should be good here.

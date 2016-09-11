From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/9] tty: tty_struct dependency clean-ups
Date: Sun, 11 Sep 2016 22:14:24 +0100
Message-ID: <20160911221424.2d56682a@lxorguk.ukuu.org.uk>
References: <20160909223711.26238-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri,  9 Sep 2016 17:37:01 -0500
Rob Herring <robh@kernel.org> wrote:

> This patch series removes or prepares to remove some of the dependencies 
> on tty_struct within tty_port drivers. This will allow using tty_ports 
> directly for so called UART slave devices. 

You can create a tty_struct kernel side with the two tiny changes I
posted before. Why do you want to do invasive tree wide changes when you
can do simple ones ?

> Next up after this are moving some functions to the tty_port ops. I've 
> got some WIP patches for some of that, but nothing ready to send out 
> quite yet.

I think before this lot happens you need to decide where these structures
belong. Termios and termios_locked for example could live in the tty_port
as the physical tty is incapable of having multiple sets of terminal data
at once.

Really though this looks to me like *MASSIVE* churn for now purpose.
Create a tty_struct kernel side, and use that, the needed patch is then
tiny.

so IMHO NAK

Alan

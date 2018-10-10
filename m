From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Insanely high baud rates
Date: Wed, 10 Oct 2018 21:17:17 +0100
Message-ID: <20181010211717.30c1f052@alans-desktop>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

On Tue, 9 Oct 2018 12:19:04 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> [Resending to a wider audience]
> 
> In trying to get the termios2 interface actually implemented in glibc,
> the question came up if we will ever care about baud rates in excess of
> 4 Gbps, even in the relatively remote future.

Even RS485 at 4MBits involves deep magic. I think we are fairly safe. Not
only that but our entire tty layer isn't capable of sustaining anything
even remotely in that range.

I think its non issue.

Alan

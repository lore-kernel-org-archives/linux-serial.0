From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] n_tty: Remove LINEMODE support
Date: Mon, 19 Jan 2015 14:40:05 -0500
Message-ID: <54BD5D95.2060604@hurleysoftware.com>
References: <1421616632-4077-1-git-send-email-peter@hurleysoftware.com> <54BC3771.7030204@symas.com> <54BC5EC7.1090202@hurleysoftware.com> <54BCFC94.1040605@symas.com> <54BD1B53.9030901@hurleysoftware.com> <54BD328F.9090208@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54BD328F.9090208@symas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Howard Chu <hyc@symas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>, linux-serial@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-serial@vger.kernel.org

On 01/19/2015 11:36 AM, Howard Chu wrote:
> Peter Hurley wrote:

[...]

>> A description of how the pty master uses EXTPROC to implement line mode would
>> be very helpful, especially to people working in the tty code (eg., me, although
>> I don't need it now).
> 
> The original patch submission carried this description
> http://lkml.iu.edu/hypermail/linux/kernel/1006.2/02428.html

[from linked source]

> Paraphrased from the 1989 BSD patch by David Borman @ cray.com:
> 
> These are the changes needed for the kernel to support
> LINEMODE in the server.
> 
> There is a new bit in the termios local flag word, EXTPROC.
> When this bit is set, several aspects of the terminal driver
> are disabled. Input line editing, character echo, and mapping
> of signals are all disabled. This allows the telnetd to turn
> off these functions when in linemode, but still keep track of
> what state the user wants the terminal to be in.

Ok, but this should go on to describe at least the basics of
transparent local/remote line editing. Even mentioning that
it should be transparent is important.

> New ioctl:
> TIOCSIG Generate a signal to processes in the
> current process group of the pty.

Yes, but documentation should describe why this is important/required/useful.
That is, how this supports client signal handling.

> There is a new mode for packet driver, the TIOCPKT_IOCTL bit.
> When packet mode is turned on in the pty, and the EXTPROC bit
> is set, then whenever the state of the pty is changed, the
> next read on the master side of the pty will have the TIOCPKT_IOCTL
> bit set. This allows the process on the server side of the pty
> to know when the state of the terminal has changed; it can then
> issue the appropriate ioctl to retrieve the new state.

... and go on to outline in a sentence or two what the pty master
process does with this information.

IOW, _how_ does this kernel interface support LINEMODE?

Regards,
Peter Hurley

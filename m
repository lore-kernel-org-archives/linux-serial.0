From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] n_tty: Remove LINEMODE support
Date: Tue, 20 Jan 2015 13:16:28 -0500
Message-ID: <54BE9B7C.7020709@hurleysoftware.com>
References: <1421616632-4077-1-git-send-email-peter@hurleysoftware.com> <54BC3771.7030204@symas.com> <54BC5EC7.1090202@hurleysoftware.com> <54BCFC94.1040605@symas.com> <54BD1B53.9030901@hurleysoftware.com> <54BD328F.9090208@symas.com> <54BD567C.8070200@hurleysoftware.com> <54BD5E54.3050909@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54BD5E54.3050909@symas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Howard Chu <hyc@symas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>, linux-serial@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-serial@vger.kernel.org

On 01/19/2015 02:43 PM, Howard Chu wrote:
> Peter Hurley wrote:
>> On 01/19/2015 11:36 AM, Howard Chu wrote:
>>> Peter Hurley wrote:

[...]

>>>> Which brings up another point: only a pty master should be able to set EXTPROC
>>>> mode. Right now, any tty can be set to EXTPROC and the pty slave can even
>>>> accidentally unset it. This argues for a new pty ioctl() to set EXTPROC in
>>>> termios. pty_set_termios() can silently merge the bit.

Another major problem with supporting EXTPROC through termios directly is
that Linux does not mask off unsupported termios bits, so the process can't
find out directly if the the kernel has this support or doesn't.

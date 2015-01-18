From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] n_tty: Remove LINEMODE support
Date: Sun, 18 Jan 2015 17:22:46 -0500
Message-ID: <54BC3236.1030004@hurleysoftware.com>
References: <1421616632-4077-1-git-send-email-peter@hurleysoftware.com> <54BC2F0A.8040404@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54BC2F0A.8040404@symas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Howard Chu <hyc@symas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Howard,

On 01/18/2015 05:09 PM, Howard Chu wrote:
> Peter Hurley wrote:
>> Commit 26df6d13406d1 ("tty: Add EXTPROC support for LINEMODE") added
>> the undocumented EXTPROC input processing mode, which ignores the ICANON
>> setting and forces pty slave input to be processed in non-canonical
>> mode.
>>
>> Although intended to provide a transparent mechanism for local line
>> edit with telnetd (and other remote shell protocols), the transparency
>> is limited.
>>
>> Userspace usage is abandoned; telnetd does not even compile with
>> LINEMODE support. readline/bash and sshd never supported this.
> 
> I object to this. Code for all of the above exists and works. I use this code daily.
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=585527
> http://lists.gnu.org/archive/html/bug-readline/2011-01/msg00004.html
> https://github.com/hyc/OpenSSH-LINEMODE
> 
> The lack of LINEMODE support in upstream sshd can only be considered a security hole.
> 
> http://www.metzdowd.com/pipermail/cryptography/2015-January/024288.html

These are all bug reports about userspace _not_ supporting this extension.

Where is a working userspace consumer of this interface?

I seriously doubt this works reliably.
What happens when the pty slave reader is in canonical mode and gets unterminated
input because only a portion of the input is available yet? The way this is
coded does _not_ require line termination before returning data to userspace.

Also, ioctl(FIONREAD) doesn't match what read() returns, nor that poll()/select()
indicated input was available.

Regards,
Peter Hurley

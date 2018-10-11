From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Insanely high baud rates
Date: Thu, 11 Oct 2018 12:39:21 -0700
Message-ID: <aa19265c-f39a-cb7d-1215-1c663d15ac30@zytor.com>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
 <20181010211717.30c1f052@alans-desktop>
 <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com>
 <20181011133134.085624af@alans-desktop> <20181011193651.GA11500@isi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011193651.GA11500@isi.edu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Craig Milo Rogers <rogers@isi.edu>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

On 10/11/18 12:36 PM, Craig Milo Rogers wrote:
> On 18.10.11, Alan Cox wrote:
>> I mean - what is the baud rate of a pty  ?
> 
> 	Solaris made the distinction between B0, which means pty hangup mode,
> and any other baud rate:
> 
> https://docs.oracle.com/cd/E88353_01/html/E37851/pty-4d.html
> 
> 	But... why not implement a pty bandwidth limitation layer?  You say, I
> need to justify it?  It's for, uh... protecting the system from unrestricted
> pty usage DOS attacks!  Yeah.  That's what it's for.

B0 is hangup, that's not in question.

	-hpa
